From: matt.porter@linaro.org (Matt Porter)
Date: Mon, 25 Nov 2013 13:16:01 -0500
Subject: [PATCH v3 3/9] usb: gadget: s3c-hsotg: enable build for other
 platforms
In-Reply-To: <1385403367-18144-1-git-send-email-matt.porter@linaro.org>
References: <1385403367-18144-1-git-send-email-matt.porter@linaro.org>
Message-ID: <1385403367-18144-4-git-send-email-matt.porter@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove unused Samsung-specific machine include and Kconfig
dependency on S3C.

Signed-off-by: Matt Porter <matt.porter@linaro.org>
Reviewed-by: Markus Mayer <markus.mayer@linaro.org>
Reviewed-by: Tim Kryger <tim.kryger@linaro.org>
---
 drivers/usb/gadget/Kconfig     | 7 +++----
 drivers/usb/gadget/s3c-hsotg.c | 2 --
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
index a91e642..970bd1a 100644
--- a/drivers/usb/gadget/Kconfig
+++ b/drivers/usb/gadget/Kconfig
@@ -294,11 +294,10 @@ config USB_PXA27X
 	   gadget drivers to also be dynamically linked.
 
 config USB_S3C_HSOTG
-	tristate "S3C HS/OtG USB Device controller"
-	depends on S3C_DEV_USB_HSOTG
+	tristate "Designware/S3C HS/OtG USB Device controller"
 	help
-	  The Samsung S3C64XX USB2.0 high-speed gadget controller
-	  integrated into the S3C64XX series SoC.
+	  The Designware USB2.0 high-speed gadget controller
+	  integrated into the S3C64XX and BCM281xx series SoC.
 
 config USB_S3C2410
 	tristate "S3C2410 USB Device Controller"
diff --git a/drivers/usb/gadget/s3c-hsotg.c b/drivers/usb/gadget/s3c-hsotg.c
index 2d1f560..a8e6c3d 100644
--- a/drivers/usb/gadget/s3c-hsotg.c
+++ b/drivers/usb/gadget/s3c-hsotg.c
@@ -37,8 +37,6 @@
 #include <linux/usb/phy.h>
 #include <linux/platform_data/s3c-hsotg.h>
 
-#include <mach/map.h>
-
 #include "s3c-hsotg.h"
 
 static const char * const s3c_hsotg_supply_names[] = {
-- 
1.8.4
