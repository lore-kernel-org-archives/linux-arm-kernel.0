From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 13 Jun 2014 18:01:14 +0200
Subject: [PATCH 12/14] ARM: use menuconfig for sub-arch menus
In-Reply-To: <1402675276-538682-1-git-send-email-arnd@arndb.de>
References: <1402675276-538682-1-git-send-email-arnd@arndb.de>
Message-ID: <1402675276-538682-13-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <robh@kernel.org>

The System Type menu is getting quite long with platforms and is
inconsistent in handling of sub-arch specific options. Tidy up the menu
by making platform options a menuconfig entry containing any platform
specific config items.

Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-bcm/Kconfig      | 7 +++----
 arch/arm/mach-berlin/Kconfig   | 6 +-----
 arch/arm/mach-cns3xxx/Kconfig  | 7 +++----
 arch/arm/mach-exynos/Kconfig   | 6 +-----
 arch/arm/mach-imx/Kconfig      | 7 +++----
 arch/arm/mach-moxart/Kconfig   | 2 +-
 arch/arm/mach-mvebu/Kconfig    | 6 +-----
 arch/arm/mach-nomadik/Kconfig  | 4 +---
 arch/arm/mach-omap2/Kconfig    | 9 ++++++---
 arch/arm/mach-prima2/Kconfig   | 6 ++----
 arch/arm/mach-qcom/Kconfig     | 6 +-----
 arch/arm/mach-shmobile/Kconfig | 4 ++--
 arch/arm/mach-tegra/Kconfig    | 7 +++----
 arch/arm/mach-u300/Kconfig     | 6 +-----
 arch/arm/mach-ux500/Kconfig    | 6 +-----
 arch/arm/mach-vexpress/Kconfig | 7 +++----
 16 files changed, 33 insertions(+), 63 deletions(-)

diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
index 9bc6db1..41c8391 100644
--- a/arch/arm/mach-bcm/Kconfig
+++ b/arch/arm/mach-bcm/Kconfig
@@ -1,10 +1,9 @@
-config ARCH_BCM
+menuconfig ARCH_BCM
 	bool "Broadcom SoC Support" if ARCH_MULTI_V6_V7
 	help
 	  This enables support for Broadcom ARM based SoC chips
 
-menu "Broadcom SoC Selection"
-	depends on ARCH_BCM
+if ARCH_BCM
 
 config ARCH_BCM_MOBILE
 	bool "Broadcom Mobile SoC Support" if ARCH_MULTI_V7
@@ -88,4 +87,4 @@ config ARCH_BCM_5301X
 	  different SoC or with the older BCM47XX and BCM53XX based
 	  network SoC using a MIPS CPU, they are supported by arch/mips/bcm47xx
 
-endmenu
+endif
diff --git a/arch/arm/mach-berlin/Kconfig b/arch/arm/mach-berlin/Kconfig
index 101e0f3..2631cfc 100644
--- a/arch/arm/mach-berlin/Kconfig
+++ b/arch/arm/mach-berlin/Kconfig
@@ -1,4 +1,4 @@
-config ARCH_BERLIN
+menuconfig ARCH_BERLIN
 	bool "Marvell Berlin SoCs" if ARCH_MULTI_V7
 	select ARCH_REQUIRE_GPIOLIB
 	select ARM_GIC
@@ -9,8 +9,6 @@ config ARCH_BERLIN
 
 if ARCH_BERLIN
 
-menu "Marvell Berlin SoC variants"
-
 config MACH_BERLIN_BG2
 	bool "Marvell Armada 1500 (BG2)"
 	select CACHE_L2X0
@@ -30,6 +28,4 @@ config MACH_BERLIN_BG2Q
 	select HAVE_ARM_TWD if SMP
 	select PINCTRL_BERLIN_BG2Q
 
-endmenu
-
 endif
diff --git a/arch/arm/mach-cns3xxx/Kconfig b/arch/arm/mach-cns3xxx/Kconfig
index 66838f4..3c22a19 100644
--- a/arch/arm/mach-cns3xxx/Kconfig
+++ b/arch/arm/mach-cns3xxx/Kconfig
@@ -1,12 +1,11 @@
-config ARCH_CNS3XXX
+menuconfig ARCH_CNS3XXX
 	bool "Cavium Networks CNS3XXX family" if ARCH_MULTI_V6
 	select ARM_GIC
 	select PCI_DOMAINS if PCI
 	help
 	  Support for Cavium Networks CNS3XXX platform.
 
-menu "CNS3XXX platform type"
-	depends on ARCH_CNS3XXX
+if ARCH_CNS3XXX
 
 config MACH_CNS3420VB
 	bool "Support for CNS3420 Validation Board"
@@ -17,4 +16,4 @@ config MACH_CNS3420VB
 	  This is a platform with an on-board ARM11 MPCore and has support
 	  for USB, USB-OTG, MMC/SD/SDIO, SATA, PCI-E, etc.
 
-endmenu
+endif
diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index 845031b..8f9b66c 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -7,7 +7,7 @@
 
 # Configuration options for the EXYNOS4
 
-config ARCH_EXYNOS
+menuconfig ARCH_EXYNOS
 	bool "Samsung EXYNOS" if ARCH_MULTI_V7
 	select ARCH_HAS_BANDGAP
 	select ARCH_HAS_HOLES_MEMORYMODEL
@@ -29,8 +29,6 @@ config ARCH_EXYNOS
 
 if ARCH_EXYNOS
 
-menu "SAMSUNG EXYNOS SoCs Support"
-
 config ARCH_EXYNOS3
 	bool "SAMSUNG EXYNOS3"
 	select ARM_CPU_SUSPEND if PM
@@ -117,8 +115,6 @@ config SOC_EXYNOS5800
 	default y
 	depends on SOC_EXYNOS5420
 
-endmenu
-
 config EXYNOS5420_MCPM
 	bool "Exynos5420 Multi-Cluster PM support"
 	depends on MCPM && SOC_EXYNOS5420
diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index b232340..28fa2fa 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -1,4 +1,4 @@
-config ARCH_MXC
+menuconfig ARCH_MXC
 	bool "Freescale i.MX family" if ARCH_MULTI_V4_V5 || ARCH_MULTI_V6_V7
 	select ARCH_HAS_OPP
 	select ARCH_REQUIRE_GPIOLIB
@@ -12,8 +12,7 @@ config ARCH_MXC
 	help
 	  Support for Freescale MXC/iMX-based family of processors
 
-menu "Freescale i.MX support"
-	depends on ARCH_MXC
+if ARCH_MXC
 
 config MXC_TZIC
 	bool
@@ -783,4 +782,4 @@ endif
 
 source "arch/arm/mach-imx/devices/Kconfig"
 
-endmenu
+endif
diff --git a/arch/arm/mach-moxart/Kconfig b/arch/arm/mach-moxart/Kconfig
index 82a4ba8..f49328c 100644
--- a/arch/arm/mach-moxart/Kconfig
+++ b/arch/arm/mach-moxart/Kconfig
@@ -1,4 +1,4 @@
-config ARCH_MOXART
+menuconfig ARCH_MOXART
 	bool "MOXA ART SoC" if ARCH_MULTI_V4
 	select CPU_FA526
 	select ARM_DMA_MEM_BUFFERABLE
diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
index 74e1ff2..3f304a5 100644
--- a/arch/arm/mach-mvebu/Kconfig
+++ b/arch/arm/mach-mvebu/Kconfig
@@ -1,4 +1,4 @@
-config ARCH_MVEBU
+menuconfig ARCH_MVEBU
 	bool "Marvell Engineering Business Unit (MVEBU) SoCs" if (ARCH_MULTI_V7 || ARCH_MULTI_V5)
 	select ARCH_SUPPORTS_BIG_ENDIAN
 	select CLKSRC_MMIO
@@ -13,8 +13,6 @@ config ARCH_MVEBU
 
 if ARCH_MVEBU
 
-menu "Marvell EBU SoC variants"
-
 config MACH_MVEBU_V7
 	bool
 	select ARMADA_370_XP_TIMER
@@ -97,6 +95,4 @@ config MACH_KIRKWOOD
 	  Say 'Y' here if you want your kernel to support boards based
 	  on the Marvell Kirkwood device tree.
 
-endmenu
-
 endif
diff --git a/arch/arm/mach-nomadik/Kconfig b/arch/arm/mach-nomadik/Kconfig
index 486d301..3c61096 100644
--- a/arch/arm/mach-nomadik/Kconfig
+++ b/arch/arm/mach-nomadik/Kconfig
@@ -1,4 +1,4 @@
-config ARCH_NOMADIK
+menuconfig ARCH_NOMADIK
 	bool "ST-Ericsson Nomadik"
 	depends on ARCH_MULTI_V5
 	select ARCH_REQUIRE_GPIOLIB
@@ -15,7 +15,6 @@ config ARCH_NOMADIK
 	  Support for the Nomadik platform by ST-Ericsson
 
 if ARCH_NOMADIK
-menu "Nomadik boards"
 
 config MACH_NOMADIK_8815NHK
 	bool "ST 8815 Nomadik Hardware Kit (evaluation board)"
@@ -24,7 +23,6 @@ config MACH_NOMADIK_8815NHK
 	select I2C_ALGOBIT
 	select I2C_NOMADIK
 
-endmenu
 endif
 
 config NOMADIK_8815
diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 0006012..4e81860 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -1,5 +1,7 @@
-config ARCH_OMAP
-	bool
+menuconfig ARCH_OMAP
+	bool "TI OMAP/AM/DRA Based" if (ARCH_MULTI_V6 || ARCH_MULTI_V7)
+
+if ARCH_OMAP
 
 config ARCH_OMAP2
 	bool "TI OMAP2"
@@ -80,7 +82,6 @@ config ARCH_OMAP2PLUS
 	bool
 	select ARCH_HAS_BANDGAP
 	select ARCH_HAS_HOLES_MEMORYMODEL
-	select ARCH_OMAP
 	select ARCH_REQUIRE_GPIOLIB
 	select CLKSRC_MMIO
 	select GENERIC_IRQ_CHIP
@@ -341,3 +342,5 @@ config OMAP4_ERRATA_I688
 endmenu
 
 endif
+
+endif
diff --git a/arch/arm/mach-prima2/Kconfig b/arch/arm/mach-prima2/Kconfig
index e4e505f..042f693 100644
--- a/arch/arm/mach-prima2/Kconfig
+++ b/arch/arm/mach-prima2/Kconfig
@@ -1,4 +1,4 @@
-config ARCH_SIRF
+menuconfig ARCH_SIRF
 	bool "CSR SiRF" if ARCH_MULTI_V7
 	select ARCH_HAS_RESET_CONTROLLER
 	select ARCH_REQUIRE_GPIOLIB
@@ -11,7 +11,7 @@ config ARCH_SIRF
 
 if ARCH_SIRF
 
-menu "CSR SiRF atlas6/primaII/Marco/Polo Specific Features"
+comment "CSR SiRF atlas6/primaII/Marco/Polo Specific Features"
 
 config ARCH_ATLAS6
 	bool "CSR SiRFSoC ATLAS6 ARM Cortex A9 Platform"
@@ -37,8 +37,6 @@ config ARCH_MARCO
 	help
           Support for CSR SiRFSoC ARM Cortex A9 Platform
 
-endmenu
-
 config SIRF_IRQ
 	bool
 
diff --git a/arch/arm/mach-qcom/Kconfig b/arch/arm/mach-qcom/Kconfig
index fd2b99d..ee5697b 100644
--- a/arch/arm/mach-qcom/Kconfig
+++ b/arch/arm/mach-qcom/Kconfig
@@ -1,4 +1,4 @@
-config ARCH_QCOM
+menuconfig ARCH_QCOM
 	bool "Qualcomm Support" if ARCH_MULTI_V7
 	select ARCH_REQUIRE_GPIOLIB
 	select ARM_GIC
@@ -11,8 +11,6 @@ config ARCH_QCOM
 
 if ARCH_QCOM
 
-menu "Qualcomm SoC Selection"
-
 config ARCH_MSM8X60
 	bool "Enable support for MSM8X60"
 	select CLKSRC_QCOM
@@ -25,8 +23,6 @@ config ARCH_MSM8974
 	bool "Enable support for MSM8974"
 	select HAVE_ARM_ARCH_TIMER
 
-endmenu
-
 config QCOM_SCM
 	bool
 
diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 270e5ca..7980730 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -1,7 +1,7 @@
 config ARCH_SHMOBILE
 	bool
 
-config ARCH_SHMOBILE_MULTI
+menuconfig ARCH_SHMOBILE_MULTI
 	bool "Renesas ARM SoCs" if ARCH_MULTI_V7
 	depends on MMU
 	select ARCH_SHMOBILE
@@ -15,7 +15,7 @@ config ARCH_SHMOBILE_MULTI
 
 if ARCH_SHMOBILE_MULTI
 
-comment "Renesas ARM SoCs System Type"
+#comment "Renesas ARM SoCs System Type"
 
 config ARCH_EMEV2
 	bool "Emma Mobile EV2"
diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
index 8981ed4..0953996 100644
--- a/arch/arm/mach-tegra/Kconfig
+++ b/arch/arm/mach-tegra/Kconfig
@@ -1,4 +1,4 @@
-config ARCH_TEGRA
+menuconfig ARCH_TEGRA
 	bool "NVIDIA Tegra" if ARCH_MULTI_V7
 	select ARCH_REQUIRE_GPIOLIB
 	select ARCH_SUPPORTS_TRUSTED_FOUNDATIONS
@@ -15,8 +15,7 @@ config ARCH_TEGRA
 	help
 	  This enables support for NVIDIA Tegra based systems.
 
-menu "NVIDIA Tegra options"
-	depends on ARCH_TEGRA
+if ARCH_TEGRA
 
 config ARCH_TEGRA_2x_SOC
 	bool "Enable support for Tegra20 family"
@@ -68,4 +67,4 @@ config TEGRA_AHB
 	  which controls AHB bus master arbitration and some
 	  performance parameters(priority, prefech size).
 
-endmenu
+endif
diff --git a/arch/arm/mach-u300/Kconfig b/arch/arm/mach-u300/Kconfig
index e3a96d7..bc51a71 100644
--- a/arch/arm/mach-u300/Kconfig
+++ b/arch/arm/mach-u300/Kconfig
@@ -1,4 +1,4 @@
-config ARCH_U300
+menuconfig ARCH_U300
 	bool "ST-Ericsson U300 Series" if ARCH_MULTI_V5
 	depends on MMU
 	select ARCH_REQUIRE_GPIOLIB
@@ -16,8 +16,6 @@ config ARCH_U300
 
 if ARCH_U300
 
-menu "ST-Ericsson AB U300/U335 Platform"
-
 config MACH_U300
 	depends on ARCH_U300
 	bool "U300"
@@ -43,6 +41,4 @@ config MACH_U300_SPIDUMMY
 		you don't need it. Selecting this will activate the
 		SPI framework and ARM PL022 support.
 
-endmenu
-
 endif
diff --git a/arch/arm/mach-ux500/Kconfig b/arch/arm/mach-ux500/Kconfig
index 9b93144..5be7c45 100644
--- a/arch/arm/mach-ux500/Kconfig
+++ b/arch/arm/mach-ux500/Kconfig
@@ -1,4 +1,4 @@
-config ARCH_U8500
+menuconfig ARCH_U8500
 	bool "ST-Ericsson U8500 Series" if ARCH_MULTI_V7
 	depends on MMU
 	select AB8500_CORE
@@ -33,8 +33,6 @@ config UX500_SOC_DB8500
 	select REGULATOR
 	select REGULATOR_DB8500_PRCMU
 
-menu "Ux500 target platform (boards)"
-
 config MACH_MOP500
 	bool "U8500 Development platform, MOP500 versions"
 	select I2C
@@ -67,8 +65,6 @@ config UX500_AUTO_PLATFORM
 	  a working kernel. If everything else is disabled, this
 	  automatically enables MACH_MOP500.
 
-endmenu
-
 config UX500_DEBUG_UART
 	int "Ux500 UART to use for low-level debug"
 	default 2
diff --git a/arch/arm/mach-vexpress/Kconfig b/arch/arm/mach-vexpress/Kconfig
index 2e2e8bb..99c1f15 100644
--- a/arch/arm/mach-vexpress/Kconfig
+++ b/arch/arm/mach-vexpress/Kconfig
@@ -1,4 +1,4 @@
-config ARCH_VEXPRESS
+menuconfig ARCH_VEXPRESS
 	bool "ARM Ltd. Versatile Express family" if ARCH_MULTI_V7
 	select ARCH_REQUIRE_GPIOLIB
 	select ARCH_SUPPORTS_BIG_ENDIAN
@@ -37,8 +37,7 @@ config ARCH_VEXPRESS
 	  platforms. The traditional (ATAGs) boot method is not usable on
 	  these boards with this option.
 
-menu "Versatile Express platform type"
-	depends on ARCH_VEXPRESS
+if ARCH_VEXPRESS
 
 config ARCH_VEXPRESS_CORTEX_A5_A9_ERRATA
 	bool "Enable A5 and A9 only errata work-arounds"
@@ -82,4 +81,4 @@ config ARCH_VEXPRESS_TC2_PM
 	  Support for CPU and cluster power management on Versatile Express
 	  with a TC2 (A15x2 A7x3) big.LITTLE core tile.
 
-endmenu
+endif
-- 
1.8.3.2
