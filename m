From: xuejiancheng@huawei.com (Jiancheng Xue)
Date: Tue, 19 Jan 2016 10:38:29 +0800
Subject: [PATCH v6 4/6] ARM: debug: add hi3519 debug uart
In-Reply-To: <1453171111-21921-1-git-send-email-xuejiancheng@huawei.com>
References: <1453171111-21921-1-git-send-email-xuejiancheng@huawei.com>
Message-ID: <1453171111-21921-5-git-send-email-xuejiancheng@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add hi3519 debug uart.

Signed-off-by: Jiancheng Xue <xuejiancheng@huawei.com>
---
 arch/arm/Kconfig.debug | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 259c0ca..6d23073 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -270,6 +270,14 @@ choice
 		  Say Y here if you want the debug print routines to direct
 		  their output to the 8250 at PCI COM1.
 
+	config DEBUG_HI3519_UART
+		bool "Hisilicon Hi3519 Debug UART"
+		depends on ARCH_HISI
+		select DEBUG_UART_PL01X
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on HI3519 UART.
+
 	config DEBUG_HI3620_UART
 		bool "Hisilicon HI3620 Debug UART"
 		depends on ARCH_HI3xxx
@@ -1392,6 +1400,7 @@ config DEBUG_UART_PHYS
 	default 0x11002000 if DEBUG_MT8127_UART0
 	default 0x11006000 if DEBUG_MT6589_UART0
 	default 0x11009000 if DEBUG_MT8135_UART3
+	default 0x12100000 if DEBUG_HI3519_UART
 	default 0x16000000 if ARCH_INTEGRATOR
 	default 0x18000300 if DEBUG_BCM_5301X
 	default 0x18010000 if DEBUG_SIRFATLAS7_UART0
@@ -1553,6 +1562,7 @@ config DEBUG_UART_VIRT
 	default 0xfee20000 if DEBUG_NSPIRE_CLASSIC_UART || DEBUG_NSPIRE_CX_UART
 	default 0xfee82340 if ARCH_IOP13XX
 	default 0xfef00000 if ARCH_IXP4XX && !CPU_BIG_ENDIAN
+	default 0xfef00000 if DEBUG_HI3519_UART
 	default 0xfef00003 if ARCH_IXP4XX && CPU_BIG_ENDIAN
 	default 0xfef36000 if DEBUG_HIGHBANK_UART
 	default 0xfefb0000 if DEBUG_OMAP1UART1 || DEBUG_OMAP7XXUART1
-- 
1.9.1
