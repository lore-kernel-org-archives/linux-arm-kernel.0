From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue,  3 Apr 2012 09:32:51 +0200
Subject: [PATCH v2 07/13] USB: ohci-at91: coding style modifications with
 one-line ifs
In-Reply-To: <cover.1333437885.git.nicolas.ferre@atmel.com>
References: <cover.1333437885.git.nicolas.ferre@atmel.com>
Message-ID: <2f20710bed6a61b953ce7c898b997bcead12045f.1333437885.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
 drivers/usb/host/ohci-at91.c |   12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
index 859177c..a8e0446 100644
--- a/drivers/usb/host/ohci-at91.c
+++ b/drivers/usb/host/ohci-at91.c
@@ -333,9 +333,8 @@ static int ohci_at91_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 			dev_dbg(hcd->self.controller,
 				"ClearPortFeature: OVER_CURRENT\n");
 
-			if (valid_port(wIndex)) {
+			if (valid_port(wIndex))
 				pdata->overcurrent_status[wIndex] = 0;
-			}
 
 			goto out;
 
@@ -388,17 +387,14 @@ static int ohci_at91_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 		dev_dbg(hcd->self.controller, "GetPortStatus(%d)\n", wIndex);
 
 		if (valid_port(wIndex)) {
-			if (! ohci_at91_usb_get_power(pdata, wIndex)) {
+			if (! ohci_at91_usb_get_power(pdata, wIndex))
 				*data &= ~cpu_to_le32(RH_PS_PPS);
-			}
 
-			if (pdata->overcurrent_changed[wIndex]) {
+			if (pdata->overcurrent_changed[wIndex])
 				*data |= cpu_to_le32(RH_PS_OCIC);
-			}
 
-			if (pdata->overcurrent_status[wIndex]) {
+			if (pdata->overcurrent_status[wIndex])
 				*data |= cpu_to_le32(RH_PS_POCI);
-			}
 		}
 	}
 
-- 
1.7.9.4
