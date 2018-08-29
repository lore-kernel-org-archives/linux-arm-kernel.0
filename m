From: robh@kernel.org (Rob Herring)
Date: Wed, 29 Aug 2018 15:01:11 -0500
Subject: [PATCH] usb: gadget: atmel: remove pointless retrieval of DT name
 property
Message-ID: <20180829200111.11891-1-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The name is always non-NULL and then is not used anywhere in this function,
so remove it.

Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Felipe Balbi <balbi@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-usb at vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/usb/gadget/udc/atmel_usba_udc.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
index 17147b8c771e..5729935c5eb2 100644
--- a/drivers/usb/gadget/udc/atmel_usba_udc.c
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
@@ -2004,7 +2004,6 @@ static struct usba_ep * atmel_udc_of_init(struct platform_device *pdev,
 						    struct usba_udc *udc)
 {
 	u32 val;
-	const char *name;
 	struct device_node *np = pdev->dev.of_node;
 	const struct of_device_id *match;
 	struct device_node *pp;
@@ -2094,11 +2093,6 @@ static struct usba_ep * atmel_udc_of_init(struct platform_device *pdev,
 		ep->can_dma = of_property_read_bool(pp, "atmel,can-dma");
 		ep->can_isoc = of_property_read_bool(pp, "atmel,can-isoc");
 
-		ret = of_property_read_string(pp, "name", &name);
-		if (ret) {
-			dev_err(&pdev->dev, "of_probe: name error(%d)\n", ret);
-			goto err;
-		}
 		sprintf(ep->name, "ep%d", ep->index);
 		ep->ep.name = ep->name;
 
-- 
2.17.1
