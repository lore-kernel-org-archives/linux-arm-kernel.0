From: mporter@linaro.org (Matt Porter)
Date: Mon, 23 Dec 2013 13:36:32 -0500
Subject: [PATCH v9 3/9] usb: gadget: s3c-hsotg: enable build for other
 platforms
In-Reply-To: <1387823798-10211-1-git-send-email-mporter@linaro.org>
References: <1387823798-10211-1-git-send-email-mporter@linaro.org>
Message-ID: <1387823798-10211-4-git-send-email-mporter@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove unused Samsung-specific machine include and Kconfig
dependency on S3C.

Signed-off-by: Matt Porter <mporter@linaro.org>
Reviewed-by: Markus Mayer <markus.mayer@linaro.org>
Reviewed-by: Tim Kryger <tim.kryger@linaro.org>
---
 drivers/usb/gadget/Kconfig     | 8 ++++----
 drivers/usb/gadget/s3c-hsotg.c | 2 --
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
index a91e642..cf955f5 100644
--- a/drivers/usb/gadget/Kconfig
+++ b/drivers/usb/gadget/Kconfig
@@ -294,11 +294,11 @@ config USB_PXA27X
 	   gadget drivers to also be dynamically linked.
 
 config USB_S3C_HSOTG
-	tristate "S3C HS/OtG USB Device controller"
-	depends on S3C_DEV_USB_HSOTG
+	tristate "Designware/S3C HS/OtG USB Device controller"
+	depends on ARM
 	help
-	  The Samsung S3C64XX USB2.0 high-speed gadget controller
-	  integrated into the S3C64XX series SoC.
+	  The Designware USB2.0 high-speed gadget controller
+	  integrated into many SoCs.
 
 config USB_S3C2410
 	tristate "S3C2410 USB Device Controller"
diff --git a/drivers/usb/gadget/s3c-hsotg.c b/drivers/usb/gadget/s3c-hsotg.c
index 9875d9c..db797f2 100644
--- a/drivers/usb/gadget/s3c-hsotg.c
+++ b/drivers/usb/gadget/s3c-hsotg.c
@@ -36,8 +36,6 @@
 #include <linux/usb/phy.h>
 #include <linux/platform_data/s3c-hsotg.h>
 
-#include <mach/map.h>
-
 #include "s3c-hsotg.h"
 
 static const char * const s3c_hsotg_supply_names[] = {
-- 
1.8.4
