From: cristian.birsan@microchip.com (cristian.birsan at microchip.com)
Date: Tue, 14 Feb 2017 18:09:04 +0200
Subject: [PATCH 2/4 linux-next] usb: gadget: udc: atmel: Minor code cleanup
In-Reply-To: <cover.1487007870.git.cristian.birsan@microchip.com>
References: <cover.1487007870.git.cristian.birsan@microchip.com>
Message-ID: <f27f5aeeabc6eaf02833ee51cd343b564c40fb3e.1487007870.git.cristian.birsan@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Cristian Birsan <cristian.birsan@microchip.com>

Minor code cleanup based on feedback received on mailinglist.

Signed-off-by: Cristian Birsan <cristian.birsan@microchip.com>
---
 drivers/usb/gadget/udc/atmel_usba_udc.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
index ce8bf8b..3becb28 100644
--- a/drivers/usb/gadget/udc/atmel_usba_udc.c
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
@@ -321,7 +321,6 @@ static inline void usba_cleanup_debugfs(struct usba_udc *udc)
 
 static ushort fifo_mode;
 
-/* "modprobe ... fifo_mode=1" etc */
 module_param(fifo_mode, ushort, 0x0);
 MODULE_PARM_DESC(fifo_mode, "Endpoint configuration mode");
 
@@ -1076,11 +1075,9 @@ static int atmel_usba_start(struct usb_gadget *gadget,
 		struct usb_gadget_driver *driver);
 static int atmel_usba_stop(struct usb_gadget *gadget);
 
-static struct usb_ep *atmel_usba_match_ep(
-		struct usb_gadget		*gadget,
-		struct usb_endpoint_descriptor	*desc,
-		struct usb_ss_ep_comp_descriptor *ep_comp
-)
+static struct usb_ep *atmel_usba_match_ep(struct usb_gadget *gadget,
+				struct usb_endpoint_descriptor	*desc,
+				struct usb_ss_ep_comp_descriptor *ep_comp)
 {
 	struct usb_ep	*_ep;
 	struct usba_ep *ep;
@@ -1100,7 +1097,6 @@ static struct usb_ep *atmel_usba_match_ep(
 		ep = to_usba_ep(_ep);
 
 		switch (usb_endpoint_type(desc)) {
-
 		case USB_ENDPOINT_XFER_CONTROL:
 			break;
 
@@ -1141,7 +1137,7 @@ static struct usb_ep *atmel_usba_match_ep(
 		ep->udc->configured_ep++;
 	}
 
-return _ep;
+	return _ep;
 }
 
 static const struct usb_gadget_ops usba_udc_ops = {
@@ -2089,8 +2085,9 @@ static struct usba_ep * atmel_udc_of_init(struct platform_device *pdev,
 		while ((pp = of_get_next_child(np, pp)))
 			udc->num_ep++;
 		udc->configured_ep = 1;
-	} else
+	} else {
 		udc->num_ep = usba_config_fifo_table(udc);
+	}
 
 	eps = devm_kzalloc(&pdev->dev, sizeof(struct usba_ep) * udc->num_ep,
 			   GFP_KERNEL);
-- 
2.7.4
