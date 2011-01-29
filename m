From: ramaxlo@gmail.com (Ramax Lo)
Date: Sat, 29 Jan 2011 22:56:45 +0800
Subject: [PATCH] AT2440EVB: Add touchscreen support
Message-ID: <1296313005-13837-1-git-send-email-ramaxlo@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add touchscreen support for AT2440EVB board.

Signed-off-by: Ramax Lo <ramaxlo@gmail.com>
---
 arch/arm/mach-s3c2440/mach-at2440evb.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c2440/mach-at2440evb.c b/arch/arm/mach-s3c2440/mach-at2440evb.c
index 6c98b78..1bcba00 100644
--- a/arch/arm/mach-s3c2440/mach-at2440evb.c
+++ b/arch/arm/mach-s3c2440/mach-at2440evb.c
@@ -36,6 +36,7 @@
 #include <mach/regs-gpio.h>
 #include <mach/regs-mem.h>
 #include <mach/regs-lcd.h>
+#include <plat/ts.h>
 #include <plat/nand.h>
 #include <plat/iic.h>
 
@@ -202,6 +203,12 @@ static struct s3c2410fb_mach_info at2440evb_fb_info __initdata = {
 	.default_display = 0,
 };
 
+static struct s3c2410_ts_mach_info at2440evb_ts_info __initdata = {
+	.delay			= 10000,
+	.presc			= 49,
+	.oversampling_shift	= 2,
+};
+
 static struct platform_device *at2440evb_devices[] __initdata = {
 	&s3c_device_ohci,
 	&s3c_device_wdt,
@@ -211,6 +218,7 @@ static struct platform_device *at2440evb_devices[] __initdata = {
 	&s3c_device_nand,
 	&s3c_device_sdi,
 	&s3c_device_lcd,
+	&s3c_device_ts,
 	&at2440evb_device_eth,
 };
 
@@ -227,6 +235,7 @@ static void __init at2440evb_init(void)
 	s3c24xx_mci_set_platdata(&at2440evb_mci_pdata);
 	s3c_nand_set_platdata(&at2440evb_nand_info);
 	s3c_i2c0_set_platdata(NULL);
+	s3c24xx_ts_set_platdata(&at2440evb_ts_info);
 
 	platform_add_devices(at2440evb_devices, ARRAY_SIZE(at2440evb_devices));
 }
-- 
1.7.0.4
