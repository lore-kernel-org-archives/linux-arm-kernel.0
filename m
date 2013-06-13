From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Thu, 13 Jun 2013 14:13:54 +0530
Subject: [PATCH v7 4/9] usb: phy: twl4030: twl4030 shouldn't be subsys_initcall
In-Reply-To: <1371113039-5784-1-git-send-email-kishon@ti.com>
References: <1371113039-5784-1-git-send-email-kishon@ti.com>
Message-ID: <1371113039-5784-5-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changed the inticall from subsys_initcall to module_init for
twl4030-usb.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/usb/phy/phy-twl4030-usb.c |   12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/usb/phy/phy-twl4030-usb.c b/drivers/usb/phy/phy-twl4030-usb.c
index 65a5e43..fba9697 100644
--- a/drivers/usb/phy/phy-twl4030-usb.c
+++ b/drivers/usb/phy/phy-twl4030-usb.c
@@ -822,17 +822,7 @@ static struct platform_driver twl4030_usb_driver = {
 	},
 };
 
-static int __init twl4030_usb_init(void)
-{
-	return platform_driver_register(&twl4030_usb_driver);
-}
-subsys_initcall(twl4030_usb_init);
-
-static void __exit twl4030_usb_exit(void)
-{
-	platform_driver_unregister(&twl4030_usb_driver);
-}
-module_exit(twl4030_usb_exit);
+module_platform_driver(twl4030_usb_driver);
 
 MODULE_ALIAS("platform:twl4030_usb");
 MODULE_AUTHOR("Texas Instruments, Inc, Nokia Corporation");
-- 
1.7.10.4
