From: jassisinghbrar@gmail.com (jassisinghbrar at gmail.com)
Date: Thu, 28 Jan 2010 17:44:17 +0900
Subject: [PATCHv3 06/10] ARM: SMDK64XX: Enable AC97 device
Message-ID: <1264668257-25271-1-git-send-email-jassisinghbrar@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jassi Brar <jassi.brar@samsung.com>

Add AC97 controller to platform devices and initialize the AC97 gpios.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 arch/arm/mach-s3c6410/mach-smdk6410.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-s3c6410/mach-smdk6410.c b/arch/arm/mach-s3c6410/mach-smdk6410.c
index eba345f..f2c70ec 100644
--- a/arch/arm/mach-s3c6410/mach-smdk6410.c
+++ b/arch/arm/mach-s3c6410/mach-smdk6410.c
@@ -55,6 +55,7 @@
 #include <plat/gpio-cfg.h>
 
 #include <plat/s3c6410.h>
+#include <plat/audio.h>
 #include <plat/clock.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
@@ -253,7 +254,7 @@ static struct platform_device *smdk6410_devices[] __initdata = {
 	&smdk6410_b_pwr_5v,
 #endif
 	&smdk6410_lcd_powerdev,
-
+	&s3c64xx_device_ac97,
 	&smdk6410_smsc911x,
 };
 
@@ -475,6 +476,8 @@ static void __init smdk6410_machine_init(void)
 	i2c_register_board_info(0, i2c_devs0, ARRAY_SIZE(i2c_devs0));
 	i2c_register_board_info(1, i2c_devs1, ARRAY_SIZE(i2c_devs1));
 
+	s3c64xx_ac97_setup_gpio(S3C64XX_AC97_GPD);
+
 	platform_add_devices(smdk6410_devices, ARRAY_SIZE(smdk6410_devices));
 }
 
-- 
1.6.2.5
