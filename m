From: padma.v@samsung.com (Padmavathi Venna)
Date: Thu, 30 Jun 2011 08:25:21 -0400
Subject: [PATCH 5/7] ARM: SAMSUNG: Add SPI platform specific code
In-Reply-To: <1309436723-662-1-git-send-email-padma.v@samsung.com>
References: <1309436723-662-1-git-send-email-padma.v@samsung.com>
Message-ID: <1309436723-662-6-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SPI platform specific data has been initialized in SMDK6410,
SMDK6440,SMDK6450,SMDKC100 and SMDKV210 machine file

Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
---
 arch/arm/mach-s3c64xx/mach-smdk6410.c |   11 +++++++++++
 arch/arm/mach-s5p64x0/mach-smdk6440.c |   11 +++++++++++
 arch/arm/mach-s5p64x0/mach-smdk6450.c |   11 +++++++++++
 arch/arm/mach-s5pc100/mach-smdkc100.c |   19 +++++++++++++++++++
 arch/arm/mach-s5pv210/mach-smdkv210.c |   12 ++++++++++++
 5 files changed, 64 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/mach-smdk6410.c b/arch/arm/mach-s3c64xx/mach-smdk6410.c
index e0521e0..ff31a3d 100644
--- a/arch/arm/mach-s3c64xx/mach-smdk6410.c
+++ b/arch/arm/mach-s3c64xx/mach-smdk6410.c
@@ -71,6 +71,7 @@
 #include <plat/adc.h>
 #include <plat/ts.h>
 #include <plat/keypad.h>
+#include <plat/s3c64xx-spi.h>
 
 #define UCON S3C2410_UCON_DEFAULT | S3C2410_UCON_UCLK
 #define ULCON S3C2410_LCON_CS8 | S3C2410_LCON_PNONE | S3C2410_LCON_STOPB
@@ -208,6 +209,16 @@ static struct platform_device smdk6410_smsc911x = {
 	},
 };
 
+static struct s3c64xx_spi_info s3c_spi0_pdata __initdata = {
+	.fifo_lvl_mask	= 0x7f,
+	.rx_lvl_offset	= 13,
+};
+
+static struct s3c64xx_spi_info s3c_spi1_pdata __initdata = {
+	.fifo_lvl_mask	= 0x7f,
+	.rx_lvl_offset	= 13,
+};
+
 #ifdef CONFIG_REGULATOR
 static struct regulator_consumer_supply smdk6410_b_pwr_5v_consumers[] __initdata = {
 	REGULATOR_SUPPLY("PVDD", "0-001b"),
diff --git a/arch/arm/mach-s5p64x0/mach-smdk6440.c b/arch/arm/mach-s5p64x0/mach-smdk6440.c
index 2d559f1..03469bc 100644
--- a/arch/arm/mach-s5p64x0/mach-smdk6440.c
+++ b/arch/arm/mach-s5p64x0/mach-smdk6440.c
@@ -46,6 +46,7 @@
 #include <plat/adc.h>
 #include <plat/ts.h>
 #include <plat/s5p-time.h>
+#include <plat/s3c64xx-spi.h>
 
 #define SMDK6440_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
 				S3C2410_UCON_RXILEVEL |		\
@@ -130,6 +131,16 @@ static struct platform_device smdk6440_backlight_device = {
 	},
 };
 
+static struct s3c64xx_spi_info s3c_spi0_pdata __initdata = {
+	.fifo_lvl_mask	= 0x1ff,
+	.rx_lvl_offset	= 15,
+};
+
+static struct s3c64xx_spi_info s3c_spi1_pdata __initdata = {
+	.fifo_lvl_mask	= 0x7f,
+	.rx_lvl_offset	= 15,
+};
+
 static struct platform_device *smdk6440_devices[] __initdata = {
 	&s3c_device_adc,
 	&s3c_device_rtc,
diff --git a/arch/arm/mach-s5p64x0/mach-smdk6450.c b/arch/arm/mach-s5p64x0/mach-smdk6450.c
index d19c469..4048447 100644
--- a/arch/arm/mach-s5p64x0/mach-smdk6450.c
+++ b/arch/arm/mach-s5p64x0/mach-smdk6450.c
@@ -46,6 +46,7 @@
 #include <plat/adc.h>
 #include <plat/ts.h>
 #include <plat/s5p-time.h>
+#include <plat/s3c64xx-spi.h>
 
 #define SMDK6450_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
 				S3C2410_UCON_RXILEVEL |		\
@@ -148,6 +149,16 @@ static struct platform_device smdk6450_backlight_device = {
 	},
 };
 
+static struct s3c64xx_spi_info s3c_spi0_pdata __initdata = {
+	.fifo_lvl_mask	= 0x1ff,
+	.rx_lvl_offset	= 15,
+};
+
+static struct s3c64xx_spi_info s3c_spi1_pdata __initdata = {
+	.fifo_lvl_mask	= 0x7f,
+	.rx_lvl_offset	= 15,
+};
+
 static struct platform_device *smdk6450_devices[] __initdata = {
 	&s3c_device_adc,
 	&s3c_device_rtc,
diff --git a/arch/arm/mach-s5pc100/mach-smdkc100.c b/arch/arm/mach-s5pc100/mach-smdkc100.c
index 0525cb3..127f7b6 100644
--- a/arch/arm/mach-s5pc100/mach-smdkc100.c
+++ b/arch/arm/mach-s5pc100/mach-smdkc100.c
@@ -51,6 +51,7 @@
 #include <plat/keypad.h>
 #include <plat/ts.h>
 #include <plat/audio.h>
+#include <plat/s3c64xx-spi.h>
 
 /* Following are default values for UCON, ULCON and UFCON UART registers */
 #define SMDKC100_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
@@ -218,6 +219,24 @@ static struct platform_device smdkc100_backlight_device = {
 	},
 };
 
+static struct s3c64xx_spi_info s3c_spi0_pdata __initdata = {
+	.fifo_lvl_mask	= 0x7f,
+	.rx_lvl_offset	= 13,
+	.high_speed	= 1,
+};
+
+static struct s3c64xx_spi_info s3c_spi1_pdata __initdata = {
+	.fifo_lvl_mask	= 0x7f,
+	.rx_lvl_offset	= 13,
+	.high_speed	= 1,
+};
+
+static struct s3c64xx_spi_info s3c_spi2_pdata __initdata = {
+	.fifo_lvl_mask	= 0x7f,
+	.rx_lvl_offset	= 13,
+	.high_speed	= 1,
+};
+
 static struct platform_device *smdkc100_devices[] __initdata = {
 	&s3c_device_adc,
 	&s3c_device_cfcon,
diff --git a/arch/arm/mach-s5pv210/mach-smdkv210.c b/arch/arm/mach-s5pv210/mach-smdkv210.c
index c6a9e86..8978757 100644
--- a/arch/arm/mach-s5pv210/mach-smdkv210.c
+++ b/arch/arm/mach-s5pv210/mach-smdkv210.c
@@ -45,6 +45,7 @@
 #include <plat/pm.h>
 #include <plat/fb.h>
 #include <plat/s5p-time.h>
+#include <plat/s3c64xx-spi.h>
 
 /* Following are default values for UCON, ULCON and UFCON UART registers */
 #define SMDKV210_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
@@ -249,6 +250,17 @@ static struct platform_device smdkv210_backlight_device = {
 	},
 };
 
+static struct s3c64xx_spi_info s3c_spi0_pdata __initdata = {
+	.fifo_lvl_mask	= 0x1ff,
+	.rx_lvl_offset	= 15,
+	.high_speed	= 1,
+};
+
+static struct s3c64xx_spi_info s3c_spi1_pdata __initdata = {
+	.fifo_lvl_mask	= 0x7f,
+	.rx_lvl_offset	= 15,
+	.high_speed	= 1,
+};
 static struct platform_device *smdkv210_devices[] __initdata = {
 	&s3c_device_adc,
 	&s3c_device_cfcon,
-- 
1.7.0.4
