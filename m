From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 29 Mar 2012 15:27:18 +0200
Subject: [PATCH 07/12] USB: ohci-at91: coding style modifications with
 one-line ifs
In-Reply-To: <cover.1333026637.git.nicolas.ferre@atmel.com>
References: <cover.1333026637.git.nicolas.ferre@atmel.com>
Message-ID: <ebf89ca2b0cb635d900e5fd3cc350935e41918ea.1333026637.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
 drivers/usb/host/ohci-at91.c |   12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
index cf9707d..dd58b555 100644
--- a/drivers/usb/host/ohci-at91.c
+++ b/drivers/usb/host/ohci-at91.c
@@ -327,9 +327,8 @@ static int ohci_at91_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 			dev_dbg(hcd->self.controller,
 				"ClearPortFeature: OVER_CURRENT\n");
 
-			if (wIndex && wIndex <= ARRAY_SIZE(pdata->vbus_pin)) {
+			if (wIndex && wIndex <= ARRAY_SIZE(pdata->vbus_pin))
 				pdata->overcurrent_status[wIndex-1] = 0;
-			}
 
 			goto out;
 
@@ -382,17 +381,14 @@ static int ohci_at91_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 		dev_dbg(hcd->self.controller, "GetPortStatus(%d)\n", wIndex);
 
 		if (wIndex && wIndex <= ARRAY_SIZE(pdata->vbus_pin)) {
-			if (! ohci_at91_usb_get_power(pdata, wIndex-1)) {
+			if (! ohci_at91_usb_get_power(pdata, wIndex-1))
 				*data &= ~cpu_to_le32(RH_PS_PPS);
-			}
 
-			if (pdata->overcurrent_changed[wIndex-1]) {
+			if (pdata->overcurrent_changed[wIndex-1])
 				*data |= cpu_to_le32(RH_PS_OCIC);
-			}
 
-			if (pdata->overcurrent_status[wIndex-1]) {
+			if (pdata->overcurrent_status[wIndex-1])
 				*data |= cpu_to_le32(RH_PS_POCI);
-			}
 		}
 	}
 
-- 
1.7.9.4
