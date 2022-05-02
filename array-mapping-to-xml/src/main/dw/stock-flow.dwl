%dw 2.0
output application/xml

var payload = [
    {
		"TOTAL": 1000,
		"PRODUCT_IDENTIFIER": 2137968,
		"COLOUR_ID": 1,
		"LAST_STOCK_UPDATE_DATE": "2021-12-15 13:13:47.497994",
		"AVAILABLE": 100002,
		"COMPUTER_SIZE_NUMBER": "173",
        "LOCATION_ARVATO": 1001
	},
	{
		"TOTAL": 14,
		"PRODUCT_IDENTIFIER": 2137968,
		"COLOUR_ID": 1,
		"LAST_STOCK_UPDATE_DATE": "2021-12-14 13:13:47.497994",
		"AVAILABLE": 100002,
		"COMPUTER_SIZE_NUMBER": "173",
        "LOCATION_ARVATO": 1001
	}
]

---
// convert to XML
shopAvailableStocks: {
    shopAvailableStock:{
        productIdentifier : payload[0].PRODUCT_IDENTIFIER as Number,
        colourId		  : payload[0].COLOUR_ID as Number,
        computerSizeNumber:	payload[0].COMPUTER_SIZE_NUMBER,
        availableQuantity : payload reduce ((item, quantity = 0) -> item.AVAILABLE + quantity),
        totalQuantity	  : payload reduce ((item, total = 0) -> item.TOTAL + total),
        maxLastUpdateDate : payload[0].LAST_STOCK_UPDATE_DATE,
        locationQuantities: {
            (map(payload, (value, index) -> {
                locationQuantity: {
                    locationArvato: value.LOCATION_ARVATO as Number,
                    locationCa: "801",
                    availableLocationQuantity: value.AVAILABLE as Number,
                    totalLocationQuantity: value.TOTAL as Number,
                    locationMaxLastUpdateDate: value.LAST_STOCK_UPDATE_DATE
                }
            }))
        }
    }
}
