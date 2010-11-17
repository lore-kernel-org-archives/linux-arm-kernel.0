From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 17 Nov 2010 22:30:08 +0100
Subject: [PATCH 40/51] ARM: imx: let the machines select SOC_IMX{21,27}
In-Reply-To: <20101117212821.GF8942@pengutronix.de>
References: <20101117212821.GF8942@pengutronix.de>
Message-ID: <1290029419-21435-40-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This prepares multi-SoC kernel support.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-imx/Kconfig |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 9e6093d..ecb65ba0 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -57,13 +57,11 @@ choice
 
 config MACH_MX21
 	bool "i.MX21 support"
-	select SOC_IMX21
 	help
 	  This enables support for Freescale's MX2 based i.MX21 processor.
 
 config MACH_MX27
 	bool "i.MX27 support"
-	select SOC_IMX27
 	help
 	  This enables support for Freescale's MX2 based i.MX27 processor.
 
@@ -77,6 +75,7 @@ comment "MX21 platforms:"
 
 config MACH_MX21ADS
 	bool "MX21ADS platform"
+	select SOC_IMX21
 	select IMX_HAVE_PLATFORM_IMX_FB
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_MXC_MMC
@@ -139,6 +138,7 @@ comment "MX27 platforms:"
 
 config MACH_MX27ADS
 	bool "MX27ADS platform"
+	select SOC_IMX27
 	select IMX_HAVE_PLATFORM_IMX_FB
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_UART
@@ -151,6 +151,7 @@ config MACH_MX27ADS
 
 config MACH_PCM038
 	bool "Phytec phyCORE-i.MX27 CPU module (pcm038)"
+	select SOC_IMX27
 	select IMX_HAVE_PLATFORM_IMX2_WDT
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_UART
@@ -180,6 +181,7 @@ endchoice
 
 config MACH_CPUIMX27
 	bool "Eukrea CPUIMX27 module"
+	select SOC_IMX27
 	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
 	select IMX_HAVE_PLATFORM_IMX2_WDT
 	select IMX_HAVE_PLATFORM_IMX_I2C
@@ -228,6 +230,7 @@ endchoice
 
 config MACH_MX27_3DS
 	bool "MX27PDK platform"
+	select SOC_IMX27
 	select IMX_HAVE_PLATFORM_IMX_KEYPAD
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_MXC_MMC
@@ -237,6 +240,7 @@ config MACH_MX27_3DS
 
 config MACH_IMX27_VISSTRIM_M10
 	bool "Vista Silicon i.MX27 Visstrim_m10"
+	select SOC_IMX27
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_MXC_MMC
@@ -248,6 +252,7 @@ config MACH_IMX27_VISSTRIM_M10
 
 config MACH_IMX27LITE
 	bool "LogicPD MX27 LITEKIT platform"
+	select SOC_IMX27
 	select IMX_HAVE_PLATFORM_IMX_UART
 	help
 	  Include support for MX27 LITEKIT platform. This includes specific
@@ -255,6 +260,7 @@ config MACH_IMX27LITE
 
 config MACH_PCA100
 	bool "Phytec phyCARD-s (pca100)"
+	select SOC_IMX27
 	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
 	select IMX_HAVE_PLATFORM_IMX2_WDT
 	select IMX_HAVE_PLATFORM_IMX_FB
@@ -273,6 +279,7 @@ config MACH_PCA100
 
 config MACH_MXT_TD60
 	bool "Maxtrack i-MXT TD60"
+	select SOC_IMX27
 	select IMX_HAVE_PLATFORM_IMX_FB
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_UART
-- 
1.7.2.3
