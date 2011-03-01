From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 1 Mar 2011 16:56:39 +0530
Subject: [PATCH V6 06/11] ST SPEAr3xx: Rework pmx_dev code to remove conflicts
In-Reply-To: <cover.1298977709.git.viresh.kumar@st.com>
References: <cover.1298977709.git.viresh.kumar@st.com>
Message-ID: <97fec145c57b8917ce1d5ebfe66b2f151bfd9fc6.1298977709.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ryan Mallon <ryan@bluewatersys.com>

Prefix the pmx_devs to remove naming conflicts between the three
SPEAr3xx platforms. Also make pmx_driver static to each platform and
rework the init code to pass the devices rather than export the
pmx_driver structure.

Reviewed-by: Stanley Miao <stanley.miao@windriver.com>
Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/mach-spear3xx/include/mach/generic.h |  193 +++++++++++++------------
 arch/arm/mach-spear3xx/spear300.c             |   66 +++++----
 arch/arm/mach-spear3xx/spear300_evb.c         |   26 ++--
 arch/arm/mach-spear3xx/spear310.c             |   28 ++--
 arch/arm/mach-spear3xx/spear310_evb.c         |   41 +++---
 arch/arm/mach-spear3xx/spear320.c             |   64 +++++----
 arch/arm/mach-spear3xx/spear320_evb.c         |   36 ++---
 arch/arm/mach-spear3xx/spear3xx.c             |   60 ++++----
 8 files changed, 257 insertions(+), 257 deletions(-)

diff --git a/arch/arm/mach-spear3xx/include/mach/generic.h b/arch/arm/mach-spear3xx/include/mach/generic.h
index c2b15b1..9186e5a 100644
--- a/arch/arm/mach-spear3xx/include/mach/generic.h
+++ b/arch/arm/mach-spear3xx/include/mach/generic.h
@@ -61,85 +61,84 @@ void spear3xx_pmx_init_addr(struct pmx_driver *driver, unsigned int addr);
 #define PMX_TIMER_1_2_MASK	(1 << 0)
 
 /* pad mux devices */
-extern struct pmx_dev pmx_firda;
-extern struct pmx_dev pmx_i2c;
-extern struct pmx_dev pmx_ssp_cs;
-extern struct pmx_dev pmx_ssp;
-extern struct pmx_dev pmx_mii;
-extern struct pmx_dev pmx_gpio_pin0;
-extern struct pmx_dev pmx_gpio_pin1;
-extern struct pmx_dev pmx_gpio_pin2;
-extern struct pmx_dev pmx_gpio_pin3;
-extern struct pmx_dev pmx_gpio_pin4;
-extern struct pmx_dev pmx_gpio_pin5;
-extern struct pmx_dev pmx_uart0_modem;
-extern struct pmx_dev pmx_uart0;
-extern struct pmx_dev pmx_timer_3_4;
-extern struct pmx_dev pmx_timer_1_2;
+extern struct pmx_dev spear3xx_pmx_firda;
+extern struct pmx_dev spear3xx_pmx_i2c;
+extern struct pmx_dev spear3xx_pmx_ssp_cs;
+extern struct pmx_dev spear3xx_pmx_ssp;
+extern struct pmx_dev spear3xx_pmx_mii;
+extern struct pmx_dev spear3xx_pmx_gpio_pin0;
+extern struct pmx_dev spear3xx_pmx_gpio_pin1;
+extern struct pmx_dev spear3xx_pmx_gpio_pin2;
+extern struct pmx_dev spear3xx_pmx_gpio_pin3;
+extern struct pmx_dev spear3xx_pmx_gpio_pin4;
+extern struct pmx_dev spear3xx_pmx_gpio_pin5;
+extern struct pmx_dev spear3xx_pmx_uart0_modem;
+extern struct pmx_dev spear3xx_pmx_uart0;
+extern struct pmx_dev spear3xx_pmx_timer_3_4;
+extern struct pmx_dev spear3xx_pmx_timer_1_2;
 
 #if defined(CONFIG_MACH_SPEAR310) || defined(CONFIG_MACH_SPEAR320)
 /* padmux plgpio devices */
-extern struct pmx_dev pmx_plgpio_0_1;
-extern struct pmx_dev pmx_plgpio_2_3;
-extern struct pmx_dev pmx_plgpio_4_5;
-extern struct pmx_dev pmx_plgpio_6_9;
-extern struct pmx_dev pmx_plgpio_10_27;
-extern struct pmx_dev pmx_plgpio_28;
-extern struct pmx_dev pmx_plgpio_29;
-extern struct pmx_dev pmx_plgpio_30;
-extern struct pmx_dev pmx_plgpio_31;
-extern struct pmx_dev pmx_plgpio_32;
-extern struct pmx_dev pmx_plgpio_33;
-extern struct pmx_dev pmx_plgpio_34_36;
-extern struct pmx_dev pmx_plgpio_37_42;
-extern struct pmx_dev pmx_plgpio_43_44_47_48;
-extern struct pmx_dev pmx_plgpio_45_46_49_50;
+extern struct pmx_dev spear3xx_pmx_plgpio_0_1;
+extern struct pmx_dev spear3xx_pmx_plgpio_2_3;
+extern struct pmx_dev spear3xx_pmx_plgpio_4_5;
+extern struct pmx_dev spear3xx_pmx_plgpio_6_9;
+extern struct pmx_dev spear3xx_pmx_plgpio_10_27;
+extern struct pmx_dev spear3xx_pmx_plgpio_28;
+extern struct pmx_dev spear3xx_pmx_plgpio_29;
+extern struct pmx_dev spear3xx_pmx_plgpio_30;
+extern struct pmx_dev spear3xx_pmx_plgpio_31;
+extern struct pmx_dev spear3xx_pmx_plgpio_32;
+extern struct pmx_dev spear3xx_pmx_plgpio_33;
+extern struct pmx_dev spear3xx_pmx_plgpio_34_36;
+extern struct pmx_dev spear3xx_pmx_plgpio_37_42;
+extern struct pmx_dev spear3xx_pmx_plgpio_43_44_47_48;
+extern struct pmx_dev spear3xx_pmx_plgpio_45_46_49_50;
 #endif
 
-extern struct pmx_driver pmx_driver;
-
 /* spear300 declarations */
 #ifdef CONFIG_MACH_SPEAR300
 /* Add spear300 machine device structure declarations here */
 extern struct amba_device gpio1_device;
 
 /* pad mux modes */
-extern struct pmx_mode nand_mode;
-extern struct pmx_mode nor_mode;
-extern struct pmx_mode photo_frame_mode;
-extern struct pmx_mode lend_ip_phone_mode;
-extern struct pmx_mode hend_ip_phone_mode;
-extern struct pmx_mode lend_wifi_phone_mode;
-extern struct pmx_mode hend_wifi_phone_mode;
-extern struct pmx_mode ata_pabx_wi2s_mode;
-extern struct pmx_mode ata_pabx_i2s_mode;
-extern struct pmx_mode caml_lcdw_mode;
-extern struct pmx_mode camu_lcd_mode;
-extern struct pmx_mode camu_wlcd_mode;
-extern struct pmx_mode caml_lcd_mode;
+extern struct pmx_mode spear300_nand_mode;
+extern struct pmx_mode spear300_nor_mode;
+extern struct pmx_mode spear300_photo_frame_mode;
+extern struct pmx_mode spear300_lend_ip_phone_mode;
+extern struct pmx_mode spear300_hend_ip_phone_mode;
+extern struct pmx_mode spear300_lend_wifi_phone_mode;
+extern struct pmx_mode spear300_hend_wifi_phone_mode;
+extern struct pmx_mode spear300_ata_pabx_wi2s_mode;
+extern struct pmx_mode spear300_ata_pabx_i2s_mode;
+extern struct pmx_mode spear300_caml_lcdw_mode;
+extern struct pmx_mode spear300_camu_lcd_mode;
+extern struct pmx_mode spear300_camu_wlcd_mode;
+extern struct pmx_mode spear300_caml_lcd_mode;
 
 /* pad mux devices */
-extern struct pmx_dev pmx_fsmc_2_chips;
-extern struct pmx_dev pmx_fsmc_4_chips;
-extern struct pmx_dev pmx_keyboard;
-extern struct pmx_dev pmx_clcd;
-extern struct pmx_dev pmx_telecom_gpio;
-extern struct pmx_dev pmx_telecom_tdm;
-extern struct pmx_dev pmx_telecom_spi_cs_i2c_clk;
-extern struct pmx_dev pmx_telecom_camera;
-extern struct pmx_dev pmx_telecom_dac;
-extern struct pmx_dev pmx_telecom_i2s;
-extern struct pmx_dev pmx_telecom_boot_pins;
-extern struct pmx_dev pmx_telecom_sdhci_4bit;
-extern struct pmx_dev pmx_telecom_sdhci_8bit;
-extern struct pmx_dev pmx_gpio1;
+extern struct pmx_dev spear300_pmx_fsmc_2_chips;
+extern struct pmx_dev spear300_pmx_fsmc_4_chips;
+extern struct pmx_dev spear300_pmx_keyboard;
+extern struct pmx_dev spear300_pmx_clcd;
+extern struct pmx_dev spear300_pmx_telecom_gpio;
+extern struct pmx_dev spear300_pmx_telecom_tdm;
+extern struct pmx_dev spear300_pmx_telecom_spi_cs_i2c_clk;
+extern struct pmx_dev spear300_pmx_telecom_camera;
+extern struct pmx_dev spear300_pmx_telecom_dac;
+extern struct pmx_dev spear300_pmx_telecom_i2s;
+extern struct pmx_dev spear300_pmx_telecom_boot_pins;
+extern struct pmx_dev spear300_pmx_telecom_sdhci_4bit;
+extern struct pmx_dev spear300_pmx_telecom_sdhci_8bit;
+extern struct pmx_dev spear300_pmx_gpio1;
 
 /* pad multiplexing support */
 #define SPEAR300_PAD_MUX_CONFIG_REG	0x99000000
 #define SPEAR300_MODE_CONFIG_REG	0x99000004
 
 /* Add spear300 machine function declarations here */
-void __init spear300_init(void);
+void __init spear300_init(struct pmx_mode *pmx_mode, struct pmx_dev **pmx_devs,
+		u8 pmx_dev_count);
 
 #endif /* CONFIG_MACH_SPEAR300 */
 
@@ -148,18 +147,19 @@ void __init spear300_init(void);
 /* Add spear310 machine device structure declarations here */
 
 /* pad mux devices */
-extern struct pmx_dev pmx_emi_cs_0_1_4_5;
-extern struct pmx_dev pmx_emi_cs_2_3;
-extern struct pmx_dev pmx_uart1;
-extern struct pmx_dev pmx_uart2;
-extern struct pmx_dev pmx_uart3_4_5;
-extern struct pmx_dev pmx_fsmc;
-extern struct pmx_dev pmx_rs485_0_1;
-extern struct pmx_dev pmx_tdm0;
+extern struct pmx_dev spear310_pmx_emi_cs_0_1_4_5;
+extern struct pmx_dev spear310_pmx_emi_cs_2_3;
+extern struct pmx_dev spear310_pmx_uart1;
+extern struct pmx_dev spear310_pmx_uart2;
+extern struct pmx_dev spear310_pmx_uart3_4_5;
+extern struct pmx_dev spear310_pmx_fsmc;
+extern struct pmx_dev spear310_pmx_rs485_0_1;
+extern struct pmx_dev spear310_pmx_tdm0;
 #define SPEAR310_PAD_MUX_CONFIG_REG	0xB4000008
 
 /* Add spear310 machine function declarations here */
-void __init spear310_init(void);
+void __init spear310_init(struct pmx_mode *pmx_mode, struct pmx_dev **pmx_devs,
+		u8 pmx_dev_count);
 
 #endif /* CONFIG_MACH_SPEAR310 */
 
@@ -168,41 +168,42 @@ void __init spear310_init(void);
 /* Add spear320 machine device structure declarations here */
 
 /* pad mux modes */
-extern struct pmx_mode auto_net_smii_mode;
-extern struct pmx_mode auto_net_mii_mode;
-extern struct pmx_mode auto_exp_mode;
-extern struct pmx_mode small_printers_mode;
+extern struct pmx_mode spear320_auto_net_smii_mode;
+extern struct pmx_mode spear320_auto_net_mii_mode;
+extern struct pmx_mode spear320_auto_exp_mode;
+extern struct pmx_mode spear320_small_printers_mode;
 
 /* pad mux devices */
-extern struct pmx_dev pmx_clcd;
-extern struct pmx_dev pmx_emi;
-extern struct pmx_dev pmx_fsmc;
-extern struct pmx_dev pmx_spp;
-extern struct pmx_dev pmx_sdhci;
-extern struct pmx_dev pmx_i2s;
-extern struct pmx_dev pmx_uart1;
-extern struct pmx_dev pmx_uart1_modem;
-extern struct pmx_dev pmx_uart2;
-extern struct pmx_dev pmx_touchscreen;
-extern struct pmx_dev pmx_can;
-extern struct pmx_dev pmx_sdhci_led;
-extern struct pmx_dev pmx_pwm0;
-extern struct pmx_dev pmx_pwm1;
-extern struct pmx_dev pmx_pwm2;
-extern struct pmx_dev pmx_pwm3;
-extern struct pmx_dev pmx_ssp1;
-extern struct pmx_dev pmx_ssp2;
-extern struct pmx_dev pmx_mii1;
-extern struct pmx_dev pmx_smii0;
-extern struct pmx_dev pmx_smii1;
-extern struct pmx_dev pmx_i2c1;
+extern struct pmx_dev spear320_pmx_clcd;
+extern struct pmx_dev spear320_pmx_emi;
+extern struct pmx_dev spear320_pmx_fsmc;
+extern struct pmx_dev spear320_pmx_spp;
+extern struct pmx_dev spear320_pmx_sdhci;
+extern struct pmx_dev spear320_pmx_i2s;
+extern struct pmx_dev spear320_pmx_uart1;
+extern struct pmx_dev spear320_pmx_uart1_modem;
+extern struct pmx_dev spear320_pmx_uart2;
+extern struct pmx_dev spear320_pmx_touchscreen;
+extern struct pmx_dev spear320_pmx_can;
+extern struct pmx_dev spear320_pmx_sdhci_led;
+extern struct pmx_dev spear320_pmx_pwm0;
+extern struct pmx_dev spear320_pmx_pwm1;
+extern struct pmx_dev spear320_pmx_pwm2;
+extern struct pmx_dev spear320_pmx_pwm3;
+extern struct pmx_dev spear320_pmx_ssp1;
+extern struct pmx_dev spear320_pmx_ssp2;
+extern struct pmx_dev spear320_pmx_mii1;
+extern struct pmx_dev spear320_pmx_smii0;
+extern struct pmx_dev spear320_pmx_smii1;
+extern struct pmx_dev spear320_pmx_i2c1;
 
 /* pad multiplexing support */
 #define SPEAR320_PAD_MUX_CONFIG_REG	0xB300000C
 #define SPEAR320_MODE_CONFIG_REG	0xB3000010
 
 /* Add spear320 machine function declarations here */
-void __init spear320_init(void);
+void __init spear320_init(struct pmx_mode *pmx_mode, struct pmx_dev **pmx_devs,
+		u8 pmx_dev_count);
 
 #endif /* CONFIG_MACH_SPEAR320 */
 
diff --git a/arch/arm/mach-spear3xx/spear300.c b/arch/arm/mach-spear3xx/spear300.c
index e1b2580..2618181 100644
--- a/arch/arm/mach-spear3xx/spear300.c
+++ b/arch/arm/mach-spear3xx/spear300.c
@@ -35,79 +35,79 @@
 #define CAML_LCD_MODE			(1 << 12)
 #define ALL_MODES			0x1FFF
 
-struct pmx_mode nand_mode = {
+struct pmx_mode spear300_nand_mode = {
 	.id = NAND_MODE,
 	.name = "nand mode",
 	.value = 0x00,
 };
 
-struct pmx_mode nor_mode = {
+struct pmx_mode spear300_nor_mode = {
 	.id = NOR_MODE,
 	.name = "nor mode",
 	.value = 0x01,
 };
 
-struct pmx_mode photo_frame_mode = {
+struct pmx_mode spear300_photo_frame_mode = {
 	.id = PHOTO_FRAME_MODE,
 	.name = "photo frame mode",
 	.value = 0x02,
 };
 
-struct pmx_mode lend_ip_phone_mode = {
+struct pmx_mode spear300_lend_ip_phone_mode = {
 	.id = LEND_IP_PHONE_MODE,
 	.name = "lend ip phone mode",
 	.value = 0x03,
 };
 
-struct pmx_mode hend_ip_phone_mode = {
+struct pmx_mode spear300_hend_ip_phone_mode = {
 	.id = HEND_IP_PHONE_MODE,
 	.name = "hend ip phone mode",
 	.value = 0x04,
 };
 
-struct pmx_mode lend_wifi_phone_mode = {
+struct pmx_mode spear300_lend_wifi_phone_mode = {
 	.id = LEND_WIFI_PHONE_MODE,
 	.name = "lend wifi phone mode",
 	.value = 0x05,
 };
 
-struct pmx_mode hend_wifi_phone_mode = {
+struct pmx_mode spear300_hend_wifi_phone_mode = {
 	.id = HEND_WIFI_PHONE_MODE,
 	.name = "hend wifi phone mode",
 	.value = 0x06,
 };
 
-struct pmx_mode ata_pabx_wi2s_mode = {
+struct pmx_mode spear300_ata_pabx_wi2s_mode = {
 	.id = ATA_PABX_WI2S_MODE,
 	.name = "ata pabx wi2s mode",
 	.value = 0x07,
 };
 
-struct pmx_mode ata_pabx_i2s_mode = {
+struct pmx_mode spear300_ata_pabx_i2s_mode = {
 	.id = ATA_PABX_I2S_MODE,
 	.name = "ata pabx i2s mode",
 	.value = 0x08,
 };
 
-struct pmx_mode caml_lcdw_mode = {
+struct pmx_mode spear300_caml_lcdw_mode = {
 	.id = CAML_LCDW_MODE,
 	.name = "caml lcdw mode",
 	.value = 0x0C,
 };
 
-struct pmx_mode camu_lcd_mode = {
+struct pmx_mode spear300_camu_lcd_mode = {
 	.id = CAMU_LCD_MODE,
 	.name = "camu lcd mode",
 	.value = 0x0D,
 };
 
-struct pmx_mode camu_wlcd_mode = {
+struct pmx_mode spear300_camu_wlcd_mode = {
 	.id = CAMU_WLCD_MODE,
 	.name = "camu wlcd mode",
 	.value = 0x0E,
 };
 
-struct pmx_mode caml_lcd_mode = {
+struct pmx_mode spear300_caml_lcd_mode = {
 	.id = CAML_LCD_MODE,
 	.name = "caml lcd mode",
 	.value = 0x0F,
@@ -130,7 +130,7 @@ static struct pmx_dev_mode pmx_fsmc_2_chips_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_fsmc_2_chips = {
+struct pmx_dev spear300_pmx_fsmc_2_chips = {
 	.name = "fsmc_2_chips",
 	.modes = pmx_fsmc_2_chips_modes,
 	.mode_count = ARRAY_SIZE(pmx_fsmc_2_chips_modes),
@@ -153,7 +153,7 @@ static struct pmx_dev_mode pmx_fsmc_4_chips_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_fsmc_4_chips = {
+struct pmx_dev spear300_pmx_fsmc_4_chips = {
 	.name = "fsmc_4_chips",
 	.modes = pmx_fsmc_4_chips_modes,
 	.mode_count = ARRAY_SIZE(pmx_fsmc_4_chips_modes),
@@ -178,7 +178,7 @@ static struct pmx_dev_mode pmx_keyboard_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_keyboard = {
+struct pmx_dev spear300_pmx_keyboard = {
 	.name = "keyboard",
 	.modes = pmx_keyboard_modes,
 	.mode_count = ARRAY_SIZE(pmx_keyboard_modes),
@@ -212,7 +212,7 @@ static struct pmx_dev_mode pmx_clcd_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_clcd = {
+struct pmx_dev spear300_pmx_clcd = {
 	.name = "clcd",
 	.modes = pmx_clcd_modes,
 	.mode_count = ARRAY_SIZE(pmx_clcd_modes),
@@ -279,7 +279,7 @@ static struct pmx_dev_mode pmx_telecom_gpio_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_telecom_gpio = {
+struct pmx_dev spear300_pmx_telecom_gpio = {
 	.name = "telecom_gpio",
 	.modes = pmx_telecom_gpio_modes,
 	.mode_count = ARRAY_SIZE(pmx_telecom_gpio_modes),
@@ -305,7 +305,7 @@ static struct pmx_dev_mode pmx_telecom_tdm_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_telecom_tdm = {
+struct pmx_dev spear300_pmx_telecom_tdm = {
 	.name = "telecom_tdm",
 	.modes = pmx_telecom_tdm_modes,
 	.mode_count = ARRAY_SIZE(pmx_telecom_tdm_modes),
@@ -330,7 +330,7 @@ static struct pmx_dev_mode pmx_telecom_spi_cs_i2c_clk_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_telecom_spi_cs_i2c_clk = {
+struct pmx_dev spear300_pmx_telecom_spi_cs_i2c_clk = {
 	.name = "telecom_spi_cs_i2c_clk",
 	.modes = pmx_telecom_spi_cs_i2c_clk_modes,
 	.mode_count = ARRAY_SIZE(pmx_telecom_spi_cs_i2c_clk_modes),
@@ -362,7 +362,7 @@ static struct pmx_dev_mode pmx_telecom_camera_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_telecom_camera = {
+struct pmx_dev spear300_pmx_telecom_camera = {
 	.name = "telecom_camera",
 	.modes = pmx_telecom_camera_modes,
 	.mode_count = ARRAY_SIZE(pmx_telecom_camera_modes),
@@ -385,7 +385,7 @@ static struct pmx_dev_mode pmx_telecom_dac_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_telecom_dac = {
+struct pmx_dev spear300_pmx_telecom_dac = {
 	.name = "telecom_dac",
 	.modes = pmx_telecom_dac_modes,
 	.mode_count = ARRAY_SIZE(pmx_telecom_dac_modes),
@@ -410,7 +410,7 @@ static struct pmx_dev_mode pmx_telecom_i2s_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_telecom_i2s = {
+struct pmx_dev spear300_pmx_telecom_i2s = {
 	.name = "telecom_i2s",
 	.modes = pmx_telecom_i2s_modes,
 	.mode_count = ARRAY_SIZE(pmx_telecom_i2s_modes),
@@ -433,7 +433,7 @@ static struct pmx_dev_mode pmx_telecom_boot_pins_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_telecom_boot_pins = {
+struct pmx_dev spear300_pmx_telecom_boot_pins = {
 	.name = "telecom_boot_pins",
 	.modes = pmx_telecom_boot_pins_modes,
 	.mode_count = ARRAY_SIZE(pmx_telecom_boot_pins_modes),
@@ -461,7 +461,7 @@ static struct pmx_dev_mode pmx_telecom_sdhci_4bit_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_telecom_sdhci_4bit = {
+struct pmx_dev spear300_pmx_telecom_sdhci_4bit = {
 	.name = "telecom_sdhci_4bit",
 	.modes = pmx_telecom_sdhci_4bit_modes,
 	.mode_count = ARRAY_SIZE(pmx_telecom_sdhci_4bit_modes),
@@ -488,7 +488,7 @@ static struct pmx_dev_mode pmx_telecom_sdhci_8bit_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_telecom_sdhci_8bit = {
+struct pmx_dev spear300_pmx_telecom_sdhci_8bit = {
 	.name = "telecom_sdhci_8bit",
 	.modes = pmx_telecom_sdhci_8bit_modes,
 	.mode_count = ARRAY_SIZE(pmx_telecom_sdhci_8bit_modes),
@@ -511,14 +511,14 @@ static struct pmx_dev_mode pmx_gpio1_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_gpio1 = {
+struct pmx_dev spear300_pmx_gpio1 = {
 	.name = "arm gpio1",
 	.modes = pmx_gpio1_modes,
 	.mode_count = ARRAY_SIZE(pmx_gpio1_modes),
 };
 
 /* pmx driver structure */
-struct pmx_driver pmx_driver = {
+static struct pmx_driver pmx_driver = {
 	.mode_reg = {.address = SPEAR300_MODE_CONFIG_REG, .mask = 0x0000000f},
 };
 
@@ -596,7 +596,8 @@ struct amba_device gpio1_device = {
 };
 
 /* spear300 routines */
-void __init spear300_init(void)
+void __init spear300_init(struct pmx_mode *pmx_mode, struct pmx_dev **pmx_devs,
+		u8 pmx_dev_count)
 {
 	int ret = 0;
 
@@ -611,10 +612,13 @@ void __init spear300_init(void)
 			printk(KERN_ERR "Error registering Shared IRQ\n");
 	}
 
+	/* pmx initialization */
+	pmx_driver.mode = pmx_mode;
+	pmx_driver.devs = pmx_devs;
+	pmx_driver.devs_count = pmx_dev_count;
+
 	/* This fixes addresses of all pmx devices for spear300 */
 	spear3xx_pmx_init_addr(&pmx_driver, SPEAR300_PAD_MUX_CONFIG_REG);
-
-	/* pmx initialization */
 	ret = pmx_register(&pmx_driver);
 	if (ret)
 		pr_err("padmux: registeration failed. err no: %d\n", ret);
diff --git a/arch/arm/mach-spear3xx/spear300_evb.c b/arch/arm/mach-spear3xx/spear300_evb.c
index 42d2253..405ae09 100644
--- a/arch/arm/mach-spear3xx/spear300_evb.c
+++ b/arch/arm/mach-spear3xx/spear300_evb.c
@@ -19,17 +19,17 @@
 /* padmux devices to enable */
 static struct pmx_dev *pmx_devs[] = {
 	/* spear3xx specific devices */
-	&pmx_i2c,
-	&pmx_ssp_cs,
-	&pmx_ssp,
-	&pmx_mii,
-	&pmx_uart0,
+	&spear3xx_pmx_i2c,
+	&spear3xx_pmx_ssp_cs,
+	&spear3xx_pmx_ssp,
+	&spear3xx_pmx_mii,
+	&spear3xx_pmx_uart0,
 
 	/* spear300 specific devices */
-	&pmx_fsmc_2_chips,
-	&pmx_clcd,
-	&pmx_telecom_sdhci_4bit,
-	&pmx_gpio1,
+	&spear300_pmx_fsmc_2_chips,
+	&spear300_pmx_clcd,
+	&spear300_pmx_telecom_sdhci_4bit,
+	&spear300_pmx_gpio1,
 };
 
 static struct amba_device *amba_devs[] __initdata = {
@@ -51,13 +51,9 @@ static void __init spear300_evb_init(void)
 {
 	unsigned int i;
 
-	/* padmux initialization, must be done before spear300_init */
-	pmx_driver.mode = &photo_frame_mode;
-	pmx_driver.devs = pmx_devs;
-	pmx_driver.devs_count = ARRAY_SIZE(pmx_devs);
-
 	/* call spear300 machine init function */
-	spear300_init();
+	spear300_init(&spear300_photo_frame_mode, pmx_devs,
+			ARRAY_SIZE(pmx_devs));
 
 	/* Add Platform Devices */
 	platform_add_devices(plat_devs, ARRAY_SIZE(plat_devs));
diff --git a/arch/arm/mach-spear3xx/spear310.c b/arch/arm/mach-spear3xx/spear310.c
index 9f18d28..4522e48 100644
--- a/arch/arm/mach-spear3xx/spear310.c
+++ b/arch/arm/mach-spear3xx/spear310.c
@@ -35,7 +35,7 @@ static struct pmx_dev_mode pmx_emi_cs_0_1_4_5_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_emi_cs_0_1_4_5 = {
+struct pmx_dev spear310_pmx_emi_cs_0_1_4_5 = {
 	.name = "emi_cs_0_1_4_5",
 	.modes = pmx_emi_cs_0_1_4_5_modes,
 	.mode_count = ARRAY_SIZE(pmx_emi_cs_0_1_4_5_modes),
@@ -56,7 +56,7 @@ static struct pmx_dev_mode pmx_emi_cs_2_3_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_emi_cs_2_3 = {
+struct pmx_dev spear310_pmx_emi_cs_2_3 = {
 	.name = "emi_cs_2_3",
 	.modes = pmx_emi_cs_2_3_modes,
 	.mode_count = ARRAY_SIZE(pmx_emi_cs_2_3_modes),
@@ -77,7 +77,7 @@ static struct pmx_dev_mode pmx_uart1_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_uart1 = {
+struct pmx_dev spear310_pmx_uart1 = {
 	.name = "uart1",
 	.modes = pmx_uart1_modes,
 	.mode_count = ARRAY_SIZE(pmx_uart1_modes),
@@ -98,7 +98,7 @@ static struct pmx_dev_mode pmx_uart2_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_uart2 = {
+struct pmx_dev spear310_pmx_uart2 = {
 	.name = "uart2",
 	.modes = pmx_uart2_modes,
 	.mode_count = ARRAY_SIZE(pmx_uart2_modes),
@@ -119,7 +119,7 @@ static struct pmx_dev_mode pmx_uart3_4_5_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_uart3_4_5 = {
+struct pmx_dev spear310_pmx_uart3_4_5 = {
 	.name = "uart3_4_5",
 	.modes = pmx_uart3_4_5_modes,
 	.mode_count = ARRAY_SIZE(pmx_uart3_4_5_modes),
@@ -140,7 +140,7 @@ static struct pmx_dev_mode pmx_fsmc_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_fsmc = {
+struct pmx_dev spear310_pmx_fsmc = {
 	.name = "fsmc",
 	.modes = pmx_fsmc_modes,
 	.mode_count = ARRAY_SIZE(pmx_fsmc_modes),
@@ -161,7 +161,7 @@ static struct pmx_dev_mode pmx_rs485_0_1_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_rs485_0_1 = {
+struct pmx_dev spear310_pmx_rs485_0_1 = {
 	.name = "rs485_0_1",
 	.modes = pmx_rs485_0_1_modes,
 	.mode_count = ARRAY_SIZE(pmx_rs485_0_1_modes),
@@ -182,14 +182,14 @@ static struct pmx_dev_mode pmx_tdm0_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_tdm0 = {
+struct pmx_dev spear310_pmx_tdm0 = {
 	.name = "tdm0",
 	.modes = pmx_tdm0_modes,
 	.mode_count = ARRAY_SIZE(pmx_tdm0_modes),
 };
 
 /* pmx driver structure */
-struct pmx_driver pmx_driver;
+static struct pmx_driver pmx_driver;
 
 /* spear3xx shared irq */
 static struct shirq_dev_config shirq_ras1_config[] = {
@@ -310,7 +310,8 @@ static struct spear_shirq shirq_intrcomm_ras = {
 /* Add spear310 specific devices here */
 
 /* spear310 routines */
-void __init spear310_init(void)
+void __init spear310_init(struct pmx_mode *pmx_mode, struct pmx_dev **pmx_devs,
+		u8 pmx_dev_count)
 {
 	void __iomem *base;
 	int ret = 0;
@@ -346,10 +347,13 @@ void __init spear310_init(void)
 			printk(KERN_ERR "Error registering Shared IRQ 4\n");
 	}
 
+	/* pmx initialization */
+	pmx_driver.mode = pmx_mode;
+	pmx_driver.devs = pmx_devs;
+	pmx_driver.devs_count = pmx_dev_count;
+
 	/* This fixes addresses of all pmx devices for spear310 */
 	spear3xx_pmx_init_addr(&pmx_driver, SPEAR310_PAD_MUX_CONFIG_REG);
-
-	/* pmx initialization */
 	ret = pmx_register(&pmx_driver);
 	if (ret)
 		pr_err("padmux: registeration failed. err no: %d\n", ret);
diff --git a/arch/arm/mach-spear3xx/spear310_evb.c b/arch/arm/mach-spear3xx/spear310_evb.c
index 2d7f333..9d4aadb 100644
--- a/arch/arm/mach-spear3xx/spear310_evb.c
+++ b/arch/arm/mach-spear3xx/spear310_evb.c
@@ -19,25 +19,25 @@
 /* padmux devices to enable */
 static struct pmx_dev *pmx_devs[] = {
 	/* spear3xx specific devices */
-	&pmx_i2c,
-	&pmx_ssp,
-	&pmx_gpio_pin0,
-	&pmx_gpio_pin1,
-	&pmx_gpio_pin2,
-	&pmx_gpio_pin3,
-	&pmx_gpio_pin4,
-	&pmx_gpio_pin5,
-	&pmx_uart0,
+	&spear3xx_pmx_i2c,
+	&spear3xx_pmx_ssp,
+	&spear3xx_pmx_gpio_pin0,
+	&spear3xx_pmx_gpio_pin1,
+	&spear3xx_pmx_gpio_pin2,
+	&spear3xx_pmx_gpio_pin3,
+	&spear3xx_pmx_gpio_pin4,
+	&spear3xx_pmx_gpio_pin5,
+	&spear3xx_pmx_uart0,
 
 	/* spear310 specific devices */
-	&pmx_emi_cs_0_1_4_5,
-	&pmx_emi_cs_2_3,
-	&pmx_uart1,
-	&pmx_uart2,
-	&pmx_uart3_4_5,
-	&pmx_fsmc,
-	&pmx_rs485_0_1,
-	&pmx_tdm0,
+	&spear310_pmx_emi_cs_0_1_4_5,
+	&spear310_pmx_emi_cs_2_3,
+	&spear310_pmx_uart1,
+	&spear310_pmx_uart2,
+	&spear310_pmx_uart3_4_5,
+	&spear310_pmx_fsmc,
+	&spear310_pmx_rs485_0_1,
+	&spear310_pmx_tdm0,
 };
 
 static struct amba_device *amba_devs[] __initdata = {
@@ -58,13 +58,8 @@ static void __init spear310_evb_init(void)
 {
 	unsigned int i;
 
-	/* padmux initialization, must be done before spear310_init */
-	pmx_driver.mode = NULL;
-	pmx_driver.devs = pmx_devs;
-	pmx_driver.devs_count = ARRAY_SIZE(pmx_devs);
-
 	/* call spear310 machine init function */
-	spear310_init();
+	spear310_init(NULL, pmx_devs, ARRAY_SIZE(pmx_devs));
 
 	/* Add Platform Devices */
 	platform_add_devices(plat_devs, ARRAY_SIZE(plat_devs));
diff --git a/arch/arm/mach-spear3xx/spear320.c b/arch/arm/mach-spear3xx/spear320.c
index 69b9549..a99cf7c 100644
--- a/arch/arm/mach-spear3xx/spear320.c
+++ b/arch/arm/mach-spear3xx/spear320.c
@@ -24,25 +24,25 @@
 #define SMALL_PRINTERS_MODE	(1 << 3)
 #define ALL_MODES		0xF
 
-struct pmx_mode auto_net_smii_mode = {
+struct pmx_mode spear320_auto_net_smii_mode = {
 	.id = AUTO_NET_SMII_MODE,
 	.name = "Automation Networking SMII Mode",
 	.value = 0x00,
 };
 
-struct pmx_mode auto_net_mii_mode = {
+struct pmx_mode spear320_auto_net_mii_mode = {
 	.id = AUTO_NET_MII_MODE,
 	.name = "Automation Networking MII Mode",
 	.value = 0x01,
 };
 
-struct pmx_mode auto_exp_mode = {
+struct pmx_mode spear320_auto_exp_mode = {
 	.id = AUTO_EXP_MODE,
 	.name = "Automation Expanded Mode",
 	.value = 0x02,
 };
 
-struct pmx_mode small_printers_mode = {
+struct pmx_mode spear320_small_printers_mode = {
 	.id = SMALL_PRINTERS_MODE,
 	.name = "Small Printers Mode",
 	.value = 0x03,
@@ -65,7 +65,7 @@ static struct pmx_dev_mode pmx_clcd_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_clcd = {
+struct pmx_dev spear320_pmx_clcd = {
 	.name = "clcd",
 	.modes = pmx_clcd_modes,
 	.mode_count = ARRAY_SIZE(pmx_clcd_modes),
@@ -87,7 +87,7 @@ static struct pmx_dev_mode pmx_emi_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_emi = {
+struct pmx_dev spear320_pmx_emi = {
 	.name = "emi",
 	.modes = pmx_emi_modes,
 	.mode_count = ARRAY_SIZE(pmx_emi_modes),
@@ -109,7 +109,7 @@ static struct pmx_dev_mode pmx_fsmc_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_fsmc = {
+struct pmx_dev spear320_pmx_fsmc = {
 	.name = "fsmc",
 	.modes = pmx_fsmc_modes,
 	.mode_count = ARRAY_SIZE(pmx_fsmc_modes),
@@ -131,7 +131,7 @@ static struct pmx_dev_mode pmx_spp_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_spp = {
+struct pmx_dev spear320_pmx_spp = {
 	.name = "spp",
 	.modes = pmx_spp_modes,
 	.mode_count = ARRAY_SIZE(pmx_spp_modes),
@@ -154,7 +154,7 @@ static struct pmx_dev_mode pmx_sdhci_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_sdhci = {
+struct pmx_dev spear320_pmx_sdhci = {
 	.name = "sdhci",
 	.modes = pmx_sdhci_modes,
 	.mode_count = ARRAY_SIZE(pmx_sdhci_modes),
@@ -176,7 +176,7 @@ static struct pmx_dev_mode pmx_i2s_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_i2s = {
+struct pmx_dev spear320_pmx_i2s = {
 	.name = "i2s",
 	.modes = pmx_i2s_modes,
 	.mode_count = ARRAY_SIZE(pmx_i2s_modes),
@@ -198,7 +198,7 @@ static struct pmx_dev_mode pmx_uart1_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_uart1 = {
+struct pmx_dev spear320_pmx_uart1 = {
 	.name = "uart1",
 	.modes = pmx_uart1_modes,
 	.mode_count = ARRAY_SIZE(pmx_uart1_modes),
@@ -233,7 +233,7 @@ static struct pmx_dev_mode pmx_uart1_modem_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_uart1_modem = {
+struct pmx_dev spear320_pmx_uart1_modem = {
 	.name = "uart1_modem",
 	.modes = pmx_uart1_modem_modes,
 	.mode_count = ARRAY_SIZE(pmx_uart1_modem_modes),
@@ -255,7 +255,7 @@ static struct pmx_dev_mode pmx_uart2_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_uart2 = {
+struct pmx_dev spear320_pmx_uart2 = {
 	.name = "uart2",
 	.modes = pmx_uart2_modes,
 	.mode_count = ARRAY_SIZE(pmx_uart2_modes),
@@ -277,7 +277,7 @@ static struct pmx_dev_mode pmx_touchscreen_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_touchscreen = {
+struct pmx_dev spear320_pmx_touchscreen = {
 	.name = "touchscreen",
 	.modes = pmx_touchscreen_modes,
 	.mode_count = ARRAY_SIZE(pmx_touchscreen_modes),
@@ -300,7 +300,7 @@ static struct pmx_dev_mode pmx_can_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_can = {
+struct pmx_dev spear320_pmx_can = {
 	.name = "can",
 	.modes = pmx_can_modes,
 	.mode_count = ARRAY_SIZE(pmx_can_modes),
@@ -322,7 +322,7 @@ static struct pmx_dev_mode pmx_sdhci_led_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_sdhci_led = {
+struct pmx_dev spear320_pmx_sdhci_led = {
 	.name = "sdhci_led",
 	.modes = pmx_sdhci_led_modes,
 	.mode_count = ARRAY_SIZE(pmx_sdhci_led_modes),
@@ -355,7 +355,7 @@ static struct pmx_dev_mode pmx_pwm0_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_pwm0 = {
+struct pmx_dev spear320_pmx_pwm0 = {
 	.name = "pwm0",
 	.modes = pmx_pwm0_modes,
 	.mode_count = ARRAY_SIZE(pmx_pwm0_modes),
@@ -388,7 +388,7 @@ static struct pmx_dev_mode pmx_pwm1_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_pwm1 = {
+struct pmx_dev spear320_pmx_pwm1 = {
 	.name = "pwm1",
 	.modes = pmx_pwm1_modes,
 	.mode_count = ARRAY_SIZE(pmx_pwm1_modes),
@@ -421,7 +421,7 @@ static struct pmx_dev_mode pmx_pwm2_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_pwm2 = {
+struct pmx_dev spear320_pmx_pwm2 = {
 	.name = "pwm2",
 	.modes = pmx_pwm2_modes,
 	.mode_count = ARRAY_SIZE(pmx_pwm2_modes),
@@ -443,7 +443,7 @@ static struct pmx_dev_mode pmx_pwm3_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_pwm3 = {
+struct pmx_dev spear320_pmx_pwm3 = {
 	.name = "pwm3",
 	.modes = pmx_pwm3_modes,
 	.mode_count = ARRAY_SIZE(pmx_pwm3_modes),
@@ -465,7 +465,7 @@ static struct pmx_dev_mode pmx_ssp1_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_ssp1 = {
+struct pmx_dev spear320_pmx_ssp1 = {
 	.name = "ssp1",
 	.modes = pmx_ssp1_modes,
 	.mode_count = ARRAY_SIZE(pmx_ssp1_modes),
@@ -487,7 +487,7 @@ static struct pmx_dev_mode pmx_ssp2_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_ssp2 = {
+struct pmx_dev spear320_pmx_ssp2 = {
 	.name = "ssp2",
 	.modes = pmx_ssp2_modes,
 	.mode_count = ARRAY_SIZE(pmx_ssp2_modes),
@@ -509,7 +509,7 @@ static struct pmx_dev_mode pmx_mii1_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_mii1 = {
+struct pmx_dev spear320_pmx_mii1 = {
 	.name = "mii1",
 	.modes = pmx_mii1_modes,
 	.mode_count = ARRAY_SIZE(pmx_mii1_modes),
@@ -531,7 +531,7 @@ static struct pmx_dev_mode pmx_smii0_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_smii0 = {
+struct pmx_dev spear320_pmx_smii0 = {
 	.name = "smii0",
 	.modes = pmx_smii0_modes,
 	.mode_count = ARRAY_SIZE(pmx_smii0_modes),
@@ -553,7 +553,7 @@ static struct pmx_dev_mode pmx_smii1_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_smii1 = {
+struct pmx_dev spear320_pmx_smii1 = {
 	.name = "smii1",
 	.modes = pmx_smii1_modes,
 	.mode_count = ARRAY_SIZE(pmx_smii1_modes),
@@ -575,14 +575,14 @@ static struct pmx_dev_mode pmx_i2c1_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_i2c1 = {
+struct pmx_dev spear320_pmx_i2c1 = {
 	.name = "i2c1",
 	.modes = pmx_i2c1_modes,
 	.mode_count = ARRAY_SIZE(pmx_i2c1_modes),
 };
 
 /* pmx driver structure */
-struct pmx_driver pmx_driver = {
+static struct pmx_driver pmx_driver = {
 	.mode_reg = {.address = SPEAR320_MODE_CONFIG_REG, .mask = 0x00000007},
 };
 
@@ -713,7 +713,8 @@ static struct spear_shirq shirq_intrcomm_ras = {
 /* Add spear320 specific devices here */
 
 /* spear320 routines */
-void __init spear320_init(void)
+void __init spear320_init(struct pmx_mode *pmx_mode, struct pmx_dev **pmx_devs,
+		u8 pmx_dev_count)
 {
 	void __iomem *base;
 	int ret = 0;
@@ -743,10 +744,13 @@ void __init spear320_init(void)
 			printk(KERN_ERR "Error registering Shared IRQ 4\n");
 	}
 
+	/* pmx initialization */
+	pmx_driver.mode = pmx_mode;
+	pmx_driver.devs = pmx_devs;
+	pmx_driver.devs_count = pmx_dev_count;
+
 	/* This fixes addresses of all pmx devices for spear320 */
 	spear3xx_pmx_init_addr(&pmx_driver, SPEAR320_PAD_MUX_CONFIG_REG);
-
-	/* pmx initialization */
 	ret = pmx_register(&pmx_driver);
 	if (ret)
 		pr_err("padmux: registeration failed. err no: %d\n", ret);
diff --git a/arch/arm/mach-spear3xx/spear320_evb.c b/arch/arm/mach-spear3xx/spear320_evb.c
index 8213e4b..7e5f17f 100644
--- a/arch/arm/mach-spear3xx/spear320_evb.c
+++ b/arch/arm/mach-spear3xx/spear320_evb.c
@@ -19,22 +19,22 @@
 /* padmux devices to enable */
 static struct pmx_dev *pmx_devs[] = {
 	/* spear3xx specific devices */
-	&pmx_i2c,
-	&pmx_ssp,
-	&pmx_mii,
-	&pmx_uart0,
+	&spear3xx_pmx_i2c,
+	&spear3xx_pmx_ssp,
+	&spear3xx_pmx_mii,
+	&spear3xx_pmx_uart0,
 
 	/* spear320 specific devices */
-	&pmx_fsmc,
-	&pmx_sdhci,
-	&pmx_i2s,
-	&pmx_uart1,
-	&pmx_uart2,
-	&pmx_can,
-	&pmx_pwm0,
-	&pmx_pwm1,
-	&pmx_pwm2,
-	&pmx_mii1,
+	&spear320_pmx_fsmc,
+	&spear320_pmx_sdhci,
+	&spear320_pmx_i2s,
+	&spear320_pmx_uart1,
+	&spear320_pmx_uart2,
+	&spear320_pmx_can,
+	&spear320_pmx_pwm0,
+	&spear320_pmx_pwm1,
+	&spear320_pmx_pwm2,
+	&spear320_pmx_mii1,
 };
 
 static struct amba_device *amba_devs[] __initdata = {
@@ -55,13 +55,9 @@ static void __init spear320_evb_init(void)
 {
 	unsigned int i;
 
-	/* padmux initialization, must be done before spear320_init */
-	pmx_driver.mode = &auto_net_mii_mode;
-	pmx_driver.devs = pmx_devs;
-	pmx_driver.devs_count = ARRAY_SIZE(pmx_devs);
-
 	/* call spear320 machine init function */
-	spear320_init();
+	spear320_init(&spear320_auto_net_mii_mode, pmx_devs,
+			ARRAY_SIZE(pmx_devs));
 
 	/* Add Platform Devices */
 	platform_add_devices(plat_devs, ARRAY_SIZE(plat_devs));
diff --git a/arch/arm/mach-spear3xx/spear3xx.c b/arch/arm/mach-spear3xx/spear3xx.c
index 9ae7009..64dac69 100644
--- a/arch/arm/mach-spear3xx/spear3xx.c
+++ b/arch/arm/mach-spear3xx/spear3xx.c
@@ -118,7 +118,7 @@ static struct pmx_dev_mode pmx_firda_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_firda = {
+struct pmx_dev spear3xx_pmx_firda = {
 	.name = "firda",
 	.modes = pmx_firda_modes,
 	.mode_count = ARRAY_SIZE(pmx_firda_modes),
@@ -140,7 +140,7 @@ static struct pmx_dev_mode pmx_i2c_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_i2c = {
+struct pmx_dev spear3xx_pmx_i2c = {
 	.name = "i2c",
 	.modes = pmx_i2c_modes,
 	.mode_count = ARRAY_SIZE(pmx_i2c_modes),
@@ -162,7 +162,7 @@ static struct pmx_dev_mode pmx_ssp_cs_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_ssp_cs = {
+struct pmx_dev spear3xx_pmx_ssp_cs = {
 	.name = "ssp_chip_selects",
 	.modes = pmx_ssp_cs_modes,
 	.mode_count = ARRAY_SIZE(pmx_ssp_cs_modes),
@@ -184,7 +184,7 @@ static struct pmx_dev_mode pmx_ssp_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_ssp = {
+struct pmx_dev spear3xx_pmx_ssp = {
 	.name = "ssp",
 	.modes = pmx_ssp_modes,
 	.mode_count = ARRAY_SIZE(pmx_ssp_modes),
@@ -206,7 +206,7 @@ static struct pmx_dev_mode pmx_mii_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_mii = {
+struct pmx_dev spear3xx_pmx_mii = {
 	.name = "mii",
 	.modes = pmx_mii_modes,
 	.mode_count = ARRAY_SIZE(pmx_mii_modes),
@@ -228,7 +228,7 @@ static struct pmx_dev_mode pmx_gpio_pin0_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_gpio_pin0 = {
+struct pmx_dev spear3xx_pmx_gpio_pin0 = {
 	.name = "gpio_pin0",
 	.modes = pmx_gpio_pin0_modes,
 	.mode_count = ARRAY_SIZE(pmx_gpio_pin0_modes),
@@ -250,7 +250,7 @@ static struct pmx_dev_mode pmx_gpio_pin1_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_gpio_pin1 = {
+struct pmx_dev spear3xx_pmx_gpio_pin1 = {
 	.name = "gpio_pin1",
 	.modes = pmx_gpio_pin1_modes,
 	.mode_count = ARRAY_SIZE(pmx_gpio_pin1_modes),
@@ -272,7 +272,7 @@ static struct pmx_dev_mode pmx_gpio_pin2_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_gpio_pin2 = {
+struct pmx_dev spear3xx_pmx_gpio_pin2 = {
 	.name = "gpio_pin2",
 	.modes = pmx_gpio_pin2_modes,
 	.mode_count = ARRAY_SIZE(pmx_gpio_pin2_modes),
@@ -294,7 +294,7 @@ static struct pmx_dev_mode pmx_gpio_pin3_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_gpio_pin3 = {
+struct pmx_dev spear3xx_pmx_gpio_pin3 = {
 	.name = "gpio_pin3",
 	.modes = pmx_gpio_pin3_modes,
 	.mode_count = ARRAY_SIZE(pmx_gpio_pin3_modes),
@@ -316,7 +316,7 @@ static struct pmx_dev_mode pmx_gpio_pin4_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_gpio_pin4 = {
+struct pmx_dev spear3xx_pmx_gpio_pin4 = {
 	.name = "gpio_pin4",
 	.modes = pmx_gpio_pin4_modes,
 	.mode_count = ARRAY_SIZE(pmx_gpio_pin4_modes),
@@ -338,7 +338,7 @@ static struct pmx_dev_mode pmx_gpio_pin5_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_gpio_pin5 = {
+struct pmx_dev spear3xx_pmx_gpio_pin5 = {
 	.name = "gpio_pin5",
 	.modes = pmx_gpio_pin5_modes,
 	.mode_count = ARRAY_SIZE(pmx_gpio_pin5_modes),
@@ -360,7 +360,7 @@ static struct pmx_dev_mode pmx_uart0_modem_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_uart0_modem = {
+struct pmx_dev spear3xx_pmx_uart0_modem = {
 	.name = "uart0_modem",
 	.modes = pmx_uart0_modem_modes,
 	.mode_count = ARRAY_SIZE(pmx_uart0_modem_modes),
@@ -382,7 +382,7 @@ static struct pmx_dev_mode pmx_uart0_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_uart0 = {
+struct pmx_dev spear3xx_pmx_uart0 = {
 	.name = "uart0",
 	.modes = pmx_uart0_modes,
 	.mode_count = ARRAY_SIZE(pmx_uart0_modes),
@@ -404,7 +404,7 @@ static struct pmx_dev_mode pmx_timer_3_4_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_timer_3_4 = {
+struct pmx_dev spear3xx_pmx_timer_3_4 = {
 	.name = "timer_3_4",
 	.modes = pmx_timer_3_4_modes,
 	.mode_count = ARRAY_SIZE(pmx_timer_3_4_modes),
@@ -426,7 +426,7 @@ static struct pmx_dev_mode pmx_timer_1_2_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_timer_1_2 = {
+struct pmx_dev spear3xx_pmx_timer_1_2 = {
 	.name = "timer_1_2",
 	.modes = pmx_timer_1_2_modes,
 	.mode_count = ARRAY_SIZE(pmx_timer_1_2_modes),
@@ -449,7 +449,7 @@ static struct pmx_dev_mode pmx_plgpio_0_1_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_plgpio_0_1 = {
+struct pmx_dev spear3xx_pmx_plgpio_0_1 = {
 	.name = "plgpio 0 and 1",
 	.modes = pmx_plgpio_0_1_modes,
 	.mode_count = ARRAY_SIZE(pmx_plgpio_0_1_modes),
@@ -471,7 +471,7 @@ static struct pmx_dev_mode pmx_plgpio_2_3_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_plgpio_2_3 = {
+struct pmx_dev spear3xx_pmx_plgpio_2_3 = {
 	.name = "plgpio 2 and 3",
 	.modes = pmx_plgpio_2_3_modes,
 	.mode_count = ARRAY_SIZE(pmx_plgpio_2_3_modes),
@@ -493,7 +493,7 @@ static struct pmx_dev_mode pmx_plgpio_4_5_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_plgpio_4_5 = {
+struct pmx_dev spear3xx_pmx_plgpio_4_5 = {
 	.name = "plgpio 4 and 5",
 	.modes = pmx_plgpio_4_5_modes,
 	.mode_count = ARRAY_SIZE(pmx_plgpio_4_5_modes),
@@ -515,7 +515,7 @@ static struct pmx_dev_mode pmx_plgpio_6_9_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_plgpio_6_9 = {
+struct pmx_dev spear3xx_pmx_plgpio_6_9 = {
 	.name = "plgpio 6 to 9",
 	.modes = pmx_plgpio_6_9_modes,
 	.mode_count = ARRAY_SIZE(pmx_plgpio_6_9_modes),
@@ -537,7 +537,7 @@ static struct pmx_dev_mode pmx_plgpio_10_27_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_plgpio_10_27 = {
+struct pmx_dev spear3xx_pmx_plgpio_10_27 = {
 	.name = "plgpio 10 to 27",
 	.modes = pmx_plgpio_10_27_modes,
 	.mode_count = ARRAY_SIZE(pmx_plgpio_10_27_modes),
@@ -559,7 +559,7 @@ static struct pmx_dev_mode pmx_plgpio_28_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_plgpio_28 = {
+struct pmx_dev spear3xx_pmx_plgpio_28 = {
 	.name = "plgpio 28",
 	.modes = pmx_plgpio_28_modes,
 	.mode_count = ARRAY_SIZE(pmx_plgpio_28_modes),
@@ -581,7 +581,7 @@ static struct pmx_dev_mode pmx_plgpio_29_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_plgpio_29 = {
+struct pmx_dev spear3xx_pmx_plgpio_29 = {
 	.name = "plgpio 29",
 	.modes = pmx_plgpio_29_modes,
 	.mode_count = ARRAY_SIZE(pmx_plgpio_29_modes),
@@ -603,7 +603,7 @@ static struct pmx_dev_mode pmx_plgpio_30_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_plgpio_30 = {
+struct pmx_dev spear3xx_pmx_plgpio_30 = {
 	.name = "plgpio 30",
 	.modes = pmx_plgpio_30_modes,
 	.mode_count = ARRAY_SIZE(pmx_plgpio_30_modes),
@@ -625,7 +625,7 @@ static struct pmx_dev_mode pmx_plgpio_31_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_plgpio_31 = {
+struct pmx_dev spear3xx_pmx_plgpio_31 = {
 	.name = "plgpio 31",
 	.modes = pmx_plgpio_31_modes,
 	.mode_count = ARRAY_SIZE(pmx_plgpio_31_modes),
@@ -647,7 +647,7 @@ static struct pmx_dev_mode pmx_plgpio_32_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_plgpio_32 = {
+struct pmx_dev spear3xx_pmx_plgpio_32 = {
 	.name = "plgpio 32",
 	.modes = pmx_plgpio_32_modes,
 	.mode_count = ARRAY_SIZE(pmx_plgpio_32_modes),
@@ -669,7 +669,7 @@ static struct pmx_dev_mode pmx_plgpio_33_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_plgpio_33 = {
+struct pmx_dev spear3xx_pmx_plgpio_33 = {
 	.name = "plgpio 33",
 	.modes = pmx_plgpio_33_modes,
 	.mode_count = ARRAY_SIZE(pmx_plgpio_33_modes),
@@ -691,7 +691,7 @@ static struct pmx_dev_mode pmx_plgpio_34_36_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_plgpio_34_36 = {
+struct pmx_dev spear3xx_pmx_plgpio_34_36 = {
 	.name = "plgpio 34 to 36",
 	.modes = pmx_plgpio_34_36_modes,
 	.mode_count = ARRAY_SIZE(pmx_plgpio_34_36_modes),
@@ -713,7 +713,7 @@ static struct pmx_dev_mode pmx_plgpio_37_42_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_plgpio_37_42 = {
+struct pmx_dev spear3xx_pmx_plgpio_37_42 = {
 	.name = "plgpio 37 to 42",
 	.modes = pmx_plgpio_37_42_modes,
 	.mode_count = ARRAY_SIZE(pmx_plgpio_37_42_modes),
@@ -735,7 +735,7 @@ static struct pmx_dev_mode pmx_plgpio_43_44_47_48_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_plgpio_43_44_47_48 = {
+struct pmx_dev spear3xx_pmx_plgpio_43_44_47_48 = {
 	.name = "plgpio 43, 44, 47 and 48",
 	.modes = pmx_plgpio_43_44_47_48_modes,
 	.mode_count = ARRAY_SIZE(pmx_plgpio_43_44_47_48_modes),
@@ -757,7 +757,7 @@ static struct pmx_dev_mode pmx_plgpio_45_46_49_50_modes[] = {
 	},
 };
 
-struct pmx_dev pmx_plgpio_45_46_49_50 = {
+struct pmx_dev spear3xx_pmx_plgpio_45_46_49_50 = {
 	.name = "plgpio 45, 46, 49 and 50",
 	.modes = pmx_plgpio_45_46_49_50_modes,
 	.mode_count = ARRAY_SIZE(pmx_plgpio_45_46_49_50_modes),
-- 
1.7.2.2
