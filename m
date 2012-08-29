From: robherring2@gmail.com (Rob Herring)
Date: Wed, 29 Aug 2012 17:49:56 -0500
Subject: [PATCH 2/6] ARM: introduce Kconfig.mach
In-Reply-To: <1346280600-29395-1-git-send-email-robherring2@gmail.com>
References: <1346280600-29395-1-git-send-email-robherring2@gmail.com>
Message-ID: <1346280600-29395-3-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Move all the mach related config options into separate Kconfig.mach file.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/Kconfig      |  529 +------------------------------------------------
 arch/arm/Kconfig.mach |  528 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 529 insertions(+), 528 deletions(-)
 create mode 100644 arch/arm/Kconfig.mach

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 3ad82c6..fa34df2 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -248,534 +248,7 @@ config MMU
 	  Select if you want MMU-based virtualised addressing space
 	  support by paged memory management. If unsure, say 'Y'.
 
-#
-# The "ARM system type" choice list is ordered alphabetically by option
-# text.  Please add new entries in the option alphabetic order.
-#
-choice
-	prompt "ARM system type"
-	default ARCH_VERSATILE
-
-config ARCH_SOCFPGA_CHOICE
-	bool "Altera SOCFPGA family"
-	select ARCH_SOCFPGA
-	help
-	  This enables support for Altera SOCFPGA Cyclone V platform
-
-config ARCH_INTEGRATOR_CHOICE
-	bool "ARM Ltd. Integrator family"
-	select ARCH_INTEGRATOR
-	help
-	  Support for ARM's Integrator platform.
-
-config ARCH_REALVIEW_CHOICE
-	bool "ARM Ltd. RealView family"
-	select ARCH_REALVIEW
-	help
-	  This enables support for ARM Ltd RealView boards.
-
-config ARCH_VERSATILE_CHOICE
-	bool "ARM Ltd. Versatile family"
-	select ARCH_VERSATILE
-	help
-	  This enables support for ARM Ltd Versatile board.
-
-config ARCH_VEXPRESS_CHOICE
-	bool "ARM Ltd. Versatile Express family"
-	select ARCH_VEXPRESS
-	help
-	  This enables support for the ARM Ltd Versatile Express boards.
-
-config ARCH_AT91_CHOICE
-	bool "Atmel AT91"
-	select ARCH_AT91
-	help
-	  This enables support for systems based on Atmel
-	  AT91RM9200 and AT91SAM9* processors.
-
-config ARCH_BCMRING_CHOICE
-	bool "Broadcom BCMRING"
-	depends on MMU
-	select ARCH_BCMRING
-	help
-	  Support for Broadcom's BCMRing platform.
-
-config ARCH_HIGHBANK_CHOICE
-	bool "Calxeda Highbank-based"
-	select ARCH_HIGHBANK
-	help
-	  Support for the Calxeda Highbank SoC based boards.
-
-config ARCH_CLPS711X_CHOICE
-	bool "Cirrus Logic CLPS711x/EP721x/EP731x-based"
-	select ARCH_CLPS711X
-	help
-	  Support for Cirrus Logic 711x/721x/731x based boards.
-
-config ARCH_CNS3XXX_CHOICE
-	bool "Cavium Networks CNS3XXX family"
-	select ARCH_CNS3XXX
-	help
-	  Support for Cavium Networks CNS3XXX platform.
-
-config ARCH_GEMINI_CHOICE
-	bool "Cortina Systems Gemini"
-	select ARCH_GEMINI
-	help
-	  Support for the Cortina Systems Gemini family SoCs
-
-config ARCH_PRIMA2_CHOICE
-	bool "CSR SiRFSoC PRIMA2 ARM Cortex A9 Platform"
-	select ARCH_PRIMA2
-	help
-          Support for CSR SiRFSoC ARM Cortex A9 Platform
-
-config ARCH_EBSA110_CHOICE
-	bool "EBSA-110"
-	select ARCH_EBSA110
-	help
-	  This is an evaluation board for the StrongARM processor available
-	  from Digital. It has limited hardware on-board, including an
-	  Ethernet interface, two PCMCIA sockets, two serial ports and a
-	  parallel port.
-
-config ARCH_EP93XX_CHOICE
-	bool "EP93xx-based"
-	select ARCH_EP93XX
-	help
-	  This enables support for the Cirrus EP93xx series of CPUs.
-
-config ARCH_FOOTBRIDGE_CHOICE
-	bool "FootBridge"
-	select ARCH_FOOTBRIDGE
-	help
-	  Support for systems based on the DC21285 companion chip
-	  ("FootBridge"), such as the Simtec CATS and the Rebel NetWinder.
-
-config ARCH_MXC_CHOICE
-	bool "Freescale MXC/iMX-based"
-	select ARCH_MXC
-	help
-	  Support for Freescale MXC/iMX-based family of processors
-
-config ARCH_MXS_CHOICE
-	bool "Freescale MXS-based"
-	select ARCH_MXS
-	help
-	  Support for Freescale MXS-based family of processors
-
-config ARCH_NETX_CHOICE
-	bool "Hilscher NetX based"
-	select ARCH_NETX
-	help
-	  This enables support for systems based on the Hilscher NetX Soc
-
-config ARCH_H720X_CHOICE
-	bool "Hynix HMS720x-based"
-	select ARCH_H720X
-	help
-	  This enables support for systems based on the Hynix HMS720x
-
-config ARCH_IOP13XX_CHOICE
-	bool "IOP13xx-based"
-	depends on MMU
-	select ARCH_IOP13XX
-	help
-	  Support for Intel's IOP13XX (XScale) family of processors.
-
-config ARCH_IOP32X_CHOICE
-	bool "IOP32x-based"
-	depends on MMU
-	select ARCH_IOP32X
-	help
-	  Support for Intel's 80219 and IOP32X (XScale) family of
-	  processors.
-
-config ARCH_IOP33X_CHOICE
-	bool "IOP33x-based"
-	depends on MMU
-	select ARCH_IOP33X
-	help
-	  Support for Intel's IOP33X (XScale) family of processors.
-
-config ARCH_IXP4XX_CHOICE
-	bool "IXP4xx-based"
-	depends on MMU
-	select ARCH_IXP4XX
-	help
-	  Support for Intel's IXP4XX (XScale) family of processors.
-
-config ARCH_MVEBU_CHOICE
-	bool "Marvell SOCs with Device Tree support"
-	select ARCH_MVEBU
-	help
-	  Support for the Marvell SoC Family with device tree support
-
-config ARCH_DOVE_CHOICE
-	bool "Marvell Dove"
-	select ARCH_DOVE
-	help
-	  Support for the Marvell Dove SoC 88AP510
-
-config ARCH_KIRKWOOD_CHOICE
-	bool "Marvell Kirkwood"
-	select ARCH_KIRKWOOD
-	help
-	  Support for the following Marvell Kirkwood series SoCs:
-	  88F6180, 88F6192 and 88F6281.
-
-config ARCH_LPC32XX_CHOICE
-	bool "NXP LPC32XX"
-	select ARCH_LPC32XX
-	help
-	  Support for the NXP LPC32XX family of processors
-
-config ARCH_MV78XX0_CHOICE
-	bool "Marvell MV78xx0"
-	select ARCH_MV78XX0
-	help
-	  Support for the following Marvell MV78xx0 series SoCs:
-	  MV781x0, MV782x0.
-
-config ARCH_ORION5X_CHOICE
-	bool "Marvell Orion"
-	depends on MMU
-	select ARCH_ORION5X
-	help
-	  Support for the following Marvell Orion 5x series SoCs:
-	  Orion-1 (5181), Orion-VoIP (5181L), Orion-NAS (5182),
-	  Orion-2 (5281), Orion-1-90 (6183).
-
-config ARCH_MMP_CHOICE
-	bool "Marvell PXA168/910/MMP2"
-	depends on MMU
-	select ARCH_MMP
-	help
-	  Support for Marvell's PXA168/PXA910(MMP) and MMP2 processor line.
-
-config ARCH_KS8695_CHOICE
-	bool "Micrel/Kendin KS8695"
-	select ARCH_KS8695
-	help
-	  Support for Micrel/Kendin KS8695 "Centaur" (ARM922T) based
-	  System-on-Chip devices.
-
-config ARCH_W90X900_CHOICE
-	bool "Nuvoton W90X900 CPU"
-	select ARCH_W90X900
-	help
-	  Support for Nuvoton (Winbond logic dept.) ARM9 processor,
-	  At present, the w90x900 has been renamed nuc900, regarding
-	  the ARM series product line, you can login the following
-	  link address to know more.
-
-	  <http://www.nuvoton.com/hq/enu/ProductAndSales/ProductLines/
-		ConsumerElectronicsIC/ARMMicrocontroller/ARMMicrocontroller>
-
-config ARCH_TEGRA_CHOICE
-	bool "NVIDIA Tegra"
-	select ARCH_TEGRA
-	help
-	  This enables support for NVIDIA Tegra based systems (Tegra APX,
-	  Tegra 6xx and Tegra 2 series).
-
-config ARCH_PICOXCELL_CHOICE
-	bool "Picochip picoXcell"
-	select ARCH_PICOXCELL
-	help
-	  This enables support for systems based on the Picochip picoXcell
-	  family of Femtocell devices.  The picoxcell support requires device tree
-	  for all boards.
-
-config ARCH_PNX4008_CHOICE
-	bool "Philips Nexperia PNX4008 Mobile"
-	select ARCH_PNX4008
-	help
-	  This enables support for Philips PNX4008 mobile platform.
-
-config ARCH_PXA_CHOICE
-	bool "PXA2xx/PXA3xx-based"
-	depends on MMU
-	select ARCH_PXA
-	help
-	  Support for Intel/Marvell's PXA2xx/PXA3xx processor line.
-
-config ARCH_MSM_CHOICE
-	bool "Qualcomm MSM"
-	select ARCH_MSM
-	help
-	  Support for Qualcomm MSM/QSD based systems.  This runs on the
-	  apps processor of the MSM/QSD and depends on a shared memory
-	  interface to the modem processor which runs the baseband
-	  stack and controls some vital subsystems
-	  (clock and power control, etc).
-
-config ARCH_SHMOBILE_CHOICE
-	bool "Renesas SH-Mobile / R-Mobile"
-	select ARCH_SHMOBILE
-	help
-	  Support for Renesas's SH-Mobile and R-Mobile ARM platforms.
-
-config ARCH_RPC_CHOICE
-	bool "RiscPC"
-	select ARCH_RPC
-	help
-	  On the Acorn Risc-PC, Linux can support the internal IDE disk and
-	  CD-ROM interface, serial and parallel port, and the floppy drive.
-
-config ARCH_SA1100_CHOICE
-	bool "SA1100-based"
-	select ARCH_SA1100
-	help
-	  Support for StrongARM 11x0 based boards.
-
-config ARCH_S3C24XX_CHOICE
-	bool "Samsung S3C24XX SoCs"
-	select ARCH_S3C24XX
-	help
-	  Samsung S3C2410, S3C2412, S3C2413, S3C2416, S3C2440, S3C2442, S3C2443
-	  and S3C2450 SoCs based systems, such as the Simtec Electronics BAST
-	  (<http://www.simtec.co.uk/products/EB110ITX/>), the IPAQ 1940 or the
-	  Samsung SMDK2410 development board (and derivatives).
-
-config ARCH_S3C64XX_CHOICE
-	bool "Samsung S3C64XX"
-	select ARCH_S3C64XX
-	help
-	  Samsung S3C64XX series based systems
-
-config ARCH_S5P64X0_CHOICE
-	bool "Samsung S5P6440 S5P6450"
-	select ARCH_S5P64X0
-	help
-	  Samsung S5P64X0 CPU based systems, such as the Samsung SMDK6440,
-	  SMDK6450.
-
-config ARCH_S5PC100_CHOICE
-	bool "Samsung S5PC100"
-	select ARCH_S5PC100
-	help
-	  Samsung S5PC100 series based systems
-
-config ARCH_S5PV210_CHOICE
-	bool "Samsung S5PV210/S5PC110"
-	select ARCH_S5PV210
-	help
-	  Samsung S5PV210/S5PC110 series based systems
-
-config ARCH_EXYNOS_CHOICE
-	bool "SAMSUNG EXYNOS"
-	select ARCH_EXYNOS
-	help
-	  Support for SAMSUNG's EXYNOS SoCs (EXYNOS4/5)
-
-config ARCH_SHARK_CHOICE
-	bool "Shark"
-	select ARCH_SHARK
-	help
-	  Support for the StrongARM based Digital DNARD machine, also known
-	  as "Shark" (<http://www.shark-linux.de/shark.html>).
-
-config ARCH_U300_CHOICE
-	bool "ST-Ericsson U300 Series"
-	depends on MMU
-	select ARCH_U300
-	help
-	  Support for ST-Ericsson U300 series mobile platforms.
-
-config ARCH_U8500_CHOICE
-	bool "ST-Ericsson U8500 Series"
-	depends on MMU
-	select ARCH_U8500
-	help
-	  Support for ST-Ericsson's Ux500 architecture
-
-config ARCH_NOMADIK_CHOICE
-	bool "STMicroelectronics Nomadik"
-	select ARCH_NOMADIK
-	help
-	  Support for the Nomadik platform by ST-Ericsson
-
-config ARCH_DAVINCI_CHOICE
-	bool "TI DaVinci"
-	select ARCH_DAVINCI
-	select NEED_MACH_GPIO_H
-	help
-	  Support for TI's DaVinci platform.
-
-config ARCH_OMAP_CHOICE
-	bool "TI OMAP"
-	depends on MMU
-	select ARCH_OMAP
-	help
-	  Support for TI's OMAP platform (OMAP1/2/3/4).
-
-config PLAT_SPEAR_CHOICE
-	bool "ST SPEAr"
-	select PLAT_SPEAR
-	help
-	  Support for ST's SPEAr platform (SPEAr3xx, SPEAr6xx and SPEAr13xx).
-
-config ARCH_VT8500_CHOICE
-	bool "VIA/WonderMedia 85xx"
-	select ARCH_VT8500
-	help
-	  Support for VIA/WonderMedia VT8500/WM85xx System-on-Chip.
-
-config ARCH_ZYNQ_CHOICE
-	bool "Xilinx Zynq ARM Cortex A9 Platform"
-	select ARCH_ZYNQ
-	help
-	  Support for Xilinx Zynq ARM Cortex A9 Platform
-endchoice
-
-#
-# This is sorted alphabetically by mach-* pathname.  However, plat-*
-# Kconfigs may be included either alphabetically (according to the
-# plat- suffix) or along side the corresponding mach-* source.
-#
-source "arch/arm/mach-mvebu/Kconfig"
-
-source "arch/arm/mach-at91/Kconfig"
-
-source "arch/arm/mach-bcmring/Kconfig"
-
-source "arch/arm/mach-clps711x/Kconfig"
-
-source "arch/arm/mach-cns3xxx/Kconfig"
-
-source "arch/arm/mach-davinci/Kconfig"
-
-source "arch/arm/mach-dove/Kconfig"
-
-source "arch/arm/mach-ebsa110/Kconfig"
-
-source "arch/arm/mach-ep93xx/Kconfig"
-
-source "arch/arm/mach-footbridge/Kconfig"
-
-source "arch/arm/mach-gemini/Kconfig"
-
-source "arch/arm/mach-h720x/Kconfig"
-
-source "arch/arm/mach-highbank/Kconfig"
-
-source "arch/arm/mach-integrator/Kconfig"
-
-source "arch/arm/mach-iop32x/Kconfig"
-
-source "arch/arm/mach-iop33x/Kconfig"
-
-source "arch/arm/mach-iop13xx/Kconfig"
-
-source "arch/arm/mach-ixp4xx/Kconfig"
-
-source "arch/arm/mach-kirkwood/Kconfig"
-
-source "arch/arm/mach-ks8695/Kconfig"
-
-source "arch/arm/mach-lpc32xx/Kconfig"
-
-source "arch/arm/mach-msm/Kconfig"
-
-source "arch/arm/mach-mv78xx0/Kconfig"
-
-source "arch/arm/plat-mxc/Kconfig"
-
-source "arch/arm/mach-mxs/Kconfig"
-
-source "arch/arm/mach-netx/Kconfig"
-
-source "arch/arm/mach-nomadik/Kconfig"
-source "arch/arm/plat-nomadik/Kconfig"
-
-source "arch/arm/plat-omap/Kconfig"
-
-source "arch/arm/mach-omap1/Kconfig"
-
-source "arch/arm/mach-omap2/Kconfig"
-
-source "arch/arm/mach-orion5x/Kconfig"
-
-source "arch/arm/mach-picoxcell/Kconfig"
-
-source "arch/arm/mach-pnx4008/Kconfig"
-
-source "arch/arm/mach-pxa/Kconfig"
-source "arch/arm/plat-pxa/Kconfig"
-
-source "arch/arm/mach-mmp/Kconfig"
-
-source "arch/arm/mach-realview/Kconfig"
-
-source "arch/arm/mach-rpc/Kconfig"
-
-source "arch/arm/mach-sa1100/Kconfig"
-
-source "arch/arm/plat-samsung/Kconfig"
-source "arch/arm/plat-s3c24xx/Kconfig"
-
-source "arch/arm/mach-shark/Kconfig"
-
-source "arch/arm/mach-socfpga/Kconfig"
-
-source "arch/arm/plat-spear/Kconfig"
-
-source "arch/arm/mach-s3c24xx/Kconfig"
-if ARCH_S3C24XX
-source "arch/arm/mach-s3c2412/Kconfig"
-source "arch/arm/mach-s3c2440/Kconfig"
-endif
-
-source "arch/arm/mach-s3c64xx/Kconfig"
-
-source "arch/arm/mach-s5p64x0/Kconfig"
-
-source "arch/arm/mach-s5pc100/Kconfig"
-
-source "arch/arm/mach-s5pv210/Kconfig"
-
-source "arch/arm/mach-exynos/Kconfig"
-
-source "arch/arm/mach-shmobile/Kconfig"
-
-source "arch/arm/mach-tegra/Kconfig"
-
-source "arch/arm/mach-u300/Kconfig"
-
-source "arch/arm/mach-ux500/Kconfig"
-
-source "arch/arm/mach-versatile/Kconfig"
-
-source "arch/arm/mach-vexpress/Kconfig"
-source "arch/arm/plat-versatile/Kconfig"
-
-source "arch/arm/mach-vt8500/Kconfig"
-
-source "arch/arm/mach-w90x900/Kconfig"
-
-source "arch/arm/mach-zynq/Kconfig"
-
-# Definitions to make life easier
-config ARCH_ACORN
-	bool
-
-config PLAT_IOP
-	bool
-	select GENERIC_CLOCKEVENTS
-
-config PLAT_ORION
-	bool
-	select CLKSRC_MMIO
-	select GENERIC_IRQ_CHIP
-	select IRQ_DOMAIN
-	select COMMON_CLK
-
-config PLAT_PXA
-	bool
-
-config PLAT_VERSATILE
-	bool
+source "arch/arm/Kconfig.mach"
 
 config ARM_TIMER_SP804
 	bool
diff --git a/arch/arm/Kconfig.mach b/arch/arm/Kconfig.mach
new file mode 100644
index 0000000..60f0386
--- /dev/null
+++ b/arch/arm/Kconfig.mach
@@ -0,0 +1,528 @@
+#
+# The "ARM system type" choice list is ordered alphabetically by option
+# text.  Please add new entries in the option alphabetic order.
+#
+choice
+	prompt "ARM system type"
+	default ARCH_VERSATILE
+
+config ARCH_SOCFPGA_CHOICE
+	bool "Altera SOCFPGA family"
+	select ARCH_SOCFPGA
+	help
+	  This enables support for Altera SOCFPGA Cyclone V platform
+
+config ARCH_INTEGRATOR_CHOICE
+	bool "ARM Ltd. Integrator family"
+	select ARCH_INTEGRATOR
+	help
+	  Support for ARM's Integrator platform.
+
+config ARCH_REALVIEW_CHOICE
+	bool "ARM Ltd. RealView family"
+	select ARCH_REALVIEW
+	help
+	  This enables support for ARM Ltd RealView boards.
+
+config ARCH_VERSATILE_CHOICE
+	bool "ARM Ltd. Versatile family"
+	select ARCH_VERSATILE
+	help
+	  This enables support for ARM Ltd Versatile board.
+
+config ARCH_VEXPRESS_CHOICE
+	bool "ARM Ltd. Versatile Express family"
+	select ARCH_VEXPRESS
+	help
+	  This enables support for the ARM Ltd Versatile Express boards.
+
+config ARCH_AT91_CHOICE
+	bool "Atmel AT91"
+	select ARCH_AT91
+	help
+	  This enables support for systems based on Atmel
+	  AT91RM9200 and AT91SAM9* processors.
+
+config ARCH_BCMRING_CHOICE
+	bool "Broadcom BCMRING"
+	depends on MMU
+	select ARCH_BCMRING
+	help
+	  Support for Broadcom's BCMRing platform.
+
+config ARCH_HIGHBANK_CHOICE
+	bool "Calxeda Highbank-based"
+	select ARCH_HIGHBANK
+	help
+	  Support for the Calxeda Highbank SoC based boards.
+
+config ARCH_CLPS711X_CHOICE
+	bool "Cirrus Logic CLPS711x/EP721x/EP731x-based"
+	select ARCH_CLPS711X
+	help
+	  Support for Cirrus Logic 711x/721x/731x based boards.
+
+config ARCH_CNS3XXX_CHOICE
+	bool "Cavium Networks CNS3XXX family"
+	select ARCH_CNS3XXX
+	help
+	  Support for Cavium Networks CNS3XXX platform.
+
+config ARCH_GEMINI_CHOICE
+	bool "Cortina Systems Gemini"
+	select ARCH_GEMINI
+	help
+	  Support for the Cortina Systems Gemini family SoCs
+
+config ARCH_PRIMA2_CHOICE
+	bool "CSR SiRFSoC PRIMA2 ARM Cortex A9 Platform"
+	select ARCH_PRIMA2
+	help
+          Support for CSR SiRFSoC ARM Cortex A9 Platform
+
+config ARCH_EBSA110_CHOICE
+	bool "EBSA-110"
+	select ARCH_EBSA110
+	help
+	  This is an evaluation board for the StrongARM processor available
+	  from Digital. It has limited hardware on-board, including an
+	  Ethernet interface, two PCMCIA sockets, two serial ports and a
+	  parallel port.
+
+config ARCH_EP93XX_CHOICE
+	bool "EP93xx-based"
+	select ARCH_EP93XX
+	help
+	  This enables support for the Cirrus EP93xx series of CPUs.
+
+config ARCH_FOOTBRIDGE_CHOICE
+	bool "FootBridge"
+	select ARCH_FOOTBRIDGE
+	help
+	  Support for systems based on the DC21285 companion chip
+	  ("FootBridge"), such as the Simtec CATS and the Rebel NetWinder.
+
+config ARCH_MXC_CHOICE
+	bool "Freescale MXC/iMX-based"
+	select ARCH_MXC
+	help
+	  Support for Freescale MXC/iMX-based family of processors
+
+config ARCH_MXS_CHOICE
+	bool "Freescale MXS-based"
+	select ARCH_MXS
+	help
+	  Support for Freescale MXS-based family of processors
+
+config ARCH_NETX_CHOICE
+	bool "Hilscher NetX based"
+	select ARCH_NETX
+	help
+	  This enables support for systems based on the Hilscher NetX Soc
+
+config ARCH_H720X_CHOICE
+	bool "Hynix HMS720x-based"
+	select ARCH_H720X
+	help
+	  This enables support for systems based on the Hynix HMS720x
+
+config ARCH_IOP13XX_CHOICE
+	bool "IOP13xx-based"
+	depends on MMU
+	select ARCH_IOP13XX
+	help
+	  Support for Intel's IOP13XX (XScale) family of processors.
+
+config ARCH_IOP32X_CHOICE
+	bool "IOP32x-based"
+	depends on MMU
+	select ARCH_IOP32X
+	help
+	  Support for Intel's 80219 and IOP32X (XScale) family of
+	  processors.
+
+config ARCH_IOP33X_CHOICE
+	bool "IOP33x-based"
+	depends on MMU
+	select ARCH_IOP33X
+	help
+	  Support for Intel's IOP33X (XScale) family of processors.
+
+config ARCH_IXP4XX_CHOICE
+	bool "IXP4xx-based"
+	depends on MMU
+	select ARCH_IXP4XX
+	help
+	  Support for Intel's IXP4XX (XScale) family of processors.
+
+config ARCH_MVEBU_CHOICE
+	bool "Marvell SOCs with Device Tree support"
+	select ARCH_MVEBU
+	help
+	  Support for the Marvell SoC Family with device tree support
+
+config ARCH_DOVE_CHOICE
+	bool "Marvell Dove"
+	select ARCH_DOVE
+	help
+	  Support for the Marvell Dove SoC 88AP510
+
+config ARCH_KIRKWOOD_CHOICE
+	bool "Marvell Kirkwood"
+	select ARCH_KIRKWOOD
+	help
+	  Support for the following Marvell Kirkwood series SoCs:
+	  88F6180, 88F6192 and 88F6281.
+
+config ARCH_LPC32XX_CHOICE
+	bool "NXP LPC32XX"
+	select ARCH_LPC32XX
+	help
+	  Support for the NXP LPC32XX family of processors
+
+config ARCH_MV78XX0_CHOICE
+	bool "Marvell MV78xx0"
+	select ARCH_MV78XX0
+	help
+	  Support for the following Marvell MV78xx0 series SoCs:
+	  MV781x0, MV782x0.
+
+config ARCH_ORION5X_CHOICE
+	bool "Marvell Orion"
+	depends on MMU
+	select ARCH_ORION5X
+	help
+	  Support for the following Marvell Orion 5x series SoCs:
+	  Orion-1 (5181), Orion-VoIP (5181L), Orion-NAS (5182),
+	  Orion-2 (5281), Orion-1-90 (6183).
+
+config ARCH_MMP_CHOICE
+	bool "Marvell PXA168/910/MMP2"
+	depends on MMU
+	select ARCH_MMP
+	help
+	  Support for Marvell's PXA168/PXA910(MMP) and MMP2 processor line.
+
+config ARCH_KS8695_CHOICE
+	bool "Micrel/Kendin KS8695"
+	select ARCH_KS8695
+	help
+	  Support for Micrel/Kendin KS8695 "Centaur" (ARM922T) based
+	  System-on-Chip devices.
+
+config ARCH_W90X900_CHOICE
+	bool "Nuvoton W90X900 CPU"
+	select ARCH_W90X900
+	help
+	  Support for Nuvoton (Winbond logic dept.) ARM9 processor,
+	  At present, the w90x900 has been renamed nuc900, regarding
+	  the ARM series product line, you can login the following
+	  link address to know more.
+
+	  <http://www.nuvoton.com/hq/enu/ProductAndSales/ProductLines/
+		ConsumerElectronicsIC/ARMMicrocontroller/ARMMicrocontroller>
+
+config ARCH_TEGRA_CHOICE
+	bool "NVIDIA Tegra"
+	select ARCH_TEGRA
+	help
+	  This enables support for NVIDIA Tegra based systems (Tegra APX,
+	  Tegra 6xx and Tegra 2 series).
+
+config ARCH_PICOXCELL_CHOICE
+	bool "Picochip picoXcell"
+	select ARCH_PICOXCELL
+	help
+	  This enables support for systems based on the Picochip picoXcell
+	  family of Femtocell devices.  The picoxcell support requires device tree
+	  for all boards.
+
+config ARCH_PNX4008_CHOICE
+	bool "Philips Nexperia PNX4008 Mobile"
+	select ARCH_PNX4008
+	help
+	  This enables support for Philips PNX4008 mobile platform.
+
+config ARCH_PXA_CHOICE
+	bool "PXA2xx/PXA3xx-based"
+	depends on MMU
+	select ARCH_PXA
+	help
+	  Support for Intel/Marvell's PXA2xx/PXA3xx processor line.
+
+config ARCH_MSM_CHOICE
+	bool "Qualcomm MSM"
+	select ARCH_MSM
+	help
+	  Support for Qualcomm MSM/QSD based systems.  This runs on the
+	  apps processor of the MSM/QSD and depends on a shared memory
+	  interface to the modem processor which runs the baseband
+	  stack and controls some vital subsystems
+	  (clock and power control, etc).
+
+config ARCH_SHMOBILE_CHOICE
+	bool "Renesas SH-Mobile / R-Mobile"
+	select ARCH_SHMOBILE
+	help
+	  Support for Renesas's SH-Mobile and R-Mobile ARM platforms.
+
+config ARCH_RPC_CHOICE
+	bool "RiscPC"
+	select ARCH_RPC
+	help
+	  On the Acorn Risc-PC, Linux can support the internal IDE disk and
+	  CD-ROM interface, serial and parallel port, and the floppy drive.
+
+config ARCH_SA1100_CHOICE
+	bool "SA1100-based"
+	select ARCH_SA1100
+	help
+	  Support for StrongARM 11x0 based boards.
+
+config ARCH_S3C24XX_CHOICE
+	bool "Samsung S3C24XX SoCs"
+	select ARCH_S3C24XX
+	help
+	  Samsung S3C2410, S3C2412, S3C2413, S3C2416, S3C2440, S3C2442, S3C2443
+	  and S3C2450 SoCs based systems, such as the Simtec Electronics BAST
+	  (<http://www.simtec.co.uk/products/EB110ITX/>), the IPAQ 1940 or the
+	  Samsung SMDK2410 development board (and derivatives).
+
+config ARCH_S3C64XX_CHOICE
+	bool "Samsung S3C64XX"
+	select ARCH_S3C64XX
+	help
+	  Samsung S3C64XX series based systems
+
+config ARCH_S5P64X0_CHOICE
+	bool "Samsung S5P6440 S5P6450"
+	select ARCH_S5P64X0
+	help
+	  Samsung S5P64X0 CPU based systems, such as the Samsung SMDK6440,
+	  SMDK6450.
+
+config ARCH_S5PC100_CHOICE
+	bool "Samsung S5PC100"
+	select ARCH_S5PC100
+	help
+	  Samsung S5PC100 series based systems
+
+config ARCH_S5PV210_CHOICE
+	bool "Samsung S5PV210/S5PC110"
+	select ARCH_S5PV210
+	help
+	  Samsung S5PV210/S5PC110 series based systems
+
+config ARCH_EXYNOS_CHOICE
+	bool "SAMSUNG EXYNOS"
+	select ARCH_EXYNOS
+	help
+	  Support for SAMSUNG's EXYNOS SoCs (EXYNOS4/5)
+
+config ARCH_SHARK_CHOICE
+	bool "Shark"
+	select ARCH_SHARK
+	help
+	  Support for the StrongARM based Digital DNARD machine, also known
+	  as "Shark" (<http://www.shark-linux.de/shark.html>).
+
+config ARCH_U300_CHOICE
+	bool "ST-Ericsson U300 Series"
+	depends on MMU
+	select ARCH_U300
+	help
+	  Support for ST-Ericsson U300 series mobile platforms.
+
+config ARCH_U8500_CHOICE
+	bool "ST-Ericsson U8500 Series"
+	depends on MMU
+	select ARCH_U8500
+	help
+	  Support for ST-Ericsson's Ux500 architecture
+
+config ARCH_NOMADIK_CHOICE
+	bool "STMicroelectronics Nomadik"
+	select ARCH_NOMADIK
+	help
+	  Support for the Nomadik platform by ST-Ericsson
+
+config ARCH_DAVINCI_CHOICE
+	bool "TI DaVinci"
+	select ARCH_DAVINCI
+	help
+	  Support for TI's DaVinci platform.
+
+config ARCH_OMAP_CHOICE
+	bool "TI OMAP"
+	depends on MMU
+	select ARCH_OMAP
+	help
+	  Support for TI's OMAP platform (OMAP1/2/3/4).
+
+config PLAT_SPEAR_CHOICE
+	bool "ST SPEAr"
+	select PLAT_SPEAR
+	help
+	  Support for ST's SPEAr platform (SPEAr3xx, SPEAr6xx and SPEAr13xx).
+
+config ARCH_VT8500_CHOICE
+	bool "VIA/WonderMedia 85xx"
+	select ARCH_VT8500
+	help
+	  Support for VIA/WonderMedia VT8500/WM85xx System-on-Chip.
+
+config ARCH_ZYNQ_CHOICE
+	bool "Xilinx Zynq ARM Cortex A9 Platform"
+	select ARCH_ZYNQ
+	help
+	  Support for Xilinx Zynq ARM Cortex A9 Platform
+endchoice
+
+#
+# This is sorted alphabetically by mach-* pathname.  However, plat-*
+# Kconfigs may be included either alphabetically (according to the
+# plat- suffix) or along side the corresponding mach-* source.
+#
+source "arch/arm/mach-mvebu/Kconfig"
+
+source "arch/arm/mach-at91/Kconfig"
+
+source "arch/arm/mach-bcmring/Kconfig"
+
+source "arch/arm/mach-clps711x/Kconfig"
+
+source "arch/arm/mach-cns3xxx/Kconfig"
+
+source "arch/arm/mach-davinci/Kconfig"
+
+source "arch/arm/mach-dove/Kconfig"
+
+source "arch/arm/mach-ebsa110/Kconfig"
+
+source "arch/arm/mach-ep93xx/Kconfig"
+
+source "arch/arm/mach-footbridge/Kconfig"
+
+source "arch/arm/mach-gemini/Kconfig"
+
+source "arch/arm/mach-h720x/Kconfig"
+
+source "arch/arm/mach-highbank/Kconfig"
+
+source "arch/arm/mach-integrator/Kconfig"
+
+source "arch/arm/mach-iop32x/Kconfig"
+
+source "arch/arm/mach-iop33x/Kconfig"
+
+source "arch/arm/mach-iop13xx/Kconfig"
+
+source "arch/arm/mach-ixp4xx/Kconfig"
+
+source "arch/arm/mach-kirkwood/Kconfig"
+
+source "arch/arm/mach-ks8695/Kconfig"
+
+source "arch/arm/mach-lpc32xx/Kconfig"
+
+source "arch/arm/mach-msm/Kconfig"
+
+source "arch/arm/mach-mv78xx0/Kconfig"
+
+source "arch/arm/plat-mxc/Kconfig"
+
+source "arch/arm/mach-mxs/Kconfig"
+
+source "arch/arm/mach-netx/Kconfig"
+
+source "arch/arm/mach-nomadik/Kconfig"
+source "arch/arm/plat-nomadik/Kconfig"
+
+source "arch/arm/plat-omap/Kconfig"
+
+source "arch/arm/mach-omap1/Kconfig"
+
+source "arch/arm/mach-omap2/Kconfig"
+
+source "arch/arm/mach-orion5x/Kconfig"
+
+source "arch/arm/mach-picoxcell/Kconfig"
+
+source "arch/arm/mach-pnx4008/Kconfig"
+
+source "arch/arm/mach-pxa/Kconfig"
+source "arch/arm/plat-pxa/Kconfig"
+
+source "arch/arm/mach-mmp/Kconfig"
+
+source "arch/arm/mach-realview/Kconfig"
+
+source "arch/arm/mach-rpc/Kconfig"
+
+source "arch/arm/mach-sa1100/Kconfig"
+
+source "arch/arm/plat-samsung/Kconfig"
+source "arch/arm/plat-s3c24xx/Kconfig"
+
+source "arch/arm/mach-shark/Kconfig"
+
+source "arch/arm/mach-socfpga/Kconfig"
+
+source "arch/arm/plat-spear/Kconfig"
+
+source "arch/arm/mach-s3c24xx/Kconfig"
+if ARCH_S3C24XX
+source "arch/arm/mach-s3c2412/Kconfig"
+source "arch/arm/mach-s3c2440/Kconfig"
+endif
+
+source "arch/arm/mach-s3c64xx/Kconfig"
+
+source "arch/arm/mach-s5p64x0/Kconfig"
+
+source "arch/arm/mach-s5pc100/Kconfig"
+
+source "arch/arm/mach-s5pv210/Kconfig"
+
+source "arch/arm/mach-exynos/Kconfig"
+
+source "arch/arm/mach-shmobile/Kconfig"
+
+source "arch/arm/mach-tegra/Kconfig"
+
+source "arch/arm/mach-u300/Kconfig"
+
+source "arch/arm/mach-ux500/Kconfig"
+
+source "arch/arm/mach-versatile/Kconfig"
+
+source "arch/arm/mach-vexpress/Kconfig"
+source "arch/arm/plat-versatile/Kconfig"
+
+source "arch/arm/mach-vt8500/Kconfig"
+
+source "arch/arm/mach-w90x900/Kconfig"
+
+source "arch/arm/mach-zynq/Kconfig"
+
+# Definitions to make life easier
+config ARCH_ACORN
+	bool
+
+config PLAT_IOP
+	bool
+	select GENERIC_CLOCKEVENTS
+
+config PLAT_ORION
+	bool
+	select CLKSRC_MMIO
+	select GENERIC_IRQ_CHIP
+	select IRQ_DOMAIN
+	select COMMON_CLK
+
+config PLAT_PXA
+	bool
+
+config PLAT_VERSATILE
+	bool
+
-- 
1.7.9.5
