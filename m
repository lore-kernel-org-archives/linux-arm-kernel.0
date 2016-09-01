From: domenico.andreoli@linux.com (Domenico Andreoli)
Date: Thu, 1 Sep 2016 13:37:47 +0200
Subject: [PATCH] arm: tidy up DEBUG_LL list
Message-ID: <20160901113747.GA6117@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kernel low-level debugging configuration on ARM sports a long list of
options, many of these predating the multi-architecture age when each
was on its own. As a result the list is not readable at its best.

This patch attempts to tidy up things, exposing only the significant
information.

Signed-off-by: Domenico Andreoli <domenico.andreoli@linux.com>
---
 arch/arm/Kconfig.debug |  240 ++++++++++++++++++++++++------------------------
 1 file changed, 120 insertions(+), 120 deletions(-)

Index: b/arch/arm/Kconfig.debug
===================================================================
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -81,7 +81,7 @@ choice
 	depends on DEBUG_LL
 
 	config DEBUG_ALPINE_UART0
-		bool "Kernel low-level debugging messages via Alpine UART0"
+		bool "Alpine UART0"
 		depends on ARCH_ALPINE
 		select DEBUG_UART_8250
 		help
@@ -89,7 +89,7 @@ choice
 		  on Alpine based platforms.
 
 	config DEBUG_ASM9260_UART
-		bool "Kernel low-level debugging via asm9260 UART"
+		bool "asm9260 UART"
 		depends on MACH_ASM9260
 		help
 		  Say Y here if you want the debug print routines to direct
@@ -110,7 +110,7 @@ choice
 		    0x80024000      | 0xf0024000     | UART9
 
 	config DEBUG_AT91_RM9200_DBGU
-		bool "Kernel low-level debugging on AT91RM9200, AT91SAM9 DBGU"
+		bool "AT91RM9200, AT91SAM9 DBGU"
 		select DEBUG_AT91_UART
 		depends on SOC_AT91RM9200 || SOC_AT91SAM9
 		help
@@ -120,7 +120,7 @@ choice
 		    at91sam9g10, at91sam9n12, at91sam9rl64, at91sam9x5
 
 	config DEBUG_AT91_SAM9263_DBGU
-		bool "Kernel low-level debugging on AT91SAM{9263,9G45,A5D3} DBGU"
+		bool "AT91SAM{9263,9G45,A5D3} DBGU"
 		select DEBUG_AT91_UART
 		depends on SOC_AT91SAM9 || SOC_SAMA5D3
 		help
@@ -130,7 +130,7 @@ choice
 		    sama5d3
 
 	config DEBUG_AT91_SAMA5D2_UART1
-		bool "Kernel low-level debugging on SAMA5D2 UART1"
+		bool "AT91SAMA5D2 UART1"
 		select DEBUG_AT91_UART
 		depends on SOC_SAMA5D2
 		help
@@ -138,7 +138,7 @@ choice
 		  on the UART1 port of sama5d2.
 
 	config DEBUG_AT91_SAMA5D4_USART3
-		bool "Kernel low-level debugging on SAMA5D4 USART3"
+		bool "AT91SAMA5D4 USART3"
 		select DEBUG_AT91_UART
 		depends on SOC_SAMA5D4
 		help
@@ -146,22 +146,22 @@ choice
 		  on the USART3 port of sama5d4.
 
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
 
 	config DEBUG_BCM_KONA_UART
-		bool "Kernel low-level debugging messages via BCM KONA UART"
+		bool "BCM KONA UART"
 		depends on ARCH_BCM_MOBILE
 		select DEBUG_UART_8250
 		help
@@ -172,11 +172,11 @@ choice
 		  bcm11351, etc...)
 
 	config DEBUG_BCM63XX_UART
-		bool "Kernel low-level debugging on BCM63XX UART"
+		bool "BCM63XX UART"
 		depends on ARCH_BCM_63XX
 
 	config DEBUG_BERLIN_UART
-		bool "Marvell Berlin SoC Debug UART"
+		bool "Marvell Berlin Debug UART"
 		depends on ARCH_BERLIN
 		select DEBUG_UART_8250
 		help
@@ -184,7 +184,7 @@ choice
 		  on Marvell Berlin SoC based platforms.
 
 	config DEBUG_BRCMSTB_UART
-		bool "Use BRCMSTB UART for low-level debug"
+		bool "BRCMSTB UART"
 		depends on ARCH_BRCMSTB
 		select DEBUG_UART_8250
 		help
@@ -195,21 +195,21 @@ choice
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
@@ -217,7 +217,7 @@ choice
                   their output to the CNS3xxx UART0.
 
 	config DEBUG_DAVINCI_DA8XX_UART1
-		bool "Kernel low-level debugging on DaVinci DA8XX using UART1"
+		bool "DaVinci DA8XX UART1"
 		depends on ARCH_DAVINCI_DA8XX
 		select DEBUG_UART_8250
 		help
@@ -225,7 +225,7 @@ choice
 		  their output to UART1 serial port on DaVinci DA8XX devices.
 
 	config DEBUG_DAVINCI_DA8XX_UART2
-		bool "Kernel low-level debugging on DaVinci DA8XX using UART2"
+		bool "DaVinci DA8XX UART2"
 		depends on ARCH_DAVINCI_DA8XX
 		select DEBUG_UART_8250
 		help
@@ -233,7 +233,7 @@ choice
 		  their output to UART2 serial port on DaVinci DA8XX devices.
 
 	config DEBUG_DAVINCI_DMx_UART0
-		bool "Kernel low-level debugging on DaVinci DMx using UART0"
+		bool "DaVinci DMx UART0"
 		depends on ARCH_DAVINCI_DMx
 		select DEBUG_UART_8250
 		help
@@ -241,21 +241,21 @@ choice
 		  their output to UART0 serial port on DaVinci DMx devices.
 
 	config DEBUG_DC21285_PORT
-		bool "Kernel low-level debugging messages via footbridge serial port"
+		bool "Footbridge serial port"
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
@@ -263,7 +263,7 @@ choice
 		  on Cirrus Logic EP93xx based platforms.
 
 	config DEBUG_FOOTBRIDGE_COM1
-		bool "Kernel low-level debugging messages via footbridge 8250 at PCI COM1"
+		bool "footbridge 8250 COM1"
 		depends on FOOTBRIDGE
 		select DEBUG_UART_8250
 		help
@@ -271,7 +271,7 @@ choice
 		  their output to the 8250 at PCI COM1.
 
 	config DEBUG_GEMINI
-		bool "Kernel low-level debugging messages via Cortina Systems Gemini UART"
+		bool "Cortina Systems Gemini UART"
 		depends on ARCH_GEMINI
 		select DEBUG_UART_8250
 		help
@@ -287,7 +287,7 @@ choice
 		  on HI3620 UART.
 
 	config DEBUG_HIGHBANK_UART
-		bool "Kernel low-level debugging messages via Highbank UART"
+		bool "Highbank UART"
 		depends on ARCH_HIGHBANK
 		select DEBUG_UART_PL01X
 		help
@@ -295,7 +295,7 @@ choice
 		  their output to the UART on Highbank based devices.
 
 	config DEBUG_HIP01_UART
-		bool "Hisilicon Hip01 Debug UART"
+		bool "Hisilicon HIP01 Debug UART"
 		depends on ARCH_HIP01
 		select DEBUG_UART_8250
 		help
@@ -303,7 +303,7 @@ choice
 		  on HIP01 UART.
 
 	config DEBUG_HIP04_UART
-		bool "Hisilicon HiP04 Debug UART"
+		bool "Hisilicon HIP04 Debug UART"
 		depends on ARCH_HIP04
 		select DEBUG_UART_8250
 		help
@@ -426,7 +426,7 @@ choice
 		  on i.MX7D.
 
 	config DEBUG_INTEGRATOR
-		bool "Kernel low-level debugging messages via ARM Integrator UART"
+		bool "ARM Integrator UART"
 		depends on ARCH_INTEGRATOR
 		select DEBUG_UART_PL01X
 		help
@@ -434,7 +434,7 @@ choice
 		  on ARM Integrator platforms.
 
 	config DEBUG_KEYSTONE_UART0
-		bool "Kernel low-level debugging on KEYSTONE2 using UART0"
+		bool "KEYSTONE2 UART0"
 		depends on ARCH_KEYSTONE
 		select DEBUG_UART_8250
 		help
@@ -442,7 +442,7 @@ choice
 		  their output to UART0 serial port on KEYSTONE2 devices.
 
 	config DEBUG_KEYSTONE_UART1
-		bool "Kernel low-level debugging on KEYSTONE2 using UART1"
+		bool "KEYSTONE2 UART1"
 		depends on ARCH_KEYSTONE
 		select DEBUG_UART_8250
 		help
@@ -457,7 +457,7 @@ choice
 		  on KS8695.
 
 	config DEBUG_LPC18XX_UART0
-		bool "Kernel low-level debugging via LPC18xx/43xx UART0"
+		bool "LPC18xx/43xx UART0"
 		depends on ARCH_LPC18XX
 		select DEBUG_UART_8250
 		help
@@ -465,7 +465,7 @@ choice
 		  on NXP LPC18xx/43xx UART0.
 
 	config DEBUG_LPC32XX
-		bool "Kernel low-level debugging messages via NXP LPC32xx UART"
+		bool "NXP LPC32xx UART"
 		depends on ARCH_LPC32XX
 		select DEBUG_UART_8250
 		help
@@ -473,14 +473,14 @@ choice
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
@@ -488,7 +488,7 @@ choice
 		  on MMP UART2.
 
 	config DEBUG_MMP_UART3
-		bool "Kernel low-level debugging message via MMP UART3"
+		bool "MMP UART3"
 		depends on ARCH_MMP
 		select DEBUG_UART_8250
 		help
@@ -496,7 +496,7 @@ choice
 		  on MMP UART3.
 
 	config DEBUG_MVEBU_UART0
-		bool "Kernel low-level debugging messages via MVEBU UART0 (old bootloaders)"
+		bool "MVEBU UART0 (old bootloaders)"
 		depends on ARCH_MVEBU
 		depends on ARCH_MVEBU && CPU_V7
 		select DEBUG_UART_8250
@@ -520,7 +520,7 @@ choice
 		  silently crashes, with no serial output at all.
 
 	config DEBUG_MVEBU_UART0_ALTERNATE
-		bool "Kernel low-level debugging messages via MVEBU UART0 (new bootloaders)"
+		bool "MVEBU UART0 (new bootloaders)"
 		depends on ARCH_MVEBU || ARCH_DOVE || ARCH_MV78XX0 || ARCH_ORION5X
 		select DEBUG_UART_8250
 		help
@@ -537,7 +537,7 @@ choice
 		  silently crashes, with no serial output at all.
 
 	config DEBUG_MVEBU_UART1_ALTERNATE
-		bool "Kernel low-level debugging messages via MVEBU UART1 (new bootloaders)"
+		bool "MVEBU UART1 (new bootloaders)"
 		depends on ARCH_MVEBU
 		select DEBUG_UART_8250
 		help
@@ -579,14 +579,14 @@ choice
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
@@ -594,7 +594,7 @@ choice
 		  on NOMADIK based platforms.
 
 	config DEBUG_NSPIRE_CLASSIC_UART
-		bool "Kernel low-level debugging via TI-NSPIRE 8250 UART"
+		bool "TI-NSPIRE 8250 UART"
 		depends on ARCH_NSPIRE
 		select DEBUG_UART_8250
 		help
@@ -602,7 +602,7 @@ choice
 		  on TI-NSPIRE classic models.
 
 	config DEBUG_NSPIRE_CX_UART
-		bool "Kernel low-level debugging via TI-NSPIRE PL011 UART"
+		bool "TI-NSPIRE PL011 UART"
 		depends on ARCH_NSPIRE
 		select DEBUG_UART_PL01X
 		help
@@ -610,7 +610,7 @@ choice
 		  on TI-NSPIRE CX models.
 
 	config DEBUG_OMAP1UART1
-		bool "Kernel low-level debugging via OMAP1 UART1"
+		bool "OMAP1 UART1"
 		depends on ARCH_OMAP1
 		select DEBUG_UART_8250
 		help
@@ -618,7 +618,7 @@ choice
 		  on OMAP1 based platforms (except OMAP730) on the UART1.
 
 	config DEBUG_OMAP1UART2
-		bool "Kernel low-level debugging via OMAP1 UART2"
+		bool "OMAP1 UART2"
 		depends on ARCH_OMAP1
 		select DEBUG_UART_8250
 		help
@@ -626,7 +626,7 @@ choice
 		  on OMAP1 based platforms (except OMAP730) on the UART2.
 
 	config DEBUG_OMAP1UART3
-		bool "Kernel low-level debugging via OMAP1 UART3"
+		bool "OMAP1 UART3"
 		depends on ARCH_OMAP1
 		select DEBUG_UART_8250
 		help
@@ -642,17 +642,17 @@ choice
 		  omap3 torpedo and 3530 lv som.
 
 	config DEBUG_OMAP2UART2
-		bool "Kernel low-level debugging messages via OMAP2/3/4 UART2"
+		bool "OMAP2/3/4 UART2"
 		depends on ARCH_OMAP2PLUS
 		select DEBUG_OMAP2PLUS_UART
 
 	config DEBUG_OMAP2UART3
-		bool "Kernel low-level debugging messages via OMAP2 UART3 (n8x0)"
+		bool "OMAP2 UART3 (n8x0)"
 		depends on ARCH_OMAP2PLUS
 		select DEBUG_OMAP2PLUS_UART
 
 	config DEBUG_OMAP3UART3
-		bool "Kernel low-level debugging messages via OMAP3 UART3 (most omap3 boards)"
+		bool "OMAP3 UART3 (most omap3 boards)"
 		depends on ARCH_OMAP2PLUS
 		select DEBUG_OMAP2PLUS_UART
 		help
@@ -661,22 +661,22 @@ choice
 		  and 3517evm.
 
 	config DEBUG_OMAP4UART3
-		bool "Kernel low-level debugging messages via OMAP4/5 UART3 (omap4 blaze, panda, omap5 sevm)"
+		bool "OMAP4/5 UART3 (omap4 blaze, panda, omap5 sevm)"
 		depends on ARCH_OMAP2PLUS
 		select DEBUG_OMAP2PLUS_UART
 
 	config DEBUG_OMAP3UART4
-		bool "Kernel low-level debugging messages via OMAP36XX UART4"
+		bool "OMAP36XX UART4"
 		depends on ARCH_OMAP2PLUS
 		select DEBUG_OMAP2PLUS_UART
 
 	config DEBUG_OMAP4UART4
-		bool "Kernel low-level debugging messages via OMAP4/5 UART4"
+		bool "OMAP4/5 UART4"
 		depends on ARCH_OMAP2PLUS
 		select DEBUG_OMAP2PLUS_UART
 
 	config DEBUG_OMAP7XXUART1
-		bool "Kernel low-level debugging via OMAP730 UART1"
+		bool "OMAP730 UART1"
 		depends on ARCH_OMAP730
 		select DEBUG_UART_8250
 		help
@@ -684,7 +684,7 @@ choice
 		  on OMAP730 based platforms on the UART1.
 
 	config DEBUG_OMAP7XXUART2
-		bool "Kernel low-level debugging via OMAP730 UART2"
+		bool "OMAP730 UART2"
 		depends on ARCH_OMAP730
 		select DEBUG_UART_8250
 		help
@@ -692,7 +692,7 @@ choice
 		  on OMAP730 based platforms on the UART2.
 
 	config DEBUG_OMAP7XXUART3
-		bool "Kernel low-level debugging via OMAP730 UART3"
+		bool "OMAP730 UART3"
 		depends on ARCH_OMAP730
 		select DEBUG_UART_8250
 		help
@@ -700,48 +700,48 @@ choice
 		  on OMAP730 based platforms on the UART3.
 
 	config DEBUG_TI81XXUART1
-		bool "Kernel low-level debugging messages via TI81XX UART1 (ti8148evm)"
+		bool "TI81XX UART1 (ti8148evm)"
 		depends on ARCH_OMAP2PLUS
 		select DEBUG_OMAP2PLUS_UART
 
 	config DEBUG_TI81XXUART2
-		bool "Kernel low-level debugging messages via TI81XX UART2"
+		bool "TI81XX UART2"
 		depends on ARCH_OMAP2PLUS
 		select DEBUG_OMAP2PLUS_UART
 
 	config DEBUG_TI81XXUART3
-		bool "Kernel low-level debugging messages via TI81XX UART3 (ti8168evm)"
+		bool "TI81XX UART3 (ti8168evm)"
 		depends on ARCH_OMAP2PLUS
 		select DEBUG_OMAP2PLUS_UART
 
 	config DEBUG_AM33XXUART1
-		bool "Kernel low-level debugging messages via AM33XX UART1"
+		bool "AM33XX UART1"
 		depends on ARCH_OMAP2PLUS
 		select DEBUG_OMAP2PLUS_UART
 
 	config DEBUG_ZOOM_UART
-		bool "Kernel low-level debugging messages via Zoom2/3 UART"
+		bool "Zoom2/3 UART"
 		depends on ARCH_OMAP2PLUS
 		select DEBUG_OMAP2PLUS_UART
 
 	config DEBUG_PICOXCELL_UART
+		bool "PicoXcell UART"
 		depends on ARCH_PICOXCELL
-		bool "Use PicoXcell UART for low-level debug"
 		select DEBUG_UART_8250
 		help
 		  Say Y here if you want kernel low-level debugging support
 		  on PicoXcell based platforms.
 
 	config DEBUG_PXA_UART1
+		bool "PXA UART1"
 		depends on ARCH_PXA
-		bool "Use PXA UART1 for low-level debug"
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
@@ -776,7 +776,7 @@ choice
 		  PB1176 platform.
 
 	config DEBUG_RK29_UART0
-		bool "Kernel low-level debugging messages via Rockchip RK29 UART0"
+		bool "Rockchip RK29 UART0"
 		depends on ARCH_ROCKCHIP
 		select DEBUG_UART_8250
 		help
@@ -784,7 +784,7 @@ choice
 		  on Rockchip based platforms.
 
 	config DEBUG_RK29_UART1
-		bool "Kernel low-level debugging messages via Rockchip RK29 UART1"
+		bool "Rockchip RK29 UART1"
 		depends on ARCH_ROCKCHIP
 		select DEBUG_UART_8250
 		help
@@ -792,7 +792,7 @@ choice
 		  on Rockchip based platforms.
 
 	config DEBUG_RK29_UART2
-		bool "Kernel low-level debugging messages via Rockchip RK29 UART2"
+		bool "Rockchip RK29 UART2"
 		depends on ARCH_ROCKCHIP
 		select DEBUG_UART_8250
 		help
@@ -800,7 +800,7 @@ choice
 		  on Rockchip based platforms.
 
 	config DEBUG_RK3X_UART0
-		bool "Kernel low-level debugging messages via Rockchip RK30/RK31 UART0"
+		bool "Rockchip RK30/RK31 UART0"
 		depends on ARCH_ROCKCHIP
 		select DEBUG_UART_8250
 		help
@@ -808,7 +808,7 @@ choice
 		  on Rockchip based platforms.
 
 	config DEBUG_RK3X_UART1
-		bool "Kernel low-level debugging messages via Rockchip RK30/RK31 UART1"
+		bool "Rockchip RK30/RK31 UART1"
 		depends on ARCH_ROCKCHIP
 		select DEBUG_UART_8250
 		help
@@ -816,7 +816,7 @@ choice
 		  on Rockchip based platforms.
 
 	config DEBUG_RK3X_UART2
-		bool "Kernel low-level debugging messages via Rockchip RK30/RK31 UART2"
+		bool "Rockchip RK30/RK31 UART2"
 		depends on ARCH_ROCKCHIP
 		select DEBUG_UART_8250
 		help
@@ -824,7 +824,7 @@ choice
 		  on Rockchip based platforms.
 
 	config DEBUG_RK3X_UART3
-		bool "Kernel low-level debugging messages via Rockchip RK30/RK31 UART3"
+		bool "Rockchip RK30/RK31 UART3"
 		depends on ARCH_ROCKCHIP
 		select DEBUG_UART_8250
 		help
@@ -832,7 +832,7 @@ choice
 		  on Rockchip based platforms.
 
 	config DEBUG_RK32_UART2
-		bool "Kernel low-level debugging messages via Rockchip RK32 UART2"
+		bool "Rockchip RK32 UART2"
 		depends on ARCH_ROCKCHIP
 		select DEBUG_UART_8250
 		help
@@ -840,28 +840,28 @@ choice
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
-		bool "Kernel low-level debugging messages via SCIF0 on R8A7790/R8A7791/R8A7793"
+		bool "R8A7790/R8A7791/R8A7793 SCIF0"
 		depends on ARCH_R8A7790 || ARCH_R8A7791 || ARCH_R8A7793
 		help
 		  Say Y here if you want kernel low-level debugging support
@@ -869,126 +869,126 @@ choice
 		  M2-N (R8A7793).
 
 	config DEBUG_RCAR_GEN2_SCIF2
-		bool "Kernel low-level debugging messages via SCIF2 on R8A7794"
+		bool "R8A7794 SCIF2"
 		depends on ARCH_R8A7794
 		help
 		  Say Y here if you want kernel low-level debugging support
 		  via SCIF2 on Renesas R-Car E2 (R8A7794).
 
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
 		  via SCIFA4 on Renesas SH-Mobile AG5 (SH73A0).
 
 	config DEBUG_S3C_UART0
+		bool "S3C UART0"
 		depends on PLAT_SAMSUNG
 		select DEBUG_EXYNOS_UART if ARCH_EXYNOS
 		select DEBUG_S3C24XX_UART if ARCH_S3C24XX
 		select DEBUG_S3C64XX_UART if ARCH_S3C64XX
 		select DEBUG_S5PV210_UART if ARCH_S5PV210
-		bool "Use Samsung S3C UART 0 for low-level debug"
 		help
 		  Say Y here if you want the debug print routines to direct
 		  their output to UART 0. The port must have been initialised
 		  by the boot-loader before use.
 
 	config DEBUG_S3C_UART1
+		bool "S3C UART1"
 		depends on PLAT_SAMSUNG
 		select DEBUG_EXYNOS_UART if ARCH_EXYNOS
 		select DEBUG_S3C24XX_UART if ARCH_S3C24XX
 		select DEBUG_S3C64XX_UART if ARCH_S3C64XX
 		select DEBUG_S5PV210_UART if ARCH_S5PV210
-		bool "Use Samsung S3C UART 1 for low-level debug"
 		help
 		  Say Y here if you want the debug print routines to direct
 		  their output to UART 1. The port must have been initialised
 		  by the boot-loader before use.
 
 	config DEBUG_S3C_UART2
+		bool "S3C UART2"
 		depends on PLAT_SAMSUNG
 		select DEBUG_EXYNOS_UART if ARCH_EXYNOS
 		select DEBUG_S3C24XX_UART if ARCH_S3C24XX
 		select DEBUG_S3C64XX_UART if ARCH_S3C64XX
 		select DEBUG_S5PV210_UART if ARCH_S5PV210
-		bool "Use Samsung S3C UART 2 for low-level debug"
 		help
 		  Say Y here if you want the debug print routines to direct
 		  their output to UART 2. The port must have been initialised
 		  by the boot-loader before use.
 
 	config DEBUG_S3C_UART3
+		bool "S3C UART3"
 		depends on PLAT_SAMSUNG && (ARCH_EXYNOS || ARCH_S5PV210)
 		select DEBUG_EXYNOS_UART if ARCH_EXYNOS
 		select DEBUG_S3C64XX_UART if ARCH_S3C64XX
 		select DEBUG_S5PV210_UART if ARCH_S5PV210
-		bool "Use Samsung S3C UART 3 for low-level debug"
 		help
 		  Say Y here if you want the debug print routines to direct
 		  their output to UART 3. The port must have been initialised
 		  by the boot-loader before use.
 
 	config DEBUG_S3C2410_UART0
+		bool "S3C2410/S3C2412 UART0"
 		depends on ARCH_S3C24XX
 		select DEBUG_S3C2410_UART
-		bool "Use S3C2410/S3C2412 UART 0 for low-level debug"
 		help
 		  Say Y here if you want the debug print routines to direct
 		  their output to UART 0. The port must have been initialised
 		  by the boot-loader before use.
 
 	config DEBUG_S3C2410_UART1
+		bool "S3C2410/S3C2412 UART1"
 		depends on ARCH_S3C24XX
 		select DEBUG_S3C2410_UART
-		bool "Use S3C2410/S3C2412 UART 1 for low-level debug"
 		help
 		  Say Y here if you want the debug print routines to direct
 		  their output to UART 1. The port must have been initialised
 		  by the boot-loader before use.
 
 	config DEBUG_S3C2410_UART2
+		bool "S3C2410/S3C2412 UART2"
 		depends on ARCH_S3C24XX
 		select DEBUG_S3C2410_UART
-		bool "Use S3C2410/S3C2412 UART 2 for low-level debug"
 		help
 		  Say Y here if you want the debug print routines to direct
 		  their output to UART 2. The port must have been initialised
 		  by the boot-loader before use.
 
 	config DEBUG_SA1100
+		bool "SA1100 UARTs"
 		depends on ARCH_SA1100
-		bool "Use SA1100 UARTs for low-level debug"
 		help
 		  Say Y here if you want kernel low-level debugging support
 		  on SA-11x0 UART ports. The kernel will check for the first
 		  enabled UART in a sequence 3-1-2.
 
 	config DEBUG_SOCFPGA_UART0
+		bool "SOCFPGA UART0"
 		depends on ARCH_SOCFPGA
-		bool "Use SOCFPGA UART0 for low-level debug"
 		select DEBUG_UART_8250
 		help
 		  Say Y here if you want kernel low-level debugging support
 		  on SOCFPGA(Cyclone 5 and Arria 5) based platforms.
 
 	config DEBUG_SOCFPGA_UART1
+		bool "SOCFPGA UART1"
 		depends on ARCH_SOCFPGA
-		bool "Use SOCFPGA UART1 for low-level debug"
 		select DEBUG_UART_8250
 		help
 		  Say Y here if you want kernel low-level debugging support
@@ -996,7 +996,7 @@ choice
 
 
 	config DEBUG_SUN9I_UART0
-		bool "Kernel low-level debugging messages via sun9i UART0"
+		bool "sun9i UART0"
 		depends on MACH_SUN9I
 		select DEBUG_UART_8250
 		help
@@ -1004,7 +1004,7 @@ choice
 		  on Allwinner A80 based platforms on the UART0.
 
 	config DEBUG_SUNXI_UART0
-		bool "Kernel low-level debugging messages via sunXi UART0"
+		bool "sunXi UART0"
 		depends on ARCH_SUNXI
 		select DEBUG_UART_8250
 		help
@@ -1012,7 +1012,7 @@ choice
 		  on Allwinner A1X based platforms on the UART0.
 
 	config DEBUG_SUNXI_UART1
-		bool "Kernel low-level debugging messages via sunXi UART1"
+		bool "sunXi UART1"
 		depends on ARCH_SUNXI
 		select DEBUG_UART_8250
 		help
@@ -1020,7 +1020,7 @@ choice
 		  on Allwinner A1X based platforms on the UART1.
 
 	config DEBUG_SUNXI_R_UART
-		bool "Kernel low-level debugging messages via sunXi R_UART"
+		bool "sunXi R_UART"
 		depends on MACH_SUN6I || MACH_SUN8I
 		select DEBUG_UART_8250
 		help
@@ -1028,7 +1028,7 @@ choice
 		  on Allwinner A31/A23 based platforms on the R_UART.
 
 	config DEBUG_SIRFPRIMA2_UART1
-		bool "Kernel low-level debugging messages via SiRFprimaII UART1"
+		bool "SiRFprimaII UART1"
 		depends on ARCH_PRIMA2
 		select DEBUG_SIRFSOC_UART
 		help
@@ -1036,7 +1036,7 @@ choice
 		  their output to the uart1 port on SiRFprimaII devices.
 
 	config DEBUG_SIRFATLAS7_UART0
-		bool "Kernel low-level debugging messages via SiRFatlas7 UART0"
+		bool "SiRFatlas7 UART0"
 		depends on ARCH_ATLAS7
 		select DEBUG_SIRFSOC_UART
 		help
@@ -1046,7 +1046,7 @@ choice
 		  debug port can be very useful.
 
 	config DEBUG_SIRFATLAS7_UART1
-		bool "Kernel low-level debugging messages via SiRFatlas7 UART1"
+		bool "SiRFatlas7 UART1"
 		depends on ARCH_ATLAS7
 		select DEBUG_SIRFSOC_UART
 		help
@@ -1054,7 +1054,7 @@ choice
 		  their output to the uart1 port on SiRFATLAS7 devices.
 
 	config DEBUG_SPEAR3XX
-		bool "Kernel low-level debugging messages via ST SPEAr 3xx/6xx UART"
+		bool "ST SPEAr 3xx/6xx UART"
 		depends on ARCH_SPEAR3XX || ARCH_SPEAR6XX
 		select DEBUG_UART_PL01X
 		help
@@ -1062,7 +1062,7 @@ choice
 		  on ST SPEAr based platforms.
 
 	config DEBUG_SPEAR13XX
-		bool "Kernel low-level debugging messages via ST SPEAr 13xx UART"
+		bool "ST SPEAr 13xx UART"
 		depends on ARCH_SPEAR13XX
 		select DEBUG_UART_PL01X
 		help
@@ -1070,7 +1070,7 @@ choice
 		  on ST SPEAr13xx based platforms.
 
 	config STIH41X_DEBUG_ASC2
-		bool "Use StiH415/416 ASC2 UART for low-level debug"
+		bool "StiH415/416 ASC2 UART"
 		depends on ARCH_STI
 		select DEBUG_STI_UART
 		help
@@ -1081,7 +1081,7 @@ choice
 		  If unsure, say N.
 
 	config STIH41X_DEBUG_SBC_ASC1
-		bool "Use StiH415/416 SBC ASC1 UART for low-level debug"
+		bool "StiH415/416 ASC1 UART"
 		depends on ARCH_STI
 		select DEBUG_STI_UART
 		help
@@ -1092,7 +1092,7 @@ choice
 		  If unsure, say N.
 
 	config TEGRA_DEBUG_UART_AUTO_ODMDATA
-		bool "Kernel low-level debugging messages via Tegra UART via ODMDATA"
+		bool "Tegra UART via ODMDATA"
 		depends on ARCH_TEGRA
 		select DEBUG_TEGRA_UART
 		help
@@ -1104,7 +1104,7 @@ choice
 		  are UART A/B/C/D/E.
 
 	config TEGRA_DEBUG_UARTA
-		bool "Kernel low-level debugging messages via Tegra UART A"
+		bool "Tegra UART A"
 		depends on ARCH_TEGRA
 		select DEBUG_TEGRA_UART
 		help
@@ -1112,7 +1112,7 @@ choice
 		  on Tegra based platforms.
 
 	config TEGRA_DEBUG_UARTB
-		bool "Kernel low-level debugging messages via Tegra UART B"
+		bool "Tegra UART B"
 		depends on ARCH_TEGRA
 		select DEBUG_TEGRA_UART
 		help
@@ -1120,7 +1120,7 @@ choice
 		  on Tegra based platforms.
 
 	config TEGRA_DEBUG_UARTC
-		bool "Kernel low-level debugging messages via Tegra UART C"
+		bool "Tegra UART C"
 		depends on ARCH_TEGRA
 		select DEBUG_TEGRA_UART
 		help
@@ -1128,7 +1128,7 @@ choice
 		  on Tegra based platforms.
 
 	config TEGRA_DEBUG_UARTD
-		bool "Kernel low-level debugging messages via Tegra UART D"
+		bool "Tegra UART D"
 		depends on ARCH_TEGRA
 		select DEBUG_TEGRA_UART
 		help
@@ -1136,7 +1136,7 @@ choice
 		  on Tegra based platforms.
 
 	config TEGRA_DEBUG_UARTE
-		bool "Kernel low-level debugging messages via Tegra UART E"
+		bool "Tegra UART E"
 		depends on ARCH_TEGRA
 		select DEBUG_TEGRA_UART
 		help
@@ -1144,7 +1144,7 @@ choice
 		  on Tegra based platforms.
 
 	config DEBUG_U300_UART
-		bool "Kernel low-level debugging messages via U300 UART0"
+		bool "U300 UART0"
 		depends on ARCH_U300
 		select DEBUG_UART_PL01X
 		help
@@ -1153,13 +1153,13 @@ choice
 
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
@@ -1178,7 +1178,7 @@ choice
 		  and may fail with non-standard SMM or custom software models.
 
 	config DEBUG_VEXPRESS_UART0_CA9
-		bool "Use PL011 UART0 at 0x10009000 (V2P-CA9 core tile)"
+		bool "PL011 UART0 at 0x10009000 (V2P-CA9 core tile)"
 		depends on ARCH_VEXPRESS
 		select DEBUG_UART_PL01X
 		help
@@ -1186,7 +1186,7 @@ choice
 		  this applies only to the V2P-CA9 tile.
 
 	config DEBUG_VEXPRESS_UART0_RS1
-		bool "Use PL011 UART0 at 0x1c090000 (RS1 complaint tiles)"
+		bool "PL011 UART0 at 0x1c090000 (RS1 complaint tiles)"
 		depends on ARCH_VEXPRESS
 		select DEBUG_UART_PL01X
 		help
@@ -1195,7 +1195,7 @@ choice
 		  core tiles, FPGA-based SMMs and software models.
 
 	config DEBUG_VEXPRESS_UART0_CRX
-		bool "Use PL011 UART0 at 0xb0090000 (Cortex-R compliant tiles)"
+		bool "PL011 UART0 at 0xb0090000 (Cortex-R compliant tiles)"
 		depends on ARCH_VEXPRESS && !MMU
 		select DEBUG_UART_PL01X
 		help
@@ -1210,14 +1210,14 @@ choice
 		  on Vybrid based platforms.
 
 	config DEBUG_VT8500_UART0
-		bool "Use UART0 on VIA/Wondermedia SoCs"
+		bool "VIA/Wondermedia UART0"
 		depends on ARCH_VT8500
 		help
 		  This option selects UART0 on VIA/Wondermedia System-on-a-chip
 		  devices, including VT8500, WM8505, WM8650 and WM8850.
 
 	config DEBUG_ZTE_ZX
-		bool "Use ZTE ZX UART"
+		bool "ZTE ZX UART"
 		select DEBUG_UART_PL01X
 		depends on ARCH_ZX
 		help
@@ -1229,14 +1229,14 @@ choice
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
@@ -1246,7 +1246,7 @@ choice
 		  appear on the USB serial adaptor, select this option.
 
 	config DEBUG_ICEDCC
-		bool "Kernel low-level debugging via EmbeddedICE DCC channel"
+		bool "EmbeddedICE DCC channel"
 		help
 		  Say Y here if you want the debug print routines to direct
 		  their output to the EmbeddedICE macrocell's DCC channel using
@@ -1257,7 +1257,7 @@ choice
 		  is nothing connected to read from the DCC.
 
 	config DEBUG_SEMIHOSTING
-		bool "Kernel low-level debug output via semihosting I/O"
+		bool "Semihosting I/O"
 		help
 		  Semihosting enables code running on an ARM target to use
 		  the I/O facilities on a host debugger/emulator through a
@@ -1273,7 +1273,7 @@ choice
 		  chapter 8 of DUI0203I_rvct_developer_guide.pdf from ARM Ltd.
 
 	config DEBUG_LL_UART_8250
-		bool "Kernel low-level debugging via 8250 UART"
+		bool "8250 UART"
 		help
 		  Say Y here if you wish the debug print routes to direct
 		  their output to an 8250 UART.  You can use this option
@@ -1286,7 +1286,7 @@ choice
 		  and will be soon removed.
 
 	config DEBUG_LL_UART_EFM32
-		bool "Kernel low-level debugging via efm32 UART"
+		bool "efm32 UART"
 		depends on ARCH_EFM32
 		help
 		  Say Y here if you want the debug print routines to direct
@@ -1300,7 +1300,7 @@ choice
 		    0x4000e400 | UART1
 
 	config DEBUG_LL_UART_PL01X
-		bool "Kernel low-level debugging via ARM Ltd PL01x Primecell UART"
+		bool "ARM Ltd PL01x Primecell UART"
 		help
 		  Say Y here if you wish the debug print routes to direct
 		  their output to a PL01x Primecell UART.  You can use
-- 
3B10 0CA1 8674 ACBA B4FE  FCD2 CE5B CF17 9960 DE13
