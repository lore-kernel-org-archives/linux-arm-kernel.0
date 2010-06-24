From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 24 Jun 2010 15:49:20 +0200
Subject: [PATCH 24/61] ARM: imx: Kconfig: use an if block instead of a depend
	for many symbols
In-Reply-To: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1277387397-3467-25-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-imx/Kconfig |   20 +++++++++++---------
 1 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index c6eddd7..3ca8fa7 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -37,25 +37,32 @@ config MACH_MX27
 
 endchoice
 
-comment "MX2 platforms:"
+endif
+
+if MACH_MX21
+
+comment "MX21 platforms:"
 
 config MACH_MX21ADS
 	bool "MX21ADS platform"
-	depends on MACH_MX21
 	help
 	  Include support for MX21ADS platform. This includes specific
 	  configurations for the board and its peripherals.
 
+endif
+
+if MACH_MX27
+
+comment "MX27 platforms:"
+
 config MACH_MX27ADS
 	bool "MX27ADS platform"
-	depends on MACH_MX27
 	help
 	  Include support for MX27ADS platform. This includes specific
 	  configurations for the board and its peripherals.
 
 config MACH_PCM038
 	bool "Phytec phyCORE-i.MX27 CPU module (pcm038)"
-	depends on MACH_MX27
 	select MXC_ULPI if USB_ULPI
 	help
 	  Include support for phyCORE-i.MX27 (aka pcm038) platform. This
@@ -77,7 +84,6 @@ endchoice
 
 config MACH_CPUIMX27
 	bool "Eukrea CPUIMX27 module"
-	depends on MACH_MX27
 	help
 	  Include support for Eukrea CPUIMX27 platform. This includes
 	  specific configurations for the module and its peripherals.
@@ -105,21 +111,18 @@ endchoice
 
 config MACH_MX27_3DS
 	bool "MX27PDK platform"
-	depends on MACH_MX27
 	help
 	  Include support for MX27PDK platform. This includes specific
 	  configurations for the board and its peripherals.
 
 config MACH_IMX27LITE
 	bool "LogicPD MX27 LITEKIT platform"
-	depends on MACH_MX27
 	help
 	  Include support for MX27 LITEKIT platform. This includes specific
 	  configurations for the board and its peripherals.
 
 config MACH_PCA100
 	bool "Phytec phyCARD-s (pca100)"
-	depends on MACH_MX27
 	select MXC_ULPI if USB_ULPI
 	help
 	  Include support for phyCARD-s (aka pca100) platform. This
@@ -127,7 +130,6 @@ config MACH_PCA100
 
 config MACH_MXT_TD60
 	bool "Maxtrack i-MXT TD60"
-	depends on MACH_MX27
 	help
 	  Include support for i-MXT (aka td60) platform. This
 	  includes specific configurations for the module and its peripherals.
-- 
1.7.1
