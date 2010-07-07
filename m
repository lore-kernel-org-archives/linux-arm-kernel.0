From: marek.vasut@gmail.com (Marek Vasut)
Date: Wed,  7 Jul 2010 14:48:49 +0200
Subject: [PATCH 2/2] pxa/spitz: Formating and naming fixes
In-Reply-To: <1278506929-12553-1-git-send-email-marek.vasut@gmail.com>
References: <1278506929-12553-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <1278506929-12553-2-git-send-email-marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Improve formating so checkpatch passes. Also, change some function and variable
names to make the naming consistent.

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---
 arch/arm/mach-pxa/spitz.c |  282 ++++++++++++++++++++++-----------------------
 1 files changed, 138 insertions(+), 144 deletions(-)

diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
index 26791de..7136da9 100644
--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -133,10 +133,8 @@ static unsigned long spitz_pin_config[] __initdata = {
  * Scoop GPIO expander
  ******************************************************************************/
 #if defined(CONFIG_SHARP_SCOOP) || defined(CONFIG_SHARP_SCOOP_MODULE)
-/*
- * Spitz SCOOP Device #1
- */
-static struct resource spitz_scoop_resources[] = {
+/* SCOOP Device #1 */
+static struct resource spitz_scoop_1_resources[] = {
 	[0] = {
 		.start		= 0x10800000,
 		.end		= 0x10800fff,
@@ -144,7 +142,7 @@ static struct resource spitz_scoop_resources[] = {
 	},
 };
 
-static struct scoop_config spitz_scoop_setup = {
+static struct scoop_config spitz_scoop_1_setup = {
 	.io_dir		= SPITZ_SCP_IO_DIR,
 	.io_out		= SPITZ_SCP_IO_OUT,
 	.suspend_clr	= SPITZ_SCP_SUS_CLR,
@@ -152,20 +150,18 @@ static struct scoop_config spitz_scoop_setup = {
 	.gpio_base	= SPITZ_SCP_GPIO_BASE,
 };
 
-struct platform_device spitzscoop_device = {
+struct platform_device spitz_scoop_1_device = {
 	.name		= "sharp-scoop",
 	.id		= 0,
 	.dev		= {
- 		.platform_data	= &spitz_scoop_setup,
+		.platform_data	= &spitz_scoop_1_setup,
 	},
-	.num_resources	= ARRAY_SIZE(spitz_scoop_resources),
-	.resource	= spitz_scoop_resources,
+	.num_resources	= ARRAY_SIZE(spitz_scoop_1_resources),
+	.resource	= spitz_scoop_1_resources,
 };
 
-/*
- * Spitz SCOOP Device #2
- */
-static struct resource spitz_scoop2_resources[] = {
+/* SCOOP Device #2 */
+static struct resource spitz_scoop_2_resources[] = {
 	[0] = {
 		.start		= 0x08800040,
 		.end		= 0x08800fff,
@@ -173,7 +169,7 @@ static struct resource spitz_scoop2_resources[] = {
 	},
 };
 
-static struct scoop_config spitz_scoop2_setup = {
+static struct scoop_config spitz_scoop_2_setup = {
 	.io_dir		= SPITZ_SCP2_IO_DIR,
 	.io_out		= SPITZ_SCP2_IO_OUT,
 	.suspend_clr	= SPITZ_SCP2_SUS_CLR,
@@ -181,23 +177,23 @@ static struct scoop_config spitz_scoop2_setup = {
 	.gpio_base	= SPITZ_SCP2_GPIO_BASE,
 };
 
-struct platform_device spitzscoop2_device = {
+struct platform_device spitz_scoop_2_device = {
 	.name		= "sharp-scoop",
 	.id		= 1,
 	.dev		= {
- 		.platform_data	= &spitz_scoop2_setup,
+		.platform_data	= &spitz_scoop_2_setup,
 	},
-	.num_resources	= ARRAY_SIZE(spitz_scoop2_resources),
-	.resource	= spitz_scoop2_resources,
+	.num_resources	= ARRAY_SIZE(spitz_scoop_2_resources),
+	.resource	= spitz_scoop_2_resources,
 };
 
 static void __init spitz_scoop_init(void)
 {
-	platform_device_register(&spitz_scoop1_device);
+	platform_device_register(&spitz_scoop_1_device);
 
 	/* Akita doesn't have the second SCOOP chip */
 	if (!machine_is_akita())
-		platform_device_register(&spitzscoop2_device);
+		platform_device_register(&spitz_scoop_2_device);
 }
 
 /* Power control is shared with between one of the CF slots and SD */
@@ -250,22 +246,22 @@ static void spitz_pcmcia_pwr(struct device *scoop, uint16_t cpr, int nr)
 }
 
 static struct scoop_pcmcia_dev spitz_pcmcia_scoop[] = {
-{
-	.dev        = &spitzscoop_device.dev,
-	.irq        = SPITZ_IRQ_GPIO_CF_IRQ,
-	.cd_irq     = SPITZ_IRQ_GPIO_CF_CD,
-	.cd_irq_str = "PCMCIA0 CD",
-},{
-	.dev        = &spitzscoop2_device.dev,
-	.irq        = SPITZ_IRQ_GPIO_CF2_IRQ,
-	.cd_irq     = -1,
-},
+	{
+		.dev		= &spitz_scoop_1_device.dev,
+		.irq		= SPITZ_IRQ_GPIO_CF_IRQ,
+		.cd_irq		= SPITZ_IRQ_GPIO_CF_CD,
+		.cd_irq_str	= "PCMCIA0 CD",
+	}, {
+		.dev		= &spitz_scoop_2_device.dev,
+		.irq		= SPITZ_IRQ_GPIO_CF2_IRQ,
+		.cd_irq		= -1,
+	},
 };
 
 static struct scoop_pcmcia_config spitz_pcmcia_config = {
-	.devs         = &spitz_pcmcia_scoop[0],
-	.num_devs     = 2,
-	.power_ctrl   = spitz_pcmcia_pwr,
+	.devs		= &spitz_pcmcia_scoop[0],
+	.num_devs	= 2,
+	.power_ctrl	= spitz_pcmcia_pwr,
 };
 
 static void __init spitz_pcmcia_init(void)
@@ -300,7 +296,7 @@ static inline void spitz_pcmcia_init(void) {}
 #define SPITZ_KEY_OK		KEY_F11
 #define SPITZ_KEY_MENU		KEY_F12
 
-static const uint32_t spitzkbd_keymap[] = {
+static const uint32_t spitz_keymap[] = {
 	KEY(0, 0, KEY_LEFTCTRL),
 	KEY(0, 1, KEY_1),
 	KEY(0, 2, KEY_3),
@@ -367,38 +363,38 @@ static const uint32_t spitzkbd_keymap[] = {
 	KEY(6, 8, KEY_RIGHT),
 };
 
-static const struct matrix_keymap_data spitzkbd_keymap_data = {
-	.keymap		= spitzkbd_keymap,
-	.keymap_size	= ARRAY_SIZE(spitzkbd_keymap),
+static const struct matrix_keymap_data spitz_keymap_data = {
+	.keymap		= spitz_keymap,
+	.keymap_size	= ARRAY_SIZE(spitz_keymap),
 };
 
-static const uint32_t spitzkbd_row_gpios[] =
+static const uint32_t spitz_row_gpios[] =
 		{ 12, 17, 91, 34, 36, 38, 39 };
-static const uint32_t spitzkbd_col_gpios[] =
+static const uint32_t spitz_col_gpios[] =
 		{ 88, 23, 24, 25, 26, 27, 52, 103, 107, 108, 114 };
 
-static struct matrix_keypad_platform_data spitzkbd_pdata = {
-	.keymap_data		= &spitzkbd_keymap_data,
-	.row_gpios		= spitzkbd_row_gpios,
-	.col_gpios		= spitzkbd_col_gpios,
-	.num_row_gpios		= ARRAY_SIZE(spitzkbd_row_gpios),
-	.num_col_gpios		= ARRAY_SIZE(spitzkbd_col_gpios),
+static struct matrix_keypad_platform_data spitz_mkp_pdata = {
+	.keymap_data		= &spitz_keymap_data,
+	.row_gpios		= spitz_row_gpios,
+	.col_gpios		= spitz_col_gpios,
+	.num_row_gpios		= ARRAY_SIZE(spitz_row_gpios),
+	.num_col_gpios		= ARRAY_SIZE(spitz_col_gpios),
 	.col_scan_delay_us	= 10,
 	.debounce_ms		= 10,
 	.wakeup			= 1,
 };
 
-static struct platform_device spitzkbd_device = {
+static struct platform_device spitz_mkp_device = {
 	.name		= "matrix-keypad",
 	.id		= -1,
 	.dev		= {
-		.platform_data = &spitzkbd_pdata,
+		.platform_data	= &spitz_mkp_pdata,
 	},
 };
 
 static void __init spitz_mkp_init(void)
 {
-	platform_device_register(&spitzkbd_device);
+	platform_device_register(&spitz_mkp_device);
 }
 #else
 static inline void spitz_mkp_init(void) {}
@@ -474,17 +470,17 @@ static struct gpio_led_platform_data spitz_gpio_leds_info = {
 	.num_leds	= ARRAY_SIZE(spitz_gpio_leds),
 };
 
-static struct platform_device spitzled_device = {
+static struct platform_device spitz_led_device = {
 	.name		= "leds-gpio",
 	.id		= -1,
 	.dev		= {
-		.platform_data = &spitz_gpio_leds_info,
+		.platform_data	= &spitz_gpio_leds_info,
 	},
 };
 
 static void __init spitz_leds_init(void)
 {
-	platform_device_register(&spitzled_device);
+	platform_device_register(&spitz_led_device);
 }
 #else
 static inline void spitz_leds_init(void) {}
@@ -494,7 +490,7 @@ static inline void spitz_leds_init(void) {}
  * SSP Devices
  ******************************************************************************/
 #if defined(CONFIG_SPI_PXA2XX) || defined(CONFIG_SPI_PXA2XX_MODULE)
-static void spitz_wait_for_hsync(void)
+static void spitz_ads7846_wait_for_hsync(void)
 {
 	while (gpio_get_value(SPITZ_GPIO_HSYNC))
 		cpu_relax();
@@ -510,7 +506,7 @@ static struct ads7846_platform_data spitz_ads7846_info = {
 	.y_plate_ohms		= 486,
 	.pressure_max		= 1024,
 	.gpio_pendown		= SPITZ_GPIO_TP_INT,
-	.wait_for_sync		= spitz_wait_for_hsync,
+	.wait_for_sync		= spitz_ads7846_wait_for_hsync,
 };
 
 static struct pxa2xx_spi_chip spitz_ads7846_chip = {
@@ -548,26 +544,26 @@ static struct pxa2xx_spi_chip spitz_max1111_chip = {
 
 static struct spi_board_info spitz_spi_devices[] = {
 	{
-		.modalias	= "ads7846",
-		.max_speed_hz	= 1200000,
-		.bus_num	= 2,
-		.chip_select	= 0,
-		.platform_data	= &spitz_ads7846_info,
-		.controller_data= &spitz_ads7846_chip,
-		.irq		= gpio_to_irq(SPITZ_GPIO_TP_INT),
+		.modalias		= "ads7846",
+		.max_speed_hz		= 1200000,
+		.bus_num		= 2,
+		.chip_select		= 0,
+		.platform_data		= &spitz_ads7846_info,
+		.controller_data	= &spitz_ads7846_chip,
+		.irq			= gpio_to_irq(SPITZ_GPIO_TP_INT),
 	}, {
-		.modalias	= "corgi-lcd",
-		.max_speed_hz	= 50000,
-		.bus_num	= 2,
-		.chip_select	= 1,
-		.platform_data	= &spitz_lcdcon_info,
-		.controller_data= &spitz_lcdcon_chip,
+		.modalias		= "corgi-lcd",
+		.max_speed_hz		= 50000,
+		.bus_num		= 2,
+		.chip_select		= 1,
+		.platform_data		= &spitz_lcdcon_info,
+		.controller_data	= &spitz_lcdcon_chip,
 	}, {
-		.modalias	= "max1111",
-		.max_speed_hz	= 450000,
-		.bus_num	= 2,
-		.chip_select	= 2,
-		.controller_data= &spitz_max1111_chip,
+		.modalias		= "max1111",
+		.max_speed_hz		= 450000,
+		.bus_num		= 2,
+		.chip_select		= 2,
+		.controller_data	= &spitz_max1111_chip,
 	},
 };
 
@@ -575,7 +571,7 @@ static struct pxa2xx_spi_master spitz_spi_info = {
 	.num_chipselect	= 3,
 };
 
-static void __init spitz_init_spi(void)
+static void __init spitz_spi_init(void)
 {
 	struct corgi_lcd_platform_data *lcd_data = &spitz_lcdcon_info;
 
@@ -588,7 +584,7 @@ static void __init spitz_init_spi(void)
 	spi_register_board_info(ARRAY_AND_SIZE(spitz_spi_devices));
 }
 #else
-static inline void spitz_init_spi(void) {}
+static inline void spitz_spi_init(void) {}
 #endif
 
 /******************************************************************************
@@ -612,7 +608,7 @@ static void spitz_mci_setpower(struct device *dev, unsigned int vdd)
 static struct pxamci_platform_data spitz_mci_platform_data = {
 	.detect_delay_ms	= 250,
 	.ocr_mask		= MMC_VDD_32_33|MMC_VDD_33_34,
-	.setpower 		= spitz_mci_setpower,
+	.setpower		= spitz_mci_setpower,
 	.gpio_card_detect	= SPITZ_GPIO_nSD_DETECT,
 	.gpio_card_ro		= SPITZ_GPIO_nSD_WP,
 	.gpio_power		= -1,
@@ -691,31 +687,31 @@ static inline void spitz_irda_init(void) {}
  ******************************************************************************/
 #if defined(CONFIG_FB_PXA) || defined(CONFIG_FB_PXA_MODULE)
 static struct pxafb_mode_info spitz_pxafb_modes[] = {
-{
-	.pixclock       = 19231,
-	.xres           = 480,
-	.yres           = 640,
-	.bpp            = 16,
-	.hsync_len      = 40,
-	.left_margin    = 46,
-	.right_margin   = 125,
-	.vsync_len      = 3,
-	.upper_margin   = 1,
-	.lower_margin   = 0,
-	.sync           = 0,
-},{
-	.pixclock       = 134617,
-	.xres           = 240,
-	.yres           = 320,
-	.bpp            = 16,
-	.hsync_len      = 20,
-	.left_margin    = 20,
-	.right_margin   = 46,
-	.vsync_len      = 2,
-	.upper_margin   = 1,
-	.lower_margin   = 0,
-	.sync           = 0,
-},
+	{
+		.pixclock       = 19231,
+		.xres           = 480,
+		.yres           = 640,
+		.bpp            = 16,
+		.hsync_len      = 40,
+		.left_margin    = 46,
+		.right_margin   = 125,
+		.vsync_len      = 3,
+		.upper_margin   = 1,
+		.lower_margin   = 0,
+		.sync           = 0,
+	}, {
+		.pixclock       = 134617,
+		.xres           = 240,
+		.yres           = 320,
+		.bpp            = 16,
+		.hsync_len      = 20,
+		.left_margin    = 20,
+		.right_margin   = 46,
+		.vsync_len      = 2,
+		.upper_margin   = 1,
+		.lower_margin   = 0,
+		.sync           = 0,
+	},
 };
 
 static struct pxafb_mach_info spitz_pxafb_info = {
@@ -737,17 +733,15 @@ static inline void spitz_lcd_init(void) {}
  * Framebuffer
  ******************************************************************************/
 #if defined(CONFIG_MTD_NAND_SHARPSL) || defined(CONFIG_MTD_NAND_SHARPSL_MODULE)
-static struct mtd_partition sharpsl_nand_partitions[] = {
+static struct mtd_partition spitz_nand_partitions[] = {
 	{
 		.name = "System Area",
 		.offset = 0,
 		.size = 7 * 1024 * 1024,
-	},
-	{
+	}, {
 		.name = "Root Filesystem",
 		.offset = 7 * 1024 * 1024,
-	},
-	{
+	}, {
 		.name = "Home Filesystem",
 		.offset = MTDPART_OFS_APPEND,
 		.size = MTDPART_SIZ_FULL,
@@ -756,14 +750,14 @@ static struct mtd_partition sharpsl_nand_partitions[] = {
 
 static uint8_t scan_ff_pattern[] = { 0xff, 0xff };
 
-static struct nand_bbt_descr sharpsl_bbt = {
-	.options = 0,
-	.offs = 4,
-	.len = 2,
-	.pattern = scan_ff_pattern
+static struct nand_bbt_descr spitz_nand_bbt = {
+	.options	= 0,
+	.offs		= 4,
+	.len		= 2,
+	.pattern	= scan_ff_pattern
 };
 
-static struct nand_ecclayout spitz_akita_oobinfo = {
+static struct nand_ecclayout akita_oobinfo = {
 	.oobfree	= { {0x08, 0x09} },
 	.eccbytes	= 24,
 	.eccpos		= {
@@ -773,13 +767,13 @@ static struct nand_ecclayout spitz_akita_oobinfo = {
 	},
 };
 
-static struct sharpsl_nand_platform_data sharpsl_nand_platform_data = {
-	.badblock_pattern	= &sharpsl_bbt,
-	.partitions		= sharpsl_nand_partitions,
-	.nr_partitions		= ARRAY_SIZE(sharpsl_nand_partitions),
+static struct sharpsl_nand_platform_data spitz_nand_pdata = {
+	.badblock_pattern	= &spitz_nand_bbt,
+	.partitions		= spitz_nand_partitions,
+	.nr_partitions		= ARRAY_SIZE(spitz_nand_partitions),
 };
 
-static struct resource sharpsl_nand_resources[] = {
+static struct resource spitz_nand_resources[] = {
 	{
 		.start	= PXA_CS3_PHYS,
 		.end	= PXA_CS3_PHYS + SZ_4K - 1,
@@ -787,31 +781,31 @@ static struct resource sharpsl_nand_resources[] = {
 	},
 };
 
-static struct platform_device sharpsl_nand_device = {
+static struct platform_device spitz_nand_device = {
 	.name		= "sharpsl-nand",
 	.id		= -1,
-	.resource	= sharpsl_nand_resources,
-	.num_resources	= ARRAY_SIZE(sharpsl_nand_resources),
+	.resource	= spitz_nand_resources,
+	.num_resources	= ARRAY_SIZE(spitz_nand_resources),
 	.dev		= {
-		.platform_data	= &sharpsl_nand_platform_data,
+		.platform_data	= &spitz_nand_pdata,
 	}
 };
 
 static void __init spitz_nand_init(void)
 {
 	if (machine_is_spitz()) {
-		sharpsl_nand_partitions[1].size = 5 * 1024 * 1024;
+		spitz_nand_partitions[1].size = 5 * 1024 * 1024;
 	} else if (machine_is_akita()) {
-		sharpsl_nand_partitions[1].size = 58 * 1024 * 1024;
-		sharpsl_nand_bbt.len = 1;
-		sharpsl_nand_pdata.ecc_layout = &spitz_akita_oobinfo;
+		spitz_nand_partitions[1].size = 58 * 1024 * 1024;
+		spitz_nand_bbt.len = 1;
+		spitz_nand_pdata.ecc_layout = &akita_oobinfo;
 	} else if (machine_is_borzoi()) {
-		sharpsl_nand_partitions[1].size = 32 * 1024 * 1024;
-		sharpsl_nand_bbt.len = 1;
-		sharpsl_nand_pdata.ecc_layout = &spitz_akita_oobinfo;
+		spitz_nand_partitions[1].size = 32 * 1024 * 1024;
+		spitz_nand_bbt.len = 1;
+		spitz_nand_pdata.ecc_layout = &akita_oobinfo;
 	}
 
-	platform_device_register(&sharpsl_nand_device);
+	platform_device_register(&spitz_nand_device);
 }
 #else
 static inline void spitz_nand_init(void) {}
@@ -821,7 +815,7 @@ static inline void spitz_nand_init(void) {}
  * NOR Flash
  ******************************************************************************/
 #if defined(CONFIG_MTD_PHYSMAP) || defined(CONFIG_MTD_PHYSMAP_MODULE)
-static struct mtd_partition sharpsl_rom_parts[] = {
+static struct mtd_partition spitz_rom_parts[] = {
 	{
 		.name	="Boot PROM Filesystem",
 		.offset	= 0x00140000,
@@ -829,13 +823,13 @@ static struct mtd_partition sharpsl_rom_parts[] = {
 	},
 };
 
-static struct physmap_flash_data sharpsl_rom_data = {
+static struct physmap_flash_data spitz_rom_data = {
 	.width		= 2,
-	.nr_parts	= ARRAY_SIZE(sharpsl_rom_parts),
-	.parts		= sharpsl_rom_parts,
+	.nr_parts	= ARRAY_SIZE(spitz_rom_parts),
+	.parts		= spitz_rom_parts,
 };
 
-static struct resource sharpsl_rom_resources[] = {
+static struct resource spitz_rom_resources[] = {
 	{
 		.start	= PXA_CS0_PHYS,
 		.end	= PXA_CS0_PHYS + SZ_8M - 1,
@@ -843,19 +837,19 @@ static struct resource sharpsl_rom_resources[] = {
 	},
 };
 
-static struct platform_device sharpsl_rom_device = {
-	.name	= "physmap-flash",
-	.id	= -1,
-	.resource = sharpsl_rom_resources,
-	.num_resources = ARRAY_SIZE(sharpsl_rom_resources),
+static struct platform_device spitz_rom_device = {
+	.name		= "physmap-flash",
+	.id		= -1,
+	.resource	= spitz_rom_resources,
+	.num_resources	= ARRAY_SIZE(spitz_rom_resources),
 	.dev		= {
-		.platform_data	= &sharpsl_rom_data,
+		.platform_data	= &spitz_rom_data,
 	},
 };
 
 static void __init spitz_nor_init(void)
 {
-	platform_device_register(&sharpsl_rom_device);
+	platform_device_register(&spitz_rom_device);
 }
 #else
 static inline void spitz_nor_init(void) {}
@@ -959,7 +953,7 @@ static void __init spitz_init(void)
 	pxa_set_btuart_info(NULL);
 	pxa_set_stuart_info(NULL);
 
-	spitz_init_spi();
+	spitz_spi_init();
 	spitz_scoop_init();
 	spitz_mkp_init();
 	spitz_keys_init();
@@ -974,7 +968,7 @@ static void __init spitz_init(void)
 	spitz_i2c_init();
 }
 
-static void __init fixup_spitz(struct machine_desc *desc,
+static void __init spitz_fixup(struct machine_desc *desc,
 		struct tag *tags, char **cmdline, struct meminfo *mi)
 {
 	sharpsl_save_param();
@@ -988,7 +982,7 @@ static void __init fixup_spitz(struct machine_desc *desc,
 MACHINE_START(SPITZ, "SHARP Spitz")
 	.phys_io	= 0x40000000,
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
-	.fixup		= fixup_spitz,
+	.fixup		= spitz_fixup,
 	.map_io		= pxa_map_io,
 	.init_irq	= pxa27x_init_irq,
 	.init_machine	= spitz_init,
@@ -1000,7 +994,7 @@ MACHINE_END
 MACHINE_START(BORZOI, "SHARP Borzoi")
 	.phys_io	= 0x40000000,
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
-	.fixup		= fixup_spitz,
+	.fixup		= spitz_fixup,
 	.map_io		= pxa_map_io,
 	.init_irq	= pxa27x_init_irq,
 	.init_machine	= spitz_init,
@@ -1012,7 +1006,7 @@ MACHINE_END
 MACHINE_START(AKITA, "SHARP Akita")
 	.phys_io	= 0x40000000,
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
-	.fixup		= fixup_spitz,
+	.fixup		= spitz_fixup,
 	.map_io		= pxa_map_io,
 	.init_irq	= pxa27x_init_irq,
 	.init_machine	= spitz_init,
-- 
1.7.1
