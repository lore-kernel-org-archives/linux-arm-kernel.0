From: xuejiancheng@huawei.com (Jiancheng Xue)
Date: Sat, 28 Nov 2015 15:20:52 +0800
Subject: [PATCH 5/5] ARM: debug: add Hi3519 debug uart
Message-ID: <1448695252-31453-1-git-send-email-xuejiancheng@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the support of Hisilicon Hi3519 debug uart.

Signed-off-by: Jiancheng Xue <xuejiancheng@huawei.com>
---
 arch/arm/Kconfig.debug | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 259c0ca..4d2ae2a 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -270,6 +270,14 @@ choice
 		  Say Y here if you want the debug print routines to direct
 		  their output to the 8250 at PCI COM1.
 
+	config DEBUG_HI3519_UART
+		bool "Hisilicon Hi3519 Debug UART"
+		depends on ARCH_HI3519
+		select DEBUG_UART_PL01X
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on HI3519 UART.
+
 	config DEBUG_HI3620_UART
 		bool "Hisilicon HI3620 Debug UART"
 		depends on ARCH_HI3xxx
@@ -1449,6 +1457,7 @@ config DEBUG_UART_PHYS
 	default 0xf7fc9000 if DEBUG_BERLIN_UART
 	default 0xf8b00000 if DEBUG_HIX5HD2_UART
 	default 0xf991e000 if DEBUG_QCOM_UARTDM
+	default 0x12100000 if DEBUG_HI3519_UART
 	default 0xfcb00000 if DEBUG_HI3620_UART
 	default 0xfd883000 if DEBUG_ALPINE_UART0
 	default 0xfe800000 if ARCH_IOP32X
@@ -1529,6 +1538,7 @@ config DEBUG_UART_VIRT
 	default 0xfe230000 if DEBUG_PICOXCELL_UART
 	default 0xfe300000 if DEBUG_BCM_KONA_UART
 	default 0xfe800000 if ARCH_IOP32X
+	default 0xfef00000 if DEBUG_HI3519_UART
 	default 0xfeb00000 if DEBUG_HI3620_UART || DEBUG_HIX5HD2_UART
 	default 0xfeb24000 if DEBUG_RK3X_UART0
 	default 0xfeb26000 if DEBUG_RK3X_UART1
-- 
1.9.1
