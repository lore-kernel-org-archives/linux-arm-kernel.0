From: robherring2@gmail.com (Rob Herring)
Date: Wed, 29 Aug 2012 17:31:27 -0500
Subject: [PATCH 01/10] usb: pxa27x_udc: remove IRQ_USB define
In-Reply-To: <1346279496-26286-1-git-send-email-robherring2@gmail.com>
References: <1346279496-26286-1-git-send-email-robherring2@gmail.com>
Message-ID: <1346279496-26286-2-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

IRQ_USB was implicitly included by gpio.h. Use the existing variable
instead of IRQ_USB.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Eric Miao <eric.y.miao@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/gadget/pxa27x_udc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/pxa27x_udc.c b/drivers/usb/gadget/pxa27x_udc.c
index 644b430..7a8713c 100644
--- a/drivers/usb/gadget/pxa27x_udc.c
+++ b/drivers/usb/gadget/pxa27x_udc.c
@@ -2508,7 +2508,7 @@ static int __init pxa_udc_probe(struct platform_device *pdev)
 			IRQF_SHARED, driver_name, udc);
 	if (retval != 0) {
 		dev_err(udc->dev, "%s: can't get irq %i, err %d\n",
-			driver_name, IRQ_USB, retval);
+			driver_name, udc->irq, retval);
 		goto err_irq;
 	}
 	retval = usb_add_gadget_udc(&pdev->dev, &udc->gadget);
-- 
1.7.9.5
