From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 12 Feb 2010 10:38:49 +0000
Subject: [PATCH 1/5] ARM: SMDK64XX: Enable AC97 device
Message-ID: <1265971133-17610-1-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jassi Brar <jassi.brar@samsung.com>

Add AC97 controller to platform devices and initialize the AC97 gpios.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-s3c6410/mach-smdk6410.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-s3c6410/mach-smdk6410.c b/arch/arm/mach-s3c6410/mach-smdk6410.c
index eba345f..259ebbb 100644
--- a/arch/arm/mach-s3c6410/mach-smdk6410.c
+++ b/arch/arm/mach-s3c6410/mach-smdk6410.c
@@ -55,6 +55,7 @@
 #include <plat/gpio-cfg.h>
 
 #include <plat/s3c6410.h>
+#include <plat/audio.h>
 #include <plat/clock.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
@@ -253,7 +254,9 @@ static struct platform_device *smdk6410_devices[] __initdata = {
 	&smdk6410_b_pwr_5v,
 #endif
 	&smdk6410_lcd_powerdev,
-
+#ifdef CONFIG_SND_SOC_SMDK_WM9713
+	&s3c64xx_device_ac97,
+#endif
 	&smdk6410_smsc911x,
 };
 
@@ -475,6 +478,10 @@ static void __init smdk6410_machine_init(void)
 	i2c_register_board_info(0, i2c_devs0, ARRAY_SIZE(i2c_devs0));
 	i2c_register_board_info(1, i2c_devs1, ARRAY_SIZE(i2c_devs1));
 
+#ifdef CONFIG_SND_SOC_SMDK_WM9713
+	s3c64xx_ac97_setup_gpio(S3C64XX_AC97_GPD);
+#endif
+
 	platform_add_devices(smdk6410_devices, ARRAY_SIZE(smdk6410_devices));
 }
 
-- 
1.6.6.1
