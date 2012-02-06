From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Mon, 6 Feb 2012 13:19:19 +0100
Subject: [PATCH] arm/imx6: Rename DEBUG_IMX6Q_UART to UART4
Message-ID: <1328530759-6291-1-git-send-email-dirk.behme@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Different boards may use differenct UART ports for debugging.
To be able to add different debug UART configurations (e.g. UART2),
rename the existing general DEBUG_IMX6Q_UART to DEBUG_IMX6Q_UART4.

Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
CC: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/Kconfig.debug                       |    6 +++---
 arch/arm/mach-imx/lluart.c                   |    2 +-
 arch/arm/plat-mxc/include/mach/debug-macro.S |    2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index e0d236d..87abb5d 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -199,12 +199,12 @@ choice
 		  Say Y here if you want kernel low-level debugging support
 		  on i.MX50 or i.MX53.
 
-	config DEBUG_IMX6Q_UART
-		bool "i.MX6Q Debug UART"
+	config DEBUG_IMX6Q_UART4
+		bool "i.MX6Q Debug UART4"
 		depends on SOC_IMX6Q
 		help
 		  Say Y here if you want kernel low-level debugging support
-		  on i.MX6Q.
+		  on i.MX6Q UART4.
 
 	config DEBUG_S3C_UART0
 		depends on PLAT_SAMSUNG
diff --git a/arch/arm/mach-imx/lluart.c b/arch/arm/mach-imx/lluart.c
index d4ab6f2..0213f8d 100644
--- a/arch/arm/mach-imx/lluart.c
+++ b/arch/arm/mach-imx/lluart.c
@@ -17,7 +17,7 @@
 #include <mach/hardware.h>
 
 static struct map_desc imx_lluart_desc = {
-#ifdef CONFIG_DEBUG_IMX6Q_UART
+#ifdef CONFIG_DEBUG_IMX6Q_UART4
 	.virtual	= MX6Q_IO_P2V(MX6Q_UART4_BASE_ADDR),
 	.pfn		= __phys_to_pfn(MX6Q_UART4_BASE_ADDR),
 	.length		= MX6Q_UART4_SIZE,
diff --git a/arch/arm/plat-mxc/include/mach/debug-macro.S b/arch/arm/plat-mxc/include/mach/debug-macro.S
index 6e192c4..8ddda36 100644
--- a/arch/arm/plat-mxc/include/mach/debug-macro.S
+++ b/arch/arm/plat-mxc/include/mach/debug-macro.S
@@ -24,7 +24,7 @@
 #define UART_PADDR	MX51_UART1_BASE_ADDR
 #elif defined (CONFIG_DEBUG_IMX50_IMX53_UART)
 #define UART_PADDR	MX53_UART1_BASE_ADDR
-#elif defined (CONFIG_DEBUG_IMX6Q_UART)
+#elif defined (CONFIG_DEBUG_IMX6Q_UART4)
 #define UART_PADDR	MX6Q_UART4_BASE_ADDR
 #endif
 
-- 
1.7.0.4
