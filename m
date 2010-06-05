From: ryan@bluewatersys.com (Ryan Mallon)
Date: Sat,  5 Jun 2010 18:05:51 +1200
Subject: [PATCH 1/5] SPEAr3xx: Make local structres static
In-Reply-To: <1275717955-14545-1-git-send-email-ryan@bluewatersys.com>
References: <1275717955-14545-1-git-send-email-ryan@bluewatersys.com>
Message-ID: <1275717955-14545-2-git-send-email-ryan@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Several structures in arch/arm/mach-spear3xx are not marked static
like they should be. Fix this.

Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
---
 arch/arm/mach-spear3xx/spear300.c |   33 ++++++++++----------
 arch/arm/mach-spear3xx/spear310.c |   16 +++++-----
 arch/arm/mach-spear3xx/spear320.c |   56 +++++++++++++++++-----------------
 arch/arm/mach-spear3xx/spear3xx.c |   60 ++++++++++++++++++------------------
 4 files changed, 83 insertions(+), 82 deletions(-)

diff --git a/arch/arm/mach-spear3xx/spear300.c b/arch/arm/mach-spear3xx/spear300.c
index 3560f8c..b71f996 100644
--- a/arch/arm/mach-spear3xx/spear300.c
+++ b/arch/arm/mach-spear3xx/spear300.c
@@ -119,7 +119,7 @@ struct pmx_mode caml_lcd_mode = {
 };
 
 /* devices */
-struct pmx_dev_mode pmx_fsmc_2_chips_modes[] = {
+static struct pmx_dev_mode pmx_fsmc_2_chips_modes[] = {
 	{
 		.ids = NAND_MODE | NOR_MODE | PHOTO_FRAME_MODE |
 			ATA_PABX_WI2S_MODE | ATA_PABX_I2S_MODE,
@@ -134,7 +134,7 @@ struct pmx_dev pmx_fsmc_2_chips = {
 	.enb_on_reset = 1,
 };
 
-struct pmx_dev_mode pmx_fsmc_4_chips_modes[] = {
+static struct pmx_dev_mode pmx_fsmc_4_chips_modes[] = {
 	{
 		.ids = NAND_MODE | NOR_MODE | PHOTO_FRAME_MODE |
 			ATA_PABX_WI2S_MODE | ATA_PABX_I2S_MODE,
@@ -149,7 +149,7 @@ struct pmx_dev pmx_fsmc_4_chips = {
 	.enb_on_reset = 1,
 };
 
-struct pmx_dev_mode pmx_keyboard_modes[] = {
+static struct pmx_dev_mode pmx_keyboard_modes[] = {
 	{
 		.ids = LEND_IP_PHONE_MODE | HEND_IP_PHONE_MODE |
 			LEND_WIFI_PHONE_MODE | HEND_WIFI_PHONE_MODE |
@@ -166,7 +166,7 @@ struct pmx_dev pmx_keyboard = {
 	.enb_on_reset = 1,
 };
 
-struct pmx_dev_mode pmx_clcd_modes[] = {
+static struct pmx_dev_mode pmx_clcd_modes[] = {
 	{
 		.ids = PHOTO_FRAME_MODE,
 		.mask = PMX_TIMER_1_2_MASK | PMX_TIMER_3_4_MASK ,
@@ -184,7 +184,7 @@ struct pmx_dev pmx_clcd = {
 	.enb_on_reset = 1,
 };
 
-struct pmx_dev_mode pmx_telecom_gpio_modes[] = {
+static struct pmx_dev_mode pmx_telecom_gpio_modes[] = {
 	{
 		.ids = PHOTO_FRAME_MODE | CAMU_LCD_MODE | CAML_LCD_MODE,
 		.mask = PMX_MII_MASK,
@@ -211,7 +211,7 @@ struct pmx_dev pmx_telecom_gpio = {
 	.enb_on_reset = 1,
 };
 
-struct pmx_dev_mode pmx_telecom_tdm_modes[] = {
+static struct pmx_dev_mode pmx_telecom_tdm_modes[] = {
 	{
 		.ids = PHOTO_FRAME_MODE | LEND_IP_PHONE_MODE |
 			HEND_IP_PHONE_MODE | LEND_WIFI_PHONE_MODE
@@ -229,7 +229,7 @@ struct pmx_dev pmx_telecom_tdm = {
 	.enb_on_reset = 1,
 };
 
-struct pmx_dev_mode pmx_telecom_spi_cs_i2c_clk_modes[] = {
+static struct pmx_dev_mode pmx_telecom_spi_cs_i2c_clk_modes[] = {
 	{
 		.ids = LEND_IP_PHONE_MODE | HEND_IP_PHONE_MODE |
 			LEND_WIFI_PHONE_MODE | HEND_WIFI_PHONE_MODE
@@ -246,7 +246,7 @@ struct pmx_dev pmx_telecom_spi_cs_i2c_clk = {
 	.enb_on_reset = 1,
 };
 
-struct pmx_dev_mode pmx_telecom_camera_modes[] = {
+static struct pmx_dev_mode pmx_telecom_camera_modes[] = {
 	{
 		.ids = CAML_LCDW_MODE | CAML_LCD_MODE,
 		.mask = PMX_MII_MASK,
@@ -263,7 +263,7 @@ struct pmx_dev pmx_telecom_camera = {
 	.enb_on_reset = 1,
 };
 
-struct pmx_dev_mode pmx_telecom_dac_modes[] = {
+static struct pmx_dev_mode pmx_telecom_dac_modes[] = {
 	{
 		.ids = ATA_PABX_I2S_MODE | CAML_LCDW_MODE | CAMU_LCD_MODE
 			| CAMU_WLCD_MODE | CAML_LCD_MODE,
@@ -278,7 +278,7 @@ struct pmx_dev pmx_telecom_dac = {
 	.enb_on_reset = 1,
 };
 
-struct pmx_dev_mode pmx_telecom_i2s_modes[] = {
+static struct pmx_dev_mode pmx_telecom_i2s_modes[] = {
 	{
 		.ids = LEND_IP_PHONE_MODE | HEND_IP_PHONE_MODE
 			| LEND_WIFI_PHONE_MODE | HEND_WIFI_PHONE_MODE |
@@ -295,7 +295,7 @@ struct pmx_dev pmx_telecom_i2s = {
 	.enb_on_reset = 1,
 };
 
-struct pmx_dev_mode pmx_telecom_boot_pins_modes[] = {
+static struct pmx_dev_mode pmx_telecom_boot_pins_modes[] = {
 	{
 		.ids = NAND_MODE | NOR_MODE,
 		.mask = PMX_UART0_MODEM_MASK | PMX_TIMER_1_2_MASK |
@@ -310,7 +310,7 @@ struct pmx_dev pmx_telecom_boot_pins = {
 	.enb_on_reset = 1,
 };
 
-struct pmx_dev_mode pmx_telecom_sdio_4bit_modes[] = {
+static struct pmx_dev_mode pmx_telecom_sdio_4bit_modes[] = {
 	{
 		.ids = PHOTO_FRAME_MODE | LEND_IP_PHONE_MODE |
 			HEND_IP_PHONE_MODE | LEND_WIFI_PHONE_MODE |
@@ -330,7 +330,7 @@ struct pmx_dev pmx_telecom_sdio_4bit = {
 	.enb_on_reset = 1,
 };
 
-struct pmx_dev_mode pmx_telecom_sdio_8bit_modes[] = {
+static struct pmx_dev_mode pmx_telecom_sdio_8bit_modes[] = {
 	{
 		.ids = PHOTO_FRAME_MODE | LEND_IP_PHONE_MODE |
 			HEND_IP_PHONE_MODE | LEND_WIFI_PHONE_MODE |
@@ -349,7 +349,7 @@ struct pmx_dev pmx_telecom_sdio_8bit = {
 	.enb_on_reset = 1,
 };
 
-struct pmx_dev_mode pmx_gpio1_modes[] = {
+static struct pmx_dev_mode pmx_gpio1_modes[] = {
 	{
 		.ids = PHOTO_FRAME_MODE,
 		.mask = PMX_UART0_MODEM_MASK | PMX_TIMER_1_2_MASK |
@@ -391,7 +391,7 @@ struct amba_device gpio1_device = {
 };
 
 /* spear3xx shared irq */
-struct shirq_dev_config shirq_ras1_config[] = {
+static struct shirq_dev_config shirq_ras1_config[] = {
 	{
 		.virq = VIRQ_IT_PERS_S,
 		.enb_mask = IT_PERS_S_IRQ_MASK,
@@ -431,7 +431,8 @@ struct shirq_dev_config shirq_ras1_config[] = {
 	},
 };
 
-struct spear_shirq shirq_ras1 = {
+
+static struct spear_shirq shirq_ras1 = {
 	.irq = IRQ_GEN_RAS_1,
 	.dev_config = shirq_ras1_config,
 	.dev_count = ARRAY_SIZE(shirq_ras1_config),
diff --git a/arch/arm/mach-spear3xx/spear310.c b/arch/arm/mach-spear3xx/spear310.c
index 96a1ab8..14698b8 100644
--- a/arch/arm/mach-spear3xx/spear310.c
+++ b/arch/arm/mach-spear3xx/spear310.c
@@ -142,7 +142,7 @@ struct pmx_driver pmx_driver = {
 /* Add spear310 specific devices here */
 
 /* spear3xx shared irq */
-struct shirq_dev_config shirq_ras1_config[] = {
+static struct shirq_dev_config shirq_ras1_config[] = {
 	{
 		.virq = VIRQ_SMII0,
 		.status_mask = SMII0_IRQ_MASK,
@@ -170,7 +170,7 @@ struct shirq_dev_config shirq_ras1_config[] = {
 	},
 };
 
-struct spear_shirq shirq_ras1 = {
+static struct spear_shirq shirq_ras1 = {
 	.irq = IRQ_GEN_RAS_1,
 	.dev_config = shirq_ras1_config,
 	.dev_count = ARRAY_SIZE(shirq_ras1_config),
@@ -182,7 +182,7 @@ struct spear_shirq shirq_ras1 = {
 	},
 };
 
-struct shirq_dev_config shirq_ras2_config[] = {
+static struct shirq_dev_config shirq_ras2_config[] = {
 	{
 		.virq = VIRQ_UART1,
 		.status_mask = UART1_IRQ_MASK,
@@ -201,7 +201,7 @@ struct shirq_dev_config shirq_ras2_config[] = {
 	},
 };
 
-struct spear_shirq shirq_ras2 = {
+static struct spear_shirq shirq_ras2 = {
 	.irq = IRQ_GEN_RAS_2,
 	.dev_config = shirq_ras2_config,
 	.dev_count = ARRAY_SIZE(shirq_ras2_config),
@@ -213,14 +213,14 @@ struct spear_shirq shirq_ras2 = {
 	},
 };
 
-struct shirq_dev_config shirq_ras3_config[] = {
+static struct shirq_dev_config shirq_ras3_config[] = {
 	{
 		.virq = VIRQ_EMI,
 		.status_mask = EMI_IRQ_MASK,
 	},
 };
 
-struct spear_shirq shirq_ras3 = {
+static struct spear_shirq shirq_ras3 = {
 	.irq = IRQ_GEN_RAS_3,
 	.dev_config = shirq_ras3_config,
 	.dev_count = ARRAY_SIZE(shirq_ras3_config),
@@ -232,7 +232,7 @@ struct spear_shirq shirq_ras3 = {
 	},
 };
 
-struct shirq_dev_config shirq_intrcomm_ras_config[] = {
+static struct shirq_dev_config shirq_intrcomm_ras_config[] = {
 	{
 		.virq = VIRQ_TDM_HDLC,
 		.status_mask = TDM_HDLC_IRQ_MASK,
@@ -245,7 +245,7 @@ struct shirq_dev_config shirq_intrcomm_ras_config[] = {
 	},
 };
 
-struct spear_shirq shirq_intrcomm_ras = {
+static struct spear_shirq shirq_intrcomm_ras = {
 	.irq = IRQ_INTRCOMM_RAS_ARM,
 	.dev_config = shirq_intrcomm_ras_config,
 	.dev_count = ARRAY_SIZE(shirq_intrcomm_ras_config),
diff --git a/arch/arm/mach-spear3xx/spear320.c b/arch/arm/mach-spear3xx/spear320.c
index 6a12195..958e52d 100644
--- a/arch/arm/mach-spear3xx/spear320.c
+++ b/arch/arm/mach-spear3xx/spear320.c
@@ -54,7 +54,7 @@ struct pmx_mode small_printers_mode = {
 };
 
 /* devices */
-struct pmx_dev_mode pmx_clcd_modes[] = {
+static struct pmx_dev_mode pmx_clcd_modes[] = {
 	{
 		.ids = AUTO_NET_SMII_MODE,
 		.mask = 0x0,
@@ -68,7 +68,7 @@ struct pmx_dev pmx_clcd = {
 	.enb_on_reset = 1,
 };
 
-struct pmx_dev_mode pmx_emi_modes[] = {
+static struct pmx_dev_mode pmx_emi_modes[] = {
 	{
 		.ids = AUTO_EXP_MODE,
 		.mask = PMX_TIMER_1_2_MASK | PMX_TIMER_3_4_MASK,
@@ -82,7 +82,7 @@ struct pmx_dev pmx_emi = {
 	.enb_on_reset = 1,
 };
 
-struct pmx_dev_mode pmx_fsmc_modes[] = {
+static struct pmx_dev_mode pmx_fsmc_modes[] = {
 	{
 		.ids = ALL_MODES,
 		.mask = 0x0,
@@ -96,7 +96,7 @@ struct pmx_dev pmx_fsmc = {
 	.enb_on_reset = 1,
 };
 
-struct pmx_dev_mode pmx_spp_modes[] = {
+static struct pmx_dev_mode pmx_spp_modes[] = {
 	{
 		.ids = SMALL_PRINTERS_MODE,
 		.mask = 0x0,
@@ -110,7 +110,7 @@ struct pmx_dev pmx_spp = {
 	.enb_on_reset = 1,
 };
 
-struct pmx_dev_mode pmx_sdio_modes[] = {
+static struct pmx_dev_mode pmx_sdio_modes[] = {
 	{
 		.ids = AUTO_NET_SMII_MODE | AUTO_NET_MII_MODE |
 			SMALL_PRINTERS_MODE,
@@ -125,7 +125,7 @@ struct pmx_dev pmx_sdio = {
 	.enb_on_reset = 1,
 };
 
-struct pmx_dev_mode pmx_i2s_modes[] = {
+static struct pmx_dev_mode pmx_i2s_modes[] = {
 	{
 		.ids = AUTO_NET_SMII_MODE | AUTO_NET_MII_MODE,
 		.mask = PMX_UART0_MODEM_MASK,
@@ -139,7 +139,7 @@ struct pmx_dev pmx_i2s = {
 	.enb_on_reset = 1,
 };
 
-struct pmx_dev_mode pmx_uart1_modes[] = {
+static struct pmx_dev_mode pmx_uart1_modes[] = {
 	{
 		.ids = ALL_MODES,
 		.mask = PMX_GPIO_PIN0_MASK | PMX_GPIO_PIN1_MASK,
@@ -153,7 +153,7 @@ struct pmx_dev pmx_uart1 = {
 	.enb_on_reset = 1,
 };
 
-struct pmx_dev_mode pmx_uart1_modem_modes[] = {
+static struct pmx_dev_mode pmx_uart1_modem_modes[] = {
 	{
 		.ids = AUTO_EXP_MODE,
 		.mask = PMX_TIMER_1_2_MASK | PMX_TIMER_3_4_MASK |
@@ -172,7 +172,7 @@ struct pmx_dev pmx_uart1_modem = {
 	.enb_on_reset = 1,
 };
 
-struct pmx_dev_mode pmx_uart2_modes[] = {
+static struct pmx_dev_mode pmx_uart2_modes[] = {
 	{
 		.ids = ALL_MODES,
 		.mask = PMX_FIRDA_MASK,
@@ -186,7 +186,7 @@ struct pmx_dev pmx_uart2 = {
 	.enb_on_reset = 1,
 };
 
-struct pmx_dev_mode pmx_touchscreen_modes[] = {
+static struct pmx_dev_mode pmx_touchscreen_modes[] = {
 	{
 		.ids = AUTO_NET_SMII_MODE,
 		.mask = PMX_SSP_CS_MASK,
@@ -200,7 +200,7 @@ struct pmx_dev pmx_touchscreen = {
 	.enb_on_reset = 1,
 };
 
-struct pmx_dev_mode pmx_can_modes[] = {
+static struct pmx_dev_mode pmx_can_modes[] = {
 	{
 		.ids = AUTO_NET_SMII_MODE | AUTO_NET_MII_MODE | AUTO_EXP_MODE,
 		.mask = PMX_GPIO_PIN2_MASK | PMX_GPIO_PIN3_MASK |
@@ -215,7 +215,7 @@ struct pmx_dev pmx_can = {
 	.enb_on_reset = 1,
 };
 
-struct pmx_dev_mode pmx_sdio_led_modes[] = {
+static struct pmx_dev_mode pmx_sdio_led_modes[] = {
 	{
 		.ids = AUTO_NET_SMII_MODE | AUTO_NET_MII_MODE,
 		.mask = PMX_SSP_CS_MASK,
@@ -229,7 +229,7 @@ struct pmx_dev pmx_sdio_led = {
 	.enb_on_reset = 1,
 };
 
-struct pmx_dev_mode pmx_pwm0_modes[] = {
+static struct pmx_dev_mode pmx_pwm0_modes[] = {
 	{
 		.ids = AUTO_NET_SMII_MODE | AUTO_NET_MII_MODE,
 		.mask = PMX_UART0_MODEM_MASK,
@@ -246,7 +246,7 @@ struct pmx_dev pmx_pwm0 = {
 	.enb_on_reset = 1,
 };
 
-struct pmx_dev_mode pmx_pwm1_modes[] = {
+static struct pmx_dev_mode pmx_pwm1_modes[] = {
 	{
 		.ids = AUTO_NET_SMII_MODE | AUTO_NET_MII_MODE,
 		.mask = PMX_UART0_MODEM_MASK,
@@ -263,7 +263,7 @@ struct pmx_dev pmx_pwm1 = {
 	.enb_on_reset = 1,
 };
 
-struct pmx_dev_mode pmx_pwm2_modes[] = {
+static struct pmx_dev_mode pmx_pwm2_modes[] = {
 	{
 		.ids = AUTO_NET_SMII_MODE | AUTO_NET_MII_MODE,
 		.mask = PMX_SSP_CS_MASK,
@@ -280,7 +280,7 @@ struct pmx_dev pmx_pwm2 = {
 	.enb_on_reset = 1,
 };
 
-struct pmx_dev_mode pmx_pwm3_modes[] = {
+static struct pmx_dev_mode pmx_pwm3_modes[] = {
 	{
 		.ids = AUTO_EXP_MODE | SMALL_PRINTERS_MODE | AUTO_NET_SMII_MODE,
 		.mask = PMX_MII_MASK,
@@ -294,7 +294,7 @@ struct pmx_dev pmx_pwm3 = {
 	.enb_on_reset = 1,
 };
 
-struct pmx_dev_mode pmx_ssp1_modes[] = {
+static struct pmx_dev_mode pmx_ssp1_modes[] = {
 	{
 		.ids = SMALL_PRINTERS_MODE | AUTO_NET_SMII_MODE,
 		.mask = PMX_MII_MASK,
@@ -308,7 +308,7 @@ struct pmx_dev pmx_ssp1 = {
 	.enb_on_reset = 1,
 };
 
-struct pmx_dev_mode pmx_ssp2_modes[] = {
+static struct pmx_dev_mode pmx_ssp2_modes[] = {
 	{
 		.ids = AUTO_NET_SMII_MODE,
 		.mask = PMX_MII_MASK,
@@ -322,7 +322,7 @@ struct pmx_dev pmx_ssp2 = {
 	.enb_on_reset = 1,
 };
 
-struct pmx_dev_mode pmx_mii1_modes[] = {
+static struct pmx_dev_mode pmx_mii1_modes[] = {
 	{
 		.ids = AUTO_NET_MII_MODE,
 		.mask = 0x0,
@@ -336,7 +336,7 @@ struct pmx_dev pmx_mii1 = {
 	.enb_on_reset = 1,
 };
 
-struct pmx_dev_mode pmx_smii0_modes[] = {
+static struct pmx_dev_mode pmx_smii0_modes[] = {
 	{
 		.ids = AUTO_NET_SMII_MODE | AUTO_EXP_MODE | SMALL_PRINTERS_MODE,
 		.mask = PMX_MII_MASK,
@@ -350,7 +350,7 @@ struct pmx_dev pmx_smii0 = {
 	.enb_on_reset = 1,
 };
 
-struct pmx_dev_mode pmx_smii1_modes[] = {
+static struct pmx_dev_mode pmx_smii1_modes[] = {
 	{
 		.ids = AUTO_NET_SMII_MODE | SMALL_PRINTERS_MODE,
 		.mask = PMX_MII_MASK,
@@ -364,7 +364,7 @@ struct pmx_dev pmx_smii1 = {
 	.enb_on_reset = 1,
 };
 
-struct pmx_dev_mode pmx_i2c1_modes[] = {
+static struct pmx_dev_mode pmx_i2c1_modes[] = {
 	{
 		.ids = AUTO_EXP_MODE,
 		.mask = 0x0,
@@ -387,7 +387,7 @@ struct pmx_driver pmx_driver = {
 /* Add spear320 specific devices here */
 
 /* spear3xx shared irq */
-struct shirq_dev_config shirq_ras1_config[] = {
+static struct shirq_dev_config shirq_ras1_config[] = {
 	{
 		.virq = VIRQ_EMI,
 		.status_mask = EMI_IRQ_MASK,
@@ -403,7 +403,7 @@ struct shirq_dev_config shirq_ras1_config[] = {
 	},
 };
 
-struct spear_shirq shirq_ras1 = {
+static struct spear_shirq shirq_ras1 = {
 	.irq = IRQ_GEN_RAS_1,
 	.dev_config = shirq_ras1_config,
 	.dev_count = ARRAY_SIZE(shirq_ras1_config),
@@ -416,7 +416,7 @@ struct spear_shirq shirq_ras1 = {
 	},
 };
 
-struct shirq_dev_config shirq_ras3_config[] = {
+static struct shirq_dev_config shirq_ras3_config[] = {
 	{
 		.virq = VIRQ_PLGPIO,
 		.enb_mask = GPIO_IRQ_MASK,
@@ -435,7 +435,7 @@ struct shirq_dev_config shirq_ras3_config[] = {
 	},
 };
 
-struct spear_shirq shirq_ras3 = {
+static struct spear_shirq shirq_ras3 = {
 	.irq = IRQ_GEN_RAS_3,
 	.dev_config = shirq_ras3_config,
 	.dev_count = ARRAY_SIZE(shirq_ras3_config),
@@ -449,7 +449,7 @@ struct spear_shirq shirq_ras3 = {
 	},
 };
 
-struct shirq_dev_config shirq_intrcomm_ras_config[] = {
+static struct shirq_dev_config shirq_intrcomm_ras_config[] = {
 	{
 		.virq = VIRQ_CANU,
 		.status_mask = CAN_U_IRQ_MASK,
@@ -497,7 +497,7 @@ struct shirq_dev_config shirq_intrcomm_ras_config[] = {
 	},
 };
 
-struct spear_shirq shirq_intrcomm_ras = {
+static struct spear_shirq shirq_intrcomm_ras = {
 	.irq = IRQ_INTRCOMM_RAS_ARM,
 	.dev_config = shirq_intrcomm_ras_config,
 	.dev_count = ARRAY_SIZE(shirq_intrcomm_ras_config),
diff --git a/arch/arm/mach-spear3xx/spear3xx.c b/arch/arm/mach-spear3xx/spear3xx.c
index e87313a..5f2cddc 100644
--- a/arch/arm/mach-spear3xx/spear3xx.c
+++ b/arch/arm/mach-spear3xx/spear3xx.c
@@ -102,7 +102,7 @@ void __init spear3xx_map_io(void)
 
 /* pad multiplexing support */
 /* devices */
-struct pmx_dev_mode pmx_firda_modes[] = {
+static struct pmx_dev_mode pmx_firda_modes[] = {
 	{
 		.ids = 0xffffffff,
 		.mask = PMX_FIRDA_MASK,
@@ -116,7 +116,7 @@ struct pmx_dev pmx_firda = {
 	.enb_on_reset = 0,
 };
 
-struct pmx_dev_mode pmx_i2c_modes[] = {
+static struct pmx_dev_mode pmx_i2c_modes[] = {
 	{
 		.ids = 0xffffffff,
 		.mask = PMX_I2C_MASK,
@@ -130,7 +130,7 @@ struct pmx_dev pmx_i2c = {
 	.enb_on_reset = 0,
 };
 
-struct pmx_dev_mode pmx_ssp_cs_modes[] = {
+static struct pmx_dev_mode pmx_ssp_cs_modes[] = {
 	{
 		.ids = 0xffffffff,
 		.mask = PMX_SSP_CS_MASK,
@@ -144,7 +144,7 @@ struct pmx_dev pmx_ssp_cs = {
 	.enb_on_reset = 0,
 };
 
-struct pmx_dev_mode pmx_ssp_modes[] = {
+static struct pmx_dev_mode pmx_ssp_modes[] = {
 	{
 		.ids = 0xffffffff,
 		.mask = PMX_SSP_MASK,
@@ -158,7 +158,7 @@ struct pmx_dev pmx_ssp = {
 	.enb_on_reset = 0,
 };
 
-struct pmx_dev_mode pmx_mii_modes[] = {
+static struct pmx_dev_mode pmx_mii_modes[] = {
 	{
 		.ids = 0xffffffff,
 		.mask = PMX_MII_MASK,
@@ -172,7 +172,7 @@ struct pmx_dev pmx_mii = {
 	.enb_on_reset = 0,
 };
 
-struct pmx_dev_mode pmx_gpio_pin0_modes[] = {
+static struct pmx_dev_mode pmx_gpio_pin0_modes[] = {
 	{
 		.ids = 0xffffffff,
 		.mask = PMX_GPIO_PIN0_MASK,
@@ -186,7 +186,7 @@ struct pmx_dev pmx_gpio_pin0 = {
 	.enb_on_reset = 0,
 };
 
-struct pmx_dev_mode pmx_gpio_pin1_modes[] = {
+static struct pmx_dev_mode pmx_gpio_pin1_modes[] = {
 	{
 		.ids = 0xffffffff,
 		.mask = PMX_GPIO_PIN1_MASK,
@@ -200,7 +200,7 @@ struct pmx_dev pmx_gpio_pin1 = {
 	.enb_on_reset = 0,
 };
 
-struct pmx_dev_mode pmx_gpio_pin2_modes[] = {
+static struct pmx_dev_mode pmx_gpio_pin2_modes[] = {
 	{
 		.ids = 0xffffffff,
 		.mask = PMX_GPIO_PIN2_MASK,
@@ -214,7 +214,7 @@ struct pmx_dev pmx_gpio_pin2 = {
 	.enb_on_reset = 0,
 };
 
-struct pmx_dev_mode pmx_gpio_pin3_modes[] = {
+static struct pmx_dev_mode pmx_gpio_pin3_modes[] = {
 	{
 		.ids = 0xffffffff,
 		.mask = PMX_GPIO_PIN3_MASK,
@@ -228,7 +228,7 @@ struct pmx_dev pmx_gpio_pin3 = {
 	.enb_on_reset = 0,
 };
 
-struct pmx_dev_mode pmx_gpio_pin4_modes[] = {
+static struct pmx_dev_mode pmx_gpio_pin4_modes[] = {
 	{
 		.ids = 0xffffffff,
 		.mask = PMX_GPIO_PIN4_MASK,
@@ -242,7 +242,7 @@ struct pmx_dev pmx_gpio_pin4 = {
 	.enb_on_reset = 0,
 };
 
-struct pmx_dev_mode pmx_gpio_pin5_modes[] = {
+static struct pmx_dev_mode pmx_gpio_pin5_modes[] = {
 	{
 		.ids = 0xffffffff,
 		.mask = PMX_GPIO_PIN5_MASK,
@@ -256,7 +256,7 @@ struct pmx_dev pmx_gpio_pin5 = {
 	.enb_on_reset = 0,
 };
 
-struct pmx_dev_mode pmx_uart0_modem_modes[] = {
+static struct pmx_dev_mode pmx_uart0_modem_modes[] = {
 	{
 		.ids = 0xffffffff,
 		.mask = PMX_UART0_MODEM_MASK,
@@ -270,7 +270,7 @@ struct pmx_dev pmx_uart0_modem = {
 	.enb_on_reset = 0,
 };
 
-struct pmx_dev_mode pmx_uart0_modes[] = {
+static struct pmx_dev_mode pmx_uart0_modes[] = {
 	{
 		.ids = 0xffffffff,
 		.mask = PMX_UART0_MASK,
@@ -284,7 +284,7 @@ struct pmx_dev pmx_uart0 = {
 	.enb_on_reset = 0,
 };
 
-struct pmx_dev_mode pmx_timer_3_4_modes[] = {
+static struct pmx_dev_mode pmx_timer_3_4_modes[] = {
 	{
 		.ids = 0xffffffff,
 		.mask = PMX_TIMER_3_4_MASK,
@@ -298,7 +298,7 @@ struct pmx_dev pmx_timer_3_4 = {
 	.enb_on_reset = 0,
 };
 
-struct pmx_dev_mode pmx_timer_1_2_modes[] = {
+static struct pmx_dev_mode pmx_timer_1_2_modes[] = {
 	{
 		.ids = 0xffffffff,
 		.mask = PMX_TIMER_1_2_MASK,
@@ -314,7 +314,7 @@ struct pmx_dev pmx_timer_1_2 = {
 
 #if defined(CONFIG_MACH_SPEAR310) || defined(CONFIG_MACH_SPEAR320)
 /* plgpios devices */
-struct pmx_dev_mode pmx_plgpio_0_1_modes[] = {
+static struct pmx_dev_mode pmx_plgpio_0_1_modes[] = {
 	{
 		.ids = 0x00,
 		.mask = PMX_FIRDA_MASK,
@@ -328,7 +328,7 @@ struct pmx_dev pmx_plgpio_0_1 = {
 	.enb_on_reset = 1,
 };
 
-struct pmx_dev_mode pmx_plgpio_2_3_modes[] = {
+static struct pmx_dev_mode pmx_plgpio_2_3_modes[] = {
 	{
 		.ids = 0x00,
 		.mask = PMX_UART0_MASK,
@@ -342,7 +342,7 @@ struct pmx_dev pmx_plgpio_2_3 = {
 	.enb_on_reset = 1,
 };
 
-struct pmx_dev_mode pmx_plgpio_4_5_modes[] = {
+static struct pmx_dev_mode pmx_plgpio_4_5_modes[] = {
 	{
 		.ids = 0x00,
 		.mask = PMX_I2C_MASK,
@@ -356,7 +356,7 @@ struct pmx_dev pmx_plgpio_4_5 = {
 	.enb_on_reset = 1,
 };
 
-struct pmx_dev_mode pmx_plgpio_6_9_modes[] = {
+static struct pmx_dev_mode pmx_plgpio_6_9_modes[] = {
 	{
 		.ids = 0x00,
 		.mask = PMX_SSP_MASK,
@@ -370,7 +370,7 @@ struct pmx_dev pmx_plgpio_6_9 = {
 	.enb_on_reset = 1,
 };
 
-struct pmx_dev_mode pmx_plgpio_10_27_modes[] = {
+static struct pmx_dev_mode pmx_plgpio_10_27_modes[] = {
 	{
 		.ids = 0x00,
 		.mask = PMX_MII_MASK,
@@ -384,7 +384,7 @@ struct pmx_dev pmx_plgpio_10_27 = {
 	.enb_on_reset = 1,
 };
 
-struct pmx_dev_mode pmx_plgpio_28_modes[] = {
+static struct pmx_dev_mode pmx_plgpio_28_modes[] = {
 	{
 		.ids = 0x00,
 		.mask = PMX_GPIO_PIN0_MASK,
@@ -398,7 +398,7 @@ struct pmx_dev pmx_plgpio_28 = {
 	.enb_on_reset = 1,
 };
 
-struct pmx_dev_mode pmx_plgpio_29_modes[] = {
+static struct pmx_dev_mode pmx_plgpio_29_modes[] = {
 	{
 		.ids = 0x00,
 		.mask = PMX_GPIO_PIN1_MASK,
@@ -412,7 +412,7 @@ struct pmx_dev pmx_plgpio_29 = {
 	.enb_on_reset = 1,
 };
 
-struct pmx_dev_mode pmx_plgpio_30_modes[] = {
+static struct pmx_dev_mode pmx_plgpio_30_modes[] = {
 	{
 		.ids = 0x00,
 		.mask = PMX_GPIO_PIN2_MASK,
@@ -426,7 +426,7 @@ struct pmx_dev pmx_plgpio_30 = {
 	.enb_on_reset = 1,
 };
 
-struct pmx_dev_mode pmx_plgpio_31_modes[] = {
+static struct pmx_dev_mode pmx_plgpio_31_modes[] = {
 	{
 		.ids = 0x00,
 		.mask = PMX_GPIO_PIN3_MASK,
@@ -440,7 +440,7 @@ struct pmx_dev pmx_plgpio_31 = {
 	.enb_on_reset = 1,
 };
 
-struct pmx_dev_mode pmx_plgpio_32_modes[] = {
+static struct pmx_dev_mode pmx_plgpio_32_modes[] = {
 	{
 		.ids = 0x00,
 		.mask = PMX_GPIO_PIN4_MASK,
@@ -454,7 +454,7 @@ struct pmx_dev pmx_plgpio_32 = {
 	.enb_on_reset = 1,
 };
 
-struct pmx_dev_mode pmx_plgpio_33_modes[] = {
+static struct pmx_dev_mode pmx_plgpio_33_modes[] = {
 	{
 		.ids = 0x00,
 		.mask = PMX_GPIO_PIN5_MASK,
@@ -468,7 +468,7 @@ struct pmx_dev pmx_plgpio_33 = {
 	.enb_on_reset = 1,
 };
 
-struct pmx_dev_mode pmx_plgpio_34_36_modes[] = {
+static struct pmx_dev_mode pmx_plgpio_34_36_modes[] = {
 	{
 		.ids = 0x00,
 		.mask = PMX_SSP_CS_MASK,
@@ -482,7 +482,7 @@ struct pmx_dev pmx_plgpio_34_36 = {
 	.enb_on_reset = 1,
 };
 
-struct pmx_dev_mode pmx_plgpio_37_42_modes[] = {
+static struct pmx_dev_mode pmx_plgpio_37_42_modes[] = {
 	{
 		.ids = 0x00,
 		.mask = PMX_UART0_MODEM_MASK,
@@ -496,7 +496,7 @@ struct pmx_dev pmx_plgpio_37_42 = {
 	.enb_on_reset = 1,
 };
 
-struct pmx_dev_mode pmx_plgpio_43_44_47_48_modes[] = {
+static struct pmx_dev_mode pmx_plgpio_43_44_47_48_modes[] = {
 	{
 		.ids = 0x00,
 		.mask = PMX_TIMER_1_2_MASK,
@@ -510,7 +510,7 @@ struct pmx_dev pmx_plgpio_43_44_47_48 = {
 	.enb_on_reset = 1,
 };
 
-struct pmx_dev_mode pmx_plgpio_45_46_49_50_modes[] = {
+static struct pmx_dev_mode pmx_plgpio_45_46_49_50_modes[] = {
 	{
 		.ids = 0x00,
 		.mask = PMX_TIMER_3_4_MASK,
-- 
1.5.5
