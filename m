From: padma.v@samsung.com (Padmavathi Venna)
Date: Thu, 30 Jun 2011 08:25:19 -0400
Subject: [PATCH 3/7] ARM: SAMSUNG: Add SPI clock definitions for SAMSUNG SoCs
In-Reply-To: <1309436723-662-1-git-send-email-padma.v@samsung.com>
References: <1309436723-662-1-git-send-email-padma.v@samsung.com>
Message-ID: <1309436723-662-4-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SPI Clocks were defined in dev-spi.c of machine specific folder.
To make SPI devices common across all SoCs,dev-spi.c is moved
from machine specific folder to plat-samsung. So SPI clock
definitions has been moved from dev-spi.c to SoC specific machine
folder for S3C64XX,S5P64X0,S5PC100 and S5PV210

Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
---
 arch/arm/mach-s3c64xx/include/mach/spi-clocks.h |    6 ++++++
 arch/arm/mach-s5p64x0/include/mach/spi-clocks.h |    5 +++++
 arch/arm/mach-s5pc100/include/mach/spi-clocks.h |    6 ++++++
 arch/arm/mach-s5pv210/include/mach/spi-clocks.h |    5 +++++
 4 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/include/mach/spi-clocks.h b/arch/arm/mach-s3c64xx/include/mach/spi-clocks.h
index 9d0c43b..525f96b 100644
--- a/arch/arm/mach-s3c64xx/include/mach/spi-clocks.h
+++ b/arch/arm/mach-s3c64xx/include/mach/spi-clocks.h
@@ -15,4 +15,10 @@
 #define S3C64XX_SPI_SRCCLK_SPIBUS	1
 #define S3C64XX_SPI_SRCCLK_48M		2
 
+static char *spi_src_clks[] = {
+	[S3C64XX_SPI_SRCCLK_PCLK] = "pclk",
+	[S3C64XX_SPI_SRCCLK_SPIBUS] = "spi-bus",
+	[S3C64XX_SPI_SRCCLK_48M] = "spi_48m",
+};
+
 #endif /* __S3C64XX_PLAT_SPI_CLKS_H */
diff --git a/arch/arm/mach-s5p64x0/include/mach/spi-clocks.h b/arch/arm/mach-s5p64x0/include/mach/spi-clocks.h
index 170a20a..3995de1 100644
--- a/arch/arm/mach-s5p64x0/include/mach/spi-clocks.h
+++ b/arch/arm/mach-s5p64x0/include/mach/spi-clocks.h
@@ -17,4 +17,9 @@
 #define S5P64X0_SPI_SRCCLK_PCLK		0
 #define S5P64X0_SPI_SRCCLK_SCLK		1
 
+static char *spi_src_clks[] = {
+	[S5P64X0_SPI_SRCCLK_PCLK] = "pclk",
+	[S5P64X0_SPI_SRCCLK_SCLK] = "sclk_spi",
+};
+
 #endif /* __ASM_ARCH_SPI_CLKS_H */
diff --git a/arch/arm/mach-s5pc100/include/mach/spi-clocks.h b/arch/arm/mach-s5pc100/include/mach/spi-clocks.h
index 65e4263..c182b02 100644
--- a/arch/arm/mach-s5pc100/include/mach/spi-clocks.h
+++ b/arch/arm/mach-s5pc100/include/mach/spi-clocks.h
@@ -15,4 +15,10 @@
 #define S5PC100_SPI_SRCCLK_48M		1
 #define S5PC100_SPI_SRCCLK_SPIBUS	2
 
+static char *spi_src_clks[] = {
+	[S5PC100_SPI_SRCCLK_PCLK] = "pclk",
+	[S5PC100_SPI_SRCCLK_48M] = "spi_48m",
+	[S5PC100_SPI_SRCCLK_SPIBUS] = "spi_bus",
+};
+
 #endif /* __S5PC100_PLAT_SPI_CLKS_H */
diff --git a/arch/arm/mach-s5pv210/include/mach/spi-clocks.h b/arch/arm/mach-s5pv210/include/mach/spi-clocks.h
index 02acded..fa17815 100644
--- a/arch/arm/mach-s5pv210/include/mach/spi-clocks.h
+++ b/arch/arm/mach-s5pv210/include/mach/spi-clocks.h
@@ -14,4 +14,9 @@
 #define S5PV210_SPI_SRCCLK_PCLK		0
 #define S5PV210_SPI_SRCCLK_SCLK		1
 
+static char *spi_src_clks[] = {
+	[S5PV210_SPI_SRCCLK_PCLK] = "pclk",
+	[S5PV210_SPI_SRCCLK_SCLK] = "sclk_spi",
+};
+
 #endif /* __S5PV210_PLAT_SPI_CLKS_H */
-- 
1.7.0.4
