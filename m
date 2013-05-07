From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Tue, 7 May 2013 19:48:22 +0800
Subject: [PATCH] usb: gadget: s3c2410_udc: fix error return code in
 s3c2410_udc_probe()
Message-ID: <CAPgLHd9zzFi6dCBH0V=eeqVtd=UstiqM8fDcDsMCfujAfEDHTg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Fix to return a negative error code in the gpio_to_irq() error handling
case instead of 0, as done elsewhere in this function.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/usb/gadget/s3c2410_udc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/gadget/s3c2410_udc.c b/drivers/usb/gadget/s3c2410_udc.c
index d0e75e1..c974776 100644
--- a/drivers/usb/gadget/s3c2410_udc.c
+++ b/drivers/usb/gadget/s3c2410_udc.c
@@ -1851,6 +1851,7 @@ static int s3c2410_udc_probe(struct platform_device *pdev)
 		irq = gpio_to_irq(udc_info->vbus_pin);
 		if (irq < 0) {
 			dev_err(dev, "no irq for gpio vbus pin\n");
+			retval = irq;
 			goto err_gpio_claim;
 		}
 
