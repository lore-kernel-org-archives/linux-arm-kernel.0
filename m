From: gerg@uclinux.org (gerg at uclinux.org)
Date: Tue, 29 Oct 2013 15:15:51 +1000
Subject: [PATCHv2 1/7] ARM: imx: add debug uart support for IMX50 SoC
In-Reply-To: <1383023757-30711-1-git-send-email-gerg@uclinux.org>
References: <1383023757-30711-1-git-send-email-gerg@uclinux.org>
Message-ID: <1383023757-30711-2-git-send-email-gerg@uclinux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Greg Ungerer <gerg@uclinux.org>

Add appropriate UART address definitions and support defines for using the
UARTs of the Freescale IMX50 SoC as debug ports.

Signed-off-by: Greg Ungerer <gerg@uclinux.org>
---
 arch/arm/Kconfig.debug            |  9 +++++++++
 arch/arm/include/debug/imx-uart.h | 10 ++++++++++
 2 files changed, 19 insertions(+)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index d597c6b..aaaa068 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -255,6 +255,13 @@ choice
 		  Say Y here if you want kernel low-level debugging support
 		  on i.MX35.
 
+	config DEBUG_IMX50_UART
+		bool "i.MX50 Debug UART"
+		depends on SOC_IMX50
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on i.MX50.
+
 	config DEBUG_IMX51_UART
 		bool "i.MX51 Debug UART"
 		depends on SOC_IMX51
@@ -869,6 +876,7 @@ config DEBUG_IMX_UART_PORT
 						DEBUG_IMX21_IMX27_UART || \
 						DEBUG_IMX31_UART || \
 						DEBUG_IMX35_UART || \
+						DEBUG_IMX50_UART || \
 						DEBUG_IMX51_UART || \
 						DEBUG_IMX53_UART || \
 						DEBUG_IMX6Q_UART || \
@@ -898,6 +906,7 @@ config DEBUG_LL_INCLUDE
 				 DEBUG_IMX21_IMX27_UART || \
 				 DEBUG_IMX31_UART || \
 				 DEBUG_IMX35_UART || \
+				 DEBUG_IMX50_UART || \
 				 DEBUG_IMX51_UART || \
 				 DEBUG_IMX53_UART ||\
 				 DEBUG_IMX6Q_UART || \
diff --git a/arch/arm/include/debug/imx-uart.h b/arch/arm/include/debug/imx-uart.h
index 29da84e..42b823c 100644
--- a/arch/arm/include/debug/imx-uart.h
+++ b/arch/arm/include/debug/imx-uart.h
@@ -43,6 +43,14 @@
 #define IMX35_UART_BASE_ADDR(n)	IMX35_UART##n##_BASE_ADDR
 #define IMX35_UART_BASE(n)	IMX35_UART_BASE_ADDR(n)
 
+#define IMX50_UART1_BASE_ADDR	0x53fbc000
+#define IMX50_UART2_BASE_ADDR	0x53fc0000
+#define IMX50_UART3_BASE_ADDR	0x5000c000
+#define IMX50_UART4_BASE_ADDR	0x53ff0000
+#define IMX50_UART5_BASE_ADDR	0x63f90000
+#define IMX50_UART_BASE_ADDR(n)	IMX50_UART##n##_BASE_ADDR
+#define IMX50_UART_BASE(n)	IMX50_UART_BASE_ADDR(n)
+
 #define IMX51_UART1_BASE_ADDR	0x73fbc000
 #define IMX51_UART2_BASE_ADDR	0x73fc0000
 #define IMX51_UART3_BASE_ADDR	0x7000c000
@@ -85,6 +93,8 @@
 #define UART_PADDR	IMX_DEBUG_UART_BASE(IMX31)
 #elif defined(CONFIG_DEBUG_IMX35_UART)
 #define UART_PADDR	IMX_DEBUG_UART_BASE(IMX35)
+#elif defined(CONFIG_DEBUG_IMX50_UART)
+#define UART_PADDR	IMX_DEBUG_UART_BASE(IMX50)
 #elif defined(CONFIG_DEBUG_IMX51_UART)
 #define UART_PADDR	IMX_DEBUG_UART_BASE(IMX51)
 #elif defined(CONFIG_DEBUG_IMX53_UART)
-- 
1.8.1.4
