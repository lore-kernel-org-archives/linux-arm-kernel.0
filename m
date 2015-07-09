From: Frank.Li@freescale.com (Frank.Li at freescale.com)
Date: Fri, 10 Jul 2015 02:09:47 +0800
Subject: [PATCH v4 7/7] ARM: imx: add low-level debug support for i.mx6ul
In-Reply-To: <1436465387-5992-1-git-send-email-Frank.Li@freescale.com>
References: <1436465387-5992-1-git-send-email-Frank.Li@freescale.com>
Message-ID: <1436465387-5992-8-git-send-email-Frank.Li@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Anson Huang <b20788@freescale.com>

Enable low-level debug support for i.MX6UL by adding the
debug port definitions for the SoC.

Singed-off-by: Anson Huang <b20788@freescale.com>
Signed-off-by: Fugang Duan <B38611@freescale.com>
Signed-off-by: Frank Li <Frank.Li@freescale.com>
---
 arch/arm/Kconfig.debug            |  9 +++++++++
 arch/arm/include/debug/imx-uart.h | 13 +++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index f1b1579..f21daa8 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -411,6 +411,13 @@ choice
 		  Say Y here if you want kernel low-level debugging support
 		  on i.MX6SX.
 
+	config DEBUG_IMX6UL_UART
+		bool "i.MX6UL Debug UART"
+		depends on SOC_IMX6UL
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on i.MX6UL.
+
 	config DEBUG_IMX7D_UART
 		bool "i.MX7D Debug UART"
 		depends on SOC_IMX7D
@@ -1269,6 +1276,7 @@ config DEBUG_IMX_UART_PORT
 						DEBUG_IMX6Q_UART || \
 						DEBUG_IMX6SL_UART || \
 						DEBUG_IMX6SX_UART || \
+						DEBUG_IMX6UL_UART || \
 						DEBUG_IMX7D_UART
 	default 1
 	depends on ARCH_MXC
@@ -1320,6 +1328,7 @@ config DEBUG_LL_INCLUDE
 				 DEBUG_IMX6Q_UART || \
 				 DEBUG_IMX6SL_UART || \
 				 DEBUG_IMX6SX_UART || \
+				 DEBUG_IMX6UL_UART || \
 				 DEBUG_IMX7D_UART
 	default "debug/ks8695.S" if DEBUG_KS8695_UART
 	default "debug/msm.S" if DEBUG_QCOM_UARTDM
diff --git a/arch/arm/include/debug/imx-uart.h b/arch/arm/include/debug/imx-uart.h
index 66f736f..bce58e9 100644
--- a/arch/arm/include/debug/imx-uart.h
+++ b/arch/arm/include/debug/imx-uart.h
@@ -90,6 +90,17 @@
 #define IMX6SX_UART_BASE_ADDR(n) IMX6SX_UART##n##_BASE_ADDR
 #define IMX6SX_UART_BASE(n)	IMX6SX_UART_BASE_ADDR(n)
 
+#define IMX6UL_UART1_BASE_ADDR	0x02020000
+#define IMX6UL_UART2_BASE_ADDR	0x021e8000
+#define IMX6UL_UART3_BASE_ADDR	0x021ec000
+#define IMX6UL_UART4_BASE_ADDR	0x021f0000
+#define IMX6UL_UART5_BASE_ADDR	0x021f4000
+#define IMX6UL_UART6_BASE_ADDR	0x021fc000
+#define IMX6UL_UART7_BASE_ADDR	0x02018000
+#define IMX6UL_UART8_BASE_ADDR	0x02024000
+#define IMX6UL_UART_BASE_ADDR(n) IMX6UL_UART##n##_BASE_ADDR
+#define IMX6UL_UART_BASE(n)	IMX6UL_UART_BASE_ADDR(n)
+
 #define IMX7D_UART1_BASE_ADDR	0x30860000
 #define IMX7D_UART2_BASE_ADDR	0x30890000
 #define IMX7D_UART3_BASE_ADDR	0x30880000
@@ -124,6 +135,8 @@
 #define UART_PADDR	IMX_DEBUG_UART_BASE(IMX6SL)
 #elif defined(CONFIG_DEBUG_IMX6SX_UART)
 #define UART_PADDR	IMX_DEBUG_UART_BASE(IMX6SX)
+#elif defined(CONFIG_DEBUG_IMX6UL_UART)
+#define UART_PADDR	IMX_DEBUG_UART_BASE(IMX6UL)
 #elif defined(CONFIG_DEBUG_IMX7D_UART)
 #define UART_PADDR	IMX_DEBUG_UART_BASE(IMX7D)
 
-- 
1.9.1
