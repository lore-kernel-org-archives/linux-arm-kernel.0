From: michael.opdenacker@free-electrons.com (Michael Opdenacker)
Date: Mon,  4 Nov 2013 10:51:25 +0100
Subject: [PATCH] ARM: SAMSUNG: remove unused SAMSUNG_GPIOLIB_4BIT Kconfig
 parameter
Message-ID: <1383558685-5343-1-git-send-email-michael.opdenacker@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This removes the SAMSUNG_GPIOLIB_4BIT Kconfig parameter,
which was no longer used anywhere in the source code
and Makefiles.

Signed-off-by: Michael Opdenacker <michael.opdenacker@free-electrons.com>
---
 arch/arm/Kconfig              | 1 -
 arch/arm/plat-samsung/Kconfig | 8 --------
 2 files changed, 9 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 1ad6fb6c094d..c9f554f73458 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -741,7 +741,6 @@ config ARCH_S3C64XX
 	select S3C_GPIO_TRACK
 	select SAMSUNG_ATAGS
 	select SAMSUNG_CLKSRC
-	select SAMSUNG_GPIOLIB_4BIT
 	select SAMSUNG_WDT_RESET
 	select USB_ARCH_HAS_OHCI
 	help
diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index 7dfba937d8fc..12c7f2998540 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -24,7 +24,6 @@ config PLAT_S5P
 	select S3C_GPIO_TRACK
 	select S5P_GPIO_DRVSTR
 	select SAMSUNG_CLKSRC if !COMMON_CLK
-	select SAMSUNG_GPIOLIB_4BIT
 	help
 	  Base platform code for Samsung's S5P series SoC.
 
@@ -115,13 +114,6 @@ config S5P_GPIO_INT
 
 # options for gpio configuration support
 
-config SAMSUNG_GPIOLIB_4BIT
-	bool
-	help
-	  GPIOlib file contains the 4 bit modification functions for gpio
-	  configuration. GPIOlib shall be compiled only for S3C64XX and S5P
-	  series of processors.
-
 config S5P_GPIO_DRVSTR
 	bool
 	help
-- 
1.8.1.2
