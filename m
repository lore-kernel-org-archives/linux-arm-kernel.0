From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 29 Sep 2011 17:13:10 +0900
Subject: [PATCH 5/5] ARM: EXYNOS4: Add support SMDK4412 Board
Message-ID: <009801cc7e7f$a0c122a0$e24367e0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Changhwan Youn <chaos.youn@samsung.com>

SMDK4412 board is same as a SMDK4212 board except that
it has EXYNOS4412 SoC, thus it can share machine code
with SMDK4212.

This patch renames mach-smdk4212.c to mach-smdk4x12.c
to support both SMDK4212 and SMDK4412 board with one
machine file.

Signed-off-by: Changhwan Youn <chaos.youn@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-exynos4/Kconfig                      |    9 ++
 arch/arm/mach-exynos4/Makefile                     |    3 +-
 .../{mach-smdk4212.c => mach-smdk4x12.c}           |  128 +++++++++++---------
 3 files changed, 80 insertions(+), 60 deletions(-)
 rename arch/arm/mach-exynos4/{mach-smdk4212.c => mach-smdk4x12.c} (61%)

diff --git a/arch/arm/mach-exynos4/Kconfig b/arch/arm/mach-exynos4/Kconfig
index bf3e21d..6dfde07 100644
--- a/arch/arm/mach-exynos4/Kconfig
+++ b/arch/arm/mach-exynos4/Kconfig
@@ -278,6 +278,15 @@ config MACH_SMDK4212
 	help
 	  Machine support for Samsung SMDK4212
 
+comment "EXYNOS4412 Boards"
+
+config MACH_SMDK4412
+	bool "SMDK4412"
+	select SOC_EXYNOS4412
+	select MACH_SMDK4212
+	help
+	  Machine support for Samsung SMDK4412
+
 endmenu
 
 comment "Configuration for HSMMC bus width"
diff --git a/arch/arm/mach-exynos4/Makefile b/arch/arm/mach-exynos4/Makefile
index e19cd12..c9b2e1f 100644
--- a/arch/arm/mach-exynos4/Makefile
+++ b/arch/arm/mach-exynos4/Makefile
@@ -34,7 +34,8 @@ obj-$(CONFIG_MACH_UNIVERSAL_C210)	+= mach-universal_c210.o
 obj-$(CONFIG_MACH_NURI)			+= mach-nuri.o
 obj-$(CONFIG_MACH_ORIGEN)		+= mach-origen.o
 
-obj-$(CONFIG_MACH_SMDK4212)		+= mach-smdk4212.o
+obj-$(CONFIG_MACH_SMDK4212)		+= mach-smdk4x12.o
+obj-$(CONFIG_MACH_SMDK4412)		+= mach-smdk4x12.o
 
 # device support
 
diff --git a/arch/arm/mach-exynos4/mach-smdk4212.c b/arch/arm/mach-exynos4/mach-smdk4x12.c
similarity index 61%
rename from arch/arm/mach-exynos4/mach-smdk4212.c
rename to arch/arm/mach-exynos4/mach-smdk4x12.c
index 3479a93..fcf2e0e 100644
--- a/arch/arm/mach-exynos4/mach-smdk4212.c
+++ b/arch/arm/mach-exynos4/mach-smdk4x12.c
@@ -1,5 +1,5 @@
 /*
- * linux/arch/arm/mach-exynos4/mach-smdk4212.c
+ * linux/arch/arm/mach-exynos4/mach-smdk4x12.c
  *
  * Copyright (c) 2011 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
@@ -37,51 +37,51 @@
 #include <mach/map.h>
 
 /* Following are default values for UCON, ULCON and UFCON UART registers */
-#define SMDK4212_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
+#define SMDK4X12_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
 				 S3C2410_UCON_RXILEVEL |	\
 				 S3C2410_UCON_TXIRQMODE |	\
 				 S3C2410_UCON_RXIRQMODE |	\
 				 S3C2410_UCON_RXFIFO_TOI |	\
 				 S3C2443_UCON_RXERR_IRQEN)
 
-#define SMDK4212_ULCON_DEFAULT	S3C2410_LCON_CS8
+#define SMDK4X12_ULCON_DEFAULT	S3C2410_LCON_CS8
 
-#define SMDK4212_UFCON_DEFAULT	(S3C2410_UFCON_FIFOMODE |	\
+#define SMDK4X12_UFCON_DEFAULT	(S3C2410_UFCON_FIFOMODE |	\
 				 S5PV210_UFCON_TXTRIG4 |	\
 				 S5PV210_UFCON_RXTRIG4)
 
-static struct s3c2410_uartcfg smdk4212_uartcfgs[] __initdata = {
+static struct s3c2410_uartcfg smdk4x12_uartcfgs[] __initdata = {
 	[0] = {
 		.hwport		= 0,
 		.flags		= 0,
-		.ucon		= SMDK4212_UCON_DEFAULT,
-		.ulcon		= SMDK4212_ULCON_DEFAULT,
-		.ufcon		= SMDK4212_UFCON_DEFAULT,
+		.ucon		= SMDK4X12_UCON_DEFAULT,
+		.ulcon		= SMDK4X12_ULCON_DEFAULT,
+		.ufcon		= SMDK4X12_UFCON_DEFAULT,
 	},
 	[1] = {
 		.hwport		= 1,
 		.flags		= 0,
-		.ucon		= SMDK4212_UCON_DEFAULT,
-		.ulcon		= SMDK4212_ULCON_DEFAULT,
-		.ufcon		= SMDK4212_UFCON_DEFAULT,
+		.ucon		= SMDK4X12_UCON_DEFAULT,
+		.ulcon		= SMDK4X12_ULCON_DEFAULT,
+		.ufcon		= SMDK4X12_UFCON_DEFAULT,
 	},
 	[2] = {
 		.hwport		= 2,
 		.flags		= 0,
-		.ucon		= SMDK4212_UCON_DEFAULT,
-		.ulcon		= SMDK4212_ULCON_DEFAULT,
-		.ufcon		= SMDK4212_UFCON_DEFAULT,
+		.ucon		= SMDK4X12_UCON_DEFAULT,
+		.ulcon		= SMDK4X12_ULCON_DEFAULT,
+		.ufcon		= SMDK4X12_UFCON_DEFAULT,
 	},
 	[3] = {
 		.hwport		= 3,
 		.flags		= 0,
-		.ucon		= SMDK4212_UCON_DEFAULT,
-		.ulcon		= SMDK4212_ULCON_DEFAULT,
-		.ufcon		= SMDK4212_UFCON_DEFAULT,
+		.ucon		= SMDK4X12_UCON_DEFAULT,
+		.ulcon		= SMDK4X12_ULCON_DEFAULT,
+		.ufcon		= SMDK4X12_UFCON_DEFAULT,
 	},
 };
 
-static struct s3c_sdhci_platdata smdk4212_hsmmc2_pdata __initdata = {
+static struct s3c_sdhci_platdata smdk4x12_hsmmc2_pdata __initdata = {
 	.cd_type		= S3C_SDHCI_CD_INTERNAL,
 	.clk_type		= S3C_SDHCI_CLK_DIV_EXTERNAL,
 #ifdef CONFIG_EXYNOS4_SDHCI_CH2_8BIT
@@ -90,7 +90,7 @@ static struct s3c_sdhci_platdata smdk4212_hsmmc2_pdata __initdata = {
 #endif
 };
 
-static struct s3c_sdhci_platdata smdk4212_hsmmc3_pdata __initdata = {
+static struct s3c_sdhci_platdata smdk4x12_hsmmc3_pdata __initdata = {
 	.cd_type		= S3C_SDHCI_CD_INTERNAL,
 	.clk_type		= S3C_SDHCI_CLK_DIV_EXTERNAL,
 };
@@ -106,7 +106,7 @@ static struct regulator_consumer_supply max8997_buck3 =
 
 static struct regulator_init_data max8997_buck1_data = {
 	.constraints	= {
-		.name		= "VDD_ARM_SMDK4212",
+		.name		= "VDD_ARM_SMDK4X12",
 		.min_uV		= 925000,
 		.max_uV		= 1350000,
 		.always_on	= 1,
@@ -121,7 +121,7 @@ static struct regulator_init_data max8997_buck1_data = {
 
 static struct regulator_init_data max8997_buck2_data = {
 	.constraints	= {
-		.name		= "VDD_INT_SMDK4212",
+		.name		= "VDD_INT_SMDK4X12",
 		.min_uV		= 950000,
 		.max_uV		= 1150000,
 		.always_on	= 1,
@@ -136,7 +136,7 @@ static struct regulator_init_data max8997_buck2_data = {
 
 static struct regulator_init_data max8997_buck3_data = {
 	.constraints	= {
-		.name		= "VDD_G3D_SMDK4212",
+		.name		= "VDD_G3D_SMDK4X12",
 		.min_uV		= 950000,
 		.max_uV		= 1150000,
 		.valid_ops_mask	= REGULATOR_CHANGE_VOLTAGE |
@@ -149,15 +149,15 @@ static struct regulator_init_data max8997_buck3_data = {
 	.consumer_supplies	= &max8997_buck3,
 };
 
-static struct max8997_regulator_data smdk4212_max8997_regulators[] = {
+static struct max8997_regulator_data smdk4x12_max8997_regulators[] = {
 	{ MAX8997_BUCK1, &max8997_buck1_data },
 	{ MAX8997_BUCK2, &max8997_buck2_data },
 	{ MAX8997_BUCK3, &max8997_buck3_data },
 };
 
-static struct max8997_platform_data smdk4212_max8997_pdata = {
-	.num_regulators	= ARRAY_SIZE(smdk4212_max8997_regulators),
-	.regulators	= smdk4212_max8997_regulators,
+static struct max8997_platform_data smdk4x12_max8997_pdata = {
+	.num_regulators	= ARRAY_SIZE(smdk4x12_max8997_regulators),
+	.regulators	= smdk4x12_max8997_regulators,
 
 	.buck1_voltage[0] = 1100000,	/* 1.1V */
 	.buck1_voltage[1] = 1100000,	/* 1.1V */
@@ -187,53 +187,53 @@ static struct max8997_platform_data smdk4212_max8997_pdata = {
 	.buck5_voltage[7] = 1100000,	/* 1.1V */
 };
 
-static struct i2c_board_info smdk4212_i2c_devs0[] __initdata = {
+static struct i2c_board_info smdk4x12_i2c_devs0[] __initdata = {
 	{
 		I2C_BOARD_INFO("max8997", 0x66),
-		.platform_data	= &smdk4212_max8997_pdata,
+		.platform_data	= &smdk4x12_max8997_pdata,
 	}
 };
 
-static struct i2c_board_info smdk4212_i2c_devs1[] __initdata = {
+static struct i2c_board_info smdk4x12_i2c_devs1[] __initdata = {
 	{ I2C_BOARD_INFO("wm8994", 0x1a), }
 };
 
-static struct i2c_board_info smdk4212_i2c_devs3[] __initdata = {
+static struct i2c_board_info smdk4x12_i2c_devs3[] __initdata = {
 	/* nothing here yet */
 };
 
-static struct i2c_board_info smdk4212_i2c_devs7[] __initdata = {
+static struct i2c_board_info smdk4x12_i2c_devs7[] __initdata = {
 	/* nothing here yet */
 };
 
-static struct samsung_bl_gpio_info smdk4212_bl_gpio_info = {
+static struct samsung_bl_gpio_info smdk4x12_bl_gpio_info = {
 	.no = EXYNOS4_GPD0(1),
 	.func = S3C_GPIO_SFN(2),
 };
 
-static struct platform_pwm_backlight_data smdk4212_bl_data = {
+static struct platform_pwm_backlight_data smdk4x12_bl_data = {
 	.pwm_id = 1,
 	.pwm_period_ns  = 1000,
 };
 
-static uint32_t smdk4212_keymap[] __initdata = {
+static uint32_t smdk4x12_keymap[] __initdata = {
 	/* KEY(row, col, keycode) */
 	KEY(1, 0, KEY_D), KEY(1, 1, KEY_A), KEY(1, 2, KEY_B),
 	KEY(1, 3, KEY_E), KEY(1, 4, KEY_C)
 };
 
-static struct matrix_keymap_data smdk4212_keymap_data __initdata = {
-	.keymap		= smdk4212_keymap,
-	.keymap_size	= ARRAY_SIZE(smdk4212_keymap),
+static struct matrix_keymap_data smdk4x12_keymap_data __initdata = {
+	.keymap		= smdk4x12_keymap,
+	.keymap_size	= ARRAY_SIZE(smdk4x12_keymap),
 };
 
-static struct samsung_keypad_platdata smdk4212_keypad_data __initdata = {
-	.keymap_data	= &smdk4212_keymap_data,
+static struct samsung_keypad_platdata smdk4x12_keypad_data __initdata = {
+	.keymap_data	= &smdk4x12_keymap_data,
 	.rows		= 2,
 	.cols		= 5,
 };
 
-static struct platform_device *smdk4212_devices[] __initdata = {
+static struct platform_device *smdk4x12_devices[] __initdata = {
 	&s3c_device_hsmmc2,
 	&s3c_device_hsmmc3,
 	&s3c_device_i2c0,
@@ -245,48 +245,58 @@ static struct platform_device *smdk4212_devices[] __initdata = {
 	&samsung_device_keypad,
 };
 
-static void __init smdk4212_map_io(void)
+static void __init smdk4x12_map_io(void)
 {
 	clk_xusbxti.rate = 24000000;
 
 	s5p_init_io(NULL, 0, S5P_VA_CHIPID);
 	s3c24xx_init_clocks(clk_xusbxti.rate);
-	s3c24xx_init_uarts(smdk4212_uartcfgs, ARRAY_SIZE(smdk4212_uartcfgs));
+	s3c24xx_init_uarts(smdk4x12_uartcfgs, ARRAY_SIZE(smdk4x12_uartcfgs));
 }
 
-static void __init smdk4212_machine_init(void)
+static void __init smdk4x12_machine_init(void)
 {
 	s3c_i2c0_set_platdata(NULL);
-	i2c_register_board_info(0, smdk4212_i2c_devs0,
-				ARRAY_SIZE(smdk4212_i2c_devs0));
+	i2c_register_board_info(0, smdk4x12_i2c_devs0,
+				ARRAY_SIZE(smdk4x12_i2c_devs0));
 
 	s3c_i2c1_set_platdata(NULL);
-	i2c_register_board_info(1, smdk4212_i2c_devs1,
-				ARRAY_SIZE(smdk4212_i2c_devs1));
+	i2c_register_board_info(1, smdk4x12_i2c_devs1,
+				ARRAY_SIZE(smdk4x12_i2c_devs1));
 
 	s3c_i2c3_set_platdata(NULL);
-	i2c_register_board_info(3, smdk4212_i2c_devs3,
-				ARRAY_SIZE(smdk4212_i2c_devs3));
+	i2c_register_board_info(3, smdk4x12_i2c_devs3,
+				ARRAY_SIZE(smdk4x12_i2c_devs3));
 
 	s3c_i2c7_set_platdata(NULL);
-	i2c_register_board_info(7, smdk4212_i2c_devs7,
-				ARRAY_SIZE(smdk4212_i2c_devs7));
+	i2c_register_board_info(7, smdk4x12_i2c_devs7,
+				ARRAY_SIZE(smdk4x12_i2c_devs7));
 
-	samsung_bl_set(&smdk4212_bl_gpio_info, &smdk4212_bl_data);
+	samsung_bl_set(&smdk4x12_bl_gpio_info, &smdk4x12_bl_data);
 
-	samsung_keypad_set_platdata(&smdk4212_keypad_data);
+	samsung_keypad_set_platdata(&smdk4x12_keypad_data);
 
-	s3c_sdhci2_set_platdata(&smdk4212_hsmmc2_pdata);
-	s3c_sdhci3_set_platdata(&smdk4212_hsmmc3_pdata);
+	s3c_sdhci2_set_platdata(&smdk4x12_hsmmc2_pdata);
+	s3c_sdhci3_set_platdata(&smdk4x12_hsmmc3_pdata);
 
-	platform_add_devices(smdk4212_devices, ARRAY_SIZE(smdk4212_devices));
+	platform_add_devices(smdk4x12_devices, ARRAY_SIZE(smdk4x12_devices));
 }
 
 MACHINE_START(SMDK4212, "SMDK4212")
 	/* Maintainer: Kukjin Kim <kgene.kim@samsung.com> */
-	.boot_params	= S5P_PA_SDRAM + 0x100,
+	.atag_offset	= 0x100,
 	.init_irq	= exynos4_init_irq,
-	.map_io		= smdk4212_map_io,
-	.init_machine	= smdk4212_machine_init,
+	.map_io		= smdk4x12_map_io,
+	.init_machine	= smdk4x12_machine_init,
+	.timer		= &exynos4_timer,
+MACHINE_END
+
+MACHINE_START(SMDK4412, "SMDK4412")
+	/* Maintainer: Kukjin Kim <kgene.kim@samsung.com> */
+	/* Maintainer: Changhwan Youn <chaos.youn@samsung.com> */
+	.atag_offset	= 0x100,
+	.init_irq	= exynos4_init_irq,
+	.map_io		= smdk4x12_map_io,
+	.init_machine	= smdk4x12_machine_init,
 	.timer		= &exynos4_timer,
 MACHINE_END
-- 
1.7.1
