From: romain.izard.pro@gmail.com (Romain Izard)
Date: Fri, 11 May 2018 12:19:56 +0200
Subject: [PATCH v2 3/3] usb: gadget: udc: atmel: Fix indenting
In-Reply-To: <20180511101956.11782-1-romain.izard.pro@gmail.com>
References: <20180511101956.11782-1-romain.izard.pro@gmail.com>
Message-ID: <20180511101956.11782-4-romain.izard.pro@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the fallout of the conversion to GPIO descriptors in 3df034081021.

Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
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
