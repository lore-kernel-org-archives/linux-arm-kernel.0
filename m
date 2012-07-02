From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon,  2 Jul 2012 17:12:59 +0100
Subject: [PATCH] ARM: S3C64XX: Mark most Cragganmore initdata devinitdata
Message-ID: <1341245579-29007-1-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the greater use of deferred probes we need to be more sure that
initdata is actually used only at system init rather than being used
by devices when they probe (which could happen after the main kernel
init has completed and is much more likely to now).

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-s3c64xx/mach-crag6410.c |   68 ++++++++++++++++-----------------
 1 file changed, 34 insertions(+), 34 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/mach-crag6410.c b/arch/arm/mach-s3c64xx/mach-crag6410.c
index 48eb76f..880d144 100644
--- a/arch/arm/mach-s3c64xx/mach-crag6410.c
+++ b/arch/arm/mach-s3c64xx/mach-crag6410.c
@@ -171,7 +171,7 @@ static struct fb_videomode crag6410_lcd_timing = {
 };
 
 /* 405566 clocks per frame => 60Hz refresh requires 24333960Hz clock */
-static struct s3c_fb_platdata crag6410_lcd_pdata __initdata = {
+static struct s3c_fb_platdata crag6410_lcd_pdata __devinitdata = {
 	.setup_gpio	= s3c64xx_fb_gpio_setup_24bpp,
 	.vtiming	= &crag6410_lcd_timing,
 	.win[0]		= &crag6410_fb_win0,
@@ -181,7 +181,7 @@ static struct s3c_fb_platdata crag6410_lcd_pdata __initdata = {
 
 /* 2x6 keypad */
 
-static uint32_t crag6410_keymap[] __initdata = {
+static uint32_t crag6410_keymap[] __devinitdata = {
 	/* KEY(row, col, keycode) */
 	KEY(0, 0, KEY_VOLUMEUP),
 	KEY(0, 1, KEY_HOME),
@@ -197,12 +197,12 @@ static uint32_t crag6410_keymap[] __initdata = {
 	KEY(1, 5, KEY_CAMERA),
 };
 
-static struct matrix_keymap_data crag6410_keymap_data __initdata = {
+static struct matrix_keymap_data crag6410_keymap_data __devinitdata = {
 	.keymap		= crag6410_keymap,
 	.keymap_size	= ARRAY_SIZE(crag6410_keymap),
 };
 
-static struct samsung_keypad_platdata crag6410_keypad_data __initdata = {
+static struct samsung_keypad_platdata crag6410_keypad_data __devinitdata = {
 	.keymap_data	= &crag6410_keymap_data,
 	.rows		= 2,
 	.cols		= 6,
@@ -373,11 +373,11 @@ static struct wm831x_buckv_pdata vddarm_pdata = {
 	.dvs_gpio = S3C64XX_GPK(0),
 };
 
-static struct regulator_consumer_supply vddarm_consumers[] __initdata = {
+static struct regulator_consumer_supply vddarm_consumers[] __devinitdata = {
 	REGULATOR_SUPPLY("vddarm", NULL),
 };
 
-static struct regulator_init_data vddarm __initdata = {
+static struct regulator_init_data vddarm __devinitdata = {
 	.constraints = {
 		.name = "VDDARM",
 		.min_uV = 1000000,
@@ -391,11 +391,11 @@ static struct regulator_init_data vddarm __initdata = {
 	.driver_data = &vddarm_pdata,
 };
 
-static struct regulator_consumer_supply vddint_consumers[] __initdata = {
+static struct regulator_consumer_supply vddint_consumers[] __devinitdata = {
 	REGULATOR_SUPPLY("vddint", NULL),
 };
 
-static struct regulator_init_data vddint __initdata = {
+static struct regulator_init_data vddint __devinitdata = {
 	.constraints = {
 		.name = "VDDINT",
 		.min_uV = 1000000,
@@ -408,27 +408,27 @@ static struct regulator_init_data vddint __initdata = {
 	.supply_regulator = "WALLVDD",
 };
 
-static struct regulator_init_data vddmem __initdata = {
+static struct regulator_init_data vddmem __devinitdata = {
 	.constraints = {
 		.name = "VDDMEM",
 		.always_on = 1,
 	},
 };
 
-static struct regulator_init_data vddsys __initdata = {
+static struct regulator_init_data vddsys __devinitdata = {
 	.constraints = {
 		.name = "VDDSYS,VDDEXT,VDDPCM,VDDSS",
 		.always_on = 1,
 	},
 };
 
-static struct regulator_consumer_supply vddmmc_consumers[] __initdata = {
+static struct regulator_consumer_supply vddmmc_consumers[] __devinitdata = {
 	REGULATOR_SUPPLY("vmmc", "s3c-sdhci.0"),
 	REGULATOR_SUPPLY("vmmc", "s3c-sdhci.1"),
 	REGULATOR_SUPPLY("vmmc", "s3c-sdhci.2"),
 };
 
-static struct regulator_init_data vddmmc __initdata = {
+static struct regulator_init_data vddmmc __devinitdata = {
 	.constraints = {
 		.name = "VDDMMC,UH",
 		.always_on = 1,
@@ -438,7 +438,7 @@ static struct regulator_init_data vddmmc __initdata = {
 	.supply_regulator = "WALLVDD",
 };
 
-static struct regulator_init_data vddotgi __initdata = {
+static struct regulator_init_data vddotgi __devinitdata = {
 	.constraints = {
 		.name = "VDDOTGi",
 		.always_on = 1,
@@ -446,7 +446,7 @@ static struct regulator_init_data vddotgi __initdata = {
 	.supply_regulator = "WALLVDD",
 };
 
-static struct regulator_init_data vddotg __initdata = {
+static struct regulator_init_data vddotg __devinitdata = {
 	.constraints = {
 		.name = "VDDOTG",
 		.always_on = 1,
@@ -454,7 +454,7 @@ static struct regulator_init_data vddotg __initdata = {
 	.supply_regulator = "WALLVDD",
 };
 
-static struct regulator_init_data vddhi __initdata = {
+static struct regulator_init_data vddhi __devinitdata = {
 	.constraints = {
 		.name = "VDDHI",
 		.always_on = 1,
@@ -462,7 +462,7 @@ static struct regulator_init_data vddhi __initdata = {
 	.supply_regulator = "WALLVDD",
 };
 
-static struct regulator_init_data vddadc __initdata = {
+static struct regulator_init_data vddadc __devinitdata = {
 	.constraints = {
 		.name = "VDDADC,VDDDAC",
 		.always_on = 1,
@@ -470,7 +470,7 @@ static struct regulator_init_data vddadc __initdata = {
 	.supply_regulator = "WALLVDD",
 };
 
-static struct regulator_init_data vddmem0 __initdata = {
+static struct regulator_init_data vddmem0 __devinitdata = {
 	.constraints = {
 		.name = "VDDMEM0",
 		.always_on = 1,
@@ -478,7 +478,7 @@ static struct regulator_init_data vddmem0 __initdata = {
 	.supply_regulator = "WALLVDD",
 };
 
-static struct regulator_init_data vddpll __initdata = {
+static struct regulator_init_data vddpll __devinitdata = {
 	.constraints = {
 		.name = "VDDPLL",
 		.always_on = 1,
@@ -486,7 +486,7 @@ static struct regulator_init_data vddpll __initdata = {
 	.supply_regulator = "WALLVDD",
 };
 
-static struct regulator_init_data vddlcd __initdata = {
+static struct regulator_init_data vddlcd __devinitdata = {
 	.constraints = {
 		.name = "VDDLCD",
 		.always_on = 1,
@@ -494,7 +494,7 @@ static struct regulator_init_data vddlcd __initdata = {
 	.supply_regulator = "WALLVDD",
 };
 
-static struct regulator_init_data vddalive __initdata = {
+static struct regulator_init_data vddalive __devinitdata = {
 	.constraints = {
 		.name = "VDDALIVE",
 		.always_on = 1,
@@ -502,28 +502,28 @@ static struct regulator_init_data vddalive __initdata = {
 	.supply_regulator = "WALLVDD",
 };
 
-static struct wm831x_backup_pdata banff_backup_pdata __initdata = {
+static struct wm831x_backup_pdata banff_backup_pdata __devinitdata = {
 	.charger_enable = 1,
 	.vlim = 2500,  /* mV */
 	.ilim = 200,   /* uA */
 };
 
-static struct wm831x_status_pdata banff_red_led __initdata = {
+static struct wm831x_status_pdata banff_red_led __devinitdata = {
 	.name = "banff:red:",
 	.default_src = WM831X_STATUS_MANUAL,
 };
 
-static struct wm831x_status_pdata banff_green_led __initdata = {
+static struct wm831x_status_pdata banff_green_led __devinitdata = {
 	.name = "banff:green:",
 	.default_src = WM831X_STATUS_MANUAL,
 };
 
-static struct wm831x_touch_pdata touch_pdata __initdata = {
+static struct wm831x_touch_pdata touch_pdata __devinitdata = {
 	.data_irq = S3C_EINT(26),
 	.pd_irq = S3C_EINT(27),
 };
 
-static struct wm831x_pdata crag_pmic_pdata __initdata = {
+static struct wm831x_pdata crag_pmic_pdata __devinitdata = {
 	.wm831x_num = 1,
 	.gpio_base = BANFF_PMIC_GPIO_BASE,
 	.soft_shutdown = true,
@@ -567,7 +567,7 @@ static struct wm831x_pdata crag_pmic_pdata __initdata = {
 	.touch = &touch_pdata,
 };
 
-static struct i2c_board_info i2c_devs0[] __initdata = {
+static struct i2c_board_info i2c_devs0[] __devinitdata = {
 	{ I2C_BOARD_INFO("24c08", 0x50), },
 	{ I2C_BOARD_INFO("tca6408", 0x20),
 	  .platform_data = &crag6410_pca_data,
@@ -582,12 +582,12 @@ static struct s3c2410_platform_i2c i2c0_pdata = {
 	.frequency = 400000,
 };
 
-static struct regulator_consumer_supply pvdd_1v2_consumers[] __initdata = {
+static struct regulator_consumer_supply pvdd_1v2_consumers[] __devinitdata = {
 	REGULATOR_SUPPLY("DCVDD", "spi0.0"),
 	REGULATOR_SUPPLY("AVDD", "spi0.0"),
 };
 
-static struct regulator_init_data pvdd_1v2 __initdata = {
+static struct regulator_init_data pvdd_1v2 __devinitdata = {
 	.constraints = {
 		.name = "PVDD_1V2",
 		.valid_ops_mask = REGULATOR_CHANGE_STATUS,
@@ -597,7 +597,7 @@ static struct regulator_init_data pvdd_1v2 __initdata = {
 	.num_consumer_supplies = ARRAY_SIZE(pvdd_1v2_consumers),
 };
 
-static struct regulator_consumer_supply pvdd_1v8_consumers[] __initdata = {
+static struct regulator_consumer_supply pvdd_1v8_consumers[] __devinitdata = {
 	REGULATOR_SUPPLY("LDOVDD", "1-001a"),
 	REGULATOR_SUPPLY("PLLVDD", "1-001a"),
 	REGULATOR_SUPPLY("DBVDD", "1-001a"),
@@ -611,7 +611,7 @@ static struct regulator_consumer_supply pvdd_1v8_consumers[] __initdata = {
 	REGULATOR_SUPPLY("DBVDD", "spi0.0"),
 };
 
-static struct regulator_init_data pvdd_1v8 __initdata = {
+static struct regulator_init_data pvdd_1v8 __devinitdata = {
 	.constraints = {
 		.name = "PVDD_1V8",
 		.always_on = 1,
@@ -621,12 +621,12 @@ static struct regulator_init_data pvdd_1v8 __initdata = {
 	.num_consumer_supplies = ARRAY_SIZE(pvdd_1v8_consumers),
 };
 
-static struct regulator_consumer_supply pvdd_3v3_consumers[] __initdata = {
+static struct regulator_consumer_supply pvdd_3v3_consumers[] __devinitdata = {
 	REGULATOR_SUPPLY("MICVDD", "1-001a"),
 	REGULATOR_SUPPLY("AVDD1", "1-001a"),
 };
 
-static struct regulator_init_data pvdd_3v3 __initdata = {
+static struct regulator_init_data pvdd_3v3 __devinitdata = {
 	.constraints = {
 		.name = "PVDD_3V3",
 		.always_on = 1,
@@ -636,7 +636,7 @@ static struct regulator_init_data pvdd_3v3 __initdata = {
 	.num_consumer_supplies = ARRAY_SIZE(pvdd_3v3_consumers),
 };
 
-static struct wm831x_pdata glenfarclas_pmic_pdata __initdata = {
+static struct wm831x_pdata glenfarclas_pmic_pdata __devinitdata = {
 	.wm831x_num = 2,
 	.irq_base = GLENFARCLAS_PMIC_IRQ_BASE,
 	.gpio_base = GLENFARCLAS_PMIC_GPIO_BASE,
@@ -668,7 +668,7 @@ static struct wm1250_ev1_pdata wm1250_ev1_pdata = {
 	},
 };
 
-static struct i2c_board_info i2c_devs1[] __initdata = {
+static struct i2c_board_info i2c_devs1[] __devinitdata = {
 	{ I2C_BOARD_INFO("wm8311", 0x34),
 	  .irq = S3C_EINT(0),
 	  .platform_data = &glenfarclas_pmic_pdata },
-- 
1.7.10
