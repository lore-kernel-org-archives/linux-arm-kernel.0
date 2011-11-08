From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue,  8 Nov 2011 16:10:46 +0000
Subject: [PATCH] ARM: S3C64XX: Raise the frequency of the second I2C bus on
 Cragganmore
Message-ID: <1320768646-21075-1-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The S3C I2C driver defaults to a rather low 66kHz, ask for 400kHz for
a bit of a speed boost.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-s3c64xx/mach-crag6410.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/mach-crag6410.c b/arch/arm/mach-s3c64xx/mach-crag6410.c
index d04b654..b9a052a 100644
--- a/arch/arm/mach-s3c64xx/mach-crag6410.c
+++ b/arch/arm/mach-s3c64xx/mach-crag6410.c
@@ -634,6 +634,11 @@ static struct i2c_board_info i2c_devs1[] __initdata = {
 	{ I2C_BOARD_INFO("wm1250-ev1", 0x27) },
 };
 
+static struct s3c2410_platform_i2c i2c1_pdata = {
+	.frequency = 400000,
+	.bus_num = 1,
+};
+
 static void __init crag6410_map_io(void)
 {
 	s3c64xx_init_io(NULL, 0);
@@ -692,7 +697,7 @@ static void __init crag6410_machine_init(void)
 	s3c_sdhci2_set_platdata(&crag6410_hsmmc2_pdata);
 
 	s3c_i2c0_set_platdata(&i2c0_pdata);
-	s3c_i2c1_set_platdata(NULL);
+	s3c_i2c1_set_platdata(&i2c1_pdata);
 	s3c_fb_set_platdata(&crag6410_lcd_pdata);
 
 	i2c_register_board_info(0, i2c_devs0, ARRAY_SIZE(i2c_devs0));
-- 
1.7.7.1
