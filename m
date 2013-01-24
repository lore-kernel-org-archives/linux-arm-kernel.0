From: rogerq@ti.com (Roger Quadros)
Date: Thu, 24 Jan 2013 11:04:56 +0200
Subject: [PATCH v10 20/20] mfd: omap-usb-host: get rid of build warning
In-Reply-To: <20130123233617.9205.88295@quantum>
References: <20130123233617.9205.88295@quantum>
Message-ID: <1359018296-5015-1-git-send-email-rogerq@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixes the below build warning when driver is built-in.

drivers/mfd/omap-usb-host.c:750:12: warning:
?usbhs_omap_remove? defined but not used [-Wunused-function]

Signed-off-by: Roger Quadros <rogerq@ti.com>
Reviewed-by: Felipe Balbi <balbi@ti.com>
---
 drivers/mfd/omap-usb-host.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
index b21ca76..6b5edf6 100644
--- a/drivers/mfd/omap-usb-host.c
+++ b/drivers/mfd/omap-usb-host.c
@@ -791,7 +791,7 @@ static struct platform_driver usbhs_omap_driver = {
 		.owner		= THIS_MODULE,
 		.pm		= &usbhsomap_dev_pm_ops,
 	},
-	.remove		= __exit_p(usbhs_omap_remove),
+	.remove		= usbhs_omap_remove,
 };
 
 MODULE_AUTHOR("Keshava Munegowda <keshava_mgowda@ti.com>");
-- 
1.7.4.1
