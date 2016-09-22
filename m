From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 23 Sep 2016 00:22:08 +0200
Subject: [PATCH 4/4] ARM: at91: debug: add samx7 support
In-Reply-To: <20160922222208.23798-1-alexandre.belloni@free-electrons.com>
References: <20160922222208.23798-1-alexandre.belloni@free-electrons.com>
Message-ID: <20160922222208.23798-5-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Szemz? Andr?s <sza@esh.hu>

Add support for low level debugging on Atmel samx7.

Signed-off-by: Szemz? Andr?s <sza@esh.hu>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/Kconfig.debug | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index a9693b6987a6..d209d0d78820 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -145,6 +145,15 @@ choice
 		  Say Y here if you want kernel low-level debugging support
 		  on the USART3 port of sama5d4.
 
+	config DEBUG_AT91_SAMX7_USART1
+		bool "Kernel low-level debugging via SAMX7 USART1"
+		select DEBUG_AT91_UART
+		depends on SOC_SAMX7
+		help
+		  Say Y here if you want the debug print routines to direct
+		  their output to the USART1 port on SAMX7 based
+		  machines.
+
 	config DEBUG_BCM2835
 		bool "Kernel low-level debugging on BCM2835 PL011 UART"
 		depends on ARCH_BCM2835 && ARCH_MULTI_V6
@@ -1479,6 +1488,7 @@ config DEBUG_UART_PHYS
 	default 0x3f201000 if DEBUG_BCM2836
 	default 0x3e000000 if DEBUG_BCM_KONA_UART
 	default 0x4000e400 if DEBUG_LL_UART_EFM32
+	default 0x40028000 if DEBUG_AT91_SAMX7_USART1
 	default 0x40081000 if DEBUG_LPC18XX_UART0
 	default 0x40090000 if DEBUG_LPC32XX
 	default 0x40100000 if DEBUG_PXA_UART1
-- 
2.9.3
