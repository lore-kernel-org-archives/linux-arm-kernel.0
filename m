From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue,  1 Jul 2014 22:37:06 +0200
Subject: [PATCH 3/3] ARM: drop Kconfig symbol FOOTBRIDGE
In-Reply-To: <1404247026-379-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1404247026-379-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1404247026-379-4-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Kconfig symbols FOOTBRIDGE and ARCH_FOOTBRIDGE are equivalent so the
former can be substituted by the latter. The two previous patches do the
same for the other occurences of FOOTBRIDGE and so this symbol can be
removed now.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/Kconfig                 |  1 -
 arch/arm/Kconfig.debug           | 14 +++++++-------
 arch/arm/mach-footbridge/Kconfig |  4 ----
 3 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 245058b3b0ef..efb20226f95e 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -442,7 +442,6 @@ config ARCH_EP93XX
 config ARCH_FOOTBRIDGE
 	bool "FootBridge"
 	select CPU_SA110
-	select FOOTBRIDGE
 	select GENERIC_CLOCKEVENTS
 	select HAVE_IDE
 	select NEED_MACH_IO_H if !MMU
diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 8f90595069a1..6b69a5dc9a79 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -195,14 +195,14 @@ choice
 
 	config DEBUG_DC21285_PORT
 		bool "Kernel low-level debugging messages via footbridge serial port"
-		depends on FOOTBRIDGE
+		depends on ARCH_FOOTBRIDGE
 		help
 		  Say Y here if you want the debug print routines to direct
 		  their output to the serial port in the DC21285 (Footbridge).
 
 	config DEBUG_FOOTBRIDGE_COM1
 		bool "Kernel low-level debugging messages via footbridge 8250 at PCI COM1"
-		depends on FOOTBRIDGE
+		depends on ARCH_FOOTBRIDGE
 		help
 		  Say Y here if you want the debug print routines to direct
 		  their output to the 8250 at PCI COM1.
@@ -1031,7 +1031,7 @@ config DEBUG_UART_PL01X
 # Compatibility options for 8250
 config DEBUG_UART_8250
 	def_bool ARCH_DOVE || ARCH_EBSA110 || \
-		(FOOTBRIDGE && !DEBUG_DC21285_PORT) || \
+		(ARCH_FOOTBRIDGE && !DEBUG_DC21285_PORT) || \
 		ARCH_GEMINI || ARCH_IOP13XX || ARCH_IOP32X || \
 		ARCH_IOP33X || ARCH_IXP4XX || ARCH_KIRKWOOD || \
 		ARCH_LPC32XX || ARCH_MV78XX0 || ARCH_ORION5X || ARCH_RPC
@@ -1071,7 +1071,7 @@ config DEBUG_UART_PHYS
 				DEBUG_S3C2410_UART1)
 	default 0x50008000 if DEBUG_S3C24XX_UART && (DEBUG_S3C_UART2 || \
 				DEBUG_S3C2410_UART2)
-	default 0x7c0003f8 if FOOTBRIDGE
+	default 0x7c0003f8 if ARCH_FOOTBRIDGE
 	default 0x80070000 if DEBUG_IMX23_UART
 	default 0x80074000 if DEBUG_IMX28_UART
 	default 0x80230000 if DEBUG_PICOXCELL_UART
@@ -1159,7 +1159,7 @@ config DEBUG_UART_VIRT
 	default 0xfed64000 if DEBUG_RK29_UART1 || DEBUG_RK3X_UART2
 	default 0xfed68000 if DEBUG_RK29_UART2 || DEBUG_RK3X_UART3
 	default 0xfedc0000 if ARCH_EP93XX
-	default 0xfee003f8 if FOOTBRIDGE
+	default 0xfee003f8 if ARCH_FOOTBRIDGE
 	default 0xfee20000 if DEBUG_NSPIRE_CLASSIC_UART || DEBUG_NSPIRE_CX_UART
 	default 0xfee82340 if ARCH_IOP13XX
 	default 0xfef00000 if ARCH_IXP4XX && !CPU_BIG_ENDIAN
@@ -1175,7 +1175,7 @@ config DEBUG_UART_VIRT
 config DEBUG_UART_8250_SHIFT
 	int "Register offset shift for the 8250 debug UART"
 	depends on DEBUG_LL_UART_8250 || DEBUG_UART_8250
-	default 0 if FOOTBRIDGE || ARCH_IOP32X
+	default 0 if ARCH_FOOTBRIDGE || ARCH_IOP32X
 	default 2
 
 config DEBUG_UART_8250_WORD
@@ -1191,7 +1191,7 @@ config DEBUG_UART_8250_WORD
 config DEBUG_UART_8250_FLOW_CONTROL
 	bool "Enable flow control for 8250 UART"
 	depends on DEBUG_LL_UART_8250 || DEBUG_UART_8250
-	default y if ARCH_EBSA110 || FOOTBRIDGE || ARCH_GEMINI || ARCH_RPC
+	default y if ARCH_EBSA110 || ARCH_FOOTBRIDGE || ARCH_GEMINI || ARCH_RPC
 
 config DEBUG_UNCOMPRESS
 	bool
diff --git a/arch/arm/mach-footbridge/Kconfig b/arch/arm/mach-footbridge/Kconfig
index 07152d00fc50..98d1dae727b6 100644
--- a/arch/arm/mach-footbridge/Kconfig
+++ b/arch/arm/mach-footbridge/Kconfig
@@ -79,10 +79,6 @@ config ARCH_NETWINDER
 
 endmenu
 
-# Footbridge support
-config FOOTBRIDGE
-	bool
-
 # Footbridge in host mode
 config FOOTBRIDGE_HOST
 	bool
-- 
2.0.0
