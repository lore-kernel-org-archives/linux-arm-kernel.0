From: padma.v@samsung.com (Padmavathi Venna)
Date: Fri, 04 Nov 2011 08:43:54 -0400
Subject: [PATCH 6/6] ARM: S3C64XX: Modified according to SPI consolidation
	work.
In-Reply-To: <1320410634-10788-1-git-send-email-padma.v@samsung.com>
References: <1320410634-10788-1-git-send-email-padma.v@samsung.com>
Message-ID: <1320410634-10788-7-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As SPI platform devices are consolidated to plat-samsung, some
corresponding changes are required in the respective machine file.
SPI platform specific data is initialized in the corresponding
machine file.

Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
---
 arch/arm/mach-s3c64xx/Kconfig         |    3 ++-
 arch/arm/mach-s3c64xx/mach-crag6410.c |    9 +++++++++
 2 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/Kconfig b/arch/arm/mach-s3c64xx/Kconfig
index 4388186..90b34ab 100644
--- a/arch/arm/mach-s3c64xx/Kconfig
+++ b/arch/arm/mach-s3c64xx/Kconfig
@@ -281,6 +281,7 @@ config MACH_WLF_CRAGG_6410
 	select S3C64XX_SETUP_IDE
 	select S3C64XX_SETUP_FB_24BPP
 	select S3C64XX_SETUP_KEYPAD
+	select S3C64XX_SETUP_SPI
 	select SAMSUNG_DEV_ADC
 	select SAMSUNG_DEV_KEYPAD
 	select S3C_DEV_USB_HOST
@@ -291,7 +292,7 @@ config MACH_WLF_CRAGG_6410
 	select S3C_DEV_I2C1
 	select S3C_DEV_WDT
 	select S3C_DEV_RTC
-	select S3C64XX_DEV_SPI
+	select S3C64XX_DEV_SPI0
 	select S3C24XX_GPIO_EXTRA128
 	select I2C
 	help
diff --git a/arch/arm/mach-s3c64xx/mach-crag6410.c b/arch/arm/mach-s3c64xx/mach-crag6410.c
index d04b654..aa3fe8f 100644
--- a/arch/arm/mach-s3c64xx/mach-crag6410.c
+++ b/arch/arm/mach-s3c64xx/mach-crag6410.c
@@ -669,6 +669,15 @@ static struct s3c_sdhci_platdata crag6410_hsmmc0_pdata = {
 	.cfg_gpio		= crag6410_cfg_sdhci0,
 };
 
+#ifdef CONFIG_S3C64XX_DEV_SPI0
+static struct s3c64xx_spi_info crag6410_spi0_pdata __initdata = {
+	.cfg_gpio       = s3c64xx_spi0_cfg_gpio,
+	.fifo_lvl_mask  = 0x7f,
+	.rx_lvl_offset  = 13,
+	.tx_st_done     = 21,
+};
+#endif
+
 static void __init crag6410_machine_init(void)
 {
 	/* Open drain IRQs need pullups */
-- 
1.7.0.4
