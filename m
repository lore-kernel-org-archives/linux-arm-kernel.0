From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 30 May 2012 18:19:37 +0100
Subject: [PATCH 2/2] ARM: S3C64XX: Add WM5102 EVM to Cragganmore modules
In-Reply-To: <1338398378-18268-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1338398378-18268-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <1338398378-18268-2-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

No platform data yet as driver is not yet merged.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-s3c64xx/mach-crag6410-module.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/mach-s3c64xx/mach-crag6410-module.c b/arch/arm/mach-s3c64xx/mach-crag6410-module.c
index 985e255..f80761c 100644
--- a/arch/arm/mach-s3c64xx/mach-crag6410-module.c
+++ b/arch/arm/mach-s3c64xx/mach-crag6410-module.c
@@ -192,6 +192,11 @@ static const struct i2c_board_info wm1277_devs[] = {
 	},
 };
 
+static const struct i2c_board_info wm5102_devs[] = {
+	{ I2C_BOARD_INFO("wm5102", 0x1a),
+	  .irq = GLENFARCLAS_PMIC_IRQ_BASE + WM831X_IRQ_GPIO_2, },
+};
+
 static const struct i2c_board_info wm6230_i2c_devs[] = {
 	{ I2C_BOARD_INFO("wm9081", 0x6c),
 	  .platform_data = &wm9081_pdata, },
@@ -229,6 +234,8 @@ static __devinitdata const struct {
 	{ .id = 0x3c, .name = "1273-EV1 Longmorn" },
 	{ .id = 0x3d, .name = "1277-EV1 Littlemill",
 	  .i2c_devs = wm1277_devs, .num_i2c_devs = ARRAY_SIZE(wm1277_devs) },
+	{ .id = 0x3e, .name = "WM5102-6271-EV1-CS127",
+	  .i2c_devs = wm5102_devs, .num_i2c_devs = ARRAY_SIZE(wm5102_devs) },
 };
 
 static __devinit int wlf_gf_module_probe(struct i2c_client *i2c,
-- 
1.7.10
