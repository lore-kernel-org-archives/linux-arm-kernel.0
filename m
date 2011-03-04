From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri,  4 Mar 2011 21:51:22 +0100
Subject: [PATCH 6/6] ARM: imx: move mx3 support to mach-imx
In-Reply-To: <20110304205008.GX22310@pengutronix.de>
References: <20110304205008.GX22310@pengutronix.de>
Message-ID: <1299271882-2130-6-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/Makefile                                  |    2 +-
 arch/arm/mach-imx/Kconfig                          |  269 ++++++++++++++++++++
 arch/arm/mach-imx/Makefile                         |   37 +++-
 arch/arm/mach-imx/Makefile.boot                    |    4 +
 arch/arm/mach-imx/cache-l2x0.c                     |   56 ++++
 arch/arm/{mach-mx3 => mach-imx}/clock-imx31.c      |    2 +-
 arch/arm/{mach-mx3 => mach-imx}/clock-imx35.c      |    0
 arch/arm/{mach-mx3/cpu.c => mach-imx/cpu-imx31.c}  |   38 +---
 arch/arm/mach-imx/cpu-imx35.c                      |   45 ++++
 .../crm_regs.h => mach-imx/crmregs-imx31.h}        |    0
 arch/arm/{mach-mx3 => mach-imx}/devices-imx31.h    |    0
 arch/arm/{mach-mx3 => mach-imx}/devices-imx35.h    |    0
 arch/arm/{mach-mx3 => mach-imx}/ehci-imx31.c       |    0
 arch/arm/{mach-mx3 => mach-imx}/ehci-imx35.c       |    0
 .../eukrea_mbimxsd35-baseboard.c}                  |    0
 arch/arm/{mach-mx3 => mach-imx}/iomux-imx31.c      |    0
 .../arm/{mach-mx3 => mach-imx}/mach-armadillo5x0.c |    2 +-
 arch/arm/{mach-mx3 => mach-imx}/mach-bug.c         |    0
 arch/arm/{mach-mx3 => mach-imx}/mach-cpuimx35.c    |    0
 .../arm/{mach-mx3 => mach-imx}/mach-kzm_arm11_01.c |    0
 arch/arm/{mach-mx3 => mach-imx}/mach-mx31_3ds.c    |    0
 arch/arm/{mach-mx3 => mach-imx}/mach-mx31ads.c     |    0
 arch/arm/{mach-mx3 => mach-imx}/mach-mx31lilly.c   |    0
 arch/arm/{mach-mx3 => mach-imx}/mach-mx31lite.c    |    0
 arch/arm/{mach-mx3 => mach-imx}/mach-mx31moboard.c |    0
 arch/arm/{mach-mx3 => mach-imx}/mach-mx35_3ds.c    |    0
 arch/arm/{mach-mx3 => mach-imx}/mach-pcm037.c      |    0
 arch/arm/{mach-mx3 => mach-imx}/mach-pcm037_eet.c  |    0
 arch/arm/{mach-mx3 => mach-imx}/mach-pcm043.c      |    0
 arch/arm/{mach-mx3 => mach-imx}/mach-qong.c        |    0
 arch/arm/{mach-mx3 => mach-imx}/mach-vpr200.c      |    0
 arch/arm/mach-imx/mm-imx31.c                       |   66 +++++
 arch/arm/mach-imx/mm-imx35.c                       |   63 +++++
 arch/arm/{mach-mx3 => mach-imx}/mx31lilly-db.c     |    0
 arch/arm/{mach-mx3 => mach-imx}/mx31lite-db.c      |    0
 .../{mach-mx3 => mach-imx}/mx31moboard-devboard.c  |    0
 .../{mach-mx3 => mach-imx}/mx31moboard-marxbot.c   |    0
 .../{mach-mx3 => mach-imx}/mx31moboard-smartbot.c  |    0
 arch/arm/{mach-mx3 => mach-imx}/pcm037.h           |    0
 arch/arm/mach-mx3/Kconfig                          |  265 -------------------
 arch/arm/mach-mx3/Makefile                         |   26 --
 arch/arm/mach-mx3/Makefile.boot                    |    3 -
 arch/arm/mach-mx3/mm.c                             |  141 ----------
 arch/arm/plat-mxc/Kconfig                          |    1 -
 44 files changed, 539 insertions(+), 481 deletions(-)
 create mode 100644 arch/arm/mach-imx/cache-l2x0.c
 rename arch/arm/{mach-mx3 => mach-imx}/clock-imx31.c (99%)
 rename arch/arm/{mach-mx3 => mach-imx}/clock-imx35.c (100%)
 rename arch/arm/{mach-mx3/cpu.c => mach-imx/cpu-imx31.c} (72%)
 create mode 100644 arch/arm/mach-imx/cpu-imx35.c
 rename arch/arm/{mach-mx3/crm_regs.h => mach-imx/crmregs-imx31.h} (100%)
 rename arch/arm/{mach-mx3 => mach-imx}/devices-imx31.h (100%)
 rename arch/arm/{mach-mx3 => mach-imx}/devices-imx35.h (100%)
 rename arch/arm/{mach-mx3 => mach-imx}/ehci-imx31.c (100%)
 rename arch/arm/{mach-mx3 => mach-imx}/ehci-imx35.c (100%)
 rename arch/arm/{mach-mx3/eukrea_mbimxsd-baseboard.c => mach-imx/eukrea_mbimxsd35-baseboard.c} (100%)
 rename arch/arm/{mach-mx3 => mach-imx}/iomux-imx31.c (100%)
 rename arch/arm/{mach-mx3 => mach-imx}/mach-armadillo5x0.c (99%)
 rename arch/arm/{mach-mx3 => mach-imx}/mach-bug.c (100%)
 rename arch/arm/{mach-mx3 => mach-imx}/mach-cpuimx35.c (100%)
 rename arch/arm/{mach-mx3 => mach-imx}/mach-kzm_arm11_01.c (100%)
 rename arch/arm/{mach-mx3 => mach-imx}/mach-mx31_3ds.c (100%)
 rename arch/arm/{mach-mx3 => mach-imx}/mach-mx31ads.c (100%)
 rename arch/arm/{mach-mx3 => mach-imx}/mach-mx31lilly.c (100%)
 rename arch/arm/{mach-mx3 => mach-imx}/mach-mx31lite.c (100%)
 rename arch/arm/{mach-mx3 => mach-imx}/mach-mx31moboard.c (100%)
 rename arch/arm/{mach-mx3 => mach-imx}/mach-mx35_3ds.c (100%)
 rename arch/arm/{mach-mx3 => mach-imx}/mach-pcm037.c (100%)
 rename arch/arm/{mach-mx3 => mach-imx}/mach-pcm037_eet.c (100%)
 rename arch/arm/{mach-mx3 => mach-imx}/mach-pcm043.c (100%)
 rename arch/arm/{mach-mx3 => mach-imx}/mach-qong.c (100%)
 rename arch/arm/{mach-mx3 => mach-imx}/mach-vpr200.c (100%)
 create mode 100644 arch/arm/mach-imx/mm-imx31.c
 create mode 100644 arch/arm/mach-imx/mm-imx35.c
 rename arch/arm/{mach-mx3 => mach-imx}/mx31lilly-db.c (100%)
 rename arch/arm/{mach-mx3 => mach-imx}/mx31lite-db.c (100%)
 rename arch/arm/{mach-mx3 => mach-imx}/mx31moboard-devboard.c (100%)
 rename arch/arm/{mach-mx3 => mach-imx}/mx31moboard-marxbot.c (100%)
 rename arch/arm/{mach-mx3 => mach-imx}/mx31moboard-smartbot.c (100%)
 rename arch/arm/{mach-mx3 => mach-imx}/pcm037.h (100%)
 delete mode 100644 arch/arm/mach-mx3/Kconfig
 delete mode 100644 arch/arm/mach-mx3/Makefile
 delete mode 100644 arch/arm/mach-mx3/Makefile.boot
 delete mode 100644 arch/arm/mach-mx3/mm.c

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index c22c1ad..63fbfca 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -155,7 +155,7 @@ machine-$(CONFIG_ARCH_MV78XX0)		:= mv78xx0
 machine-$(CONFIG_ARCH_MX1)		:= imx
 machine-$(CONFIG_ARCH_MX2)		:= imx
 machine-$(CONFIG_ARCH_MX25)		:= imx
-machine-$(CONFIG_ARCH_MX3)		:= mx3
+machine-$(CONFIG_ARCH_MX3)		:= imx
 machine-$(CONFIG_ARCH_MX5)		:= mx5
 machine-$(CONFIG_ARCH_MXC91231)		:= mxc91231
 machine-$(CONFIG_ARCH_MXS)		:= mxs
diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 5eec099..d879a17 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -1,5 +1,15 @@
 config IMX_HAVE_DMA_V1
 	bool
+#
+# ARCH_MX31 and ARCH_MX35 are left for compatibility
+# Some usages assume that having one of them implies not having (e.g.) ARCH_MX2.
+# To easily distinguish good and reviewed from unreviewed usages new (and IMHO
+# more sensible) names are used: SOC_IMX31 and SOC_IMX35
+config ARCH_MX31
+	bool
+
+config ARCH_MX35
+	bool
 
 config SOC_IMX1
 	bool
@@ -31,6 +41,22 @@ config SOC_IMX27
 	select IMX_HAVE_IOMUX_V1
 	select MXC_AVIC
 
+config SOC_IMX31
+	bool
+	select IMX_HAVE_PLATFORM_MXC_RNGA
+	select ARCH_MXC_AUDMUX_V2
+	select ARCH_MX31
+	select MXC_AVIC
+
+config SOC_IMX35
+	bool
+	select ARCH_MXC_IOMUX_V3
+	select ARCH_MXC_AUDMUX_V2
+	select HAVE_EPIT
+	select ARCH_MX35
+	select MXC_AVIC
+
+
 if ARCH_MX1
 
 comment "MX1 platforms:"
@@ -313,3 +339,246 @@ config MACH_IMX27IPCAM
 	  configurations for the board and its peripherals.
 
 endif
+
+if ARCH_MX3
+
+comment "MX31 platforms:"
+
+config MACH_MX31ADS
+	bool "Support MX31ADS platforms"
+	select SOC_IMX31
+	select IMX_HAVE_PLATFORM_IMX_I2C
+	select IMX_HAVE_PLATFORM_IMX_SSI
+	select IMX_HAVE_PLATFORM_IMX_UART
+	default y
+	help
+	  Include support for MX31ADS platform. This includes specific
+	  configurations for the board and its peripherals.
+
+config MACH_MX31ADS_WM1133_EV1
+	bool "Support Wolfson Microelectronics 1133-EV1 module"
+	depends on MACH_MX31ADS
+	depends on MFD_WM8350_I2C
+	depends on REGULATOR_WM8350
+	select MFD_WM8350_CONFIG_MODE_0
+	select MFD_WM8352_CONFIG_MODE_0
+	help
+	  Include support for the Wolfson Microelectronics 1133-EV1 PMU
+	  and audio module for the MX31ADS platform.
+
+config MACH_MX31LILLY
+	bool "Support MX31 LILLY-1131 platforms (INCO startec)"
+	select SOC_IMX31
+	select IMX_HAVE_PLATFORM_IMX_UART
+	select IMX_HAVE_PLATFORM_IPU_CORE
+	select IMX_HAVE_PLATFORM_MXC_EHCI
+	select IMX_HAVE_PLATFORM_MXC_MMC
+	select IMX_HAVE_PLATFORM_SPI_IMX
+	select MXC_ULPI if USB_ULPI
+	help
+	  Include support for mx31 based LILLY1131 modules. This includes
+	  specific configurations for the board and its peripherals.
+
+config MACH_MX31LITE
+	bool "Support MX31 LITEKIT (LogicPD)"
+	select SOC_IMX31
+	select MXC_ULPI if USB_ULPI
+	select IMX_HAVE_PLATFORM_IMX2_WDT
+	select IMX_HAVE_PLATFORM_IMX_UART
+	select IMX_HAVE_PLATFORM_MXC_EHCI
+	select IMX_HAVE_PLATFORM_MXC_MMC
+	select IMX_HAVE_PLATFORM_MXC_NAND
+	select IMX_HAVE_PLATFORM_MXC_RTC
+	select IMX_HAVE_PLATFORM_SPI_IMX
+	help
+	  Include support for MX31 LITEKIT platform. This includes specific
+	  configurations for the board and its peripherals.
+
+config MACH_PCM037
+	bool "Support Phytec pcm037 (i.MX31) platforms"
+	select SOC_IMX31
+	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
+	select IMX_HAVE_PLATFORM_IMX2_WDT
+	select IMX_HAVE_PLATFORM_IMX_I2C
+	select IMX_HAVE_PLATFORM_IMX_UART
+	select IMX_HAVE_PLATFORM_IPU_CORE
+	select IMX_HAVE_PLATFORM_MXC_EHCI
+	select IMX_HAVE_PLATFORM_MXC_MMC
+	select IMX_HAVE_PLATFORM_MXC_NAND
+	select IMX_HAVE_PLATFORM_MXC_W1
+	select MXC_ULPI if USB_ULPI
+	help
+	  Include support for Phytec pcm037 platform. This includes
+	  specific configurations for the board and its peripherals.
+
+config MACH_PCM037_EET
+	bool "Support pcm037 EET board extensions"
+	depends on MACH_PCM037
+	select IMX_HAVE_PLATFORM_SPI_IMX
+	help
+	  Add support for PCM037 EET baseboard extensions. If you are using the
+	  OLED display with EET, use "video=mx3fb:CMEL-OLED" kernel
+	  command-line parameter.
+
+config MACH_MX31_3DS
+	bool "Support MX31PDK (3DS)"
+	select SOC_IMX31
+	select MXC_DEBUG_BOARD
+	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
+	select IMX_HAVE_PLATFORM_IMX2_WDT
+	select IMX_HAVE_PLATFORM_IMX_I2C
+	select IMX_HAVE_PLATFORM_IMX_KEYPAD
+	select IMX_HAVE_PLATFORM_IMX_UART
+	select IMX_HAVE_PLATFORM_MXC_EHCI
+	select IMX_HAVE_PLATFORM_MXC_NAND
+	select IMX_HAVE_PLATFORM_SPI_IMX
+	select MXC_ULPI if USB_ULPI
+	help
+	  Include support for MX31PDK (3DS) platform. This includes specific
+	  configurations for the board and its peripherals.
+
+config MACH_MX31_3DS_MXC_NAND_USE_BBT
+	bool "Make the MXC NAND driver use the in flash Bad Block Table"
+	depends on MACH_MX31_3DS
+	depends on MTD_NAND_MXC
+	help
+	  Enable this if you want that the MXC NAND driver uses the in flash
+	  Bad Block Table to know what blocks are bad instead of scanning the
+	  entire flash looking for bad block markers.
+
+config MACH_MX31MOBOARD
+	bool "Support mx31moboard platforms (EPFL Mobots group)"
+	select SOC_IMX31
+	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
+	select IMX_HAVE_PLATFORM_IMX_I2C
+	select IMX_HAVE_PLATFORM_IMX_UART
+	select IMX_HAVE_PLATFORM_IPU_CORE
+	select IMX_HAVE_PLATFORM_MXC_EHCI
+	select IMX_HAVE_PLATFORM_MXC_MMC
+	select IMX_HAVE_PLATFORM_SPI_IMX
+	select MXC_ULPI if USB_ULPI
+	help
+	  Include support for mx31moboard platform. This includes specific
+	  configurations for the board and its peripherals.
+
+config MACH_QONG
+	bool "Support Dave/DENX QongEVB-LITE platform"
+	select SOC_IMX31
+	select IMX_HAVE_PLATFORM_IMX_UART
+	help
+	  Include support for Dave/DENX QongEVB-LITE platform. This includes
+	  specific configurations for the board and its peripherals.
+
+config MACH_ARMADILLO5X0
+	bool "Support Atmark Armadillo-500 Development Base Board"
+	select SOC_IMX31
+	select IMX_HAVE_PLATFORM_IMX_I2C
+	select IMX_HAVE_PLATFORM_IMX_UART
+	select IMX_HAVE_PLATFORM_IPU_CORE
+	select IMX_HAVE_PLATFORM_MXC_EHCI
+	select IMX_HAVE_PLATFORM_MXC_MMC
+	select IMX_HAVE_PLATFORM_MXC_NAND
+	select MXC_ULPI if USB_ULPI
+	help
+	  Include support for Atmark Armadillo-500 platform. This includes
+	  specific configurations for the board and its peripherals.
+
+config MACH_KZM_ARM11_01
+	bool "Support KZM-ARM11-01(Kyoto Microcomputer)"
+	select SOC_IMX31
+	select IMX_HAVE_PLATFORM_IMX_UART
+	help
+	  Include support for KZM-ARM11-01. This includes specific
+	  configurations for the board and its peripherals.
+
+config MACH_BUG
+	bool "Support Buglabs BUGBase platform"
+	select SOC_IMX31
+	select IMX_HAVE_PLATFORM_IMX_UART
+	default y
+	help
+	  Include support for BUGBase 1.3 platform. This includes specific
+	  configurations for the board and its peripherals.
+
+comment "MX35 platforms:"
+
+config MACH_PCM043
+	bool "Support Phytec pcm043 (i.MX35) platforms"
+	select SOC_IMX35
+	select IMX_HAVE_PLATFORM_FLEXCAN
+	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
+	select IMX_HAVE_PLATFORM_IMX2_WDT
+	select IMX_HAVE_PLATFORM_IMX_I2C
+	select IMX_HAVE_PLATFORM_IMX_SSI
+	select IMX_HAVE_PLATFORM_IMX_UART
+	select IMX_HAVE_PLATFORM_IPU_CORE
+	select IMX_HAVE_PLATFORM_MXC_EHCI
+	select IMX_HAVE_PLATFORM_MXC_NAND
+	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
+	select MXC_ULPI if USB_ULPI
+	help
+	  Include support for Phytec pcm043 platform. This includes
+	  specific configurations for the board and its peripherals.
+
+config MACH_MX35_3DS
+	bool "Support MX35PDK platform"
+	select SOC_IMX35
+	select MXC_DEBUG_BOARD
+	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
+	select IMX_HAVE_PLATFORM_IMX2_WDT
+	select IMX_HAVE_PLATFORM_IMX_I2C
+	select IMX_HAVE_PLATFORM_IMX_UART
+	select IMX_HAVE_PLATFORM_MXC_EHCI
+	select IMX_HAVE_PLATFORM_MXC_NAND
+	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
+	help
+	  Include support for MX35PDK platform. This includes specific
+	  configurations for the board and its peripherals.
+
+config MACH_EUKREA_CPUIMX35
+	bool "Support Eukrea CPUIMX35 Platform"
+	select SOC_IMX35
+	select IMX_HAVE_PLATFORM_FLEXCAN
+	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
+	select IMX_HAVE_PLATFORM_IMX2_WDT
+	select IMX_HAVE_PLATFORM_IMX_I2C
+	select IMX_HAVE_PLATFORM_IMX_UART
+	select IMX_HAVE_PLATFORM_MXC_EHCI
+	select IMX_HAVE_PLATFORM_MXC_NAND
+	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
+	select MXC_ULPI if USB_ULPI
+	help
+	  Include support for Eukrea CPUIMX35 platform. This includes
+	  specific configurations for the board and its peripherals.
+
+choice
+	prompt "Baseboard"
+	depends on MACH_EUKREA_CPUIMX35
+	default MACH_EUKREA_MBIMXSD35_BASEBOARD
+
+config MACH_EUKREA_MBIMXSD35_BASEBOARD
+	bool "Eukrea MBIMXSD development board"
+	select IMX_HAVE_PLATFORM_IMX_SSI
+	select IMX_HAVE_PLATFORM_IPU_CORE
+	help
+	  This adds board specific devices that can be found on Eukrea's
+	  MBIMXSD evaluation board.
+
+endchoice
+
+config MACH_VPR200
+	bool "Support VPR200 platform"
+	select SOC_IMX35
+	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
+	select IMX_HAVE_PLATFORM_IMX2_WDT
+	select IMX_HAVE_PLATFORM_IMX_UART
+	select IMX_HAVE_PLATFORM_IMX_I2C
+	select IMX_HAVE_PLATFORM_IPU_CORE
+	select IMX_HAVE_PLATFORM_MXC_EHCI
+	select IMX_HAVE_PLATFORM_MXC_NAND
+	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
+	help
+	  Include support for VPR200 platform. This includes specific
+	  configurations for the board and its peripherals.
+
+endif
diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index b85794d..6d51e65 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -1,9 +1,3 @@
-#
-# Makefile for the linux kernel.
-#
-
-# Object file lists.
-
 obj-$(CONFIG_IMX_HAVE_DMA_V1) += dma-v1.o
 
 obj-$(CONFIG_ARCH_MX1) += clock-imx1.o mm-imx1.o
@@ -14,18 +8,26 @@ obj-$(CONFIG_ARCH_MX25) += clock-imx25.o mm-imx25.o ehci-imx25.o
 obj-$(CONFIG_MACH_MX27) += cpu-imx27.o pm-imx27.o
 obj-$(CONFIG_MACH_MX27) += clock-imx27.o mm-imx27.o ehci-imx27.o
 
+obj-$(CONFIG_SOC_IMX31) += mm-imx31.o cpu-imx31.o clock-imx31.o iomux-imx31.o ehci-imx31.o
+obj-$(CONFIG_SOC_IMX35) += mm-imx35.o cpu-imx35.o clock-imx35.o ehci-imx35.o
+obj-$(CONFIG_CACHE_L2X0) += cache-l2x0.o
+
 # Support for CMOS sensor interface
-obj-$(CONFIG_MX1_VIDEO)	+= mx1-camera-fiq.o mx1-camera-fiq-ksym.o
+obj-$(CONFIG_MX1_VIDEO) += mx1-camera-fiq.o mx1-camera-fiq-ksym.o
 
+# i.MX1 based machines
 obj-$(CONFIG_ARCH_MX1ADS) += mach-mx1ads.o
 obj-$(CONFIG_MACH_SCB9328) += mach-scb9328.o
 
+# i.MX21 based machines
 obj-$(CONFIG_MACH_MX21ADS) += mach-mx21ads.o
 
+# i.MX25 based machines
 obj-$(CONFIG_MACH_MX25_3DS) += mach-mx25_3ds.o
 obj-$(CONFIG_MACH_EUKREA_CPUIMX25) += mach-eukrea_cpuimx25.o
 obj-$(CONFIG_MACH_EUKREA_MBIMXSD25_BASEBOARD) += eukrea_mbimxsd25-baseboard.o
 
+# i.MX27 based machines
 obj-$(CONFIG_MACH_MX27ADS) += mach-mx27ads.o
 obj-$(CONFIG_MACH_PCM038) += mach-pcm038.o
 obj-$(CONFIG_MACH_PCM970_BASEBOARD) += pcm970-baseboard.o
@@ -37,3 +39,24 @@ obj-$(CONFIG_MACH_EUKREA_MBIMX27_BASEBOARD) += eukrea_mbimx27-baseboard.o
 obj-$(CONFIG_MACH_PCA100) += mach-pca100.o
 obj-$(CONFIG_MACH_MXT_TD60) += mach-mxt_td60.o
 obj-$(CONFIG_MACH_IMX27IPCAM) += mach-imx27ipcam.o
+
+# i.MX31 based machines
+obj-$(CONFIG_MACH_MX31ADS) += mach-mx31ads.o
+obj-$(CONFIG_MACH_MX31LILLY) += mach-mx31lilly.o mx31lilly-db.o
+obj-$(CONFIG_MACH_MX31LITE) += mach-mx31lite.o mx31lite-db.o
+obj-$(CONFIG_MACH_PCM037) += mach-pcm037.o
+obj-$(CONFIG_MACH_PCM037_EET) += mach-pcm037_eet.o
+obj-$(CONFIG_MACH_MX31_3DS) += mach-mx31_3ds.o
+obj-$(CONFIG_MACH_MX31MOBOARD) += mach-mx31moboard.o mx31moboard-devboard.o \
+		mx31moboard-marxbot.o mx31moboard-smartbot.o
+obj-$(CONFIG_MACH_QONG) += mach-qong.o
+obj-$(CONFIG_MACH_ARMADILLO5X0) += mach-armadillo5x0.o
+obj-$(CONFIG_MACH_KZM_ARM11_01) += mach-kzm_arm11_01.o
+obj-$(CONFIG_MACH_BUG) += mach-bug.o
+
+# i.MX35 based machines
+obj-$(CONFIG_MACH_PCM043) += mach-pcm043.o
+obj-$(CONFIG_MACH_MX35_3DS) += mach-mx35_3ds.o
+obj-$(CONFIG_MACH_EUKREA_CPUIMX35) += mach-cpuimx35.o
+obj-$(CONFIG_MACH_EUKREA_MBIMXSD35_BASEBOARD) += eukrea_mbimxsd35-baseboard.o
+obj-$(CONFIG_MACH_VPR200) += mach-vpr200.o
diff --git a/arch/arm/mach-imx/Makefile.boot b/arch/arm/mach-imx/Makefile.boot
index 3953d60..ebee18b 100644
--- a/arch/arm/mach-imx/Makefile.boot
+++ b/arch/arm/mach-imx/Makefile.boot
@@ -13,3 +13,7 @@ initrd_phys-$(CONFIG_ARCH_MX25)	:= 0x80800000
 zreladdr-$(CONFIG_MACH_MX27)	:= 0xA0008000
 params_phys-$(CONFIG_MACH_MX27)	:= 0xA0000100
 initrd_phys-$(CONFIG_MACH_MX27)	:= 0xA0800000
+
+zreladdr-$(CONFIG_ARCH_MX3)	:= 0x80008000
+params_phys-$(CONFIG_ARCH_MX3)	:= 0x80000100
+initrd_phys-$(CONFIG_ARCH_MX3)	:= 0x80800000
diff --git a/arch/arm/mach-imx/cache-l2x0.c b/arch/arm/mach-imx/cache-l2x0.c
new file mode 100644
index 0000000..69d1322
--- /dev/null
+++ b/arch/arm/mach-imx/cache-l2x0.c
@@ -0,0 +1,56 @@
+/*
+ * Copyright (C) 2009-2010 Pengutronix
+ * Sascha Hauer <s.hauer@pengutronix.de>
+ * Juergen Beisert <j.beisert@pengutronix.de>
+ *
+ * This program is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU General Public License version 2 as published by the
+ * Free Software Foundation.
+ */
+
+#include <linux/init.h>
+#include <linux/err.h>
+#include <linux/kernel.h>
+
+#include <asm/hardware/cache-l2x0.h>
+
+#include <mach/hardware.h>
+
+static int mxc_init_l2x0(void)
+{
+	void __iomem *l2x0_base;
+	void __iomem *clkctl_base;
+
+	if (!cpu_is_mx31() && !cpu_is_mx35())
+		return 0;
+
+/*
+ * First of all, we must repair broken chip settings. There are some
+ * i.MX35 CPUs in the wild, comming with bogus L2 cache settings. These
+ * misconfigured CPUs will run amok immediately when the L2 cache gets enabled.
+ * Workaraound is to setup the correct register setting prior enabling the
+ * L2 cache. This should not hurt already working CPUs, as they are using the
+ * same value.
+ */
+#define L2_MEM_VAL 0x10
+
+	clkctl_base = ioremap(MX35_CLKCTL_BASE_ADDR, 4096);
+	if (clkctl_base != NULL) {
+		writel(0x00000515, clkctl_base + L2_MEM_VAL);
+		iounmap(clkctl_base);
+	} else {
+		pr_err("L2 cache: Cannot fix timing. Trying to continue without\n");
+	}
+
+	l2x0_base = ioremap(MX3x_L2CC_BASE_ADDR, 4096);
+	if (IS_ERR(l2x0_base)) {
+		printk(KERN_ERR "remapping L2 cache area failed with %ld\n",
+				PTR_ERR(l2x0_base));
+		return 0;
+	}
+
+	l2x0_init(l2x0_base, 0x00030024, 0x00000000);
+
+	return 0;
+}
+arch_initcall(mxc_init_l2x0);
diff --git a/arch/arm/mach-mx3/clock-imx31.c b/arch/arm/mach-imx/clock-imx31.c
similarity index 99%
rename from arch/arm/mach-mx3/clock-imx31.c
rename to arch/arm/mach-imx/clock-imx31.c
index d423cac..8081f07 100644
--- a/arch/arm/mach-mx3/clock-imx31.c
+++ b/arch/arm/mach-imx/clock-imx31.c
@@ -32,7 +32,7 @@
 #include <mach/mx31.h>
 #include <mach/common.h>
 
-#include "crm_regs.h"
+#include "crmregs-imx31.h"
 
 #define PRE_DIV_MIN_FREQ    10000000 /* Minimum Frequency after Predivider */
 
diff --git a/arch/arm/mach-mx3/clock-imx35.c b/arch/arm/mach-imx/clock-imx35.c
similarity index 100%
rename from arch/arm/mach-mx3/clock-imx35.c
rename to arch/arm/mach-imx/clock-imx35.c
diff --git a/arch/arm/mach-mx3/cpu.c b/arch/arm/mach-imx/cpu-imx31.c
similarity index 72%
rename from arch/arm/mach-mx3/cpu.c
rename to arch/arm/mach-imx/cpu-imx31.c
index d1d3395..a378070 100644
--- a/arch/arm/mach-mx3/cpu.c
+++ b/arch/arm/mach-imx/cpu-imx31.c
@@ -1,5 +1,5 @@
 /*
- * MX3 CPU type detection
+ * MX31 CPU type detection
  *
  * Copyright (c) 2009 Daniel Mack <daniel@caiaq.de>
  *
@@ -17,14 +17,12 @@
 unsigned int mx31_cpu_rev;
 EXPORT_SYMBOL(mx31_cpu_rev);
 
-struct mx3_cpu_type {
+static struct {
 	u8 srev;
 	const char *name;
 	const char *v;
 	unsigned int rev;
-};
-
-static struct mx3_cpu_type mx31_cpu_type[] __initdata = {
+} mx31_cpu_type[] __initdata = {
 	{ .srev = 0x00, .name = "i.MX31(L)", .v = "1.0",  .rev = IMX_CHIP_REVISION_1_0	},
 	{ .srev = 0x10, .name = "i.MX31",    .v = "1.1",  .rev = IMX_CHIP_REVISION_1_1	},
 	{ .srev = 0x11, .name = "i.MX31L",   .v = "1.1",  .rev = IMX_CHIP_REVISION_1_1	},
@@ -57,33 +55,3 @@ void __init mx31_read_cpu_rev(void)
 
 	printk(KERN_WARNING "Unknown CPU identifier. srev = %02x\n", srev);
 }
-
-unsigned int mx35_cpu_rev;
-EXPORT_SYMBOL(mx35_cpu_rev);
-
-void __init mx35_read_cpu_rev(void)
-{
-	u32 rev;
-	char *srev;
-
-	rev = __raw_readl(MX35_IO_ADDRESS(MX35_IIM_BASE_ADDR + MXC_IIMSREV));
-	switch (rev) {
-	case 0x00:
-		mx35_cpu_rev = IMX_CHIP_REVISION_1_0;
-		srev = "1.0";
-		break;
-	case 0x10:
-		mx35_cpu_rev = IMX_CHIP_REVISION_2_0;
-		srev = "2.0";
-		break;
-	case 0x11:
-		mx35_cpu_rev = IMX_CHIP_REVISION_2_1;
-		srev = "2.1";
-		break;
-	default:
-		mx35_cpu_rev = IMX_CHIP_REVISION_UNKNOWN;
-		srev = "unknown";
-	}
-
-	printk(KERN_INFO "CPU identified as i.MX35, silicon rev %s\n", srev);
-}
diff --git a/arch/arm/mach-imx/cpu-imx35.c b/arch/arm/mach-imx/cpu-imx35.c
new file mode 100644
index 0000000..52b59fc
--- /dev/null
+++ b/arch/arm/mach-imx/cpu-imx35.c
@@ -0,0 +1,45 @@
+/*
+ * MX35 CPU type detection
+ *
+ * Copyright (c) 2009 Daniel Mack <daniel@caiaq.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+#include <linux/module.h>
+#include <linux/io.h>
+#include <mach/hardware.h>
+#include <mach/iim.h>
+
+unsigned int mx35_cpu_rev;
+EXPORT_SYMBOL(mx35_cpu_rev);
+
+void __init mx35_read_cpu_rev(void)
+{
+	u32 rev;
+	char *srev;
+
+	rev = __raw_readl(MX35_IO_ADDRESS(MX35_IIM_BASE_ADDR + MXC_IIMSREV));
+	switch (rev) {
+	case 0x00:
+		mx35_cpu_rev = IMX_CHIP_REVISION_1_0;
+		srev = "1.0";
+		break;
+	case 0x10:
+		mx35_cpu_rev = IMX_CHIP_REVISION_2_0;
+		srev = "2.0";
+		break;
+	case 0x11:
+		mx35_cpu_rev = IMX_CHIP_REVISION_2_1;
+		srev = "2.1";
+		break;
+	default:
+		mx35_cpu_rev = IMX_CHIP_REVISION_UNKNOWN;
+		srev = "unknown";
+	}
+
+	printk(KERN_INFO "CPU identified as i.MX35, silicon rev %s\n", srev);
+}
+
diff --git a/arch/arm/mach-mx3/crm_regs.h b/arch/arm/mach-imx/crmregs-imx31.h
similarity index 100%
rename from arch/arm/mach-mx3/crm_regs.h
rename to arch/arm/mach-imx/crmregs-imx31.h
diff --git a/arch/arm/mach-mx3/devices-imx31.h b/arch/arm/mach-imx/devices-imx31.h
similarity index 100%
rename from arch/arm/mach-mx3/devices-imx31.h
rename to arch/arm/mach-imx/devices-imx31.h
diff --git a/arch/arm/mach-mx3/devices-imx35.h b/arch/arm/mach-imx/devices-imx35.h
similarity index 100%
rename from arch/arm/mach-mx3/devices-imx35.h
rename to arch/arm/mach-imx/devices-imx35.h
diff --git a/arch/arm/mach-mx3/ehci-imx31.c b/arch/arm/mach-imx/ehci-imx31.c
similarity index 100%
rename from arch/arm/mach-mx3/ehci-imx31.c
rename to arch/arm/mach-imx/ehci-imx31.c
diff --git a/arch/arm/mach-mx3/ehci-imx35.c b/arch/arm/mach-imx/ehci-imx35.c
similarity index 100%
rename from arch/arm/mach-mx3/ehci-imx35.c
rename to arch/arm/mach-imx/ehci-imx35.c
diff --git a/arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c b/arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c
similarity index 100%
rename from arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c
rename to arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c
diff --git a/arch/arm/mach-mx3/iomux-imx31.c b/arch/arm/mach-imx/iomux-imx31.c
similarity index 100%
rename from arch/arm/mach-mx3/iomux-imx31.c
rename to arch/arm/mach-imx/iomux-imx31.c
diff --git a/arch/arm/mach-mx3/mach-armadillo5x0.c b/arch/arm/mach-imx/mach-armadillo5x0.c
similarity index 99%
rename from arch/arm/mach-mx3/mach-armadillo5x0.c
rename to arch/arm/mach-imx/mach-armadillo5x0.c
index 9f4543f..d5f4c76 100644
--- a/arch/arm/mach-mx3/mach-armadillo5x0.c
+++ b/arch/arm/mach-imx/mach-armadillo5x0.c
@@ -52,7 +52,7 @@
 #include <mach/ulpi.h>
 
 #include "devices-imx31.h"
-#include "crm_regs.h"
+#include "crmregs-imx31.h"
 
 static int armadillo5x0_pins[] = {
 	/* UART1 */
diff --git a/arch/arm/mach-mx3/mach-bug.c b/arch/arm/mach-imx/mach-bug.c
similarity index 100%
rename from arch/arm/mach-mx3/mach-bug.c
rename to arch/arm/mach-imx/mach-bug.c
diff --git a/arch/arm/mach-mx3/mach-cpuimx35.c b/arch/arm/mach-imx/mach-cpuimx35.c
similarity index 100%
rename from arch/arm/mach-mx3/mach-cpuimx35.c
rename to arch/arm/mach-imx/mach-cpuimx35.c
diff --git a/arch/arm/mach-mx3/mach-kzm_arm11_01.c b/arch/arm/mach-imx/mach-kzm_arm11_01.c
similarity index 100%
rename from arch/arm/mach-mx3/mach-kzm_arm11_01.c
rename to arch/arm/mach-imx/mach-kzm_arm11_01.c
diff --git a/arch/arm/mach-mx3/mach-mx31_3ds.c b/arch/arm/mach-imx/mach-mx31_3ds.c
similarity index 100%
rename from arch/arm/mach-mx3/mach-mx31_3ds.c
rename to arch/arm/mach-imx/mach-mx31_3ds.c
diff --git a/arch/arm/mach-mx3/mach-mx31ads.c b/arch/arm/mach-imx/mach-mx31ads.c
similarity index 100%
rename from arch/arm/mach-mx3/mach-mx31ads.c
rename to arch/arm/mach-imx/mach-mx31ads.c
diff --git a/arch/arm/mach-mx3/mach-mx31lilly.c b/arch/arm/mach-imx/mach-mx31lilly.c
similarity index 100%
rename from arch/arm/mach-mx3/mach-mx31lilly.c
rename to arch/arm/mach-imx/mach-mx31lilly.c
diff --git a/arch/arm/mach-mx3/mach-mx31lite.c b/arch/arm/mach-imx/mach-mx31lite.c
similarity index 100%
rename from arch/arm/mach-mx3/mach-mx31lite.c
rename to arch/arm/mach-imx/mach-mx31lite.c
diff --git a/arch/arm/mach-mx3/mach-mx31moboard.c b/arch/arm/mach-imx/mach-mx31moboard.c
similarity index 100%
rename from arch/arm/mach-mx3/mach-mx31moboard.c
rename to arch/arm/mach-imx/mach-mx31moboard.c
diff --git a/arch/arm/mach-mx3/mach-mx35_3ds.c b/arch/arm/mach-imx/mach-mx35_3ds.c
similarity index 100%
rename from arch/arm/mach-mx3/mach-mx35_3ds.c
rename to arch/arm/mach-imx/mach-mx35_3ds.c
diff --git a/arch/arm/mach-mx3/mach-pcm037.c b/arch/arm/mach-imx/mach-pcm037.c
similarity index 100%
rename from arch/arm/mach-mx3/mach-pcm037.c
rename to arch/arm/mach-imx/mach-pcm037.c
diff --git a/arch/arm/mach-mx3/mach-pcm037_eet.c b/arch/arm/mach-imx/mach-pcm037_eet.c
similarity index 100%
rename from arch/arm/mach-mx3/mach-pcm037_eet.c
rename to arch/arm/mach-imx/mach-pcm037_eet.c
diff --git a/arch/arm/mach-mx3/mach-pcm043.c b/arch/arm/mach-imx/mach-pcm043.c
similarity index 100%
rename from arch/arm/mach-mx3/mach-pcm043.c
rename to arch/arm/mach-imx/mach-pcm043.c
diff --git a/arch/arm/mach-mx3/mach-qong.c b/arch/arm/mach-imx/mach-qong.c
similarity index 100%
rename from arch/arm/mach-mx3/mach-qong.c
rename to arch/arm/mach-imx/mach-qong.c
diff --git a/arch/arm/mach-mx3/mach-vpr200.c b/arch/arm/mach-imx/mach-vpr200.c
similarity index 100%
rename from arch/arm/mach-mx3/mach-vpr200.c
rename to arch/arm/mach-imx/mach-vpr200.c
diff --git a/arch/arm/mach-imx/mm-imx31.c b/arch/arm/mach-imx/mm-imx31.c
new file mode 100644
index 0000000..86b9b45
--- /dev/null
+++ b/arch/arm/mach-imx/mm-imx31.c
@@ -0,0 +1,66 @@
+/*
+ *  Copyright (C) 1999,2000 Arm Limited
+ *  Copyright (C) 2000 Deep Blue Solutions Ltd
+ *  Copyright (C) 2002 Shane Nay (shane at minirl.com)
+ *  Copyright 2005-2007 Freescale Semiconductor, Inc. All Rights Reserved.
+ *    - add MX31 specific definitions
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/mm.h>
+#include <linux/init.h>
+#include <linux/err.h>
+
+#include <asm/pgtable.h>
+#include <asm/mach/map.h>
+
+#include <mach/common.h>
+#include <mach/hardware.h>
+#include <mach/iomux-v3.h>
+#include <mach/gpio.h>
+#include <mach/irqs.h>
+
+static struct map_desc mx31_io_desc[] __initdata = {
+	imx_map_entry(MX31, X_MEMC, MT_DEVICE),
+	imx_map_entry(MX31, AVIC, MT_DEVICE_NONSHARED),
+	imx_map_entry(MX31, AIPS1, MT_DEVICE_NONSHARED),
+	imx_map_entry(MX31, AIPS2, MT_DEVICE_NONSHARED),
+	imx_map_entry(MX31, SPBA0, MT_DEVICE_NONSHARED),
+};
+
+/*
+ * This function initializes the memory map. It is called during the
+ * system startup to create static physical to virtual memory mappings
+ * for the IO modules.
+ */
+void __init mx31_map_io(void)
+{
+	iotable_init(mx31_io_desc, ARRAY_SIZE(mx31_io_desc));
+}
+
+void __init imx31_init_early(void)
+{
+	mxc_set_cpu_type(MXC_CPU_MX31);
+	mxc_arch_reset_init(MX31_IO_ADDRESS(MX31_WDOG_BASE_ADDR));
+}
+
+static struct mxc_gpio_port imx31_gpio_ports[] = {
+	DEFINE_IMX_GPIO_PORT_IRQ(MX31, 0, 1, MX31_INT_GPIO1),
+	DEFINE_IMX_GPIO_PORT_IRQ(MX31, 1, 2, MX31_INT_GPIO2),
+	DEFINE_IMX_GPIO_PORT_IRQ(MX31, 2, 3, MX31_INT_GPIO3),
+};
+
+void __init mx31_init_irq(void)
+{
+	mxc_init_irq(MX31_IO_ADDRESS(MX31_AVIC_BASE_ADDR));
+	mxc_gpio_init(imx31_gpio_ports,	ARRAY_SIZE(imx31_gpio_ports));
+}
diff --git a/arch/arm/mach-imx/mm-imx35.c b/arch/arm/mach-imx/mm-imx35.c
new file mode 100644
index 0000000..c880e6d
--- /dev/null
+++ b/arch/arm/mach-imx/mm-imx35.c
@@ -0,0 +1,63 @@
+/*
+ *  Copyright (C) 1999,2000 Arm Limited
+ *  Copyright (C) 2000 Deep Blue Solutions Ltd
+ *  Copyright (C) 2002 Shane Nay (shane at minirl.com)
+ *  Copyright 2005-2007 Freescale Semiconductor, Inc. All Rights Reserved.
+ *    - add MX31 specific definitions
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/mm.h>
+#include <linux/init.h>
+#include <linux/err.h>
+
+#include <asm/pgtable.h>
+#include <asm/mach/map.h>
+#include <asm/hardware/cache-l2x0.h>
+
+#include <mach/common.h>
+#include <mach/hardware.h>
+#include <mach/iomux-v3.h>
+#include <mach/gpio.h>
+#include <mach/irqs.h>
+
+static struct map_desc mx35_io_desc[] __initdata = {
+	imx_map_entry(MX35, X_MEMC, MT_DEVICE),
+	imx_map_entry(MX35, AVIC, MT_DEVICE_NONSHARED),
+	imx_map_entry(MX35, AIPS1, MT_DEVICE_NONSHARED),
+	imx_map_entry(MX35, AIPS2, MT_DEVICE_NONSHARED),
+	imx_map_entry(MX35, SPBA0, MT_DEVICE_NONSHARED),
+};
+
+void __init mx35_map_io(void)
+{
+	iotable_init(mx35_io_desc, ARRAY_SIZE(mx35_io_desc));
+}
+
+void __init imx35_init_early(void)
+{
+	mxc_set_cpu_type(MXC_CPU_MX35);
+	mxc_iomux_v3_init(MX35_IO_ADDRESS(MX35_IOMUXC_BASE_ADDR));
+	mxc_arch_reset_init(MX35_IO_ADDRESS(MX35_WDOG_BASE_ADDR));
+}
+
+static struct mxc_gpio_port imx35_gpio_ports[] = {
+	DEFINE_IMX_GPIO_PORT_IRQ(MX35, 0, 1, MX35_INT_GPIO1),
+	DEFINE_IMX_GPIO_PORT_IRQ(MX35, 1, 2, MX35_INT_GPIO2),
+	DEFINE_IMX_GPIO_PORT_IRQ(MX35, 2, 3, MX35_INT_GPIO3),
+};
+
+void __init mx35_init_irq(void)
+{
+	mxc_init_irq(MX35_IO_ADDRESS(MX35_AVIC_BASE_ADDR));
+	mxc_gpio_init(imx35_gpio_ports,	ARRAY_SIZE(imx35_gpio_ports));
+}
diff --git a/arch/arm/mach-mx3/mx31lilly-db.c b/arch/arm/mach-imx/mx31lilly-db.c
similarity index 100%
rename from arch/arm/mach-mx3/mx31lilly-db.c
rename to arch/arm/mach-imx/mx31lilly-db.c
diff --git a/arch/arm/mach-mx3/mx31lite-db.c b/arch/arm/mach-imx/mx31lite-db.c
similarity index 100%
rename from arch/arm/mach-mx3/mx31lite-db.c
rename to arch/arm/mach-imx/mx31lite-db.c
diff --git a/arch/arm/mach-mx3/mx31moboard-devboard.c b/arch/arm/mach-imx/mx31moboard-devboard.c
similarity index 100%
rename from arch/arm/mach-mx3/mx31moboard-devboard.c
rename to arch/arm/mach-imx/mx31moboard-devboard.c
diff --git a/arch/arm/mach-mx3/mx31moboard-marxbot.c b/arch/arm/mach-imx/mx31moboard-marxbot.c
similarity index 100%
rename from arch/arm/mach-mx3/mx31moboard-marxbot.c
rename to arch/arm/mach-imx/mx31moboard-marxbot.c
diff --git a/arch/arm/mach-mx3/mx31moboard-smartbot.c b/arch/arm/mach-imx/mx31moboard-smartbot.c
similarity index 100%
rename from arch/arm/mach-mx3/mx31moboard-smartbot.c
rename to arch/arm/mach-imx/mx31moboard-smartbot.c
diff --git a/arch/arm/mach-mx3/pcm037.h b/arch/arm/mach-imx/pcm037.h
similarity index 100%
rename from arch/arm/mach-mx3/pcm037.h
rename to arch/arm/mach-imx/pcm037.h
diff --git a/arch/arm/mach-mx3/Kconfig b/arch/arm/mach-mx3/Kconfig
deleted file mode 100644
index df2e9da..0000000
--- a/arch/arm/mach-mx3/Kconfig
+++ /dev/null
@@ -1,265 +0,0 @@
-if ARCH_MX3
-
-# ARCH_MX31 and ARCH_MX35 are left for compatibility
-# Some usages assume that having one of them implies not having (e.g.) ARCH_MX2.
-# To easily distinguish good and reviewed from unreviewed usages new (and IMHO
-# more sensible) names are used: SOC_IMX31 and SOC_IMX35
-config ARCH_MX31
-	bool
-
-config ARCH_MX35
-	bool
-
-config SOC_IMX31
-	bool
-	select IMX_HAVE_PLATFORM_MXC_RNGA
-	select ARCH_MXC_AUDMUX_V2
-	select ARCH_MX31
-	select MXC_AVIC
-
-config SOC_IMX35
-	bool
-	select ARCH_MXC_IOMUX_V3
-	select ARCH_MXC_AUDMUX_V2
-	select HAVE_EPIT
-	select ARCH_MX35
-	select MXC_AVIC
-
-comment "MX3 platforms:"
-
-config MACH_MX31ADS
-	bool "Support MX31ADS platforms"
-	select SOC_IMX31
-	select IMX_HAVE_PLATFORM_IMX_I2C
-	select IMX_HAVE_PLATFORM_IMX_SSI
-	select IMX_HAVE_PLATFORM_IMX_UART
-	default y
-	help
-	  Include support for MX31ADS platform. This includes specific
-	  configurations for the board and its peripherals.
-
-config MACH_MX31ADS_WM1133_EV1
-	bool "Support Wolfson Microelectronics 1133-EV1 module"
-	depends on MACH_MX31ADS
-	depends on MFD_WM8350_I2C
-	depends on REGULATOR_WM8350
-	select MFD_WM8350_CONFIG_MODE_0
-	select MFD_WM8352_CONFIG_MODE_0
-	help
-	  Include support for the Wolfson Microelectronics 1133-EV1 PMU
-	  and audio module for the MX31ADS platform.
-
-config MACH_PCM037
-	bool "Support Phytec pcm037 (i.MX31) platforms"
-	select SOC_IMX31
-	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
-	select IMX_HAVE_PLATFORM_IMX2_WDT
-	select IMX_HAVE_PLATFORM_IMX_I2C
-	select IMX_HAVE_PLATFORM_IMX_UART
-	select IMX_HAVE_PLATFORM_IPU_CORE
-	select IMX_HAVE_PLATFORM_MXC_EHCI
-	select IMX_HAVE_PLATFORM_MXC_MMC
-	select IMX_HAVE_PLATFORM_MXC_NAND
-	select IMX_HAVE_PLATFORM_MXC_W1
-	select MXC_ULPI if USB_ULPI
-	help
-	  Include support for Phytec pcm037 platform. This includes
-	  specific configurations for the board and its peripherals.
-
-config MACH_PCM037_EET
-	bool "Support pcm037 EET board extensions"
-	depends on MACH_PCM037
-	select IMX_HAVE_PLATFORM_SPI_IMX
-	help
-	  Add support for PCM037 EET baseboard extensions. If you are using the
-	  OLED display with EET, use "video=mx3fb:CMEL-OLED" kernel
-	  command-line parameter.
-
-config MACH_MX31LITE
-	bool "Support MX31 LITEKIT (LogicPD)"
-	select SOC_IMX31
-	select MXC_ULPI if USB_ULPI
-	select IMX_HAVE_PLATFORM_IMX2_WDT
-	select IMX_HAVE_PLATFORM_IMX_UART
-	select IMX_HAVE_PLATFORM_MXC_EHCI
-	select IMX_HAVE_PLATFORM_MXC_MMC
-	select IMX_HAVE_PLATFORM_MXC_NAND
-	select IMX_HAVE_PLATFORM_MXC_RTC
-	select IMX_HAVE_PLATFORM_SPI_IMX
-	help
-	  Include support for MX31 LITEKIT platform. This includes specific
-	  configurations for the board and its peripherals.
-
-config MACH_MX31_3DS
-	bool "Support MX31PDK (3DS)"
-	select SOC_IMX31
-	select MXC_DEBUG_BOARD
-	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
-	select IMX_HAVE_PLATFORM_IMX2_WDT
-	select IMX_HAVE_PLATFORM_IMX_I2C
-	select IMX_HAVE_PLATFORM_IMX_KEYPAD
-	select IMX_HAVE_PLATFORM_IMX_UART
-	select IMX_HAVE_PLATFORM_MXC_EHCI
-	select IMX_HAVE_PLATFORM_MXC_NAND
-	select IMX_HAVE_PLATFORM_SPI_IMX
-	select MXC_ULPI if USB_ULPI
-	help
-	  Include support for MX31PDK (3DS) platform. This includes specific
-	  configurations for the board and its peripherals.
-
-config MACH_MX31_3DS_MXC_NAND_USE_BBT
-	bool "Make the MXC NAND driver use the in flash Bad Block Table"
-	depends on MACH_MX31_3DS
-	depends on MTD_NAND_MXC
-	help
-	  Enable this if you want that the MXC NAND driver uses the in flash
-	  Bad Block Table to know what blocks are bad instead of scanning the
-	  entire flash looking for bad block markers.
-
-config MACH_MX31MOBOARD
-	bool "Support mx31moboard platforms (EPFL Mobots group)"
-	select SOC_IMX31
-	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
-	select IMX_HAVE_PLATFORM_IMX_I2C
-	select IMX_HAVE_PLATFORM_IMX_UART
-	select IMX_HAVE_PLATFORM_IPU_CORE
-	select IMX_HAVE_PLATFORM_MXC_EHCI
-	select IMX_HAVE_PLATFORM_MXC_MMC
-	select IMX_HAVE_PLATFORM_SPI_IMX
-	select MXC_ULPI if USB_ULPI
-	help
-	  Include support for mx31moboard platform. This includes specific
-	  configurations for the board and its peripherals.
-
-config MACH_MX31LILLY
-	bool "Support MX31 LILLY-1131 platforms (INCO startec)"
-	select SOC_IMX31
-	select IMX_HAVE_PLATFORM_IMX_UART
-	select IMX_HAVE_PLATFORM_IPU_CORE
-	select IMX_HAVE_PLATFORM_MXC_EHCI
-	select IMX_HAVE_PLATFORM_MXC_MMC
-	select IMX_HAVE_PLATFORM_SPI_IMX
-	select MXC_ULPI if USB_ULPI
-	help
-	  Include support for mx31 based LILLY1131 modules. This includes
-	  specific configurations for the board and its peripherals.
-
-config MACH_QONG
-	bool "Support Dave/DENX QongEVB-LITE platform"
-	select SOC_IMX31
-	select IMX_HAVE_PLATFORM_IMX_UART
-	help
-	  Include support for Dave/DENX QongEVB-LITE platform. This includes
-	  specific configurations for the board and its peripherals.
-
-config MACH_PCM043
-	bool "Support Phytec pcm043 (i.MX35) platforms"
-	select SOC_IMX35
-	select IMX_HAVE_PLATFORM_FLEXCAN
-	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
-	select IMX_HAVE_PLATFORM_IMX2_WDT
-	select IMX_HAVE_PLATFORM_IMX_I2C
-	select IMX_HAVE_PLATFORM_IMX_SSI
-	select IMX_HAVE_PLATFORM_IMX_UART
-	select IMX_HAVE_PLATFORM_IPU_CORE
-	select IMX_HAVE_PLATFORM_MXC_EHCI
-	select IMX_HAVE_PLATFORM_MXC_NAND
-	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
-	select MXC_ULPI if USB_ULPI
-	help
-	  Include support for Phytec pcm043 platform. This includes
-	  specific configurations for the board and its peripherals.
-
-config MACH_ARMADILLO5X0
-	bool "Support Atmark Armadillo-500 Development Base Board"
-	select SOC_IMX31
-	select IMX_HAVE_PLATFORM_IMX_I2C
-	select IMX_HAVE_PLATFORM_IMX_UART
-	select IMX_HAVE_PLATFORM_IPU_CORE
-	select IMX_HAVE_PLATFORM_MXC_EHCI
-	select IMX_HAVE_PLATFORM_MXC_MMC
-	select IMX_HAVE_PLATFORM_MXC_NAND
-	select MXC_ULPI if USB_ULPI
-	help
-	  Include support for Atmark Armadillo-500 platform. This includes
-	  specific configurations for the board and its peripherals.
-
-config MACH_MX35_3DS
-	bool "Support MX35PDK platform"
-	select SOC_IMX35
-	select MXC_DEBUG_BOARD
-	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
-	select IMX_HAVE_PLATFORM_IMX2_WDT
-	select IMX_HAVE_PLATFORM_IMX_I2C
-	select IMX_HAVE_PLATFORM_IMX_UART
-	select IMX_HAVE_PLATFORM_MXC_EHCI
-	select IMX_HAVE_PLATFORM_MXC_NAND
-	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
-	help
-	  Include support for MX35PDK platform. This includes specific
-	  configurations for the board and its peripherals.
-
-config MACH_KZM_ARM11_01
-	bool "Support KZM-ARM11-01(Kyoto Microcomputer)"
-	select SOC_IMX31
-	select IMX_HAVE_PLATFORM_IMX_UART
-	help
-	  Include support for KZM-ARM11-01. This includes specific
-	  configurations for the board and its peripherals.
-
-config MACH_BUG
-	bool "Support Buglabs BUGBase platform"
-	select SOC_IMX31
-	select IMX_HAVE_PLATFORM_IMX_UART
-	default y
-	help
-	  Include support for BUGBase 1.3 platform. This includes specific
-	  configurations for the board and its peripherals.
-
-config MACH_EUKREA_CPUIMX35
-	bool "Support Eukrea CPUIMX35 Platform"
-	select SOC_IMX35
-	select IMX_HAVE_PLATFORM_FLEXCAN
-	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
-	select IMX_HAVE_PLATFORM_IMX2_WDT
-	select IMX_HAVE_PLATFORM_IMX_I2C
-	select IMX_HAVE_PLATFORM_IMX_UART
-	select IMX_HAVE_PLATFORM_MXC_EHCI
-	select IMX_HAVE_PLATFORM_MXC_NAND
-	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
-	select MXC_ULPI if USB_ULPI
-	help
-	  Include support for Eukrea CPUIMX35 platform. This includes
-	  specific configurations for the board and its peripherals.
-
-choice
-	prompt "Baseboard"
-	depends on MACH_EUKREA_CPUIMX35
-	default MACH_EUKREA_MBIMXSD35_BASEBOARD
-
-config MACH_EUKREA_MBIMXSD35_BASEBOARD
-	bool "Eukrea MBIMXSD development board"
-	select IMX_HAVE_PLATFORM_IMX_SSI
-	select IMX_HAVE_PLATFORM_IPU_CORE
-	help
-	  This adds board specific devices that can be found on Eukrea's
-	  MBIMXSD evaluation board.
-
-endchoice
-
-config MACH_VPR200
-	bool "Support VPR200 platform"
-	select SOC_IMX35
-	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
-	select IMX_HAVE_PLATFORM_IMX2_WDT
-	select IMX_HAVE_PLATFORM_IMX_UART
-	select IMX_HAVE_PLATFORM_IMX_I2C
-	select IMX_HAVE_PLATFORM_IPU_CORE
-	select IMX_HAVE_PLATFORM_MXC_EHCI
-	select IMX_HAVE_PLATFORM_MXC_NAND
-	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
-	help
-	  Include support for VPR200 platform. This includes specific
-	  configurations for the board and its peripherals.
-
-endif
diff --git a/arch/arm/mach-mx3/Makefile b/arch/arm/mach-mx3/Makefile
deleted file mode 100644
index 15a7ff8..0000000
--- a/arch/arm/mach-mx3/Makefile
+++ /dev/null
@@ -1,26 +0,0 @@
-#
-# Makefile for the linux kernel.
-#
-
-# Object file lists.
-
-obj-y				:= mm.o cpu.o
-obj-$(CONFIG_SOC_IMX31)		+= clock-imx31.o iomux-imx31.o ehci-imx31.o
-obj-$(CONFIG_SOC_IMX35)		+= clock-imx35.o ehci-imx35.o
-obj-$(CONFIG_MACH_MX31ADS)	+= mach-mx31ads.o
-obj-$(CONFIG_MACH_MX31LILLY)	+= mach-mx31lilly.o mx31lilly-db.o
-obj-$(CONFIG_MACH_MX31LITE)	+= mach-mx31lite.o mx31lite-db.o
-obj-$(CONFIG_MACH_PCM037)	+= mach-pcm037.o
-obj-$(CONFIG_MACH_PCM037_EET)	+= mach-pcm037_eet.o
-obj-$(CONFIG_MACH_MX31_3DS)	+= mach-mx31_3ds.o
-obj-$(CONFIG_MACH_MX31MOBOARD)	+= mach-mx31moboard.o mx31moboard-devboard.o \
-				   mx31moboard-marxbot.o mx31moboard-smartbot.o
-obj-$(CONFIG_MACH_QONG)		+= mach-qong.o
-obj-$(CONFIG_MACH_PCM043)	+= mach-pcm043.o
-obj-$(CONFIG_MACH_ARMADILLO5X0) += mach-armadillo5x0.o
-obj-$(CONFIG_MACH_MX35_3DS)	+= mach-mx35_3ds.o
-obj-$(CONFIG_MACH_KZM_ARM11_01)	+= mach-kzm_arm11_01.o
-obj-$(CONFIG_MACH_BUG)		+= mach-bug.o
-obj-$(CONFIG_MACH_EUKREA_CPUIMX35)	+= mach-cpuimx35.o
-obj-$(CONFIG_MACH_EUKREA_MBIMXSD35_BASEBOARD)	+= eukrea_mbimxsd-baseboard.o
-obj-$(CONFIG_MACH_VPR200)	+= mach-vpr200.o
diff --git a/arch/arm/mach-mx3/Makefile.boot b/arch/arm/mach-mx3/Makefile.boot
deleted file mode 100644
index e1dd366..0000000
--- a/arch/arm/mach-mx3/Makefile.boot
+++ /dev/null
@@ -1,3 +0,0 @@
-   zreladdr-y	:= 0x80008000
-params_phys-y	:= 0x80000100
-initrd_phys-y	:= 0x80800000
diff --git a/arch/arm/mach-mx3/mm.c b/arch/arm/mach-mx3/mm.c
deleted file mode 100644
index 54d7174..0000000
--- a/arch/arm/mach-mx3/mm.c
+++ /dev/null
@@ -1,141 +0,0 @@
-/*
- *  Copyright (C) 1999,2000 Arm Limited
- *  Copyright (C) 2000 Deep Blue Solutions Ltd
- *  Copyright (C) 2002 Shane Nay (shane at minirl.com)
- *  Copyright 2005-2007 Freescale Semiconductor, Inc. All Rights Reserved.
- *    - add MX31 specific definitions
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-
-#include <linux/mm.h>
-#include <linux/init.h>
-#include <linux/err.h>
-
-#include <asm/pgtable.h>
-#include <asm/mach/map.h>
-#include <asm/hardware/cache-l2x0.h>
-
-#include <mach/common.h>
-#include <mach/hardware.h>
-#include <mach/iomux-v3.h>
-#include <mach/gpio.h>
-#include <mach/irqs.h>
-
-#ifdef CONFIG_SOC_IMX31
-static struct map_desc mx31_io_desc[] __initdata = {
-	imx_map_entry(MX31, X_MEMC, MT_DEVICE),
-	imx_map_entry(MX31, AVIC, MT_DEVICE_NONSHARED),
-	imx_map_entry(MX31, AIPS1, MT_DEVICE_NONSHARED),
-	imx_map_entry(MX31, AIPS2, MT_DEVICE_NONSHARED),
-	imx_map_entry(MX31, SPBA0, MT_DEVICE_NONSHARED),
-};
-
-/*
- * This function initializes the memory map. It is called during the
- * system startup to create static physical to virtual memory mappings
- * for the IO modules.
- */
-void __init mx31_map_io(void)
-{
-	iotable_init(mx31_io_desc, ARRAY_SIZE(mx31_io_desc));
-}
-
-void __init imx31_init_early(void)
-{
-	mxc_set_cpu_type(MXC_CPU_MX31);
-	mxc_arch_reset_init(MX31_IO_ADDRESS(MX31_WDOG_BASE_ADDR));
-}
-
-static struct mxc_gpio_port imx31_gpio_ports[] = {
-	DEFINE_IMX_GPIO_PORT_IRQ(MX31, 0, 1, MX31_INT_GPIO1),
-	DEFINE_IMX_GPIO_PORT_IRQ(MX31, 1, 2, MX31_INT_GPIO2),
-	DEFINE_IMX_GPIO_PORT_IRQ(MX31, 2, 3, MX31_INT_GPIO3),
-};
-
-void __init mx31_init_irq(void)
-{
-	mxc_init_irq(MX31_IO_ADDRESS(MX31_AVIC_BASE_ADDR));
-	mxc_gpio_init(imx31_gpio_ports,	ARRAY_SIZE(imx31_gpio_ports));
-}
-#endif /* ifdef CONFIG_SOC_IMX31 */
-
-#ifdef CONFIG_SOC_IMX35
-static struct map_desc mx35_io_desc[] __initdata = {
-	imx_map_entry(MX35, X_MEMC, MT_DEVICE),
-	imx_map_entry(MX35, AVIC, MT_DEVICE_NONSHARED),
-	imx_map_entry(MX35, AIPS1, MT_DEVICE_NONSHARED),
-	imx_map_entry(MX35, AIPS2, MT_DEVICE_NONSHARED),
-	imx_map_entry(MX35, SPBA0, MT_DEVICE_NONSHARED),
-};
-
-void __init mx35_map_io(void)
-{
-	iotable_init(mx35_io_desc, ARRAY_SIZE(mx35_io_desc));
-}
-
-void __init imx35_init_early(void)
-{
-	mxc_set_cpu_type(MXC_CPU_MX35);
-	mxc_iomux_v3_init(MX35_IO_ADDRESS(MX35_IOMUXC_BASE_ADDR));
-	mxc_arch_reset_init(MX35_IO_ADDRESS(MX35_WDOG_BASE_ADDR));
-}
-
-static struct mxc_gpio_port imx35_gpio_ports[] = {
-	DEFINE_IMX_GPIO_PORT_IRQ(MX35, 0, 1, MX35_INT_GPIO1),
-	DEFINE_IMX_GPIO_PORT_IRQ(MX35, 1, 2, MX35_INT_GPIO2),
-	DEFINE_IMX_GPIO_PORT_IRQ(MX35, 2, 3, MX35_INT_GPIO3),
-};
-
-void __init mx35_init_irq(void)
-{
-	mxc_init_irq(MX35_IO_ADDRESS(MX35_AVIC_BASE_ADDR));
-	mxc_gpio_init(imx35_gpio_ports,	ARRAY_SIZE(imx35_gpio_ports));
-}
-#endif /* ifdef CONFIG_SOC_IMX35 */
-
-#ifdef CONFIG_CACHE_L2X0
-static int mxc_init_l2x0(void)
-{
-	void __iomem *l2x0_base;
-	void __iomem *clkctl_base;
-/*
- * First of all, we must repair broken chip settings. There are some
- * i.MX35 CPUs in the wild, comming with bogus L2 cache settings. These
- * misconfigured CPUs will run amok immediately when the L2 cache gets enabled.
- * Workaraound is to setup the correct register setting prior enabling the
- * L2 cache. This should not hurt already working CPUs, as they are using the
- * same value
- */
-#define L2_MEM_VAL 0x10
-
-	clkctl_base = ioremap(MX35_CLKCTL_BASE_ADDR, 4096);
-	if (clkctl_base != NULL) {
-		writel(0x00000515, clkctl_base + L2_MEM_VAL);
-		iounmap(clkctl_base);
-	} else {
-		pr_err("L2 cache: Cannot fix timing. Trying to continue without\n");
-	}
-
-	l2x0_base = ioremap(MX3x_L2CC_BASE_ADDR, 4096);
-	if (IS_ERR(l2x0_base)) {
-		printk(KERN_ERR "remapping L2 cache area failed with %ld\n",
-				PTR_ERR(l2x0_base));
-		return 0;
-	}
-
-	l2x0_init(l2x0_base, 0x00030024, 0x00000000);
-
-	return 0;
-}
-
-arch_initcall(mxc_init_l2x0);
-#endif
diff --git a/arch/arm/plat-mxc/Kconfig b/arch/arm/plat-mxc/Kconfig
index b0cb425..8d183c5 100644
--- a/arch/arm/plat-mxc/Kconfig
+++ b/arch/arm/plat-mxc/Kconfig
@@ -47,7 +47,6 @@ config ARCH_MX5
 endchoice
 
 source "arch/arm/mach-imx/Kconfig"
-source "arch/arm/mach-mx3/Kconfig"
 source "arch/arm/mach-mxc91231/Kconfig"
 source "arch/arm/mach-mx5/Kconfig"
 
-- 
1.7.2.3
