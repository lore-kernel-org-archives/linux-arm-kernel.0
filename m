From: sachin.kamat@samsung.com (Sachin Kamat)
Date: Tue, 24 Jun 2014 15:49:31 +0530
Subject: [PATCH 1/1] ARM: Kconfig.debug: Update Samsung UART config options
Message-ID: <1403605171-31805-1-git-send-email-sachin.kamat@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In a multiplatform config, the low level debug option shows several
UART port entries. Improve the user visible string so that it becomes
clear to the user about Samsung UART ports.
While at it also remove some lines from the help text that are no
longer applicable across all Samsung platforms.

Signed-off-by: Sachin Kamat <sachin.kamat@samsung.com>
---
 arch/arm/Kconfig.debug |   20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 3548612b0bfe..b92993e59a12 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -617,53 +617,41 @@ choice
 		depends on PLAT_SAMSUNG
 		select DEBUG_EXYNOS_UART if ARCH_EXYNOS
 		select DEBUG_S3C24XX_UART if ARCH_S3C24XX
-		bool "Use S3C UART 0 for low-level debug"
+		bool "Use Samsung S3C UART 0 for low-level debug"
 		help
 		  Say Y here if you want the debug print routines to direct
 		  their output to UART 0. The port must have been initialised
 		  by the boot-loader before use.
 
-		  The uncompressor code port configuration is now handled
-		  by CONFIG_S3C_LOWLEVEL_UART_PORT.
-
 	config DEBUG_S3C_UART1
 		depends on PLAT_SAMSUNG
 		select DEBUG_EXYNOS_UART if ARCH_EXYNOS
 		select DEBUG_S3C24XX_UART if ARCH_S3C24XX
-		bool "Use S3C UART 1 for low-level debug"
+		bool "Use Samsung S3C UART 1 for low-level debug"
 		help
 		  Say Y here if you want the debug print routines to direct
 		  their output to UART 1. The port must have been initialised
 		  by the boot-loader before use.
 
-		  The uncompressor code port configuration is now handled
-		  by CONFIG_S3C_LOWLEVEL_UART_PORT.
-
 	config DEBUG_S3C_UART2
 		depends on PLAT_SAMSUNG
 		select DEBUG_EXYNOS_UART if ARCH_EXYNOS
 		select DEBUG_S3C24XX_UART if ARCH_S3C24XX
-		bool "Use S3C UART 2 for low-level debug"
+		bool "Use Samsung S3C UART 2 for low-level debug"
 		help
 		  Say Y here if you want the debug print routines to direct
 		  their output to UART 2. The port must have been initialised
 		  by the boot-loader before use.
 
-		  The uncompressor code port configuration is now handled
-		  by CONFIG_S3C_LOWLEVEL_UART_PORT.
-
 	config DEBUG_S3C_UART3
 		depends on PLAT_SAMSUNG && ARCH_EXYNOS
 		select DEBUG_EXYNOS_UART
-		bool "Use S3C UART 3 for low-level debug"
+		bool "Use Samsung S3C UART 3 for low-level debug"
 		help
 		  Say Y here if you want the debug print routines to direct
 		  their output to UART 3. The port must have been initialised
 		  by the boot-loader before use.
 
-		  The uncompressor code port configuration is now handled
-		  by CONFIG_S3C_LOWLEVEL_UART_PORT.
-
 	config DEBUG_S3C2410_UART0
 		depends on ARCH_S3C24XX
 		select DEBUG_S3C2410_UART
-- 
1.7.9.5
