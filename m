From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 20 Jan 2012 09:52:10 +0000
Subject: [PATCH] ARM: debug: arrange Kconfig options more logically
Message-ID: <E1RoB8k-0005HD-RL@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arrange the Kconfig options in rough alphabetical order, and place the
default 'none' and 'icedcc' options at the end.  This prefers the
platform specific debug option rather than the 'none' option, which is
what we actually want.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/Kconfig.debug |  156 ++++++++++++++++++++++++------------------------
 1 files changed, 78 insertions(+), 78 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index e0d236d..03646c4 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -81,25 +81,6 @@ choice
 	prompt "Kernel low-level debugging port"
 	depends on DEBUG_LL
 
-	config DEBUG_LL_UART_NONE
-		bool "No low-level debugging UART"
-		help
-		  Say Y here if your platform doesn't provide a UART option
-		  below. This relies on your platform choosing the right UART
-		  definition internally in order for low-level debugging to
-		  work.
-
-	config DEBUG_ICEDCC
-		bool "Kernel low-level debugging via EmbeddedICE DCC channel"
-		help
-		  Say Y here if you want the debug print routines to direct
-		  their output to the EmbeddedICE macrocell's DCC channel using
-		  co-processor 14. This is known to work on the ARM9 style ICE
-		  channel and on the XScale with the PEEDI.
-
-		  Note that the system will appear to hang during boot if there
-		  is nothing connected to read from the DCC.
-
 	config AT91_DEBUG_LL_DBGU0
 		bool "Kernel low-level debugging on rm9200, 9260/9g20, 9261/9g10 and 9rl"
 		depends on HAVE_AT91_DBGU0
@@ -108,20 +89,6 @@ choice
 		bool "Kernel low-level debugging on 9263, 9g45 and cap9"
 		depends on HAVE_AT91_DBGU1
 
-	config DEBUG_FOOTBRIDGE_COM1
-		bool "Kernel low-level debugging messages via footbridge 8250 at PCI COM1"
-		depends on FOOTBRIDGE
-		help
-		  Say Y here if you want the debug print routines to direct
-		  their output to the 8250 at PCI COM1.
-
-	config DEBUG_DC21285_PORT
-		bool "Kernel low-level debugging messages via footbridge serial port"
-		depends on FOOTBRIDGE
-		help
-		  Say Y here if you want the debug print routines to direct
-		  their output to the serial port in the DC21285 (Footbridge).
-
 	config DEBUG_CLPS711X_UART1
 		bool "Kernel low-level debugging messages via UART1"
 		depends on ARCH_CLPS711X
@@ -136,6 +103,20 @@ choice
 		  Say Y here if you want the debug print routines to direct
 		  their output to the second serial port on these devices.
 
+	config DEBUG_DC21285_PORT
+		bool "Kernel low-level debugging messages via footbridge serial port"
+		depends on FOOTBRIDGE
+		help
+		  Say Y here if you want the debug print routines to direct
+		  their output to the serial port in the DC21285 (Footbridge).
+
+	config DEBUG_FOOTBRIDGE_COM1
+		bool "Kernel low-level debugging messages via footbridge 8250 at PCI COM1"
+		depends on FOOTBRIDGE
+		help
+		  Say Y here if you want the debug print routines to direct
+		  their output to the 8250 at PCI COM1.
+
 	config DEBUG_HIGHBANK_UART
 		bool "Kernel low-level debugging messages via Highbank UART"
 		depends on ARCH_HIGHBANK
@@ -206,38 +187,42 @@ choice
 		  Say Y here if you want kernel low-level debugging support
 		  on i.MX6Q.
 
-	config DEBUG_S3C_UART0
-		depends on PLAT_SAMSUNG
-		bool "Use S3C UART 0 for low-level debug"
+	config DEBUG_MSM_UART1
+		bool "Kernel low-level debugging messages via MSM UART1"
+		depends on ARCH_MSM7X00A || ARCH_MSM7X30 || ARCH_QSD8X50
 		help
 		  Say Y here if you want the debug print routines to direct
-		  their output to UART 0. The port must have been initialised
-		  by the boot-loader before use.
-
-		  The uncompressor code port configuration is now handled
-		  by CONFIG_S3C_LOWLEVEL_UART_PORT.
+		  their output to the first serial port on MSM devices.
 
-	config DEBUG_S3C_UART1
-		depends on PLAT_SAMSUNG
-		bool "Use S3C UART 1 for low-level debug"
+	config DEBUG_MSM_UART2
+		bool "Kernel low-level debugging messages via MSM UART2"
+		depends on ARCH_MSM7X00A || ARCH_MSM7X30 || ARCH_QSD8X50
 		help
 		  Say Y here if you want the debug print routines to direct
-		  their output to UART 1. The port must have been initialised
-		  by the boot-loader before use.
+		  their output to the second serial port on MSM devices.
 
-		  The uncompressor code port configuration is now handled
-		  by CONFIG_S3C_LOWLEVEL_UART_PORT.
+	config DEBUG_MSM_UART3
+		bool "Kernel low-level debugging messages via MSM UART3"
+		depends on ARCH_MSM7X00A || ARCH_MSM7X30 || ARCH_QSD8X50
+		help
+		  Say Y here if you want the debug print routines to direct
+		  their output to the third serial port on MSM devices.
 
-	config DEBUG_S3C_UART2
-		depends on PLAT_SAMSUNG
-		bool "Use S3C UART 2 for low-level debug"
+	config DEBUG_MSM8660_UART
+		bool "Kernel low-level debugging messages via MSM 8660 UART"
+		depends on ARCH_MSM8X60
+		select MSM_HAS_DEBUG_UART_HS
 		help
 		  Say Y here if you want the debug print routines to direct
-		  their output to UART 2. The port must have been initialised
-		  by the boot-loader before use.
+		  their output to the serial port on MSM 8660 devices.
 
-		  The uncompressor code port configuration is now handled
-		  by CONFIG_S3C_LOWLEVEL_UART_PORT.
+	config DEBUG_MSM8960_UART
+		bool "Kernel low-level debugging messages via MSM 8960 UART"
+		depends on ARCH_MSM8960
+		select MSM_HAS_DEBUG_UART_HS
+		help
+		  Say Y here if you want the debug print routines to direct
+		  their output to the serial port on MSM 8960 devices.
 
 	config DEBUG_REALVIEW_STD_PORT
 		bool "RealView Default UART"
@@ -255,42 +240,57 @@ choice
 		  their output to the standard serial port on the RealView
 		  PB1176 platform.
 
-	config DEBUG_MSM_UART1
-		bool "Kernel low-level debugging messages via MSM UART1"
-		depends on ARCH_MSM7X00A || ARCH_MSM7X30 || ARCH_QSD8X50
+	config DEBUG_S3C_UART0
+		depends on PLAT_SAMSUNG
+		bool "Use S3C UART 0 for low-level debug"
 		help
 		  Say Y here if you want the debug print routines to direct
-		  their output to the first serial port on MSM devices.
+		  their output to UART 0. The port must have been initialised
+		  by the boot-loader before use.
 
-	config DEBUG_MSM_UART2
-		bool "Kernel low-level debugging messages via MSM UART2"
-		depends on ARCH_MSM7X00A || ARCH_MSM7X30 || ARCH_QSD8X50
+		  The uncompressor code port configuration is now handled
+		  by CONFIG_S3C_LOWLEVEL_UART_PORT.
+
+	config DEBUG_S3C_UART1
+		depends on PLAT_SAMSUNG
+		bool "Use S3C UART 1 for low-level debug"
 		help
 		  Say Y here if you want the debug print routines to direct
-		  their output to the second serial port on MSM devices.
+		  their output to UART 1. The port must have been initialised
+		  by the boot-loader before use.
 
-	config DEBUG_MSM_UART3
-		bool "Kernel low-level debugging messages via MSM UART3"
-		depends on ARCH_MSM7X00A || ARCH_MSM7X30 || ARCH_QSD8X50
+		  The uncompressor code port configuration is now handled
+		  by CONFIG_S3C_LOWLEVEL_UART_PORT.
+
+	config DEBUG_S3C_UART2
+		depends on PLAT_SAMSUNG
+		bool "Use S3C UART 2 for low-level debug"
 		help
 		  Say Y here if you want the debug print routines to direct
-		  their output to the third serial port on MSM devices.
+		  their output to UART 2. The port must have been initialised
+		  by the boot-loader before use.
 
-	config DEBUG_MSM8660_UART
-		bool "Kernel low-level debugging messages via MSM 8660 UART"
-		depends on ARCH_MSM8X60
-		select MSM_HAS_DEBUG_UART_HS
+		  The uncompressor code port configuration is now handled
+		  by CONFIG_S3C_LOWLEVEL_UART_PORT.
+
+	config DEBUG_LL_UART_NONE
+		bool "No low-level debugging UART"
 		help
-		  Say Y here if you want the debug print routines to direct
-		  their output to the serial port on MSM 8660 devices.
+		  Say Y here if your platform doesn't provide a UART option
+		  below. This relies on your platform choosing the right UART
+		  definition internally in order for low-level debugging to
+		  work.
 
-	config DEBUG_MSM8960_UART
-		bool "Kernel low-level debugging messages via MSM 8960 UART"
-		depends on ARCH_MSM8960
-		select MSM_HAS_DEBUG_UART_HS
+	config DEBUG_ICEDCC
+		bool "Kernel low-level debugging via EmbeddedICE DCC channel"
 		help
 		  Say Y here if you want the debug print routines to direct
-		  their output to the serial port on MSM 8960 devices.
+		  their output to the EmbeddedICE macrocell's DCC channel using
+		  co-processor 14. This is known to work on the ARM9 style ICE
+		  channel and on the XScale with the PEEDI.
+
+		  Note that the system will appear to hang during boot if there
+		  is nothing connected to read from the DCC.
 
 endchoice
 
-- 
1.7.4.4
