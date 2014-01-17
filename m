From: marc.ceeeee@gmail.com (Marc Carino)
Date: Fri, 17 Jan 2014 11:19:22 -0800
Subject: [PATCH v4 3/8] ARM: brcmstb: add debug UART for earlyprintk support
In-Reply-To: <1389986367-4010-1-git-send-email-marc.ceeeee@gmail.com>
References: <1389986367-4010-1-git-send-email-marc.ceeeee@gmail.com>
Message-ID: <1389986367-4010-4-git-send-email-marc.ceeeee@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the UART definitions needed to support earlyprintk on brcmstb machines.

Signed-off-by: Marc Carino <marc.ceeeee@gmail.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/Kconfig.debug |   16 +++++++++++++++-
 1 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 5765abf..266c699 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -94,6 +94,17 @@ choice
 		depends on ARCH_BCM2835
 		select DEBUG_UART_PL01X
 
+	config DEBUG_BRCMSTB_UART
+		bool "Use BRCMSTB UART for low-level debug"
+		depends on ARCH_BRCMSTB
+		select DEBUG_UART_8250
+		help
+		  Say Y here if you want the debug print routines to direct
+		  their output to the first serial port on these devices.
+
+		  If you have a Broadcom STB chip and would like early print
+		  messages to appear over the UART, select this option.
+
 	config DEBUG_CLPS711X_UART1
 		bool "Kernel low-level debugging messages via UART1"
 		depends on ARCH_CLPS711X
@@ -988,6 +999,7 @@ config DEBUG_UART_PHYS
 	default 0x20064000 if DEBUG_RK29_UART1 || DEBUG_RK3X_UART2
 	default 0x20068000 if DEBUG_RK29_UART2 || DEBUG_RK3X_UART3
 	default 0x20201000 if DEBUG_BCM2835
+	default 0xf0406b00 if DEBUG_BRCMSTB_UART
 	default 0x4000e400 if DEBUG_LL_UART_EFM32
 	default 0x40090000 if ARCH_LPC32XX
 	default 0x40100000 if DEBUG_PXA_UART1
@@ -1029,6 +1041,7 @@ config DEBUG_UART_VIRT
 	default 0xf0009000 if DEBUG_CNS3XXX
 	default 0xf01fb000 if DEBUG_NOMADIK_UART
 	default 0xf0201000 if DEBUG_BCM2835
+	default 0xfc406b00 if DEBUG_BRCMSTB_UART
 	default 0xf11f1000 if ARCH_VERSATILE
 	default 0xf1600000 if ARCH_INTEGRATOR
 	default 0xf1c28000 if DEBUG_SUNXI_UART0
@@ -1091,7 +1104,8 @@ config DEBUG_UART_8250_WORD
 	default y if DEBUG_PICOXCELL_UART || DEBUG_SOCFPGA_UART || \
 		ARCH_KEYSTONE || \
 		DEBUG_DAVINCI_DMx_UART0 || DEBUG_DAVINCI_DA8XX_UART1 || \
-		DEBUG_DAVINCI_DA8XX_UART2 || DEBUG_DAVINCI_TNETV107X_UART1
+		DEBUG_DAVINCI_DA8XX_UART2 || DEBUG_DAVINCI_TNETV107X_UART1 || \
+		DEBUG_BRCMSTB_UART
 
 config DEBUG_UART_8250_FLOW_CONTROL
 	bool "Enable flow control for 8250 UART"
-- 
1.7.1
