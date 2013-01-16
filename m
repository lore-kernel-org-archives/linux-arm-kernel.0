From: rogerq@ti.com (Roger Quadros)
Date: Wed, 16 Jan 2013 16:43:53 +0200
Subject: [PATCH v6 22/22] mdf: omap-usb-host: get rid of build warning
In-Reply-To: <1358347433-329-1-git-send-email-rogerq@ti.com>
References: <1358347433-329-1-git-send-email-rogerq@ti.com>
Message-ID: <1358347433-329-23-git-send-email-rogerq@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixes the below build warning when driver is built-in.

drivers/mfd/omap-usb-host.c:750:12: warning:
?usbhs_omap_remove? defined but not used [-Wunused-function]

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/mfd/omap-usb-host.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
index 56b6f69..151034f 100644
--- a/drivers/mfd/omap-usb-host.c
+++ b/drivers/mfd/omap-usb-host.c
@@ -778,7 +778,7 @@ static struct platform_driver usbhs_omap_driver = {
 		.owner		= THIS_MODULE,
 		.pm		= &usbhsomap_dev_pm_ops,
 	},
-	.remove		= __exit_p(usbhs_omap_remove),
+	.remove		= usbhs_omap_remove,
 };
 
 MODULE_AUTHOR("Keshava Munegowda <keshava_mgowda@ti.com>");
-- 
1.7.4.1
