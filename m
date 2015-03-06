From: festevam@gmail.com (Fabio Estevam)
Date: Fri,  6 Mar 2015 14:25:56 -0300
Subject: [PATCH v2 1/3] ARM: imx25: Remove eukrea mx25 board files
Message-ID: <1425662758-4675-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

eukrea mx25 is well supported in device tree, so let's get rid of its board
files.

Cc: Eric B?nard <eric@eukrea.com>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- None

 arch/arm/mach-imx/Kconfig                      |  32 ---
 arch/arm/mach-imx/Makefile                     |   2 -
 arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c | 310 -------------------------
 arch/arm/mach-imx/mach-eukrea_cpuimx25.c       | 172 --------------
 4 files changed, 516 deletions(-)
 delete mode 100644 arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c
 delete mode 100644 arch/arm/mach-imx/mach-eukrea_cpuimx25.c

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 247a465..4861ad5 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -151,38 +151,6 @@ config MACH_MX21ADS
 
 comment "MX25 platforms:"
 
-config MACH_EUKREA_CPUIMX25SD
-	bool "Support Eukrea CPUIMX25 Platform"
-	select IMX_HAVE_PLATFORM_FLEXCAN
-	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
-	select IMX_HAVE_PLATFORM_IMX2_WDT
-	select IMX_HAVE_PLATFORM_IMXDI_RTC
-	select IMX_HAVE_PLATFORM_IMX_FB
-	select IMX_HAVE_PLATFORM_IMX_I2C
-	select IMX_HAVE_PLATFORM_IMX_UART
-	select IMX_HAVE_PLATFORM_MXC_EHCI
-	select IMX_HAVE_PLATFORM_MXC_NAND
-	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
-	select USB_ULPI_VIEWPORT if USB_ULPI
-	select SOC_IMX25
-
-choice
-	prompt "Baseboard"
-	depends on MACH_EUKREA_CPUIMX25SD
-	default MACH_EUKREA_MBIMXSD25_BASEBOARD
-
-config MACH_EUKREA_MBIMXSD25_BASEBOARD
-	bool "Eukrea MBIMXSD development board"
-	select IMX_HAVE_PLATFORM_GPIO_KEYS
-	select IMX_HAVE_PLATFORM_IMX_SSI
-	select IMX_HAVE_PLATFORM_SPI_IMX
-	select LEDS_GPIO_REGISTER
-	help
-	  This adds board specific devices that can be found on Eukrea's
-	  MBIMXSD evaluation board.
-
-endchoice
-
 config MACH_IMX25_DT
 	bool "Support i.MX25 platforms from device tree"
 	select SOC_IMX25
diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index e92ede9..724b7fb 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -49,8 +49,6 @@ obj-$(CONFIG_MACH_IMX1_DT) += imx1-dt.o
 obj-$(CONFIG_MACH_MX21ADS) += mach-mx21ads.o
 
 # i.MX25 based machines
-obj-$(CONFIG_MACH_EUKREA_CPUIMX25SD) += mach-eukrea_cpuimx25.o
-obj-$(CONFIG_MACH_EUKREA_MBIMXSD25_BASEBOARD) += eukrea_mbimxsd25-baseboard.o
 obj-$(CONFIG_MACH_IMX25_DT) += imx25-dt.o
 
 # i.MX27 based machines
diff --git a/arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c b/arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c
deleted file mode 100644
index e77cc3af..0000000
diff --git a/arch/arm/mach-imx/mach-eukrea_cpuimx25.c b/arch/arm/mach-imx/mach-eukrea_cpuimx25.c
deleted file mode 100644
index b2ee6e0..0000000
-- 
1.9.1
