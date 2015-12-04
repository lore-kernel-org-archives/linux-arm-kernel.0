From: arnd@arndb.de (Arnd Bergmann)
Date: Fri,  4 Dec 2015 23:30:41 +0100
Subject: [PATCH 09/10] ARM: debug-ll: reorder Kconfig alphanumerically
In-Reply-To: <1449268242-808553-1-git-send-email-arnd@arndb.de>
References: <1449268242-808553-1-git-send-email-arnd@arndb.de>
Message-ID: <1449268242-808553-10-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The file has gotten a little out of sync, as platforms got
added in the wrong place, or have been renamed. This moves
the options around, but should not change any functionality.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig.debug | 282 ++++++++++++++++++++++++-------------------------
 1 file changed, 141 insertions(+), 141 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 1d0f5e24ad51..974cf51b5182 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -232,23 +232,6 @@ choice
 		  Say Y here if you want the debug print routines to direct
 		  their output to UART0 serial port on DaVinci DMx devices.
 
-	config DEBUG_ZYNQ_UART0
-		bool "Kernel low-level debugging on Xilinx Zynq using UART0"
-		depends on ARCH_ZYNQ
-		help
-		  Say Y here if you want the debug print routines to direct
-		  their output to UART0 on the Zynq platform.
-
-	config DEBUG_ZYNQ_UART1
-		bool "Kernel low-level debugging on Xilinx Zynq using UART1"
-		depends on ARCH_ZYNQ
-		help
-		  Say Y here if you want the debug print routines to direct
-		  their output to UART1 on the Zynq platform.
-
-		  If you have a ZC702 board and want early boot messages to
-		  appear on the USB serial adaptor, select this option.
-
 	config DEBUG_DC21285_PORT
 		bool "Kernel low-level debugging messages via footbridge serial port"
 		depends on FOOTBRIDGE
@@ -263,6 +246,20 @@ choice
 		  Say Y here if you want the debug print routines to direct
 		  their output to the UA0 serial port in the CX92755.
 
+	config DEBUG_LL_UART_EFM32
+		bool "Kernel low-level debugging via efm32 UART"
+		depends on ARCH_EFM32
+		help
+		  Say Y here if you want the debug print routines to direct
+		  their output to an UART or USART port on efm32 based
+		  machines. Use the following addresses for DEBUG_UART_PHYS:
+
+		    0x4000c000 | USART0
+		    0x4000c400 | USART1
+		    0x4000c800 | USART2
+		    0x4000e000 | UART0
+		    0x4000e400 | UART1
+
 	config DEBUG_EP93XX
 		bool "Kernel low-level debugging messages via ep93xx UART"
 		depends on ARCH_EP93XX
@@ -512,23 +509,6 @@ choice
 		  Say Y here if you want kernel low-level debugging support
 		  on MMP UART3.
 
-	config DEBUG_QCOM_UARTDM
-		bool "Kernel low-level debugging messages via QCOM UARTDM"
-		depends on ARCH_QCOM
-		help
-		  Say Y here if you want the debug print routines to direct
-		  their output to the serial port on Qualcomm devices.
-
-		  ARCH      DEBUG_UART_PHYS   DEBUG_UART_VIRT
-		  APQ8064   0x16640000        0xf0040000
-		  APQ8084   0xf995e000        0xfa75e000
-		  MSM8X60   0x19c40000        0xf0040000
-		  MSM8960   0x16440000        0xf0040000
-		  MSM8974   0xf991e000        0xfa71e000
-
-		  Please adjust DEBUG_UART_PHYS and DEBUG_UART_BASE configuration
-		  options based on your needs.
-
 	config DEBUG_MVEBU_UART0
 		bool "Kernel low-level debugging messages via MVEBU UART0 (old bootloaders)"
 		depends on ARCH_MVEBU
@@ -588,12 +568,29 @@ choice
 		  when u-boot hands over to the kernel, the system
 		  silently crashes, with no serial output at all.
 
-	config DEBUG_VF_UART
-		bool "Vybrid UART"
-		depends on SOC_VF610
+	config DEBUG_MT6589_UART0
+		bool "Mediatek mt6589 UART0"
+		depends on ARCH_MEDIATEK
+		select DEBUG_UART_8250
 		help
 		  Say Y here if you want kernel low-level debugging support
-		  on Vybrid based platforms.
+		  for Mediatek mt6589 based platforms on UART0.
+
+	config DEBUG_MT8127_UART0
+		bool "Mediatek mt8127/mt6592 UART0"
+		depends on ARCH_MEDIATEK
+		select DEBUG_UART_8250
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  for Mediatek mt8127 based platforms on UART0.
+
+	config DEBUG_MT8135_UART3
+		bool "Mediatek mt8135 UART3"
+		depends on ARCH_MEDIATEK
+		select DEBUG_UART_8250
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  for Mediatek mt8135 based platforms on UART3.
 
 	config DEBUG_NETX_UART
 		bool "Kernel low-level debugging messages via NetX UART"
@@ -757,6 +754,23 @@ choice
 		  Say Y here if you want kernel low-level debugging support
 		  on PXA UART1.
 
+	config DEBUG_QCOM_UARTDM
+		bool "Kernel low-level debugging messages via QCOM UARTDM"
+		depends on ARCH_QCOM
+		help
+		  Say Y here if you want the debug print routines to direct
+		  their output to the serial port on Qualcomm devices.
+
+		  ARCH      DEBUG_UART_PHYS   DEBUG_UART_VIRT
+		  APQ8064   0x16640000        0xf0040000
+		  APQ8084   0xf995e000        0xfa75e000
+		  MSM8X60   0x19c40000        0xf0040000
+		  MSM8960   0x16440000        0xf0040000
+		  MSM8974   0xf991e000        0xfa71e000
+
+		  Please adjust DEBUG_UART_PHYS and DEBUG_UART_BASE configuration
+		  options based on your needs.
+
 	config DEBUG_REALVIEW_STD_PORT
 		bool "RealView Default UART"
 		depends on ARCH_REALVIEW
@@ -1027,58 +1041,6 @@ choice
 		  Say Y here if you want kernel low-level debugging support
 		  on Allwinner A31/A23 based platforms on the R_UART.
 
-	config TEGRA_DEBUG_UART_AUTO_ODMDATA
-		bool "Kernel low-level debugging messages via Tegra UART via ODMDATA"
-		depends on ARCH_TEGRA
-		select DEBUG_TEGRA_UART
-		help
-		  Automatically determines which UART to use for low-level
-		  debug based on the ODMDATA value. This value is part of
-		  the BCT, and is written to the boot memory device using
-		  nvflash, or other flashing tool.  When bits 19:18 are 3,
-		  then bits 17:15 indicate which UART to use; 0/1/2/3/4
-		  are UART A/B/C/D/E.
-
-	config TEGRA_DEBUG_UARTA
-		bool "Kernel low-level debugging messages via Tegra UART A"
-		depends on ARCH_TEGRA
-		select DEBUG_TEGRA_UART
-		help
-		  Say Y here if you want kernel low-level debugging support
-		  on Tegra based platforms.
-
-	config TEGRA_DEBUG_UARTB
-		bool "Kernel low-level debugging messages via Tegra UART B"
-		depends on ARCH_TEGRA
-		select DEBUG_TEGRA_UART
-		help
-		  Say Y here if you want kernel low-level debugging support
-		  on Tegra based platforms.
-
-	config TEGRA_DEBUG_UARTC
-		bool "Kernel low-level debugging messages via Tegra UART C"
-		depends on ARCH_TEGRA
-		select DEBUG_TEGRA_UART
-		help
-		  Say Y here if you want kernel low-level debugging support
-		  on Tegra based platforms.
-
-	config TEGRA_DEBUG_UARTD
-		bool "Kernel low-level debugging messages via Tegra UART D"
-		depends on ARCH_TEGRA
-		select DEBUG_TEGRA_UART
-		help
-		  Say Y here if you want kernel low-level debugging support
-		  on Tegra based platforms.
-
-	config TEGRA_DEBUG_UARTE
-		bool "Kernel low-level debugging messages via Tegra UART E"
-		depends on ARCH_TEGRA
-		select DEBUG_TEGRA_UART
-		help
-		  Say Y here if you want kernel low-level debugging support
-		  on Tegra based platforms.
-
 	config DEBUG_SIRFPRIMA2_UART1
 		bool "Kernel low-level debugging messages via SiRFprimaII UART1"
 		depends on ARCH_PRIMA2
@@ -1143,6 +1105,58 @@ choice
 
 		  If unsure, say N.
 
+	config TEGRA_DEBUG_UART_AUTO_ODMDATA
+		bool "Kernel low-level debugging messages via Tegra UART via ODMDATA"
+		depends on ARCH_TEGRA
+		select DEBUG_TEGRA_UART
+		help
+		  Automatically determines which UART to use for low-level
+		  debug based on the ODMDATA value. This value is part of
+		  the BCT, and is written to the boot memory device using
+		  nvflash, or other flashing tool.  When bits 19:18 are 3,
+		  then bits 17:15 indicate which UART to use; 0/1/2/3/4
+		  are UART A/B/C/D/E.
+
+	config TEGRA_DEBUG_UARTA
+		bool "Kernel low-level debugging messages via Tegra UART A"
+		depends on ARCH_TEGRA
+		select DEBUG_TEGRA_UART
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on Tegra based platforms.
+
+	config TEGRA_DEBUG_UARTB
+		bool "Kernel low-level debugging messages via Tegra UART B"
+		depends on ARCH_TEGRA
+		select DEBUG_TEGRA_UART
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on Tegra based platforms.
+
+	config TEGRA_DEBUG_UARTC
+		bool "Kernel low-level debugging messages via Tegra UART C"
+		depends on ARCH_TEGRA
+		select DEBUG_TEGRA_UART
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on Tegra based platforms.
+
+	config TEGRA_DEBUG_UARTD
+		bool "Kernel low-level debugging messages via Tegra UART D"
+		depends on ARCH_TEGRA
+		select DEBUG_TEGRA_UART
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on Tegra based platforms.
+
+	config TEGRA_DEBUG_UARTE
+		bool "Kernel low-level debugging messages via Tegra UART E"
+		depends on ARCH_TEGRA
+		select DEBUG_TEGRA_UART
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on Tegra based platforms.
+
 	config DEBUG_U300_UART
 		bool "Kernel low-level debugging messages via U300 UART0"
 		depends on ARCH_U300
@@ -1158,14 +1172,6 @@ choice
 		  Say Y here if you want kernel low-level debugging support
 		  on Ux500 based platforms.
 
-	config DEBUG_MT6589_UART0
-		bool "Mediatek mt6589 UART0"
-		depends on ARCH_MEDIATEK
-		select DEBUG_UART_8250
-		help
-		  Say Y here if you want kernel low-level debugging support
-		  for Mediatek mt6589 based platforms on UART0.
-
 	config DEBUG_VERSATILE
 		bool "Kernel low-level debugging messages via ARM Versatile UART"
 		depends on ARCH_VERSATILE
@@ -1174,22 +1180,6 @@ choice
 		  Say Y here if you want kernel low-level debugging support
 		  on ARM Versatile platforms.
 
-	config DEBUG_MT8127_UART0
-		bool "Mediatek mt8127/mt6592 UART0"
-		depends on ARCH_MEDIATEK
-		select DEBUG_UART_8250
-		help
-		  Say Y here if you want kernel low-level debugging support
-		  for Mediatek mt8127 based platforms on UART0.
-
-	config DEBUG_MT8135_UART3
-		bool "Mediatek mt8135 UART3"
-		depends on ARCH_MEDIATEK
-		select DEBUG_UART_8250
-		help
-		  Say Y here if you want kernel low-level debugging support
-		  for Mediatek mt8135 based platforms on UART3.
-
 	config DEBUG_VEXPRESS_UART0_DETECT
 		bool "Autodetect UART0 on Versatile Express Cortex-A core tiles"
 		depends on ARCH_VEXPRESS && CPU_CP15_MMU
@@ -1226,6 +1216,13 @@ choice
 		  This option selects UART0 at 0xb0090000. This is appropriate for
 		  Cortex-R series tiles and SMMs, such as Cortex-R5 and Cortex-R7
 
+	config DEBUG_VF_UART
+		bool "Vybrid UART"
+		depends on SOC_VF610
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on Vybrid based platforms.
+
 	config DEBUG_VT8500_UART0
 		bool "Use UART0 on VIA/Wondermedia SoCs"
 		depends on ARCH_VT8500
@@ -1233,6 +1230,35 @@ choice
 		  This option selects UART0 on VIA/Wondermedia System-on-a-chip
 		  devices, including VT8500, WM8505, WM8650 and WM8850.
 
+	config DEBUG_ZTE_ZX
+		bool "Use ZTE ZX UART"
+		select DEBUG_UART_PL01X
+		depends on ARCH_ZX
+		help
+		  Say Y here if you are enabling ZTE ZX296702 SOC and need
+		  debug uart support.
+
+		  This option is preferred over the platform specific
+		  options; the platform specific options are deprecated
+		  and will be soon removed.
+
+	config DEBUG_ZYNQ_UART0
+		bool "Kernel low-level debugging on Xilinx Zynq using UART0"
+		depends on ARCH_ZYNQ
+		help
+		  Say Y here if you want the debug print routines to direct
+		  their output to UART0 on the Zynq platform.
+
+	config DEBUG_ZYNQ_UART1
+		bool "Kernel low-level debugging on Xilinx Zynq using UART1"
+		depends on ARCH_ZYNQ
+		help
+		  Say Y here if you want the debug print routines to direct
+		  their output to UART1 on the Zynq platform.
+
+		  If you have a ZC702 board and want early boot messages to
+		  appear on the USB serial adaptor, select this option.
+
 	config DEBUG_ICEDCC
 		bool "Kernel low-level debugging via EmbeddedICE DCC channel"
 		help
@@ -1260,18 +1286,6 @@ choice
 		  For more details about semihosting, please see
 		  chapter 8 of DUI0203I_rvct_developer_guide.pdf from ARM Ltd.
 
-	config DEBUG_ZTE_ZX
-		bool "Use ZTE ZX UART"
-		select DEBUG_UART_PL01X
-		depends on ARCH_ZX
-		help
-		  Say Y here if you are enabling ZTE ZX296702 SOC and need
-		  debug uart support.
-
-		  This option is preferred over the platform specific
-		  options; the platform specific options are deprecated
-		  and will be soon removed.
-
 	config DEBUG_LL_UART_8250
 		bool "Kernel low-level debugging via 8250 UART"
 		help
@@ -1285,20 +1299,6 @@ choice
 		  options; the platform specific options are deprecated
 		  and will be soon removed.
 
-	config DEBUG_LL_UART_EFM32
-		bool "Kernel low-level debugging via efm32 UART"
-		depends on ARCH_EFM32
-		help
-		  Say Y here if you want the debug print routines to direct
-		  their output to an UART or USART port on efm32 based
-		  machines. Use the following addresses for DEBUG_UART_PHYS:
-
-		    0x4000c000 | USART0
-		    0x4000c400 | USART1
-		    0x4000c800 | USART2
-		    0x4000e000 | UART0
-		    0x4000e400 | UART1
-
 	config DEBUG_LL_UART_PL01X
 		bool "Kernel low-level debugging via ARM Ltd PL01x Primecell UART"
 		help
@@ -1572,6 +1572,7 @@ config DEBUG_UART_VIRT
 	default 0xf1c28000 if DEBUG_SUNXI_UART0
 	default 0xf1c28400 if DEBUG_SUNXI_UART1
 	default 0xf1f02800 if DEBUG_SUNXI_R_UART
+	default 0xf31004c0 if DEBUG_MESON_UARTAO
 	default 0xf4090000 if DEBUG_LPC32XX
 	default 0xf4200000 if DEBUG_GEMINI
 	default 0xf6200000 if DEBUG_PXA_UART1
@@ -1602,7 +1603,6 @@ config DEBUG_UART_VIRT
 	default 0xfd883000 if DEBUG_ALPINE_UART0
 	default 0xfde12000 if DEBUG_MVEBU_UART0_ALTERNATE && ARCH_DOVE
 	default 0xfe012000 if DEBUG_MVEBU_UART0_ALTERNATE && ARCH_ORION5X
-	default 0xf31004c0 if DEBUG_MESON_UARTAO
 	default 0xfe017000 if DEBUG_MMP_UART2
 	default 0xfe018000 if DEBUG_MMP_UART3
 	default 0xfe100000 if DEBUG_IMX23_UART || DEBUG_IMX28_UART
-- 
2.1.0.rc2
