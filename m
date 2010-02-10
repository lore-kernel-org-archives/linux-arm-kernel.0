From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 10 Feb 2010 20:29:13 +0000
Subject: [PATCH] ARM: SMDK6410: Fix modular build of AC97 audio driver
Message-ID: <1265833753-22360-1-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the AC97 audio driver is built modular a _MODULE is appended to
the symbol defined for the config option. Rather than write a lengthy
check against multiple symbols just unconditionally register the AC97
controller device - much simpler and hardly a massive resource hit.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-s3c6410/mach-smdk6410.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-s3c6410/mach-smdk6410.c b/arch/arm/mach-s3c6410/mach-smdk6410.c
index 259ebbb..f2c70ec 100644
--- a/arch/arm/mach-s3c6410/mach-smdk6410.c
+++ b/arch/arm/mach-s3c6410/mach-smdk6410.c
@@ -254,9 +254,7 @@ static struct platform_device *smdk6410_devices[] __initdata = {
 	&smdk6410_b_pwr_5v,
 #endif
 	&smdk6410_lcd_powerdev,
-#ifdef CONFIG_SND_SOC_SMDK_WM9713
 	&s3c64xx_device_ac97,
-#endif
 	&smdk6410_smsc911x,
 };
 
@@ -478,9 +476,7 @@ static void __init smdk6410_machine_init(void)
 	i2c_register_board_info(0, i2c_devs0, ARRAY_SIZE(i2c_devs0));
 	i2c_register_board_info(1, i2c_devs1, ARRAY_SIZE(i2c_devs1));
 
-#ifdef CONFIG_SND_SOC_SMDK_WM9713
 	s3c64xx_ac97_setup_gpio(S3C64XX_AC97_GPD);
-#endif
 
 	platform_add_devices(smdk6410_devices, ARRAY_SIZE(smdk6410_devices));
 }
-- 
1.6.6.1
