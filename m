From: hauke@hauke-m.de (Hauke Mehrtens)
Date: Tue,  7 Jan 2014 23:58:10 +0100
Subject: [PATCH v7 2/4] ARM: BCM5301X: add early debugging support
In-Reply-To: <1389135492-11655-1-git-send-email-hauke@hauke-m.de>
References: <1389135492-11655-1-git-send-email-hauke@hauke-m.de>
Message-ID: <1389135492-11655-3-git-send-email-hauke@hauke-m.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds support for early debugging of BCM5301X SoC.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig.debug |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index bda94e4..eebd81e 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -102,6 +102,11 @@ choice
 		  Say Y here if you want kernel low-level debugging support
 		  on Marvell Berlin SoC based platforms.
 
+	config DEBUG_BCM_5301X
+		bool "Kernel low-level debugging on BCM5301X UART1"
+		depends on ARCH_BCM_5301X
+		select DEBUG_UART_PL01X
+
 	config DEBUG_CLPS711X_UART1
 		bool "Kernel low-level debugging messages via UART1"
 		depends on ARCH_CLPS711X
@@ -1005,6 +1010,7 @@ config DEBUG_UART_PHYS
 	default 0x20064000 if DEBUG_RK29_UART1 || DEBUG_RK3X_UART2
 	default 0x20068000 if DEBUG_RK29_UART2 || DEBUG_RK3X_UART3
 	default 0x20201000 if DEBUG_BCM2835
+	default 0x18000300 if DEBUG_BCM_5301X
 	default 0x4000e400 if DEBUG_LL_UART_EFM32
 	default 0x40090000 if ARCH_LPC32XX
 	default 0x40100000 if DEBUG_PXA_UART1
@@ -1047,6 +1053,7 @@ config DEBUG_UART_VIRT
 	default 0xf0009000 if DEBUG_CNS3XXX
 	default 0xf01fb000 if DEBUG_NOMADIK_UART
 	default 0xf0201000 if DEBUG_BCM2835
+	default 0xf1000300 if DEBUG_BCM_5301X
 	default 0xf11f1000 if ARCH_VERSATILE
 	default 0xf1600000 if ARCH_INTEGRATOR
 	default 0xf1c28000 if DEBUG_SUNXI_UART0
-- 
1.7.10.4
