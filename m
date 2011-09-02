From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri,  2 Sep 2011 19:37:23 +0100
Subject: [PATCH] ARM: S3C64XX: Add devices for Kilchoman audio module on
	Cragganmore
Message-ID: <1314988643-24557-1-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Kilchoman audio module carries a WM5100 audio CODEC and WM9081 speaker
amplifier.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-s3c64xx/mach-crag6410-module.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/mach-crag6410-module.c b/arch/arm/mach-s3c64xx/mach-crag6410-module.c
index c0fe002..7c5ddb6 100644
--- a/arch/arm/mach-s3c64xx/mach-crag6410-module.c
+++ b/arch/arm/mach-s3c64xx/mach-crag6410-module.c
@@ -117,6 +117,14 @@ static const struct i2c_board_info wm1254_devs[] = {
 	  .platform_data = &wm9081_pdata, },
 };
 
+static const struct i2c_board_info wm1255_devs[] = {
+	{ I2C_BOARD_INFO("wm5100", 0x1a),
+	  .irq = GLENFARCLAS_PMIC_IRQ_BASE + WM831X_IRQ_GPIO_2,
+	},
+	{ I2C_BOARD_INFO("wm9081", 0x6c),
+	  .platform_data = &wm9081_pdata, },
+};
+
 static const struct i2c_board_info wm1259_devs[] = {
 	{ I2C_BOARD_INFO("wm8962", 0x1a),
 	  .platform_data = &wm8962_pdata,
@@ -145,7 +153,8 @@ static __devinitdata const struct {
 	  .i2c_devs = wm1254_devs, .num_i2c_devs = ARRAY_SIZE(wm1254_devs) },
 	{ .id = 0x3a, .name = "1259-EV1 Tobermory",
 	  .i2c_devs = wm1259_devs, .num_i2c_devs = ARRAY_SIZE(wm1259_devs) },
-	{ .id = 0x3b, .name = "1255-EV1 Kilchoman" },
+	{ .id = 0x3b, .name = "1255-EV1 Kilchoman",
+	  .i2c_devs = wm1255_devs, .num_i2c_devs = ARRAY_SIZE(wm1255_devs) },
 	{ .id = 0x3c, .name = "1273-EV1 Longmorn" },
 };
 
-- 
1.7.5.4
