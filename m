From: wfp5p@virginia.edu (Bill Pemberton)
Date: Mon, 19 Nov 2012 13:24:21 -0500
Subject: [PATCH 312/493] mfd: remove use of __devinitdata
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Message-ID: <1353349642-3677-312-git-send-email-wfp5p@virginia.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_HOTPLUG is going away as an option so __devinitdata is no
longer needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com> 
Cc: Linus Walleij <linus.walleij@linaro.org> 
Cc: Peter Tyser <ptyser@xes-inc.com> 
Cc: linux-arm-kernel at lists.infradead.org 
---
 drivers/mfd/88pm860x-core.c | 68 ++++++++++++++++++++++-----------------------
 drivers/mfd/ab8500-core.c   | 34 +++++++++++------------
 drivers/mfd/cs5535-mfd.c    |  4 +--
 drivers/mfd/da9052-core.c   |  2 +-
 drivers/mfd/lpc_ich.c       |  2 +-
 drivers/mfd/max77686.c      |  2 +-
 drivers/mfd/max8925-core.c  | 52 +++++++++++++++++-----------------
 drivers/mfd/palmas.c        |  2 +-
 drivers/mfd/sm501.c         |  2 +-
 drivers/mfd/sta2x11-mfd.c   |  4 +--
 drivers/mfd/tc6393xb.c      |  6 ++--
 drivers/mfd/timberdale.c    | 34 +++++++++++------------
 12 files changed, 106 insertions(+), 106 deletions(-)

diff --git a/drivers/mfd/88pm860x-core.c b/drivers/mfd/88pm860x-core.c
index ad36ad7..20dd0d4 100644
--- a/drivers/mfd/88pm860x-core.c
+++ b/drivers/mfd/88pm860x-core.c
@@ -28,111 +28,111 @@
 
 #define INT_STATUS_NUM			3
 
-static struct resource bk0_resources[] __devinitdata = {
+static struct resource bk0_resources[] = {
 	{2, 2, "duty cycle", IORESOURCE_REG, },
 	{3, 3, "always on",  IORESOURCE_REG, },
 	{3, 3, "current",    IORESOURCE_REG, },
 };
-static struct resource bk1_resources[] __devinitdata = {
+static struct resource bk1_resources[] = {
 	{4, 4, "duty cycle", IORESOURCE_REG, },
 	{5, 5, "always on",  IORESOURCE_REG, },
 	{5, 5, "current",    IORESOURCE_REG, },
 };
-static struct resource bk2_resources[] __devinitdata = {
+static struct resource bk2_resources[] = {
 	{6, 6, "duty cycle", IORESOURCE_REG, },
 	{7, 7, "always on",  IORESOURCE_REG, },
 	{5, 5, "current",    IORESOURCE_REG, },
 };
 
-static struct resource led0_resources[] __devinitdata = {
+static struct resource led0_resources[] = {
 	/* RGB1 Red LED */
 	{0xd, 0xd, "control", IORESOURCE_REG, },
 	{0xc, 0xc, "blink",   IORESOURCE_REG, },
 };
-static struct resource led1_resources[] __devinitdata = {
+static struct resource led1_resources[] = {
 	/* RGB1 Green LED */
 	{0xe, 0xe, "control", IORESOURCE_REG, },
 	{0xc, 0xc, "blink",   IORESOURCE_REG, },
 };
-static struct resource led2_resources[] __devinitdata = {
+static struct resource led2_resources[] = {
 	/* RGB1 Blue LED */
 	{0xf, 0xf, "control", IORESOURCE_REG, },
 	{0xc, 0xc, "blink",   IORESOURCE_REG, },
 };
-static struct resource led3_resources[] __devinitdata = {
+static struct resource led3_resources[] = {
 	/* RGB2 Red LED */
 	{0x9, 0x9, "control", IORESOURCE_REG, },
 	{0x8, 0x8, "blink",   IORESOURCE_REG, },
 };
-static struct resource led4_resources[] __devinitdata = {
+static struct resource led4_resources[] = {
 	/* RGB2 Green LED */
 	{0xa, 0xa, "control", IORESOURCE_REG, },
 	{0x8, 0x8, "blink",   IORESOURCE_REG, },
 };
-static struct resource led5_resources[] __devinitdata = {
+static struct resource led5_resources[] = {
 	/* RGB2 Blue LED */
 	{0xb, 0xb, "control", IORESOURCE_REG, },
 	{0x8, 0x8, "blink",   IORESOURCE_REG, },
 };
 
-static struct resource buck1_resources[] __devinitdata = {
+static struct resource buck1_resources[] = {
 	{0x24, 0x24, "buck set", IORESOURCE_REG, },
 };
-static struct resource buck2_resources[] __devinitdata = {
+static struct resource buck2_resources[] = {
 	{0x25, 0x25, "buck set", IORESOURCE_REG, },
 };
-static struct resource buck3_resources[] __devinitdata = {
+static struct resource buck3_resources[] = {
 	{0x26, 0x26, "buck set", IORESOURCE_REG, },
 };
-static struct resource ldo1_resources[] __devinitdata = {
+static struct resource ldo1_resources[] = {
 	{0x10, 0x10, "ldo set", IORESOURCE_REG, },
 };
-static struct resource ldo2_resources[] __devinitdata = {
+static struct resource ldo2_resources[] = {
 	{0x11, 0x11, "ldo set", IORESOURCE_REG, },
 };
-static struct resource ldo3_resources[] __devinitdata = {
+static struct resource ldo3_resources[] = {
 	{0x12, 0x12, "ldo set", IORESOURCE_REG, },
 };
-static struct resource ldo4_resources[] __devinitdata = {
+static struct resource ldo4_resources[] = {
 	{0x13, 0x13, "ldo set", IORESOURCE_REG, },
 };
-static struct resource ldo5_resources[] __devinitdata = {
+static struct resource ldo5_resources[] = {
 	{0x14, 0x14, "ldo set", IORESOURCE_REG, },
 };
-static struct resource ldo6_resources[] __devinitdata = {
+static struct resource ldo6_resources[] = {
 	{0x15, 0x15, "ldo set", IORESOURCE_REG, },
 };
-static struct resource ldo7_resources[] __devinitdata = {
+static struct resource ldo7_resources[] = {
 	{0x16, 0x16, "ldo set", IORESOURCE_REG, },
 };
-static struct resource ldo8_resources[] __devinitdata = {
+static struct resource ldo8_resources[] = {
 	{0x17, 0x17, "ldo set", IORESOURCE_REG, },
 };
-static struct resource ldo9_resources[] __devinitdata = {
+static struct resource ldo9_resources[] = {
 	{0x18, 0x18, "ldo set", IORESOURCE_REG, },
 };
-static struct resource ldo10_resources[] __devinitdata = {
+static struct resource ldo10_resources[] = {
 	{0x19, 0x19, "ldo set", IORESOURCE_REG, },
 };
-static struct resource ldo12_resources[] __devinitdata = {
+static struct resource ldo12_resources[] = {
 	{0x1a, 0x1a, "ldo set", IORESOURCE_REG, },
 };
-static struct resource ldo_vibrator_resources[] __devinitdata = {
+static struct resource ldo_vibrator_resources[] = {
 	{0x28, 0x28, "ldo set", IORESOURCE_REG, },
 };
-static struct resource ldo14_resources[] __devinitdata = {
+static struct resource ldo14_resources[] = {
 	{0x1b, 0x1b, "ldo set", IORESOURCE_REG, },
 };
 
-static struct resource touch_resources[] __devinitdata = {
+static struct resource touch_resources[] = {
 	{PM8607_IRQ_PEN, PM8607_IRQ_PEN, "touch", IORESOURCE_IRQ,},
 };
 
-static struct resource onkey_resources[] __devinitdata = {
+static struct resource onkey_resources[] = {
 	{PM8607_IRQ_ONKEY, PM8607_IRQ_ONKEY, "onkey", IORESOURCE_IRQ,},
 };
 
-static struct resource codec_resources[] __devinitdata = {
+static struct resource codec_resources[] = {
 	/* Headset microphone insertion or removal */
 	{PM8607_IRQ_MICIN,   PM8607_IRQ_MICIN,   "micin",   IORESOURCE_IRQ,},
 	/* Hook-switch press or release */
@@ -143,12 +143,12 @@ static struct resource codec_resources[] __devinitdata = {
 	{PM8607_IRQ_AUDIO_SHORT, PM8607_IRQ_AUDIO_SHORT, "audio-short", IORESOURCE_IRQ,},
 };
 
-static struct resource battery_resources[] __devinitdata = {
+static struct resource battery_resources[] = {
 	{PM8607_IRQ_CC,  PM8607_IRQ_CC,  "columb counter", IORESOURCE_IRQ,},
 	{PM8607_IRQ_BAT, PM8607_IRQ_BAT, "battery",        IORESOURCE_IRQ,},
 };
 
-static struct resource charger_resources[] __devinitdata = {
+static struct resource charger_resources[] = {
 	{PM8607_IRQ_CHG,  PM8607_IRQ_CHG,  "charger detect",  IORESOURCE_IRQ,},
 	{PM8607_IRQ_CHG_DONE,  PM8607_IRQ_CHG_DONE,  "charging done",       IORESOURCE_IRQ,},
 	{PM8607_IRQ_CHG_FAIL,  PM8607_IRQ_CHG_FAIL,  "charging timeout",    IORESOURCE_IRQ,},
@@ -158,11 +158,11 @@ static struct resource charger_resources[] __devinitdata = {
 	{PM8607_IRQ_VCHG, PM8607_IRQ_VCHG, "vchg voltage",    IORESOURCE_IRQ,},
 };
 
-static struct resource rtc_resources[] __devinitdata = {
+static struct resource rtc_resources[] = {
 	{PM8607_IRQ_RTC, PM8607_IRQ_RTC, "rtc", IORESOURCE_IRQ,},
 };
 
-static struct mfd_cell bk_devs[] __devinitdata = {
+static struct mfd_cell bk_devs[] = {
 	{
 		.name = "88pm860x-backlight",
 		.id = 0,
@@ -181,7 +181,7 @@ static struct mfd_cell bk_devs[] __devinitdata = {
 	},
 };
 
-static struct mfd_cell led_devs[] __devinitdata = {
+static struct mfd_cell led_devs[] = {
 	{
 		.name = "88pm860x-led",
 		.id = 0,
@@ -215,7 +215,7 @@ static struct mfd_cell led_devs[] __devinitdata = {
 	},
 };
 
-static struct mfd_cell reg_devs[] __devinitdata = {
+static struct mfd_cell reg_devs[] = {
 	{
 		.name = "88pm860x-regulator",
 		.id = 0,
diff --git a/drivers/mfd/ab8500-core.c b/drivers/mfd/ab8500-core.c
index 058d4d0..d02d9f9 100644
--- a/drivers/mfd/ab8500-core.c
+++ b/drivers/mfd/ab8500-core.c
@@ -586,7 +586,7 @@ int ab8500_suspend(struct ab8500 *ab8500)
 		return 0;
 }
 
-static struct resource __devinitdata ab8500_gpadc_resources[] = {
+static struct resource ab8500_gpadc_resources[] = {
 	{
 		.name	= "HW_CONV_END",
 		.start	= AB8500_INT_GP_HW_ADC_CONV_END,
@@ -601,7 +601,7 @@ static struct resource __devinitdata ab8500_gpadc_resources[] = {
 	},
 };
 
-static struct resource __devinitdata ab8500_rtc_resources[] = {
+static struct resource ab8500_rtc_resources[] = {
 	{
 		.name	= "60S",
 		.start	= AB8500_INT_RTC_60S,
@@ -616,7 +616,7 @@ static struct resource __devinitdata ab8500_rtc_resources[] = {
 	},
 };
 
-static struct resource __devinitdata ab8500_poweronkey_db_resources[] = {
+static struct resource ab8500_poweronkey_db_resources[] = {
 	{
 		.name	= "ONKEY_DBF",
 		.start	= AB8500_INT_PON_KEY1DB_F,
@@ -631,7 +631,7 @@ static struct resource __devinitdata ab8500_poweronkey_db_resources[] = {
 	},
 };
 
-static struct resource __devinitdata ab8500_av_acc_detect_resources[] = {
+static struct resource ab8500_av_acc_detect_resources[] = {
 	{
 	       .name = "ACC_DETECT_1DB_F",
 	       .start = AB8500_INT_ACC_DETECT_1DB_F,
@@ -670,7 +670,7 @@ static struct resource __devinitdata ab8500_av_acc_detect_resources[] = {
 	},
 };
 
-static struct resource __devinitdata ab8500_charger_resources[] = {
+static struct resource ab8500_charger_resources[] = {
 	{
 		.name = "MAIN_CH_UNPLUG_DET",
 		.start = AB8500_INT_MAIN_CH_UNPLUG_DET,
@@ -751,7 +751,7 @@ static struct resource __devinitdata ab8500_charger_resources[] = {
 	},
 };
 
-static struct resource __devinitdata ab8500_btemp_resources[] = {
+static struct resource ab8500_btemp_resources[] = {
 	{
 		.name = "BAT_CTRL_INDB",
 		.start = AB8500_INT_BAT_CTRL_INDB,
@@ -784,7 +784,7 @@ static struct resource __devinitdata ab8500_btemp_resources[] = {
 	},
 };
 
-static struct resource __devinitdata ab8500_fg_resources[] = {
+static struct resource ab8500_fg_resources[] = {
 	{
 		.name = "NCONV_ACCU",
 		.start = AB8500_INT_CCN_CONV_ACC,
@@ -823,10 +823,10 @@ static struct resource __devinitdata ab8500_fg_resources[] = {
 	},
 };
 
-static struct resource __devinitdata ab8500_chargalg_resources[] = {};
+static struct resource ab8500_chargalg_resources[] = {};
 
 #ifdef CONFIG_DEBUG_FS
-static struct resource __devinitdata ab8500_debug_resources[] = {
+static struct resource ab8500_debug_resources[] = {
 	{
 		.name	= "IRQ_FIRST",
 		.start	= AB8500_INT_MAIN_EXT_CH_NOT_OK,
@@ -842,7 +842,7 @@ static struct resource __devinitdata ab8500_debug_resources[] = {
 };
 #endif
 
-static struct resource __devinitdata ab8500_usb_resources[] = {
+static struct resource ab8500_usb_resources[] = {
 	{
 		.name = "ID_WAKEUP_R",
 		.start = AB8500_INT_ID_WAKEUP_R,
@@ -887,7 +887,7 @@ static struct resource __devinitdata ab8500_usb_resources[] = {
 	},
 };
 
-static struct resource __devinitdata ab8505_iddet_resources[] = {
+static struct resource ab8505_iddet_resources[] = {
 	{
 		.name  = "KeyDeglitch",
 		.start = AB8505_INT_KEYDEGLITCH,
@@ -920,7 +920,7 @@ static struct resource __devinitdata ab8505_iddet_resources[] = {
 	},
 };
 
-static struct resource __devinitdata ab8500_temp_resources[] = {
+static struct resource ab8500_temp_resources[] = {
 	{
 		.name  = "AB8500_TEMP_WARM",
 		.start = AB8500_INT_TEMP_WARM,
@@ -929,7 +929,7 @@ static struct resource __devinitdata ab8500_temp_resources[] = {
 	},
 };
 
-static struct mfd_cell __devinitdata abx500_common_devs[] = {
+static struct mfd_cell abx500_common_devs[] = {
 #ifdef CONFIG_DEBUG_FS
 	{
 		.name = "ab8500-debug",
@@ -1001,7 +1001,7 @@ static struct mfd_cell __devinitdata abx500_common_devs[] = {
 	},
 };
 
-static struct mfd_cell __devinitdata ab8500_bm_devs[] = {
+static struct mfd_cell ab8500_bm_devs[] = {
 	{
 		.name = "ab8500-charger",
 		.num_resources = ARRAY_SIZE(ab8500_charger_resources),
@@ -1024,7 +1024,7 @@ static struct mfd_cell __devinitdata ab8500_bm_devs[] = {
 	},
 };
 
-static struct mfd_cell __devinitdata ab8500_devs[] = {
+static struct mfd_cell ab8500_devs[] = {
 	{
 		.name = "ab8500-gpio",
 		.of_compatible = "stericsson,ab8500-gpio",
@@ -1041,7 +1041,7 @@ static struct mfd_cell __devinitdata ab8500_devs[] = {
 	},
 };
 
-static struct mfd_cell __devinitdata ab9540_devs[] = {
+static struct mfd_cell ab9540_devs[] = {
 	{
 		.name = "ab8500-gpio",
 	},
@@ -1056,7 +1056,7 @@ static struct mfd_cell __devinitdata ab9540_devs[] = {
 };
 
 /* Device list common to ab9540 and ab8505 */
-static struct mfd_cell __devinitdata ab9540_ab8505_devs[] = {
+static struct mfd_cell ab9540_ab8505_devs[] = {
 	{
 		.name = "ab-iddet",
 		.num_resources = ARRAY_SIZE(ab8505_iddet_resources),
diff --git a/drivers/mfd/cs5535-mfd.c b/drivers/mfd/cs5535-mfd.c
index 0779b13..d9dc87f 100644
--- a/drivers/mfd/cs5535-mfd.c
+++ b/drivers/mfd/cs5535-mfd.c
@@ -71,9 +71,9 @@ static int cs5535_mfd_res_disable(struct platform_device *pdev)
 	return 0;
 }
 
-static __devinitdata struct resource cs5535_mfd_resources[NR_BARS];
+static struct resource cs5535_mfd_resources[NR_BARS];
 
-static __devinitdata struct mfd_cell cs5535_mfd_cells[] = {
+static struct mfd_cell cs5535_mfd_cells[] = {
 	{
 		.id = SMB_BAR,
 		.name = "cs5535-smb",
diff --git a/drivers/mfd/da9052-core.c b/drivers/mfd/da9052-core.c
index c71c4a2..689b747 100644
--- a/drivers/mfd/da9052-core.c
+++ b/drivers/mfd/da9052-core.c
@@ -515,7 +515,7 @@ static struct resource da9052_tsi_resources[] = {
 	},
 };
 
-static struct mfd_cell __devinitdata da9052_subdev_info[] = {
+static struct mfd_cell da9052_subdev_info[] = {
 	{
 		.name = "da9052-regulator",
 		.id = 1,
diff --git a/drivers/mfd/lpc_ich.c b/drivers/mfd/lpc_ich.c
index 9989175..7c83e1b 100644
--- a/drivers/mfd/lpc_ich.c
+++ b/drivers/mfd/lpc_ich.c
@@ -196,7 +196,7 @@ enum lpc_chipsets {
 	LPC_LPT_LP,	/* Lynx Point-LP */
 };
 
-struct lpc_ich_info lpc_chipset_info[] __devinitdata = {
+struct lpc_ich_info lpc_chipset_info[] = {
 	[LPC_ICH] = {
 		.name = "ICH",
 		.iTCO_version = 1,
diff --git a/drivers/mfd/max77686.c b/drivers/mfd/max77686.c
index d9e24c8..f6878f8 100644
--- a/drivers/mfd/max77686.c
+++ b/drivers/mfd/max77686.c
@@ -45,7 +45,7 @@ static struct regmap_config max77686_regmap_config = {
 };
 
 #ifdef CONFIG_OF
-static struct of_device_id __devinitdata max77686_pmic_dt_match[] = {
+static struct of_device_id max77686_pmic_dt_match[] = {
 	{.compatible = "maxim,max77686",        .data = 0},
 	{},
 };
diff --git a/drivers/mfd/max8925-core.c b/drivers/mfd/max8925-core.c
index 20daa16..60325c4 100644
--- a/drivers/mfd/max8925-core.c
+++ b/drivers/mfd/max8925-core.c
@@ -19,12 +19,12 @@
 #include <linux/mfd/core.h>
 #include <linux/mfd/max8925.h>
 
-static struct resource bk_resources[] __devinitdata = {
+static struct resource bk_resources[] = {
 	{ 0x84, 0x84, "mode control", IORESOURCE_REG, },
 	{ 0x85, 0x85, "control",      IORESOURCE_REG, },
 };
 
-static struct mfd_cell bk_devs[] __devinitdata = {
+static struct mfd_cell bk_devs[] = {
 	{
 		.name		= "max8925-backlight",
 		.num_resources	= ARRAY_SIZE(bk_resources),
@@ -110,99 +110,99 @@ static struct mfd_cell onkey_devs[] = {
 	},
 };
 
-static struct resource sd1_resources[] __devinitdata = {
+static struct resource sd1_resources[] = {
 	{0x06, 0x06, "sdv", IORESOURCE_REG, },
 };
 
-static struct resource sd2_resources[] __devinitdata = {
+static struct resource sd2_resources[] = {
 	{0x09, 0x09, "sdv", IORESOURCE_REG, },
 };
 
-static struct resource sd3_resources[] __devinitdata = {
+static struct resource sd3_resources[] = {
 	{0x0c, 0x0c, "sdv", IORESOURCE_REG, },
 };
 
-static struct resource ldo1_resources[] __devinitdata = {
+static struct resource ldo1_resources[] = {
 	{0x1a, 0x1a, "ldov", IORESOURCE_REG, },
 };
 
-static struct resource ldo2_resources[] __devinitdata = {
+static struct resource ldo2_resources[] = {
 	{0x1e, 0x1e, "ldov", IORESOURCE_REG, },
 };
 
-static struct resource ldo3_resources[] __devinitdata = {
+static struct resource ldo3_resources[] = {
 	{0x22, 0x22, "ldov", IORESOURCE_REG, },
 };
 
-static struct resource ldo4_resources[] __devinitdata = {
+static struct resource ldo4_resources[] = {
 	{0x26, 0x26, "ldov", IORESOURCE_REG, },
 };
 
-static struct resource ldo5_resources[] __devinitdata = {
+static struct resource ldo5_resources[] = {
 	{0x2a, 0x2a, "ldov", IORESOURCE_REG, },
 };
 
-static struct resource ldo6_resources[] __devinitdata = {
+static struct resource ldo6_resources[] = {
 	{0x2e, 0x2e, "ldov", IORESOURCE_REG, },
 };
 
-static struct resource ldo7_resources[] __devinitdata = {
+static struct resource ldo7_resources[] = {
 	{0x32, 0x32, "ldov", IORESOURCE_REG, },
 };
 
-static struct resource ldo8_resources[] __devinitdata = {
+static struct resource ldo8_resources[] = {
 	{0x36, 0x36, "ldov", IORESOURCE_REG, },
 };
 
-static struct resource ldo9_resources[] __devinitdata = {
+static struct resource ldo9_resources[] = {
 	{0x3a, 0x3a, "ldov", IORESOURCE_REG, },
 };
 
-static struct resource ldo10_resources[] __devinitdata = {
+static struct resource ldo10_resources[] = {
 	{0x3e, 0x3e, "ldov", IORESOURCE_REG, },
 };
 
-static struct resource ldo11_resources[] __devinitdata = {
+static struct resource ldo11_resources[] = {
 	{0x42, 0x42, "ldov", IORESOURCE_REG, },
 };
 
-static struct resource ldo12_resources[] __devinitdata = {
+static struct resource ldo12_resources[] = {
 	{0x46, 0x46, "ldov", IORESOURCE_REG, },
 };
 
-static struct resource ldo13_resources[] __devinitdata = {
+static struct resource ldo13_resources[] = {
 	{0x4a, 0x4a, "ldov", IORESOURCE_REG, },
 };
 
-static struct resource ldo14_resources[] __devinitdata = {
+static struct resource ldo14_resources[] = {
 	{0x4e, 0x4e, "ldov", IORESOURCE_REG, },
 };
 
-static struct resource ldo15_resources[] __devinitdata = {
+static struct resource ldo15_resources[] = {
 	{0x52, 0x52, "ldov", IORESOURCE_REG, },
 };
 
-static struct resource ldo16_resources[] __devinitdata = {
+static struct resource ldo16_resources[] = {
 	{0x12, 0x12, "ldov", IORESOURCE_REG, },
 };
 
-static struct resource ldo17_resources[] __devinitdata = {
+static struct resource ldo17_resources[] = {
 	{0x16, 0x16, "ldov", IORESOURCE_REG, },
 };
 
-static struct resource ldo18_resources[] __devinitdata = {
+static struct resource ldo18_resources[] = {
 	{0x74, 0x74, "ldov", IORESOURCE_REG, },
 };
 
-static struct resource ldo19_resources[] __devinitdata = {
+static struct resource ldo19_resources[] = {
 	{0x5e, 0x5e, "ldov", IORESOURCE_REG, },
 };
 
-static struct resource ldo20_resources[] __devinitdata = {
+static struct resource ldo20_resources[] = {
 	{0x9e, 0x9e, "ldov", IORESOURCE_REG, },
 };
 
-static struct mfd_cell reg_devs[] __devinitdata = {
+static struct mfd_cell reg_devs[] = {
 	{
 		.name = "max8925-regulator",
 		.id = 0,
diff --git a/drivers/mfd/palmas.c b/drivers/mfd/palmas.c
index cb52783..6ffd7a2 100644
--- a/drivers/mfd/palmas.c
+++ b/drivers/mfd/palmas.c
@@ -492,7 +492,7 @@ static const struct i2c_device_id palmas_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, palmas_i2c_id);
 
-static struct of_device_id __devinitdata of_palmas_match_tbl[] = {
+static struct of_device_id of_palmas_match_tbl[] = {
 	{ .compatible = "ti,palmas", },
 	{ /* end */ }
 };
diff --git a/drivers/mfd/sm501.c b/drivers/mfd/sm501.c
index c9c102c..9b53733 100644
--- a/drivers/mfd/sm501.c
+++ b/drivers/mfd/sm501.c
@@ -1728,7 +1728,7 @@ static struct pci_driver sm501_pci_driver = {
 
 MODULE_ALIAS("platform:sm501");
 
-static struct of_device_id __devinitdata of_sm501_match_tbl[] = {
+static struct of_device_id of_sm501_match_tbl[] = {
 	{ .compatible = "smi,sm501", },
 	{ /* end */ }
 };
diff --git a/drivers/mfd/sta2x11-mfd.c b/drivers/mfd/sta2x11-mfd.c
index 2cfd55f..1438be54 100644
--- a/drivers/mfd/sta2x11-mfd.c
+++ b/drivers/mfd/sta2x11-mfd.c
@@ -330,14 +330,14 @@ static const __devinitconst struct resource apbreg_resources[] = {
 #define DEV(_name, _r) \
 	{ .name = _name, .num_resources = ARRAY_SIZE(_r), .resources = _r, }
 
-static __devinitdata struct mfd_cell sta2x11_mfd_bar0[] = {
+static struct mfd_cell sta2x11_mfd_bar0[] = {
 	DEV("sta2x11-gpio", gpio_resources), /* offset 0: we add pdata later */
 	DEV("sta2x11-sctl", sctl_resources),
 	DEV("sta2x11-scr", scr_resources),
 	DEV("sta2x11-time", time_resources),
 };
 
-static __devinitdata struct mfd_cell sta2x11_mfd_bar1[] = {
+static struct mfd_cell sta2x11_mfd_bar1[] = {
 	DEV("sta2x11-apbreg", apbreg_resources),
 };
 
diff --git a/drivers/mfd/tc6393xb.c b/drivers/mfd/tc6393xb.c
index 2567232..1ff8ed6 100644
--- a/drivers/mfd/tc6393xb.c
+++ b/drivers/mfd/tc6393xb.c
@@ -137,7 +137,7 @@ static int tc6393xb_nand_enable(struct platform_device *nand)
 	return 0;
 }
 
-static struct resource __devinitdata tc6393xb_nand_resources[] = {
+static struct resource tc6393xb_nand_resources[] = {
 	{
 		.start	= 0x1000,
 		.end	= 0x1007,
@@ -196,7 +196,7 @@ static const struct resource tc6393xb_ohci_resources[] = {
 	},
 };
 
-static struct resource __devinitdata tc6393xb_fb_resources[] = {
+static struct resource tc6393xb_fb_resources[] = {
 	{
 		.start	= 0x5000,
 		.end	= 0x51ff,
@@ -382,7 +382,7 @@ static struct tmio_mmc_data tc6393xb_mmc_data = {
 	.set_clk_div = tc6393xb_mmc_clk_div,
 };
 
-static struct mfd_cell __devinitdata tc6393xb_cells[] = {
+static struct mfd_cell tc6393xb_cells[] = {
 	[TC6393XB_CELL_NAND] = {
 		.name = "tmio-nand",
 		.enable = tc6393xb_nand_enable,
diff --git a/drivers/mfd/timberdale.c b/drivers/mfd/timberdale.c
index dddf1df..294e14d 100644
--- a/drivers/mfd/timberdale.c
+++ b/drivers/mfd/timberdale.c
@@ -75,13 +75,13 @@ static struct i2c_board_info timberdale_i2c_board_info[] = {
 	},
 };
 
-static __devinitdata struct xiic_i2c_platform_data
+static struct xiic_i2c_platform_data
 timberdale_xiic_platform_data = {
 	.devices = timberdale_i2c_board_info,
 	.num_devices = ARRAY_SIZE(timberdale_i2c_board_info)
 };
 
-static __devinitdata struct ocores_i2c_platform_data
+static struct ocores_i2c_platform_data
 timberdale_ocores_platform_data = {
 	.reg_shift = 2,
 	.clock_khz = 62500,
@@ -143,7 +143,7 @@ static struct spi_board_info timberdale_spi_8bit_board_info[] = {
 	},
 };
 
-static __devinitdata struct xspi_platform_data timberdale_xspi_platform_data = {
+static struct xspi_platform_data timberdale_xspi_platform_data = {
 	.num_chipselect = 3,
 	.little_endian = true,
 	/* bits per word and devices will be filled in runtime depending
@@ -164,7 +164,7 @@ static const __devinitconst struct resource timberdale_spi_resources[] = {
 	},
 };
 
-static __devinitdata struct ks8842_platform_data
+static struct ks8842_platform_data
 	timberdale_ks8842_platform_data = {
 	.rx_dma_channel = DMA_ETH_RX,
 	.tx_dma_channel = DMA_ETH_TX
@@ -183,7 +183,7 @@ static const __devinitconst struct resource timberdale_eth_resources[] = {
 	},
 };
 
-static __devinitdata struct timbgpio_platform_data
+static struct timbgpio_platform_data
 	timberdale_gpio_platform_data = {
 	.gpio_base = 0,
 	.nr_pins = GPIO_NR_PINS,
@@ -247,13 +247,13 @@ static const __devinitconst struct resource timberdale_uartlite_resources[] = {
 	},
 };
 
-static __devinitdata struct i2c_board_info timberdale_adv7180_i2c_board_info = {
+static struct i2c_board_info timberdale_adv7180_i2c_board_info = {
 	/* Requires jumper JP9 to be off */
 	I2C_BOARD_INFO("adv7180", 0x42 >> 1),
 	.irq = IRQ_TIMBERDALE_ADV7180
 };
 
-static __devinitdata struct timb_video_platform_data
+static struct timb_video_platform_data
 	timberdale_video_platform_data = {
 	.dma_channel = DMA_VIDEO_RX,
 	.i2c_adapter = 0,
@@ -276,15 +276,15 @@ timberdale_radio_resources[] = {
 	},
 };
 
-static __devinitdata struct i2c_board_info timberdale_tef6868_i2c_board_info = {
+static struct i2c_board_info timberdale_tef6868_i2c_board_info = {
 	I2C_BOARD_INFO("tef6862", 0x60)
 };
 
-static __devinitdata struct i2c_board_info timberdale_saa7706_i2c_board_info = {
+static struct i2c_board_info timberdale_saa7706_i2c_board_info = {
 	I2C_BOARD_INFO("saa7706h", 0x1C)
 };
 
-static __devinitdata struct timb_radio_platform_data
+static struct timb_radio_platform_data
 	timberdale_radio_platform_data = {
 	.i2c_adapter = 0,
 	.tuner = &timberdale_tef6868_i2c_board_info,
@@ -303,7 +303,7 @@ static const __devinitconst struct resource timberdale_video_resources[] = {
 	*/
 };
 
-static __devinitdata struct timb_dma_platform_data timb_dma_platform_data = {
+static struct timb_dma_platform_data timb_dma_platform_data = {
 	.nr_channels = 10,
 	.channels = {
 		{
@@ -375,7 +375,7 @@ static const __devinitconst struct resource timberdale_dma_resources[] = {
 	},
 };
 
-static __devinitdata struct mfd_cell timberdale_cells_bar0_cfg0[] = {
+static struct mfd_cell timberdale_cells_bar0_cfg0[] = {
 	{
 		.name = "timb-dma",
 		.num_resources = ARRAY_SIZE(timberdale_dma_resources),
@@ -432,7 +432,7 @@ static __devinitdata struct mfd_cell timberdale_cells_bar0_cfg0[] = {
 	},
 };
 
-static __devinitdata struct mfd_cell timberdale_cells_bar0_cfg1[] = {
+static struct mfd_cell timberdale_cells_bar0_cfg1[] = {
 	{
 		.name = "timb-dma",
 		.num_resources = ARRAY_SIZE(timberdale_dma_resources),
@@ -499,7 +499,7 @@ static __devinitdata struct mfd_cell timberdale_cells_bar0_cfg1[] = {
 	},
 };
 
-static __devinitdata struct mfd_cell timberdale_cells_bar0_cfg2[] = {
+static struct mfd_cell timberdale_cells_bar0_cfg2[] = {
 	{
 		.name = "timb-dma",
 		.num_resources = ARRAY_SIZE(timberdale_dma_resources),
@@ -549,7 +549,7 @@ static __devinitdata struct mfd_cell timberdale_cells_bar0_cfg2[] = {
 	},
 };
 
-static __devinitdata struct mfd_cell timberdale_cells_bar0_cfg3[] = {
+static struct mfd_cell timberdale_cells_bar0_cfg3[] = {
 	{
 		.name = "timb-dma",
 		.num_resources = ARRAY_SIZE(timberdale_dma_resources),
@@ -620,7 +620,7 @@ static const __devinitconst struct resource timberdale_sdhc_resources[] = {
 	},
 };
 
-static __devinitdata struct mfd_cell timberdale_cells_bar1[] = {
+static struct mfd_cell timberdale_cells_bar1[] = {
 	{
 		.name = "sdhci",
 		.num_resources = ARRAY_SIZE(timberdale_sdhc_resources),
@@ -628,7 +628,7 @@ static __devinitdata struct mfd_cell timberdale_cells_bar1[] = {
 	},
 };
 
-static __devinitdata struct mfd_cell timberdale_cells_bar2[] = {
+static struct mfd_cell timberdale_cells_bar2[] = {
 	{
 		.name = "sdhci",
 		.num_resources = ARRAY_SIZE(timberdale_sdhc_resources),
-- 
1.8.0
