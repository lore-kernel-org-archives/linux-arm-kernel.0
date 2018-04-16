From: romain.izard.pro@gmail.com (Romain Izard)
Date: Mon, 16 Apr 2018 11:34:05 +0200
Subject: [PATCH 3/3] usb: gadget: udc: atmel: Fix indenting
In-Reply-To: <20180416093405.16612-1-romain.izard.pro@gmail.com>
References: <20180416093405.16612-1-romain.izard.pro@gmail.com>
Message-ID: <20180416093405.16612-4-romain.izard.pro@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the fallout of the conversion to GPIO descriptors in 3df034081021.

Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
---
 drivers/usb/gadget/udc/atmel_usba_udc.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
index b9623e228609..2f586f2bda7e 100644
--- a/drivers/usb/gadget/udc/atmel_usba_udc.c
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
@@ -2277,15 +2277,15 @@ static int usba_udc_probe(struct platform_device *pdev)
 	if (udc->vbus_pin) {
 		irq_set_status_flags(gpiod_to_irq(udc->vbus_pin), IRQ_NOAUTOEN);
 		ret = devm_request_threaded_irq(&pdev->dev,
-					gpiod_to_irq(udc->vbus_pin), NULL,
-					usba_vbus_irq_thread, USBA_VBUS_IRQFLAGS,
-					"atmel_usba_udc", udc);
-			if (ret) {
-				udc->vbus_pin = NULL;
-				dev_warn(&udc->pdev->dev,
-					 "failed to request vbus irq; "
-					 "assuming always on\n");
-			}
+				gpiod_to_irq(udc->vbus_pin), NULL,
+				usba_vbus_irq_thread, USBA_VBUS_IRQFLAGS,
+				"atmel_usba_udc", udc);
+		if (ret) {
+			udc->vbus_pin = NULL;
+			dev_warn(&udc->pdev->dev,
+				 "failed to request vbus irq; "
+				 "assuming always on\n");
+		}
 	}
 
 	ret = usb_add_gadget_udc(&pdev->dev, &udc->gadget);
-- 
2.14.1
