From: wfp5p@virginia.edu (Bill Pemberton)
Date: Mon, 19 Nov 2012 13:24:49 -0500
Subject: [PATCH 340/493] arm: remove use of __devinitdata
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Message-ID: <1353349642-3677-340-git-send-email-wfp5p@virginia.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_HOTPLUG is going away as an option so __devinitdata is no
longer needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: Will Deacon <will.deacon@arm.com> 
Cc: Russell King <linux@arm.linux.org.uk> 
Cc: Ben Dooks <ben-linux@fluff.org> 
Cc: Kukjin Kim <kgene.kim@samsung.com> 
Cc: linux-arm-kernel at lists.infradead.org 
Cc: patches at opensource.wolfsonmicro.com 
Cc: linux-samsung-soc at vger.kernel.org 
Cc: linux-tegra at vger.kernel.org 
---
 arch/arm/kernel/perf_event_cpu.c             |  4 +-
 arch/arm/mach-s3c64xx/mach-crag6410-module.c |  2 +-
 arch/arm/mach-s3c64xx/mach-crag6410.c        | 68 ++++++++++++++--------------
 arch/arm/mach-sa1100/neponset.c              |  2 +-
 arch/arm/mach-tegra/tegra2_emc.c             |  2 +-
 5 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/arch/arm/kernel/perf_event_cpu.c b/arch/arm/kernel/perf_event_cpu.c
index cfc2728..5f66206 100644
--- a/arch/arm/kernel/perf_event_cpu.c
+++ b/arch/arm/kernel/perf_event_cpu.c
@@ -178,7 +178,7 @@ static struct notifier_block __cpuinitdata cpu_pmu_hotplug_notifier = {
 /*
  * PMU platform driver and devicetree bindings.
  */
-static struct of_device_id __devinitdata cpu_pmu_of_device_ids[] = {
+static struct of_device_id cpu_pmu_of_device_ids[] = {
 	{.compatible = "arm,cortex-a15-pmu",	.data = armv7_a15_pmu_init},
 	{.compatible = "arm,cortex-a9-pmu",	.data = armv7_a9_pmu_init},
 	{.compatible = "arm,cortex-a8-pmu",	.data = armv7_a8_pmu_init},
@@ -190,7 +190,7 @@ static struct of_device_id __devinitdata cpu_pmu_of_device_ids[] = {
 	{},
 };
 
-static struct platform_device_id __devinitdata cpu_pmu_plat_device_ids[] = {
+static struct platform_device_id cpu_pmu_plat_device_ids[] = {
 	{.name = "arm-pmu"},
 	{},
 };
diff --git a/arch/arm/mach-s3c64xx/mach-crag6410-module.c b/arch/arm/mach-s3c64xx/mach-crag6410-module.c
index b4f7600c..ea42289 100644
--- a/arch/arm/mach-s3c64xx/mach-crag6410-module.c
+++ b/arch/arm/mach-s3c64xx/mach-crag6410-module.c
@@ -290,7 +290,7 @@ static const struct i2c_board_info wm2200_i2c[] = {
 	  .platform_data = &wm2200_pdata, },
 };
 
-static __devinitdata const struct {
+static const struct {
 	u8 id;
 	u8 rev;
 	const char *name;
diff --git a/arch/arm/mach-s3c64xx/mach-crag6410.c b/arch/arm/mach-s3c64xx/mach-crag6410.c
index 2abe95d..24ce994 100644
--- a/arch/arm/mach-s3c64xx/mach-crag6410.c
+++ b/arch/arm/mach-s3c64xx/mach-crag6410.c
@@ -171,7 +171,7 @@ static struct fb_videomode crag6410_lcd_timing = {
 };
 
 /* 405566 clocks per frame => 60Hz refresh requires 24333960Hz clock */
-static struct s3c_fb_platdata crag6410_lcd_pdata __devinitdata = {
+static struct s3c_fb_platdata crag6410_lcd_pdata = {
 	.setup_gpio	= s3c64xx_fb_gpio_setup_24bpp,
 	.vtiming	= &crag6410_lcd_timing,
 	.win[0]		= &crag6410_fb_win0,
@@ -181,7 +181,7 @@ static struct s3c_fb_platdata crag6410_lcd_pdata __devinitdata = {
 
 /* 2x6 keypad */
 
-static uint32_t crag6410_keymap[] __devinitdata = {
+static uint32_t crag6410_keymap[] = {
 	/* KEY(row, col, keycode) */
 	KEY(0, 0, KEY_VOLUMEUP),
 	KEY(0, 1, KEY_HOME),
@@ -197,12 +197,12 @@ static uint32_t crag6410_keymap[] __devinitdata = {
 	KEY(1, 5, KEY_CAMERA),
 };
 
-static struct matrix_keymap_data crag6410_keymap_data __devinitdata = {
+static struct matrix_keymap_data crag6410_keymap_data = {
 	.keymap		= crag6410_keymap,
 	.keymap_size	= ARRAY_SIZE(crag6410_keymap),
 };
 
-static struct samsung_keypad_platdata crag6410_keypad_data __devinitdata = {
+static struct samsung_keypad_platdata crag6410_keypad_data = {
 	.keymap_data	= &crag6410_keymap_data,
 	.rows		= 2,
 	.cols		= 6,
@@ -392,11 +392,11 @@ static struct wm831x_buckv_pdata vddarm_pdata = {
 	.dvs_gpio = S3C64XX_GPK(0),
 };
 
-static struct regulator_consumer_supply vddarm_consumers[] __devinitdata = {
+static struct regulator_consumer_supply vddarm_consumers[] = {
 	REGULATOR_SUPPLY("vddarm", NULL),
 };
 
-static struct regulator_init_data vddarm __devinitdata = {
+static struct regulator_init_data vddarm = {
 	.constraints = {
 		.name = "VDDARM",
 		.min_uV = 1000000,
@@ -410,11 +410,11 @@ static struct regulator_init_data vddarm __devinitdata = {
 	.driver_data = &vddarm_pdata,
 };
 
-static struct regulator_consumer_supply vddint_consumers[] __devinitdata = {
+static struct regulator_consumer_supply vddint_consumers[] = {
 	REGULATOR_SUPPLY("vddint", NULL),
 };
 
-static struct regulator_init_data vddint __devinitdata = {
+static struct regulator_init_data vddint = {
 	.constraints = {
 		.name = "VDDINT",
 		.min_uV = 1000000,
@@ -427,27 +427,27 @@ static struct regulator_init_data vddint __devinitdata = {
 	.supply_regulator = "WALLVDD",
 };
 
-static struct regulator_init_data vddmem __devinitdata = {
+static struct regulator_init_data vddmem = {
 	.constraints = {
 		.name = "VDDMEM",
 		.always_on = 1,
 	},
 };
 
-static struct regulator_init_data vddsys __devinitdata = {
+static struct regulator_init_data vddsys = {
 	.constraints = {
 		.name = "VDDSYS,VDDEXT,VDDPCM,VDDSS",
 		.always_on = 1,
 	},
 };
 
-static struct regulator_consumer_supply vddmmc_consumers[] __devinitdata = {
+static struct regulator_consumer_supply vddmmc_consumers[] = {
 	REGULATOR_SUPPLY("vmmc", "s3c-sdhci.0"),
 	REGULATOR_SUPPLY("vmmc", "s3c-sdhci.1"),
 	REGULATOR_SUPPLY("vmmc", "s3c-sdhci.2"),
 };
 
-static struct regulator_init_data vddmmc __devinitdata = {
+static struct regulator_init_data vddmmc = {
 	.constraints = {
 		.name = "VDDMMC,UH",
 		.always_on = 1,
@@ -457,7 +457,7 @@ static struct regulator_init_data vddmmc __devinitdata = {
 	.supply_regulator = "WALLVDD",
 };
 
-static struct regulator_init_data vddotgi __devinitdata = {
+static struct regulator_init_data vddotgi = {
 	.constraints = {
 		.name = "VDDOTGi",
 		.always_on = 1,
@@ -465,7 +465,7 @@ static struct regulator_init_data vddotgi __devinitdata = {
 	.supply_regulator = "WALLVDD",
 };
 
-static struct regulator_init_data vddotg __devinitdata = {
+static struct regulator_init_data vddotg = {
 	.constraints = {
 		.name = "VDDOTG",
 		.always_on = 1,
@@ -473,7 +473,7 @@ static struct regulator_init_data vddotg __devinitdata = {
 	.supply_regulator = "WALLVDD",
 };
 
-static struct regulator_init_data vddhi __devinitdata = {
+static struct regulator_init_data vddhi = {
 	.constraints = {
 		.name = "VDDHI",
 		.always_on = 1,
@@ -481,7 +481,7 @@ static struct regulator_init_data vddhi __devinitdata = {
 	.supply_regulator = "WALLVDD",
 };
 
-static struct regulator_init_data vddadc __devinitdata = {
+static struct regulator_init_data vddadc = {
 	.constraints = {
 		.name = "VDDADC,VDDDAC",
 		.always_on = 1,
@@ -489,7 +489,7 @@ static struct regulator_init_data vddadc __devinitdata = {
 	.supply_regulator = "WALLVDD",
 };
 
-static struct regulator_init_data vddmem0 __devinitdata = {
+static struct regulator_init_data vddmem0 = {
 	.constraints = {
 		.name = "VDDMEM0",
 		.always_on = 1,
@@ -497,7 +497,7 @@ static struct regulator_init_data vddmem0 __devinitdata = {
 	.supply_regulator = "WALLVDD",
 };
 
-static struct regulator_init_data vddpll __devinitdata = {
+static struct regulator_init_data vddpll = {
 	.constraints = {
 		.name = "VDDPLL",
 		.always_on = 1,
@@ -505,7 +505,7 @@ static struct regulator_init_data vddpll __devinitdata = {
 	.supply_regulator = "WALLVDD",
 };
 
-static struct regulator_init_data vddlcd __devinitdata = {
+static struct regulator_init_data vddlcd = {
 	.constraints = {
 		.name = "VDDLCD",
 		.always_on = 1,
@@ -513,7 +513,7 @@ static struct regulator_init_data vddlcd __devinitdata = {
 	.supply_regulator = "WALLVDD",
 };
 
-static struct regulator_init_data vddalive __devinitdata = {
+static struct regulator_init_data vddalive = {
 	.constraints = {
 		.name = "VDDALIVE",
 		.always_on = 1,
@@ -521,28 +521,28 @@ static struct regulator_init_data vddalive __devinitdata = {
 	.supply_regulator = "WALLVDD",
 };
 
-static struct wm831x_backup_pdata banff_backup_pdata __devinitdata = {
+static struct wm831x_backup_pdata banff_backup_pdata = {
 	.charger_enable = 1,
 	.vlim = 2500,  /* mV */
 	.ilim = 200,   /* uA */
 };
 
-static struct wm831x_status_pdata banff_red_led __devinitdata = {
+static struct wm831x_status_pdata banff_red_led = {
 	.name = "banff:red:",
 	.default_src = WM831X_STATUS_MANUAL,
 };
 
-static struct wm831x_status_pdata banff_green_led __devinitdata = {
+static struct wm831x_status_pdata banff_green_led = {
 	.name = "banff:green:",
 	.default_src = WM831X_STATUS_MANUAL,
 };
 
-static struct wm831x_touch_pdata touch_pdata __devinitdata = {
+static struct wm831x_touch_pdata touch_pdata = {
 	.data_irq = S3C_EINT(26),
 	.pd_irq = S3C_EINT(27),
 };
 
-static struct wm831x_pdata crag_pmic_pdata __devinitdata = {
+static struct wm831x_pdata crag_pmic_pdata = {
 	.wm831x_num = 1,
 	.gpio_base = BANFF_PMIC_GPIO_BASE,
 	.soft_shutdown = true,
@@ -586,7 +586,7 @@ static struct wm831x_pdata crag_pmic_pdata __devinitdata = {
 	.touch = &touch_pdata,
 };
 
-static struct i2c_board_info i2c_devs0[] __devinitdata = {
+static struct i2c_board_info i2c_devs0[] = {
 	{ I2C_BOARD_INFO("24c08", 0x50), },
 	{ I2C_BOARD_INFO("tca6408", 0x20),
 	  .platform_data = &crag6410_pca_data,
@@ -601,13 +601,13 @@ static struct s3c2410_platform_i2c i2c0_pdata = {
 	.frequency = 400000,
 };
 
-static struct regulator_consumer_supply pvdd_1v2_consumers[] __devinitdata = {
+static struct regulator_consumer_supply pvdd_1v2_consumers[] = {
 	REGULATOR_SUPPLY("DCVDD", "spi0.0"),
 	REGULATOR_SUPPLY("AVDD", "spi0.0"),
 	REGULATOR_SUPPLY("AVDD", "spi0.1"),
 };
 
-static struct regulator_init_data pvdd_1v2 __devinitdata = {
+static struct regulator_init_data pvdd_1v2 = {
 	.constraints = {
 		.name = "PVDD_1V2",
 		.valid_ops_mask = REGULATOR_CHANGE_STATUS,
@@ -617,7 +617,7 @@ static struct regulator_init_data pvdd_1v2 __devinitdata = {
 	.num_consumer_supplies = ARRAY_SIZE(pvdd_1v2_consumers),
 };
 
-static struct regulator_consumer_supply pvdd_1v8_consumers[] __devinitdata = {
+static struct regulator_consumer_supply pvdd_1v8_consumers[] = {
 	REGULATOR_SUPPLY("LDOVDD", "1-001a"),
 	REGULATOR_SUPPLY("PLLVDD", "1-001a"),
 	REGULATOR_SUPPLY("DBVDD", "1-001a"),
@@ -649,7 +649,7 @@ static struct regulator_consumer_supply pvdd_1v8_consumers[] __devinitdata = {
 	REGULATOR_SUPPLY("CPVDD", "wm5110-codec"),
 };
 
-static struct regulator_init_data pvdd_1v8 __devinitdata = {
+static struct regulator_init_data pvdd_1v8 = {
 	.constraints = {
 		.name = "PVDD_1V8",
 		.always_on = 1,
@@ -659,12 +659,12 @@ static struct regulator_init_data pvdd_1v8 __devinitdata = {
 	.num_consumer_supplies = ARRAY_SIZE(pvdd_1v8_consumers),
 };
 
-static struct regulator_consumer_supply pvdd_3v3_consumers[] __devinitdata = {
+static struct regulator_consumer_supply pvdd_3v3_consumers[] = {
 	REGULATOR_SUPPLY("MICVDD", "1-001a"),
 	REGULATOR_SUPPLY("AVDD1", "1-001a"),
 };
 
-static struct regulator_init_data pvdd_3v3 __devinitdata = {
+static struct regulator_init_data pvdd_3v3 = {
 	.constraints = {
 		.name = "PVDD_3V3",
 		.always_on = 1,
@@ -674,7 +674,7 @@ static struct regulator_init_data pvdd_3v3 __devinitdata = {
 	.num_consumer_supplies = ARRAY_SIZE(pvdd_3v3_consumers),
 };
 
-static struct wm831x_pdata glenfarclas_pmic_pdata __devinitdata = {
+static struct wm831x_pdata glenfarclas_pmic_pdata = {
 	.wm831x_num = 2,
 	.irq_base = GLENFARCLAS_PMIC_IRQ_BASE,
 	.gpio_base = GLENFARCLAS_PMIC_GPIO_BASE,
@@ -706,7 +706,7 @@ static struct wm1250_ev1_pdata wm1250_ev1_pdata = {
 	},
 };
 
-static struct i2c_board_info i2c_devs1[] __devinitdata = {
+static struct i2c_board_info i2c_devs1[] = {
 	{ I2C_BOARD_INFO("wm8311", 0x34),
 	  .irq = S3C_EINT(0),
 	  .platform_data = &glenfarclas_pmic_pdata },
diff --git a/arch/arm/mach-sa1100/neponset.c b/arch/arm/mach-sa1100/neponset.c
index a039b54..195d8bb 100644
--- a/arch/arm/mach-sa1100/neponset.c
+++ b/arch/arm/mach-sa1100/neponset.c
@@ -154,7 +154,7 @@ static u_int neponset_get_mctrl(struct uart_port *port)
 	return ret;
 }
 
-static struct sa1100_port_fns neponset_port_fns __devinitdata = {
+static struct sa1100_port_fns neponset_port_fns = {
 	.set_mctrl	= neponset_set_mctrl,
 	.get_mctrl	= neponset_get_mctrl,
 };
diff --git a/arch/arm/mach-tegra/tegra2_emc.c b/arch/arm/mach-tegra/tegra2_emc.c
index 30f40de..e18aa2f 100644
--- a/arch/arm/mach-tegra/tegra2_emc.c
+++ b/arch/arm/mach-tegra/tegra2_emc.c
@@ -333,7 +333,7 @@ static int tegra_emc_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static struct of_device_id tegra_emc_of_match[] __devinitdata = {
+static struct of_device_id tegra_emc_of_match[] = {
 	{ .compatible = "nvidia,tegra20-emc", },
 	{ },
 };
-- 
1.8.0
