From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat, 29 Mar 2014 14:44:26 +0400
Subject: [PATCH] ARM: Keep DEBUG_UART_{PHYS,VIRT} entries sorted
Message-ID: <1396089866-9380-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch sorts the entries for DEBUG_UART_{PHYS,VIRT}.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/Kconfig.debug | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 7289853..00c6950 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -1039,9 +1039,9 @@ config DEBUG_UART_PHYS
 	default 0x40100000 if DEBUG_PXA_UART1
 	default 0x42000000 if ARCH_GEMINI
 	default 0x7c0003f8 if FOOTBRIDGE
-	default 0x80230000 if DEBUG_PICOXCELL_UART
 	default 0x80070000 if DEBUG_IMX23_UART
 	default 0x80074000 if DEBUG_IMX28_UART
+	default 0x80230000 if DEBUG_PICOXCELL_UART
 	default 0x808c0000 if ARCH_EP93XX
 	default 0x90020000 if DEBUG_NSPIRE_CLASSIC_UART || DEBUG_NSPIRE_CX_UART
 	default 0xb0090000 if DEBUG_VEXPRESS_UART0_CRX
@@ -1105,22 +1105,22 @@ config DEBUG_UART_VIRT
 	default 0xfeb26000 if DEBUG_RK3X_UART1
 	default 0xfeb30c00 if DEBUG_KEYSTONE_UART0
 	default 0xfeb31000 if DEBUG_KEYSTONE_UART1
-	default 0xfec12000 if DEBUG_MVEBU_UART || DEBUG_MVEBU_UART_ALTERNATE
-	default 0xfed60000 if DEBUG_RK29_UART0
-	default 0xfed64000 if DEBUG_RK29_UART1 || DEBUG_RK3X_UART2
-	default 0xfed68000 if DEBUG_RK29_UART2 || DEBUG_RK3X_UART3
 	default 0xfec02000 if DEBUG_SOCFPGA_UART
+	default 0xfec12000 if DEBUG_MVEBU_UART || DEBUG_MVEBU_UART_ALTERNATE
 	default 0xfec20000 if DEBUG_DAVINCI_DMx_UART0
 	default 0xfed0c000 if DEBUG_DAVINCI_DA8XX_UART1
 	default 0xfed0d000 if DEBUG_DAVINCI_DA8XX_UART2
 	default 0xfed12000 if ARCH_KIRKWOOD
+	default 0xfed60000 if DEBUG_RK29_UART0
+	default 0xfed64000 if DEBUG_RK29_UART1 || DEBUG_RK3X_UART2
+	default 0xfed68000 if DEBUG_RK29_UART2 || DEBUG_RK3X_UART3
 	default 0xfedc0000 if ARCH_EP93XX
 	default 0xfee003f8 if FOOTBRIDGE
 	default 0xfee20000 if DEBUG_NSPIRE_CLASSIC_UART || DEBUG_NSPIRE_CX_UART
-	default 0xfef36000 if DEBUG_HIGHBANK_UART
 	default 0xfee82340 if ARCH_IOP13XX
 	default 0xfef00000 if ARCH_IXP4XX && !CPU_BIG_ENDIAN
 	default 0xfef00003 if ARCH_IXP4XX && CPU_BIG_ENDIAN
+	default 0xfef36000 if DEBUG_HIGHBANK_UART
 	default 0xfefff700 if ARCH_IOP33X
 	default 0xff003000 if DEBUG_U300_UART
 	default DEBUG_UART_PHYS if !MMU
-- 
1.8.3.2
