From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 24 Sep 2014 22:48:56 +0800
Subject: [PATCH v2 2/7] ARM: sunxi: Add debug uart used by sun9i (Allwinner
 A80)
In-Reply-To: <1411570141-29960-1-git-send-email-wens@csie.org>
References: <1411570141-29960-1-git-send-email-wens@csie.org>
Message-ID: <1411570141-29960-3-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The uarts on sun9i are still compatible with the dw_8250, but are
located at different addresses.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/Kconfig.debug | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index b11ad54..1e191d1 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -707,6 +707,14 @@ choice
 		  Say Y here if you want kernel low-level debugging support
 		  on SOCFPGA based platforms.
 
+	config DEBUG_SUN9I_UART0
+		bool "Kernel low-level debugging messages via sun9i UART0"
+		depends on MACH_SUN9I
+		select DEBUG_UART_8250
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on Allwinner A80 based platforms on the UART0.
+
 	config DEBUG_SUNXI_UART0
 		bool "Kernel low-level debugging messages via sunXi UART0"
 		depends on ARCH_SUNXI
@@ -1068,6 +1076,7 @@ config DEBUG_UART_PHYS
 	default 0x02530c00 if DEBUG_KEYSTONE_UART0
 	default 0x02531000 if DEBUG_KEYSTONE_UART1
 	default 0x03010fe0 if ARCH_RPC
+	default 0x07000000 if DEBUG_SUN9I_UART0
 	default 0x10009000 if DEBUG_REALVIEW_STD_PORT || DEBUG_CNS3XXX || \
 				DEBUG_VEXPRESS_UART0_CA9
 	default 0x1010c000 if DEBUG_REALVIEW_PB1176_PORT
@@ -1145,6 +1154,7 @@ config DEBUG_UART_VIRT
 	default 0xf2100000 if DEBUG_PXA_UART1
 	default 0xf4090000 if ARCH_LPC32XX
 	default 0xf4200000 if ARCH_GEMINI
+	default 0xf7000000 if DEBUG_SUN9I_UART0
 	default 0xf7000000 if DEBUG_S3C24XX_UART && (DEBUG_S3C_UART0 || \
 				DEBUG_S3C2410_UART0)
 	default 0xf7004000 if DEBUG_S3C24XX_UART && (DEBUG_S3C_UART1 || \
-- 
2.1.0
