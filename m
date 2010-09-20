From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 20 Sep 2010 18:31:07 +0200
Subject: [PATCH] atmel_usba_udc: force vbus_pin at -EINVAL when gpio_request
	failled
Message-ID: <1285000267-22964-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

to ensure gpio_is_valid return false

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
 drivers/usb/gadget/atmel_usba_udc.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/gadget/atmel_usba_udc.c b/drivers/usb/gadget/atmel_usba_udc.c
index d623c7b..7d84ee9 100644
--- a/drivers/usb/gadget/atmel_usba_udc.c
+++ b/drivers/usb/gadget/atmel_usba_udc.c
@@ -2014,6 +2014,9 @@ static int __init usba_udc_probe(struct platform_device *pdev)
 			} else {
 				disable_irq(gpio_to_irq(udc->vbus_pin));
 			}
+		} else {
+			/* gpio_request fail so use -EINVAL for gpio_is_valid */
+			ubc->vbus_pin = -EINVAL;
 		}
 	}
 
-- 
1.7.1
