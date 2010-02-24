From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 24 Feb 2010 11:08:14 +0100
Subject: [PATCH 19/39] arm/imx: let ARCH_MXC select COMMON_CLKDEV instead of
	each subfamily
In-Reply-To: <20100224100649.GA6456@pengutronix.de>
References: <20100224100649.GA6456@pengutronix.de>
Message-ID: <1267006114-31743-19-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/Kconfig          |    1 +
 arch/arm/plat-mxc/Kconfig |    5 -----
 2 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 233a222..39baa60 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -312,6 +312,7 @@ config ARCH_MXC
 	select GENERIC_GPIO
 	select ARCH_REQUIRE_GPIOLIB
 	select HAVE_CLK
+	select COMMON_CLKDEV
 	help
 	  Support for Freescale MXC/iMX-based family of processors
 
diff --git a/arch/arm/plat-mxc/Kconfig b/arch/arm/plat-mxc/Kconfig
index 8b0a1ee..55bfe61 100644
--- a/arch/arm/plat-mxc/Kconfig
+++ b/arch/arm/plat-mxc/Kconfig
@@ -9,35 +9,30 @@ choice
 config ARCH_MX1
 	bool "MX1-based"
 	select CPU_ARM920T
-	select COMMON_CLKDEV
 	help
 	  This enables support for systems based on the Freescale i.MX1 family
 
 config ARCH_MX2
 	bool "MX2-based"
 	select CPU_ARM926T
-	select COMMON_CLKDEV
 	help
 	  This enables support for systems based on the Freescale i.MX2 family
 
 config ARCH_MX25
 	bool "MX25-based"
 	select CPU_ARM926T
-	select COMMON_CLKDEV
 	help
 	  This enables support for systems based on the Freescale i.MX25 family
 
 config ARCH_MX3
 	bool "MX3-based"
 	select CPU_V6
-	select COMMON_CLKDEV
 	help
 	  This enables support for systems based on the Freescale i.MX3 family
 
 config ARCH_MXC91231
 	bool "MXC91231-based"
 	select CPU_V6
-	select COMMON_CLKDEV
 	help
 	  This enables support for systems based on the Freescale MXC91231 family
 
-- 
1.6.6.2
