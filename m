From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 28 Aug 2012 12:06:19 +0200
Subject: [PATCH 1/3] ARM: EXYNOS: Use EXYNOS4210_GPEx instead of EXYNOS4_GPEx
In-Reply-To: <4648723.rWnut7F0uJ@amdc1227>
References: <4648723.rWnut7F0uJ@amdc1227>
Message-ID: <14029212.D3MKvQZpbq@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GPEx gpios are specific to Exynos4210 and do not exist on Exynos4x12.
Redefine them to use the exact SoC name.

Based on "ARM: EXYYNOS: Use EXYNOS4210_GPEx instead of EXYNOS4_GPEx" by
Joonyoung Shim, see:
http://lists.infradead.org/pipermail/linux-arm-kernel/2012-May/100738.html

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
---
 arch/arm/mach-exynos/include/mach/gpio.h   | 32 +++++++++++++++---------------
 arch/arm/mach-exynos/mach-nuri.c           | 16 +++++++--------
 arch/arm/mach-exynos/mach-origen.c         |  6 +++---
 arch/arm/mach-exynos/mach-trats.c          |  4 ++--
 arch/arm/mach-exynos/mach-universal_c210.c | 32 +++++++++++++++---------------
 arch/arm/mach-exynos/setup-fimc.c          |  4 ++--
 drivers/gpio/gpio-samsung.c                | 20 +++++++++----------
 7 files changed, 57 insertions(+), 57 deletions(-)

diff --git a/arch/arm/mach-exynos/include/mach/gpio.h b/arch/arm/mach-exynos/include/mach/gpio.h
index eb24f1e..21c9bf1 100644
--- a/arch/arm/mach-exynos/include/mach/gpio.h
+++ b/arch/arm/mach-exynos/include/mach/gpio.h
@@ -26,11 +26,11 @@
 #define EXYNOS4_GPIO_C1_NR	(5)
 #define EXYNOS4_GPIO_D0_NR	(4)
 #define EXYNOS4_GPIO_D1_NR	(4)
-#define EXYNOS4_GPIO_E0_NR	(5)
-#define EXYNOS4_GPIO_E1_NR	(8)
-#define EXYNOS4_GPIO_E2_NR	(6)
-#define EXYNOS4_GPIO_E3_NR	(8)
-#define EXYNOS4_GPIO_E4_NR	(8)
+#define EXYNOS4210_GPIO_E0_NR	(5)
+#define EXYNOS4210_GPIO_E1_NR	(8)
+#define EXYNOS4210_GPIO_E2_NR	(6)
+#define EXYNOS4210_GPIO_E3_NR	(8)
+#define EXYNOS4210_GPIO_E4_NR	(8)
 #define EXYNOS4_GPIO_F0_NR	(8)
 #define EXYNOS4_GPIO_F1_NR	(8)
 #define EXYNOS4_GPIO_F2_NR	(8)
@@ -67,12 +67,12 @@ enum exynos4_gpio_number {
 	EXYNOS4_GPIO_C1_START	= EXYNOS_GPIO_NEXT(EXYNOS4_GPIO_C0),
 	EXYNOS4_GPIO_D0_START	= EXYNOS_GPIO_NEXT(EXYNOS4_GPIO_C1),
 	EXYNOS4_GPIO_D1_START	= EXYNOS_GPIO_NEXT(EXYNOS4_GPIO_D0),
-	EXYNOS4_GPIO_E0_START	= EXYNOS_GPIO_NEXT(EXYNOS4_GPIO_D1),
-	EXYNOS4_GPIO_E1_START	= EXYNOS_GPIO_NEXT(EXYNOS4_GPIO_E0),
-	EXYNOS4_GPIO_E2_START	= EXYNOS_GPIO_NEXT(EXYNOS4_GPIO_E1),
-	EXYNOS4_GPIO_E3_START	= EXYNOS_GPIO_NEXT(EXYNOS4_GPIO_E2),
-	EXYNOS4_GPIO_E4_START	= EXYNOS_GPIO_NEXT(EXYNOS4_GPIO_E3),
-	EXYNOS4_GPIO_F0_START	= EXYNOS_GPIO_NEXT(EXYNOS4_GPIO_E4),
+	EXYNOS4210_GPIO_E0_START	= EXYNOS_GPIO_NEXT(EXYNOS4_GPIO_D1),
+	EXYNOS4210_GPIO_E1_START	= EXYNOS_GPIO_NEXT(EXYNOS4210_GPIO_E0),
+	EXYNOS4210_GPIO_E2_START	= EXYNOS_GPIO_NEXT(EXYNOS4210_GPIO_E1),
+	EXYNOS4210_GPIO_E3_START	= EXYNOS_GPIO_NEXT(EXYNOS4210_GPIO_E2),
+	EXYNOS4210_GPIO_E4_START	= EXYNOS_GPIO_NEXT(EXYNOS4210_GPIO_E3),
+	EXYNOS4_GPIO_F0_START	= EXYNOS_GPIO_NEXT(EXYNOS4210_GPIO_E4),
 	EXYNOS4_GPIO_F1_START	= EXYNOS_GPIO_NEXT(EXYNOS4_GPIO_F0),
 	EXYNOS4_GPIO_F2_START	= EXYNOS_GPIO_NEXT(EXYNOS4_GPIO_F1),
 	EXYNOS4_GPIO_F3_START	= EXYNOS_GPIO_NEXT(EXYNOS4_GPIO_F2),
@@ -108,11 +108,11 @@ enum exynos4_gpio_number {
 #define EXYNOS4_GPC1(_nr)	(EXYNOS4_GPIO_C1_START + (_nr))
 #define EXYNOS4_GPD0(_nr)	(EXYNOS4_GPIO_D0_START + (_nr))
 #define EXYNOS4_GPD1(_nr)	(EXYNOS4_GPIO_D1_START + (_nr))
-#define EXYNOS4_GPE0(_nr)	(EXYNOS4_GPIO_E0_START + (_nr))
-#define EXYNOS4_GPE1(_nr)	(EXYNOS4_GPIO_E1_START + (_nr))
-#define EXYNOS4_GPE2(_nr)	(EXYNOS4_GPIO_E2_START + (_nr))
-#define EXYNOS4_GPE3(_nr)	(EXYNOS4_GPIO_E3_START + (_nr))
-#define EXYNOS4_GPE4(_nr)	(EXYNOS4_GPIO_E4_START + (_nr))
+#define EXYNOS4210_GPE0(_nr)	(EXYNOS4210_GPIO_E0_START + (_nr))
+#define EXYNOS4210_GPE1(_nr)	(EXYNOS4210_GPIO_E1_START + (_nr))
+#define EXYNOS4210_GPE2(_nr)	(EXYNOS4210_GPIO_E2_START + (_nr))
+#define EXYNOS4210_GPE3(_nr)	(EXYNOS4210_GPIO_E3_START + (_nr))
+#define EXYNOS4210_GPE4(_nr)	(EXYNOS4210_GPIO_E4_START + (_nr))
 #define EXYNOS4_GPF0(_nr)	(EXYNOS4_GPIO_F0_START + (_nr))
 #define EXYNOS4_GPF1(_nr)	(EXYNOS4_GPIO_F1_START + (_nr))
 #define EXYNOS4_GPF2(_nr)	(EXYNOS4_GPIO_F2_START + (_nr))
diff --git a/arch/arm/mach-exynos/mach-nuri.c b/arch/arm/mach-exynos/mach-nuri.c
index ea785fc..426bb79 100644
--- a/arch/arm/mach-exynos/mach-nuri.c
+++ b/arch/arm/mach-exynos/mach-nuri.c
@@ -268,7 +268,7 @@ static struct s3c_fb_platdata nuri_fb_pdata __initdata = {
 
 static void nuri_lcd_power_on(struct plat_lcd_data *pd, unsigned int power)
 {
-	int gpio = EXYNOS4_GPE1(5);
+	int gpio = EXYNOS4210_GPE1(5);
 
 	gpio_request(gpio, "LVDS_nSHDN");
 	gpio_direction_output(gpio, power);
@@ -277,7 +277,7 @@ static void nuri_lcd_power_on(struct plat_lcd_data *pd, unsigned int power)
 
 static int nuri_bl_init(struct device *dev)
 {
-	return gpio_request_one(EXYNOS4_GPE2(3), GPIOF_OUT_INIT_LOW,
+	return gpio_request_one(EXYNOS4210_GPE2(3), GPIOF_OUT_INIT_LOW,
 				"LCD_LD0_EN");
 }
 
@@ -286,14 +286,14 @@ static int nuri_bl_notify(struct device *dev, int brightness)
 	if (brightness < 1)
 		brightness = 0;
 
-	gpio_set_value(EXYNOS4_GPE2(3), 1);
+	gpio_set_value(EXYNOS4210_GPE2(3), 1);
 
 	return brightness;
 }
 
 static void nuri_bl_exit(struct device *dev)
 {
-	gpio_free(EXYNOS4_GPE2(3));
+	gpio_free(EXYNOS4210_GPE2(3));
 }
 
 /* nuri pwm backlight */
@@ -1048,7 +1048,7 @@ static struct max8903_pdata nuri_max8903 = {
 	 */
 	.dok = EXYNOS4_GPX1(4), /* TA_nCONNECTED */
 	/* uok, usus: not connected */
-	.chg = EXYNOS4_GPE2(0), /* TA_nCHG */
+	.chg = EXYNOS4210_GPE2(0), /* TA_nCHG */
 	/* flt: vcc_1.8V_pda */
 	.dcm = EXYNOS4_GPL0(1), /* CURR_ADJ */
 
@@ -1119,7 +1119,7 @@ static struct regulator_init_data cam_vt_cam15_reg_init_data = {
 static struct fixed_voltage_config cam_vt_cam15_fixed_voltage_cfg = {
 	.supply_name	= "VT_CAM_1.5V",
 	.microvolts	= 1500000,
-	.gpio		= EXYNOS4_GPE2(2), /* VT_CAM_1.5V_EN */
+	.gpio		= EXYNOS4210_GPE2(2), /* VT_CAM_1.5V_EN */
 	.enable_high	= 1,
 	.init_data	= &cam_vt_cam15_reg_init_data,
 };
@@ -1143,7 +1143,7 @@ static struct regulator_init_data cam_vdda_reg_init_data = {
 static struct fixed_voltage_config cam_vdda_fixed_voltage_cfg = {
 	.supply_name	= "CAM_IO_EN",
 	.microvolts	= 2800000,
-	.gpio		= EXYNOS4_GPE2(1), /* CAM_IO_EN */
+	.gpio		= EXYNOS4210_GPE2(1), /* CAM_IO_EN */
 	.enable_high	= 1,
 	.init_data	= &cam_vdda_reg_init_data,
 };
@@ -1167,7 +1167,7 @@ static struct regulator_init_data cam_8m_12v_reg_init_data = {
 static struct fixed_voltage_config cam_8m_12v_fixed_voltage_cfg = {
 	.supply_name	= "8M_1.2V",
 	.microvolts	= 1200000,
-	.gpio		= EXYNOS4_GPE2(5), /* 8M_1.2V_EN */
+	.gpio		= EXYNOS4210_GPE2(5), /* 8M_1.2V_EN */
 	.enable_high	= 1,
 	.init_data	= &cam_8m_12v_reg_init_data,
 };
diff --git a/arch/arm/mach-exynos/mach-origen.c b/arch/arm/mach-exynos/mach-origen.c
index 5ca8030..13424fc 100644
--- a/arch/arm/mach-exynos/mach-origen.c
+++ b/arch/arm/mach-exynos/mach-origen.c
@@ -591,13 +591,13 @@ static void lcd_hv070wsa_set_power(struct plat_lcd_data *pd, unsigned int power)
 	int ret;
 
 	if (power)
-		ret = gpio_request_one(EXYNOS4_GPE3(4),
+		ret = gpio_request_one(EXYNOS4210_GPE3(4),
 					GPIOF_OUT_INIT_HIGH, "GPE3_4");
 	else
-		ret = gpio_request_one(EXYNOS4_GPE3(4),
+		ret = gpio_request_one(EXYNOS4210_GPE3(4),
 					GPIOF_OUT_INIT_LOW, "GPE3_4");
 
-	gpio_free(EXYNOS4_GPE3(4));
+	gpio_free(EXYNOS4210_GPE3(4));
 
 	if (ret)
 		pr_err("failed to request gpio for LCD power: %d\n", ret);
diff --git a/arch/arm/mach-exynos/mach-trats.c b/arch/arm/mach-exynos/mach-trats.c
index fdcbcbd..d2c9787 100644
--- a/arch/arm/mach-exynos/mach-trats.c
+++ b/arch/arm/mach-exynos/mach-trats.c
@@ -770,7 +770,7 @@ static struct regulator_init_data cam_vdda_reg_init_data = {
 static struct fixed_voltage_config cam_vdda_fixed_voltage_cfg = {
 	.supply_name	= "CAM_IO_EN",
 	.microvolts	= 2800000,
-	.gpio		= EXYNOS4_GPE2(1), /* CAM_IO_EN */
+	.gpio		= EXYNOS4210_GPE2(1), /* CAM_IO_EN */
 	.enable_high	= 1,
 	.init_data	= &cam_vdda_reg_init_data,
 };
@@ -794,7 +794,7 @@ static struct regulator_init_data cam_8m_12v_reg_init_data = {
 static struct fixed_voltage_config cam_8m_12v_fixed_voltage_cfg = {
 	.supply_name	= "8M_1.2V_EN",
 	.microvolts	= 1200000,
-	.gpio		= EXYNOS4_GPE2(5), /* 8M_1.2V_EN */
+	.gpio		= EXYNOS4210_GPE2(5), /* 8M_1.2V_EN */
 	.enable_high	= 1,
 	.init_data	= &cam_8m_12v_reg_init_data,
 };
diff --git a/arch/arm/mach-exynos/mach-universal_c210.c b/arch/arm/mach-exynos/mach-universal_c210.c
index 8951bcc..9c60e66 100644
--- a/arch/arm/mach-exynos/mach-universal_c210.c
+++ b/arch/arm/mach-exynos/mach-universal_c210.c
@@ -552,7 +552,7 @@ static struct max8998_platform_data universal_lp3974_pdata = {
 	.buck2_voltage1		= 1200000,	/* G3D */
 	.buck2_voltage2		= 1100000,
 	.buck1_default_idx	= 0,
-	.buck2_set3		= EXYNOS4_GPE2(0),
+	.buck2_set3		= EXYNOS4210_GPE2(0),
 	.buck2_default_idx	= 0,
 	.wakeup			= true,
 };
@@ -581,7 +581,7 @@ static struct regulator_init_data hdmi_fixed_voltage_init_data = {
 static struct fixed_voltage_config hdmi_fixed_voltage_config = {
 	.supply_name		= "HDMI_EN1",
 	.microvolts		= 5000000,
-	.gpio			= EXYNOS4_GPE0(1),
+	.gpio			= EXYNOS4210_GPE0(1),
 	.enable_high		= true,
 	.init_data		= &hdmi_fixed_voltage_init_data,
 };
@@ -630,12 +630,12 @@ static void __init universal_tsp_init(void)
 	int gpio;
 
 	/* TSP_LDO_ON: XMDMADDR_11 */
-	gpio = EXYNOS4_GPE2(3);
+	gpio = EXYNOS4210_GPE2(3);
 	gpio_request_one(gpio, GPIOF_OUT_INIT_HIGH, "TSP_LDO_ON");
 	gpio_export(gpio, 0);
 
 	/* TSP_INT: XMDMADDR_7 */
-	gpio = EXYNOS4_GPE1(7);
+	gpio = EXYNOS4210_GPE1(7);
 	gpio_request(gpio, "TSP_INT");
 
 	s5p_register_gpio_interrupt(gpio);
@@ -661,8 +661,8 @@ static struct mcs_platform_data touchkey_data = {
 /* GPIO I2C 3_TOUCH 2.8V */
 #define I2C_GPIO_BUS_12		12
 static struct i2c_gpio_platform_data i2c_gpio12_data = {
-	.sda_pin	= EXYNOS4_GPE4(0),	/* XMDMDATA_8 */
-	.scl_pin	= EXYNOS4_GPE4(1),	/* XMDMDATA_9 */
+	.sda_pin	= EXYNOS4210_GPE4(0),	/* XMDMDATA_8 */
+	.scl_pin	= EXYNOS4210_GPE4(1),	/* XMDMDATA_9 */
 };
 
 static struct platform_device i2c_gpio12 = {
@@ -684,13 +684,13 @@ static void __init universal_touchkey_init(void)
 {
 	int gpio;
 
-	gpio = EXYNOS4_GPE3(7);			/* XMDMDATA_7 */
+	gpio = EXYNOS4210_GPE3(7);			/* XMDMDATA_7 */
 	gpio_request(gpio, "3_TOUCH_INT");
 	s5p_register_gpio_interrupt(gpio);
 	s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(0xf));
 	i2c_gpio12_devs[0].irq = gpio_to_irq(gpio);
 
-	gpio = EXYNOS4_GPE3(3);			/* XMDMDATA_3 */
+	gpio = EXYNOS4210_GPE3(3);			/* XMDMDATA_3 */
 	gpio_request_one(gpio, GPIOF_OUT_INIT_HIGH, "3_TOUCH_EN");
 }
 
@@ -776,7 +776,7 @@ static struct regulator_init_data mmc0_fixed_voltage_init_data = {
 static struct fixed_voltage_config mmc0_fixed_voltage_config = {
 	.supply_name		= "MASSMEMORY_EN",
 	.microvolts		= 2800000,
-	.gpio			= EXYNOS4_GPE1(3),
+	.gpio			= EXYNOS4210_GPE1(3),
 	.enable_high		= true,
 	.init_data		= &mmc0_fixed_voltage_init_data,
 };
@@ -887,7 +887,7 @@ static struct regulator_init_data cam_vt_dio_reg_init_data = {
 static struct fixed_voltage_config cam_vt_dio_fixed_voltage_cfg = {
 	.supply_name	= "CAM_VT_D_IO",
 	.microvolts	= 2800000,
-	.gpio		= EXYNOS4_GPE2(1), /* CAM_PWR_EN2 */
+	.gpio		= EXYNOS4210_GPE2(1), /* CAM_PWR_EN2 */
 	.enable_high	= 1,
 	.init_data	= &cam_vt_dio_reg_init_data,
 };
@@ -909,7 +909,7 @@ static struct regulator_init_data cam_i_core_reg_init_data = {
 static struct fixed_voltage_config cam_i_core_fixed_voltage_cfg = {
 	.supply_name	= "CAM_I_CORE_1.2V",
 	.microvolts	= 1200000,
-	.gpio		= EXYNOS4_GPE2(2),	/* CAM_8M_CORE_EN */
+	.gpio		= EXYNOS4210_GPE2(2),	/* CAM_8M_CORE_EN */
 	.enable_high	= 1,
 	.init_data	= &cam_i_core_reg_init_data,
 };
@@ -931,7 +931,7 @@ static struct regulator_init_data cam_s_if_reg_init_data = {
 static struct fixed_voltage_config cam_s_if_fixed_voltage_cfg = {
 	.supply_name	= "CAM_S_IF_1.8V",
 	.microvolts	= 1800000,
-	.gpio		= EXYNOS4_GPE3(0),	/* CAM_PWR_EN1 */
+	.gpio		= EXYNOS4210_GPE3(0),	/* CAM_PWR_EN1 */
 	.enable_high	= 1,
 	.init_data	= &cam_s_if_reg_init_data,
 };
@@ -949,11 +949,11 @@ static struct s5p_platform_mipi_csis mipi_csis_platdata = {
 	.phy_enable	= s5p_csis_phy_enable,
 };
 
-#define GPIO_CAM_LEVEL_EN(n)	EXYNOS4_GPE4(n + 3)
+#define GPIO_CAM_LEVEL_EN(n)	EXYNOS4210_GPE4(n + 3)
 #define GPIO_CAM_8M_ISP_INT	EXYNOS4_GPX1(5)	/* XEINT_13 */
-#define GPIO_CAM_MEGA_nRST	EXYNOS4_GPE2(5)
-#define GPIO_CAM_VGA_NRST	EXYNOS4_GPE4(7)
-#define GPIO_CAM_VGA_NSTBY	EXYNOS4_GPE4(6)
+#define GPIO_CAM_MEGA_nRST	EXYNOS4210_GPE2(5)
+#define GPIO_CAM_VGA_NRST	EXYNOS4210_GPE4(7)
+#define GPIO_CAM_VGA_NSTBY	EXYNOS4210_GPE4(6)
 
 static int s5k6aa_set_power(int on)
 {
diff --git a/arch/arm/mach-exynos/setup-fimc.c b/arch/arm/mach-exynos/setup-fimc.c
index 6a45078..d74843e 100644
--- a/arch/arm/mach-exynos/setup-fimc.c
+++ b/arch/arm/mach-exynos/setup-fimc.c
@@ -26,8 +26,8 @@ int exynos4_fimc_setup_gpio(enum s5p_camport_id id)
 		break;
 
 	case S5P_CAMPORT_B:
-		gpio8 = EXYNOS4_GPE0(0); /* DATA[0:7] */
-		gpio5 = EXYNOS4_GPE1(0); /* PCLK, VSYNC, HREF, CLKOUT, FIELD */
+		gpio8 = EXYNOS4210_GPE0(0); /* DATA[0:7] */
+		gpio5 = EXYNOS4210_GPE1(0); /* PCLK, VSYNC, HREF, CLKOUT, FIELD */
 		sfn = S3C_GPIO_SFN(3);
 		break;
 
diff --git a/drivers/gpio/gpio-samsung.c b/drivers/gpio/gpio-samsung.c
index ba126cc..c996440 100644
--- a/drivers/gpio/gpio-samsung.c
+++ b/drivers/gpio/gpio-samsung.c
@@ -2171,32 +2171,32 @@ static struct samsung_gpio_chip exynos4_gpios_1[] = {
 		},
 	}, {
 		.chip	= {
-			.base	= EXYNOS4_GPE0(0),
-			.ngpio	= EXYNOS4_GPIO_E0_NR,
+			.base	= EXYNOS4210_GPE0(0),
+			.ngpio	= EXYNOS4210_GPIO_E0_NR,
 			.label	= "GPE0",
 		},
 	}, {
 		.chip	= {
-			.base	= EXYNOS4_GPE1(0),
-			.ngpio	= EXYNOS4_GPIO_E1_NR,
+			.base	= EXYNOS4210_GPE1(0),
+			.ngpio	= EXYNOS4210_GPIO_E1_NR,
 			.label	= "GPE1",
 		},
 	}, {
 		.chip	= {
-			.base	= EXYNOS4_GPE2(0),
-			.ngpio	= EXYNOS4_GPIO_E2_NR,
+			.base	= EXYNOS4210_GPE2(0),
+			.ngpio	= EXYNOS4210_GPIO_E2_NR,
 			.label	= "GPE2",
 		},
 	}, {
 		.chip	= {
-			.base	= EXYNOS4_GPE3(0),
-			.ngpio	= EXYNOS4_GPIO_E3_NR,
+			.base	= EXYNOS4210_GPE3(0),
+			.ngpio	= EXYNOS4210_GPIO_E3_NR,
 			.label	= "GPE3",
 		},
 	}, {
 		.chip	= {
-			.base	= EXYNOS4_GPE4(0),
-			.ngpio	= EXYNOS4_GPIO_E4_NR,
+			.base	= EXYNOS4210_GPE4(0),
+			.ngpio	= EXYNOS4210_GPIO_E4_NR,
 			.label	= "GPE4",
 		},
 	}, {
-- 
1.7.12
