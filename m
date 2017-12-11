From: domenico.andreoli@linux.com (Domenico Andreoli)
Date: Mon, 11 Dec 2017 12:17:31 +0100
Subject: [PATCH] ARM: DEBUG_LL options' description clean-up
Message-ID: <20171211111730.uvzos6slimk7whdc@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM: DEBUG_LL options' description clean-up

The Kconfig menu for ARM low-level debugging exposes enough variety of
description text which needs to be visually filtered out when searching
for the right option. Longer descriptions are not fully visible when
using menuconfig.

This patch removes the clutter and leaves (or adds, when missing)
the relevant info to identify the wanted option. As general pattern,
SoC/board is specified first then the UART details.

Signed-off-by: Domenico Andreoli <domenico.andreoli@linux.com>

Index: arm.git/arch/arm/Kconfig.debug
===================================================================
--- arm.git.orig/arch/arm/Kconfig.debug	2017-12-11 11:50:28.295893938 +0100
+++ arm.git/arch/arm/Kconfig.debug	2017-12-11 12:05:37.780982910 +0100
@@ -82,7 +82,7 @@ choice
 	depends on DEBUG_LL
 
 	config DEBUG_ALPINE_UART0
-		bool "Kernel low-level debugging messages via Alpine UART0"
+		bool "Alpine UART0"
 		depends on ARCH_ALPINE
 		select DEBUG_UART_8250
 		help
@@ -90,7 +90,7 @@ choice
 		  on Alpine based platforms.
 
 	config DEBUG_ASM9260_UART
-		bool "Kernel low-level debugging via asm9260 UART"
+		bool "asm9260 UART"
 		depends on MACH_ASM9260
 		help
 		  Say Y here if you want the debug print routines to direct
@@ -111,7 +111,7 @@ choice
 		    0x80024000      | 0xf0024000     | UART9
 
 	config DEBUG_AT91_RM9200_DBGU
-		bool "Kernel low-level debugging on AT91RM9200, AT91SAM9 DBGU"
+		bool "AT91RM9200, AT91SAM9 DBGU"
 		select DEBUG_AT91_UART
 		depends on SOC_AT91RM9200 || SOC_AT91SAM9
 		help
@@ -121,7 +121,7 @@ choice
 		    at91sam9g10, at91sam9n12, at91sam9rl64, at91sam9x5
 
 	config DEBUG_AT91_SAM9263_DBGU
-		bool "Kernel low-level debugging on AT91SAM{9263,9G45,A5D3} DBGU"
+		bool "AT91SAM{9263,9G45,A5D3} DBGU"
 		select DEBUG_AT91_UART
 		depends on SOC_AT91SAM9 || SOC_SAMA5D3
 		help
@@ -131,7 +131,7 @@ choice
 		    sama5d3
 
 	config DEBUG_AT91_SAMA5D2_UART1
-		bool "Kernel low-level debugging on SAMA5D2 UART1"
+		bool "SAMA5D2 UART1"
 		select DEBUG_AT91_UART
 		depends on SOC_SAMA5D2
 		help
@@ -139,7 +139,7 @@ choice
 		  on the UART1 port of sama5d2.
 
 	config DEBUG_AT91_SAMA5D4_USART3
-		bool "Kernel low-level debugging on SAMA5D4 USART3"
+		bool "SAMA5D4 USART3"
 		select DEBUG_AT91_UART
 		depends on SOC_SAMA5D4
 		help
@@ -147,7 +147,7 @@ choice
 		  on the USART3 port of sama5d4.
 
 	config DEBUG_AT91_SAMV7_USART1
-		bool "Kernel low-level debugging via SAMV7 USART1"
+		bool "SAMV7 USART1"
 		select DEBUG_AT91_UART
 		depends on SOC_SAMV7
 		help
@@ -156,27 +156,27 @@ choice
 		  machines.
 
 	config DEBUG_BCM2835
-		bool "Kernel low-level debugging on BCM2835 PL011 UART"
+		bool "BCM2835 PL011 UART"
 		depends on ARCH_BCM2835 && ARCH_MULTI_V6
 		select DEBUG_UART_PL01X
 
 	config DEBUG_BCM2836
-		bool "Kernel low-level debugging on BCM2836 PL011 UART"
+		bool "BCM2836 PL011 UART"
 		depends on ARCH_BCM2835 && ARCH_MULTI_V7
 		select DEBUG_UART_PL01X
 
 	config DEBUG_BCM_5301X
-		bool "Kernel low-level debugging on BCM5301X/NSP UART1"
+		bool "BCM5301X/NSP UART1"
 		depends on ARCH_BCM_5301X || ARCH_BCM_NSP
 		select DEBUG_UART_8250
 
 	config DEBUG_BCM_HR2
-		bool "Kernel low-level debugging on Hurricane 2 UART2"
+		bool "Hurricane 2 UART2"
 		depends on ARCH_BCM_HR2
 		select DEBUG_UART_8250
 
 	config DEBUG_BCM_KONA_UART
-		bool "Kernel low-level debugging messages via BCM KONA UART"
+		bool "BCM KONA UART"
 		depends on ARCH_BCM_MOBILE
 		select DEBUG_UART_8250
 		help
@@ -187,7 +187,7 @@ choice
 		  bcm11351, etc...)
 
 	config DEBUG_BCM63XX_UART
-		bool "Kernel low-level debugging on BCM63XX UART"
+		bool "BCM63XX UART"
 		depends on ARCH_BCM_63XX
 
 	config DEBUG_BERLIN_UART
@@ -199,7 +199,7 @@ choice
 		  on Marvell Berlin SoC based platforms.
 
 	config DEBUG_BRCMSTB_UART
-		bool "Use BRCMSTB UART for low-level debug"
+		bool "BRCMSTB UART"
 		depends on ARCH_BRCMSTB
 		help
 		  Say Y here if you want the debug print routines to direct
@@ -211,21 +211,21 @@ choice
 		  messages to appear over the UART, select this option.
 
 	config DEBUG_CLPS711X_UART1
-		bool "Kernel low-level debugging messages via UART1"
+		bool "CLPS711X UART1"
 		depends on ARCH_CLPS711X
 		help
 		  Say Y here if you want the debug print routines to direct
 		  their output to the first serial port on these devices.
 
 	config DEBUG_CLPS711X_UART2
-		bool "Kernel low-level debugging messages via UART2"
+		bool "CLPS711X UART2"
 		depends on ARCH_CLPS711X
 		help
 		  Say Y here if you want the debug print routines to direct
 		  their output to the second serial port on these devices.
 
 	config DEBUG_CNS3XXX
-		bool "Kernel Kernel low-level debugging on Cavium Networks CNS3xxx"
+		bool "Cavium Networks CNS3xxx"
 		depends on ARCH_CNS3XXX
 		select DEBUG_UART_8250
 		help
@@ -233,7 +233,7 @@ choice
                   their output to the CNS3xxx UART0.
 
 	config DEBUG_DAVINCI_DA8XX_UART1
-		bool "Kernel low-level debugging on DaVinci DA8XX using UART1"
+		bool "DaVinci DA8XX UART1"
 		depends on ARCH_DAVINCI_DA8XX
 		select DEBUG_UART_8250
 		help
@@ -241,7 +241,7 @@ choice
 		  their output to UART1 serial port on DaVinci DA8XX devices.
 
 	config DEBUG_DAVINCI_DA8XX_UART2
-		bool "Kernel low-level debugging on DaVinci DA8XX using UART2"
+		bool "DaVinci DA8XX UART2"
 		depends on ARCH_DAVINCI_DA8XX
 		select DEBUG_UART_8250
 		help
@@ -249,7 +249,7 @@ choice
 		  their output to UART2 serial port on DaVinci DA8XX devices.
 
 	config DEBUG_DAVINCI_DMx_UART0
-		bool "Kernel low-level debugging on DaVinci DMx using UART0"
+		bool "DaVinci DMx UART0"
 		depends on ARCH_DAVINCI_DMx
 		select DEBUG_UART_8250
 		help
@@ -257,21 +257,21 @@ choice
 		  their output to UART0 serial port on DaVinci DMx devices.
 
 	config DEBUG_DC21285_PORT
-		bool "Kernel low-level debugging messages via footbridge serial port"
+		bool "footbridge serial port"
 		depends on FOOTBRIDGE
 		help
 		  Say Y here if you want the debug print routines to direct
 		  their output to the serial port in the DC21285 (Footbridge).
 
 	config DEBUG_DIGICOLOR_UA0
-		bool "Kernel low-level debugging messages via Digicolor UA0"
+		bool "Digicolor UA0"
 		depends on ARCH_DIGICOLOR
 		help
 		  Say Y here if you want the debug print routines to direct
 		  their output to the UA0 serial port in the CX92755.
 
 	config DEBUG_EP93XX
-		bool "Kernel low-level debugging messages via ep93xx UART"
+		bool "ep93xx UART"
 		depends on ARCH_EP93XX
 		select DEBUG_UART_PL01X
 		help
@@ -279,7 +279,7 @@ choice
 		  on Cirrus Logic EP93xx based platforms.
 
 	config DEBUG_FOOTBRIDGE_COM1
-		bool "Kernel low-level debugging messages via footbridge 8250 at PCI COM1"
+		bool "footbridge 8250 at PCI COM1"
 		depends on FOOTBRIDGE
 		select DEBUG_UART_8250
 		help
@@ -287,7 +287,7 @@ choice
 		  their output to the 8250 at PCI COM1.
 
 	config DEBUG_GEMINI
-		bool "Kernel low-level debugging messages via Cortina Systems Gemini UART"
+		bool "Cortina Systems Gemini UART"
 		depends on ARCH_GEMINI
 		select DEBUG_UART_8250
 		help
@@ -303,7 +303,7 @@ choice
 		  on HI3620 UART.
 
 	config DEBUG_HIGHBANK_UART
-		bool "Kernel low-level debugging messages via Highbank UART"
+		bool "Highbank UART"
 		depends on ARCH_HIGHBANK
 		select DEBUG_UART_PL01X
 		help
@@ -442,7 +442,7 @@ choice
 		  on i.MX7D.
 
 	config DEBUG_INTEGRATOR
-		bool "Kernel low-level debugging messages via ARM Integrator UART"
+		bool "ARM Integrator UART"
 		depends on ARCH_INTEGRATOR
 		select DEBUG_UART_PL01X
 		help
@@ -450,7 +450,7 @@ choice
 		  on ARM Integrator platforms.
 
 	config DEBUG_KEYSTONE_UART0
-		bool "Kernel low-level debugging on KEYSTONE2 using UART0"
+		bool "KEYSTONE2 UART0"
 		depends on ARCH_KEYSTONE
 		select DEBUG_UART_8250
 		help
@@ -458,7 +458,7 @@ choice
 		  their output to UART0 serial port on KEYSTONE2 devices.
 
 	config DEBUG_KEYSTONE_UART1
-		bool "Kernel low-level debugging on KEYSTONE2 using UART1"
+		bool "KEYSTONE2 UART1"
 		depends on ARCH_KEYSTONE
 		select DEBUG_UART_8250
 		help
@@ -473,7 +473,7 @@ choice
 		  on KS8695.
 
 	config DEBUG_LPC18XX_UART0
-		bool "Kernel low-level debugging via LPC18xx/43xx UART0"
+		bool "LPC18xx/43xx UART0"
 		depends on ARCH_LPC18XX
 		select DEBUG_UART_8250
 		help
@@ -481,7 +481,7 @@ choice
 		  on NXP LPC18xx/43xx UART0.
 
 	config DEBUG_LPC32XX
-		bool "Kernel low-level debugging messages via NXP LPC32xx UART"
+		bool "NXP LPC32xx UART"
 		depends on ARCH_LPC32XX
 		select DEBUG_UART_8250
 		help
@@ -489,14 +489,14 @@ choice
 		  on NXP LPC32xx based platforms.
 
 	config DEBUG_MESON_UARTAO
-		bool "Kernel low-level debugging via Meson6 UARTAO"
+		bool "Meson6 UARTAO"
 		depends on ARCH_MESON
 		help
 		  Say Y here if you want kernel low-lever debugging support
 		  on Amlogic Meson6 based platforms on the UARTAO.
 
 	config DEBUG_MMP_UART2
-		bool "Kernel low-level debugging message via MMP UART2"
+		bool "MMP UART2"
 		depends on ARCH_MMP
 		select DEBUG_UART_8250
 		help
@@ -504,7 +504,7 @@ choice
 		  on MMP UART2.
 
 	config DEBUG_MMP_UART3
-		bool "Kernel low-level debugging message via MMP UART3"
+		bool "MMP UART3"
 		depends on ARCH_MMP
 		select DEBUG_UART_8250
 		help
@@ -512,7 +512,7 @@ choice
 		  on MMP UART3.
 
 	config DEBUG_MVEBU_UART0
-		bool "Kernel low-level debugging messages via MVEBU UART0 (old bootloaders)"
+		bool "MVEBU UART0 (old bootloaders)"
 		depends on ARCH_MVEBU
 		depends on ARCH_MVEBU && CPU_V7
 		select DEBUG_UART_8250
@@ -536,7 +536,7 @@ choice
 		  silently crashes, with no serial output at all.
 
 	config DEBUG_MVEBU_UART0_ALTERNATE
-		bool "Kernel low-level debugging messages via MVEBU UART0 (new bootloaders)"
+		bool "MVEBU UART0 (new bootloaders)"
 		depends on ARCH_MVEBU || ARCH_DOVE || ARCH_MV78XX0 || ARCH_ORION5X
 		select DEBUG_UART_8250
 		help
@@ -553,7 +553,7 @@ choice
 		  silently crashes, with no serial output at all.
 
 	config DEBUG_MVEBU_UART1_ALTERNATE
-		bool "Kernel low-level debugging messages via MVEBU UART1 (new bootloaders)"
+		bool "MVEBU UART1 (new bootloaders)"
 		depends on ARCH_MVEBU
 		select DEBUG_UART_8250
 		help
@@ -595,14 +595,14 @@ choice
 		  for Mediatek mt8135 based platforms on UART3.
 
 	config DEBUG_NETX_UART
-		bool "Kernel low-level debugging messages via NetX UART"
+		bool "NetX UART"
 		depends on ARCH_NETX
 		help
 		  Say Y here if you want kernel low-level debugging support
 		  on Hilscher NetX based platforms.
 
 	config DEBUG_NOMADIK_UART
-		bool "Kernel low-level debugging messages via NOMADIK UART"
+		bool "NOMADIK UART"
 		depends on ARCH_NOMADIK
 		select DEBUG_UART_PL01X
 		help
@@ -610,7 +610,7 @@ choice
 		  on NOMADIK based platforms.
 
 	config DEBUG_NSPIRE_CLASSIC_UART
-		bool "Kernel low-level debugging via TI-NSPIRE 8250 UART"
+		bool "TI-NSPIRE 8250 UART"
 		depends on ARCH_NSPIRE
 		select DEBUG_UART_8250
 		help
@@ -618,7 +618,7 @@ choice
 		  on TI-NSPIRE classic models.
 
 	config DEBUG_NSPIRE_CX_UART
-		bool "Kernel low-level debugging via TI-NSPIRE PL011 UART"
+		bool "TI-NSPIRE PL011 UART"
 		depends on ARCH_NSPIRE
 		select DEBUG_UART_PL01X
 		help
@@ -626,7 +626,7 @@ choice
 		  on TI-NSPIRE CX models.
 
 	config DEBUG_OMAP1UART1
-		bool "Kernel low-level debugging via OMAP1 UART1"
+		bool "OMAP1 UART1"
 		depends on ARCH_OMAP1
 		select DEBUG_UART_8250
 		help
@@ -634,7 +634,7 @@ choice
 		  on OMAP1 based platforms (except OMAP730) on the UART1.
 
 	config DEBUG_OMAP1UART2
-		bool "Kernel low-level debugging via OMAP1 UART2"
+		bool "OMAP1 UART2"
 		depends on ARCH_OMAP1
 		select DEBUG_UART_8250
 		help
@@ -642,7 +642,7 @@ choice
 		  on OMAP1 based platforms (except OMAP730) on the UART2.
 
 	config DEBUG_OMAP1UART3
-		bool "Kernel low-level debugging via OMAP1 UART3"
+		bool "OMAP1 UART3"
 		depends on ARCH_OMAP1
 		select DEBUG_UART_8250
 		help
@@ -658,17 +658,17 @@ choice
 		  omap3 torpedo and 3530 lv som.
 
 	config DEBUG_OMAP2UART2
-		bool "Kernel low-level debugging messages via OMAP2/3/4 UART2"
+		bool "OMAP2/3/4 UART2"
 		depends on ARCH_OMAP2PLUS
 		select DEBUG_UART_8250
 
 	config DEBUG_OMAP2UART3
-		bool "Kernel low-level debugging messages via OMAP2 UART3 (n8x0)"
+		bool "OMAP2 UART3 (n8x0)"
 		depends on ARCH_OMAP2PLUS
 		select DEBUG_UART_8250
 
 	config DEBUG_OMAP3UART3
-		bool "Kernel low-level debugging messages via OMAP3 UART3 (most omap3 boards)"
+		bool "OMAP3 UART3 (most omap3 boards)"
 		depends on ARCH_OMAP2PLUS
 		select DEBUG_UART_8250
 		help
@@ -677,22 +677,22 @@ choice
 		  and 3517evm.
 
 	config DEBUG_OMAP4UART3
-		bool "Kernel low-level debugging messages via OMAP4/5 UART3 (omap4 blaze, panda, omap5 sevm)"
+		bool "OMAP4/5 UART3 (omap4 blaze, panda, omap5 sevm)"
 		depends on ARCH_OMAP2PLUS
 		select DEBUG_UART_8250
 
 	config DEBUG_OMAP3UART4
-		bool "Kernel low-level debugging messages via OMAP36XX UART4"
+		bool "OMAP36XX UART4"
 		depends on ARCH_OMAP2PLUS
 		select DEBUG_UART_8250
 
 	config DEBUG_OMAP4UART4
-		bool "Kernel low-level debugging messages via OMAP4/5 UART4"
+		bool "OMAP4/5 UART4"
 		depends on ARCH_OMAP2PLUS
 		select DEBUG_UART_8250
 
 	config DEBUG_OMAP7XXUART1
-		bool "Kernel low-level debugging via OMAP730 UART1"
+		bool "OMAP730 UART1"
 		depends on ARCH_OMAP730
 		select DEBUG_UART_8250
 		help
@@ -700,7 +700,7 @@ choice
 		  on OMAP730 based platforms on the UART1.
 
 	config DEBUG_OMAP7XXUART2
-		bool "Kernel low-level debugging via OMAP730 UART2"
+		bool "OMAP730 UART2"
 		depends on ARCH_OMAP730
 		select DEBUG_UART_8250
 		help
@@ -708,7 +708,7 @@ choice
 		  on OMAP730 based platforms on the UART2.
 
 	config DEBUG_OMAP7XXUART3
-		bool "Kernel low-level debugging via OMAP730 UART3"
+		bool "OMAP730 UART3"
 		depends on ARCH_OMAP730
 		select DEBUG_UART_8250
 		help
@@ -716,33 +716,33 @@ choice
 		  on OMAP730 based platforms on the UART3.
 
 	config DEBUG_TI81XXUART1
-		bool "Kernel low-level debugging messages via TI81XX UART1 (ti8148evm)"
+		bool "TI81XX UART1 (ti8148evm)"
 		depends on ARCH_OMAP2PLUS
 		select DEBUG_UART_8250
 
 	config DEBUG_TI81XXUART2
-		bool "Kernel low-level debugging messages via TI81XX UART2"
+		bool "TI81XX UART2"
 		depends on ARCH_OMAP2PLUS
 		select DEBUG_UART_8250
 
 	config DEBUG_TI81XXUART3
-		bool "Kernel low-level debugging messages via TI81XX UART3 (ti8168evm)"
+		bool "TI81XX UART3 (ti8168evm)"
 		depends on ARCH_OMAP2PLUS
 		select DEBUG_UART_8250
 
 	config DEBUG_AM33XXUART1
-		bool "Kernel low-level debugging messages via AM33XX UART1"
+		bool "AM33XX UART1"
 		depends on ARCH_OMAP2PLUS
 		select DEBUG_UART_8250
 
 	config DEBUG_ZOOM_UART
-		bool "Kernel low-level debugging messages via Zoom2/3 UART"
+		bool "Zoom2/3 UART"
 		depends on ARCH_OMAP2PLUS
 		select DEBUG_OMAP2PLUS_UART
 
 	config DEBUG_PICOXCELL_UART
 		depends on ARCH_PICOXCELL
-		bool "Use PicoXcell UART for low-level debug"
+		bool "PicoXcell UART"
 		select DEBUG_UART_8250
 		help
 		  Say Y here if you want kernel low-level debugging support
@@ -750,14 +750,14 @@ choice
 
 	config DEBUG_PXA_UART1
 		depends on ARCH_PXA
-		bool "Use PXA UART1 for low-level debug"
+		bool "PXA UART1"
 		select DEBUG_UART_8250
 		help
 		  Say Y here if you want kernel low-level debugging support
 		  on PXA UART1.
 
 	config DEBUG_QCOM_UARTDM
-		bool "Kernel low-level debugging messages via QCOM UARTDM"
+		bool "QCOM UARTDM"
 		depends on ARCH_QCOM
 		help
 		  Say Y here if you want the debug print routines to direct
@@ -793,7 +793,7 @@ choice
 		  PB1176 platform.
 
 	config DEBUG_RV1108_UART0
-		bool "Kernel low-level debugging messages via Rockchip RV1108 UART0"
+		bool "Rockchip RV1108 UART0"
 		depends on ARCH_ROCKCHIP
 		select DEBUG_UART_8250
 		help
@@ -801,7 +801,7 @@ choice
                   on Rockchip RV1108 based platforms.
 
 	config DEBUG_RV1108_UART1
-		bool "Kernel low-level debugging messages via Rockchip RV1108 UART1"
+		bool "Rockchip RV1108 UART1"
 		depends on ARCH_ROCKCHIP
 		select DEBUG_UART_8250
 		help
@@ -809,7 +809,7 @@ choice
 		  on Rockchip RV1108 based platforms.
 
 	config DEBUG_RV1108_UART2
-		bool "Kernel low-level debugging messages via Rockchip RV1108 UART2"
+		bool "Rockchip RV1108 UART2"
 		depends on ARCH_ROCKCHIP
 		select DEBUG_UART_8250
 		help
@@ -817,7 +817,7 @@ choice
 		  on Rockchip RV1108 based platforms.
 
 	config DEBUG_RK29_UART0
-		bool "Kernel low-level debugging messages via Rockchip RK29 UART0"
+		bool "Rockchip RK29 UART0"
 		depends on ARCH_ROCKCHIP
 		select DEBUG_UART_8250
 		help
@@ -825,7 +825,7 @@ choice
 		  on Rockchip based platforms.
 
 	config DEBUG_RK29_UART1
-		bool "Kernel low-level debugging messages via Rockchip RK29 UART1"
+		bool "Rockchip RK29 UART1"
 		depends on ARCH_ROCKCHIP
 		select DEBUG_UART_8250
 		help
@@ -833,7 +833,7 @@ choice
 		  on Rockchip based platforms.
 
 	config DEBUG_RK29_UART2
-		bool "Kernel low-level debugging messages via Rockchip RK29 UART2"
+		bool "Rockchip RK29 UART2"
 		depends on ARCH_ROCKCHIP
 		select DEBUG_UART_8250
 		help
@@ -841,7 +841,7 @@ choice
 		  on Rockchip based platforms.
 
 	config DEBUG_RK3X_UART0
-		bool "Kernel low-level debugging messages via Rockchip RK30/RK31 UART0"
+		bool "Rockchip RK30/RK31 UART0"
 		depends on ARCH_ROCKCHIP
 		select DEBUG_UART_8250
 		help
@@ -849,7 +849,7 @@ choice
 		  on Rockchip based platforms.
 
 	config DEBUG_RK3X_UART1
-		bool "Kernel low-level debugging messages via Rockchip RK30/RK31 UART1"
+		bool "Rockchip RK30/RK31 UART1"
 		depends on ARCH_ROCKCHIP
 		select DEBUG_UART_8250
 		help
@@ -857,7 +857,7 @@ choice
 		  on Rockchip based platforms.
 
 	config DEBUG_RK3X_UART2
-		bool "Kernel low-level debugging messages via Rockchip RK30/RK31 UART2"
+		bool "Rockchip RK30/RK31 UART2"
 		depends on ARCH_ROCKCHIP
 		select DEBUG_UART_8250
 		help
@@ -865,7 +865,7 @@ choice
 		  on Rockchip based platforms.
 
 	config DEBUG_RK3X_UART3
-		bool "Kernel low-level debugging messages via Rockchip RK30/RK31 UART3"
+		bool "Rockchip RK30/RK31 UART3"
 		depends on ARCH_ROCKCHIP
 		select DEBUG_UART_8250
 		help
@@ -873,7 +873,7 @@ choice
 		  on Rockchip based platforms.
 
 	config DEBUG_RK32_UART2
-		bool "Kernel low-level debugging messages via Rockchip RK32 UART2"
+		bool "Rockchip RK32 UART2"
 		depends on ARCH_ROCKCHIP
 		select DEBUG_UART_8250
 		help
@@ -881,28 +881,28 @@ choice
 		  on Rockchip RK32xx based platforms.
 
 	config DEBUG_R7S72100_SCIF2
-		bool "Kernel low-level debugging messages via SCIF2 on R7S72100"
+		bool "R7S72100 SCIF2"
 		depends on ARCH_R7S72100
 		help
 		  Say Y here if you want kernel low-level debugging support
 		  via SCIF2 on Renesas RZ/A1H (R7S72100).
 
 	config DEBUG_RCAR_GEN1_SCIF0
-		bool "Kernel low-level debugging messages via SCIF0 on R8A7778"
+		bool "R8A7778 SCIF0"
 		depends on ARCH_R8A7778
 		help
 		  Say Y here if you want kernel low-level debugging support
 		  via SCIF0 on Renesas R-Car M1A (R8A7778).
 
 	config DEBUG_RCAR_GEN1_SCIF2
-		bool "Kernel low-level debugging messages via SCIF2 on R8A7779"
+		bool "R8A7779 SCIF2"
 		depends on ARCH_R8A7779
 		help
 		  Say Y here if you want kernel low-level debugging support
 		  via SCIF2 on Renesas R-Car H1 (R8A7779).
 
 	config DEBUG_RCAR_GEN2_SCIF0
-		bool "Kernel low-level debugging messages via SCIF0 on R-Car Gen2 and RZ/G1"
+		bool "R-Car Gen2 and RZ/G1 SCIF0"
 		depends on ARCH_R8A7743 || ARCH_R8A7790 || ARCH_R8A7791 || \
 			ARCH_R8A7792 || ARCH_R8A7793
 		help
@@ -911,35 +911,35 @@ choice
 		  M2-W (R8A7791), V2H (R8A7792), or M2-N (R8A7793).
 
 	config DEBUG_RCAR_GEN2_SCIF2
-		bool "Kernel low-level debugging messages via SCIF2 on R8A7794"
+		bool "R8A7794 SCIF2"
 		depends on ARCH_R8A7794
 		help
 		  Say Y here if you want kernel low-level debugging support
 		  via SCIF2 on Renesas R-Car E2 (R8A7794).
 
 	config DEBUG_RCAR_GEN2_SCIF4
-		bool "Kernel low-level debugging messages via SCIF4 on R8A7745"
+		bool "R8A7745 SCIF4"
 		depends on ARCH_R8A7745
 		help
 		  Say Y here if you want kernel low-level debugging support
 		  via SCIF4 on Renesas RZ/G1E (R8A7745).
 
 	config DEBUG_RMOBILE_SCIFA0
-		bool "Kernel low-level debugging messages via SCIFA0 on R8A73A4"
+		bool "R8A73A4 SCIFA0"
 		depends on ARCH_R8A73A4
 		help
 		  Say Y here if you want kernel low-level debugging support
 		  via SCIFA0 on Renesas R-Mobile APE6 (R8A73A4).
 
 	config DEBUG_RMOBILE_SCIFA1
-		bool "Kernel low-level debugging messages via SCIFA1 on R8A7740"
+		bool "R8A7740 SCIFA1"
 		depends on ARCH_R8A7740
 		help
 		  Say Y here if you want kernel low-level debugging support
 		  via SCIFA1 on Renesas R-Mobile A1 (R8A7740).
 
 	config DEBUG_RMOBILE_SCIFA4
-		bool "Kernel low-level debugging messages via SCIFA4 on SH73A0"
+		bool "SH73A0 SCIFA4"
 		depends on ARCH_SH73A0
 		help
 		  Say Y here if you want kernel low-level debugging support
@@ -951,7 +951,7 @@ choice
 		select DEBUG_S3C24XX_UART if ARCH_S3C24XX
 		select DEBUG_S3C64XX_UART if ARCH_S3C64XX
 		select DEBUG_S5PV210_UART if ARCH_S5PV210
-		bool "Use Samsung S3C UART 0 for low-level debug"
+		bool "Samsung S3C UART0"
 		help
 		  Say Y here if you want the debug print routines to direct
 		  their output to UART 0. The port must have been initialised
@@ -963,7 +963,7 @@ choice
 		select DEBUG_S3C24XX_UART if ARCH_S3C24XX
 		select DEBUG_S3C64XX_UART if ARCH_S3C64XX
 		select DEBUG_S5PV210_UART if ARCH_S5PV210
-		bool "Use Samsung S3C UART 1 for low-level debug"
+		bool "Samsung S3C UART1"
 		help
 		  Say Y here if you want the debug print routines to direct
 		  their output to UART 1. The port must have been initialised
@@ -975,7 +975,7 @@ choice
 		select DEBUG_S3C24XX_UART if ARCH_S3C24XX
 		select DEBUG_S3C64XX_UART if ARCH_S3C64XX
 		select DEBUG_S5PV210_UART if ARCH_S5PV210
-		bool "Use Samsung S3C UART 2 for low-level debug"
+		bool "Samsung S3C UART2"
 		help
 		  Say Y here if you want the debug print routines to direct
 		  their output to UART 2. The port must have been initialised
@@ -986,7 +986,7 @@ choice
 		select DEBUG_EXYNOS_UART if ARCH_EXYNOS
 		select DEBUG_S3C64XX_UART if ARCH_S3C64XX
 		select DEBUG_S5PV210_UART if ARCH_S5PV210
-		bool "Use Samsung S3C UART 3 for low-level debug"
+		bool "Samsung S3C UART3"
 		help
 		  Say Y here if you want the debug print routines to direct
 		  their output to UART 3. The port must have been initialised
@@ -995,7 +995,7 @@ choice
 	config DEBUG_S3C2410_UART0
 		depends on ARCH_S3C24XX
 		select DEBUG_S3C2410_UART
-		bool "Use S3C2410/S3C2412 UART 0 for low-level debug"
+		bool "S3C2410/S3C2412 UART0"
 		help
 		  Say Y here if you want the debug print routines to direct
 		  their output to UART 0. The port must have been initialised
@@ -1004,7 +1004,7 @@ choice
 	config DEBUG_S3C2410_UART1
 		depends on ARCH_S3C24XX
 		select DEBUG_S3C2410_UART
-		bool "Use S3C2410/S3C2412 UART 1 for low-level debug"
+		bool "S3C2410/S3C2412 UART1"
 		help
 		  Say Y here if you want the debug print routines to direct
 		  their output to UART 1. The port must have been initialised
@@ -1013,7 +1013,7 @@ choice
 	config DEBUG_S3C2410_UART2
 		depends on ARCH_S3C24XX
 		select DEBUG_S3C2410_UART
-		bool "Use S3C2410/S3C2412 UART 2 for low-level debug"
+		bool "S3C2410/S3C2412 UART2"
 		help
 		  Say Y here if you want the debug print routines to direct
 		  their output to UART 2. The port must have been initialised
@@ -1021,7 +1021,7 @@ choice
 
 	config DEBUG_SA1100
 		depends on ARCH_SA1100
-		bool "Use SA1100 UARTs for low-level debug"
+		bool "SA1100 UARTs"
 		help
 		  Say Y here if you want kernel low-level debugging support
 		  on SA-11x0 UART ports. The kernel will check for the first
@@ -1029,7 +1029,7 @@ choice
 
 	config DEBUG_SOCFPGA_UART0
 		depends on ARCH_SOCFPGA
-		bool "Use SOCFPGA UART0 for low-level debug"
+		bool "SOCFPGA UART0"
 		select DEBUG_UART_8250
 		help
 		  Say Y here if you want kernel low-level debugging support
@@ -1037,7 +1037,7 @@ choice
 
 	config DEBUG_SOCFPGA_UART1
 		depends on ARCH_SOCFPGA
-		bool "Use SOCFPGA UART1 for low-level debug"
+		bool "SOCFPGA UART1"
 		select DEBUG_UART_8250
 		help
 		  Say Y here if you want kernel low-level debugging support
@@ -1045,7 +1045,7 @@ choice
 
 
 	config DEBUG_SUN9I_UART0
-		bool "Kernel low-level debugging messages via sun9i UART0"
+		bool "sun9i UART0"
 		depends on MACH_SUN9I
 		select DEBUG_UART_8250
 		help
@@ -1053,7 +1053,7 @@ choice
 		  on Allwinner A80 based platforms on the UART0.
 
 	config DEBUG_SUNXI_UART0
-		bool "Kernel low-level debugging messages via sunXi UART0"
+		bool "sunXi UART0"
 		depends on ARCH_SUNXI
 		select DEBUG_UART_8250
 		help
@@ -1061,7 +1061,7 @@ choice
 		  on Allwinner A1X based platforms on the UART0.
 
 	config DEBUG_SUNXI_UART1
-		bool "Kernel low-level debugging messages via sunXi UART1"
+		bool "sunXi UART1"
 		depends on ARCH_SUNXI
 		select DEBUG_UART_8250
 		help
@@ -1069,7 +1069,7 @@ choice
 		  on Allwinner A1X based platforms on the UART1.
 
 	config DEBUG_SUNXI_R_UART
-		bool "Kernel low-level debugging messages via sunXi R_UART"
+		bool "sunXi R_UART"
 		depends on MACH_SUN6I || MACH_SUN8I
 		select DEBUG_UART_8250
 		help
@@ -1077,7 +1077,7 @@ choice
 		  on Allwinner A31/A23 based platforms on the R_UART.
 
 	config DEBUG_SIRFPRIMA2_UART1
-		bool "Kernel low-level debugging messages via SiRFprimaII UART1"
+		bool "SiRFprimaII UART1"
 		depends on ARCH_PRIMA2
 		select DEBUG_SIRFSOC_UART
 		help
@@ -1085,7 +1085,7 @@ choice
 		  their output to the uart1 port on SiRFprimaII devices.
 
 	config DEBUG_SIRFATLAS7_UART0
-		bool "Kernel low-level debugging messages via SiRFatlas7 UART0"
+		bool "SiRFatlas7 UART0"
 		depends on ARCH_ATLAS7
 		select DEBUG_SIRFSOC_UART
 		help
@@ -1095,7 +1095,7 @@ choice
 		  debug port can be very useful.
 
 	config DEBUG_SIRFATLAS7_UART1
-		bool "Kernel low-level debugging messages via SiRFatlas7 UART1"
+		bool "SiRFatlas7 UART1"
 		depends on ARCH_ATLAS7
 		select DEBUG_SIRFSOC_UART
 		help
@@ -1103,7 +1103,7 @@ choice
 		  their output to the uart1 port on SiRFATLAS7 devices.
 
 	config DEBUG_SPEAR3XX
-		bool "Kernel low-level debugging messages via ST SPEAr 3xx/6xx UART"
+		bool "ST SPEAr 3xx/6xx UART"
 		depends on ARCH_SPEAR3XX || ARCH_SPEAR6XX
 		select DEBUG_UART_PL01X
 		help
@@ -1111,7 +1111,7 @@ choice
 		  on ST SPEAr based platforms.
 
 	config DEBUG_SPEAR13XX
-		bool "Kernel low-level debugging messages via ST SPEAr 13xx UART"
+		bool "ST SPEAr 13xx UART"
 		depends on ARCH_SPEAR13XX
 		select DEBUG_UART_PL01X
 		help
@@ -1119,7 +1119,7 @@ choice
 		  on ST SPEAr13xx based platforms.
 
 	config STIH41X_DEBUG_ASC2
-		bool "Use StiH415/416 ASC2 UART for low-level debug"
+		bool "StiH415/416 ASC2 UART"
 		depends on ARCH_STI
 		select DEBUG_STI_UART
 		help
@@ -1130,7 +1130,7 @@ choice
 		  If unsure, say N.
 
 	config STIH41X_DEBUG_SBC_ASC1
-		bool "Use StiH415/416 SBC ASC1 UART for low-level debug"
+		bool "StiH415/416 SBC ASC1 UART"
 		depends on ARCH_STI
 		select DEBUG_STI_UART
 		help
@@ -1141,7 +1141,7 @@ choice
 		  If unsure, say N.
 
 	config TEGRA_DEBUG_UART_AUTO_ODMDATA
-		bool "Kernel low-level debugging messages via Tegra UART via ODMDATA"
+		bool "Tegra UART via ODMDATA"
 		depends on ARCH_TEGRA
 		select DEBUG_TEGRA_UART
 		help
@@ -1153,7 +1153,7 @@ choice
 		  are UART A/B/C/D/E.
 
 	config TEGRA_DEBUG_UARTA
-		bool "Kernel low-level debugging messages via Tegra UART A"
+		bool "Tegra UART A"
 		depends on ARCH_TEGRA
 		select DEBUG_TEGRA_UART
 		help
@@ -1161,7 +1161,7 @@ choice
 		  on Tegra based platforms.
 
 	config TEGRA_DEBUG_UARTB
-		bool "Kernel low-level debugging messages via Tegra UART B"
+		bool "Tegra UART B"
 		depends on ARCH_TEGRA
 		select DEBUG_TEGRA_UART
 		help
@@ -1169,7 +1169,7 @@ choice
 		  on Tegra based platforms.
 
 	config TEGRA_DEBUG_UARTC
-		bool "Kernel low-level debugging messages via Tegra UART C"
+		bool "Tegra UART C"
 		depends on ARCH_TEGRA
 		select DEBUG_TEGRA_UART
 		help
@@ -1177,7 +1177,7 @@ choice
 		  on Tegra based platforms.
 
 	config TEGRA_DEBUG_UARTD
-		bool "Kernel low-level debugging messages via Tegra UART D"
+		bool "Tegra UART D"
 		depends on ARCH_TEGRA
 		select DEBUG_TEGRA_UART
 		help
@@ -1185,7 +1185,7 @@ choice
 		  on Tegra based platforms.
 
 	config TEGRA_DEBUG_UARTE
-		bool "Kernel low-level debugging messages via Tegra UART E"
+		bool "Tegra UART E"
 		depends on ARCH_TEGRA
 		select DEBUG_TEGRA_UART
 		help
@@ -1193,7 +1193,7 @@ choice
 		  on Tegra based platforms.
 
 	config DEBUG_U300_UART
-		bool "Kernel low-level debugging messages via U300 UART0"
+		bool "U300 UART0"
 		depends on ARCH_U300
 		select DEBUG_UART_PL01X
 		help
@@ -1202,13 +1202,13 @@ choice
 
 	config DEBUG_UX500_UART
 		depends on ARCH_U8500
-		bool "Use Ux500 UART for low-level debug"
+		bool "Ux500 UART"
 		help
 		  Say Y here if you want kernel low-level debugging support
 		  on Ux500 based platforms.
 
 	config DEBUG_VERSATILE
-		bool "Kernel low-level debugging messages via ARM Versatile UART"
+		bool "ARM Versatile UART"
 		depends on ARCH_VERSATILE
 		select DEBUG_UART_PL01X
 		help
@@ -1259,7 +1259,7 @@ choice
 		  on Vybrid based platforms.
 
 	config DEBUG_VT8500_UART0
-		bool "Use UART0 on VIA/Wondermedia SoCs"
+		bool "VIA/Wondermedia UART0"
 		depends on ARCH_VT8500
 		help
 		  This option selects UART0 on VIA/Wondermedia System-on-a-chip
@@ -1278,14 +1278,14 @@ choice
 		  and will be soon removed.
 
 	config DEBUG_ZYNQ_UART0
-		bool "Kernel low-level debugging on Xilinx Zynq using UART0"
+		bool "Xilinx Zynq UART0"
 		depends on ARCH_ZYNQ
 		help
 		  Say Y here if you want the debug print routines to direct
 		  their output to UART0 on the Zynq platform.
 
 	config DEBUG_ZYNQ_UART1
-		bool "Kernel low-level debugging on Xilinx Zynq using UART1"
+		bool "Xilinx Zynq UART1"
 		depends on ARCH_ZYNQ
 		help
 		  Say Y here if you want the debug print routines to direct
@@ -1295,7 +1295,7 @@ choice
 		  appear on the USB serial adaptor, select this option.
 
 	config DEBUG_ICEDCC
-		bool "Kernel low-level debugging via EmbeddedICE DCC channel"
+		bool "EmbeddedICE DCC channel"
 		help
 		  Say Y here if you want the debug print routines to direct
 		  their output to the EmbeddedICE macrocell's DCC channel using
@@ -1306,7 +1306,7 @@ choice
 		  is nothing connected to read from the DCC.
 
 	config DEBUG_SEMIHOSTING
-		bool "Kernel low-level debug output via semihosting I/O"
+		bool "Semihosting I/O"
 		help
 		  Semihosting enables code running on an ARM target to use
 		  the I/O facilities on a host debugger/emulator through a
@@ -1322,7 +1322,7 @@ choice
 		  chapter 8 of DUI0203I_rvct_developer_guide.pdf from ARM Ltd.
 
 	config DEBUG_LL_UART_8250
-		bool "Kernel low-level debugging via 8250 UART"
+		bool "8250 UART"
 		help
 		  Say Y here if you wish the debug print routes to direct
 		  their output to an 8250 UART.  You can use this option
@@ -1335,7 +1335,7 @@ choice
 		  and will be soon removed.
 
 	config DEBUG_LL_UART_EFM32
-		bool "Kernel low-level debugging via efm32 UART"
+		bool "efm32 UART"
 		depends on ARCH_EFM32
 		help
 		  Say Y here if you want the debug print routines to direct
@@ -1349,7 +1349,7 @@ choice
 		    0x4000e400 | UART1
 
 	config DEBUG_LL_UART_PL01X
-		bool "Kernel low-level debugging via ARM Ltd PL01x Primecell UART"
+		bool "ARM Ltd PL01x Primecell UART"
 		help
 		  Say Y here if you wish the debug print routes to direct
 		  their output to a PL01x Primecell UART.  You can use
