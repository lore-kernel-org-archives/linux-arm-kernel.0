From: olof@lixom.net (Olof Johansson)
Date: Wed, 15 Jul 2015 07:10:21 -0400
Subject: [PATCH] arm64: Split out platform options to separate Kconfig
Message-ID: <1436958621-23524-1-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Let's move out the platform Kconfig entries to a separate file, since these
changes usually get moved through arm-soc instead of the arm64 arch tree, and
this will lead to fewer conflicts

Signed-off-by: Olof Johansson <olof@lixom.net>
---

Will, Catalin, I'll merge this through arm-soc if I get your acks. Thanks!


-Olof

 arch/arm64/Kconfig           | 105 +------------------------------------------
 arch/arm64/Kconfig.platforms | 104 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 105 insertions(+), 104 deletions(-)
 create mode 100644 arch/arm64/Kconfig.platforms

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 318175f..430e7fa 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -160,110 +160,7 @@ source "init/Kconfig"
 
 source "kernel/Kconfig.freezer"
 
-menu "Platform selection"
-
-config ARCH_EXYNOS
-	bool
-	help
-	  This enables support for Samsung Exynos SoC family
-
-config ARCH_EXYNOS7
-	bool "ARMv8 based Samsung Exynos7"
-	select ARCH_EXYNOS
-	select COMMON_CLK_SAMSUNG
-	select HAVE_S3C2410_WATCHDOG if WATCHDOG
-	select HAVE_S3C_RTC if RTC_CLASS
-	select PINCTRL
-	select PINCTRL_EXYNOS
-
-	help
-	  This enables support for Samsung Exynos7 SoC family
-
-config ARCH_FSL_LS2085A
-	bool "Freescale LS2085A SOC"
-	help
-	  This enables support for Freescale LS2085A SOC.
-
-config ARCH_HISI
-	bool "Hisilicon SoC Family"
-	help
-	  This enables support for Hisilicon ARMv8 SoC family
-
-config ARCH_MEDIATEK
-	bool "Mediatek MT65xx & MT81xx ARMv8 SoC"
-	select ARM_GIC
-	select PINCTRL
-	help
-	  Support for Mediatek MT65xx & MT81xx ARMv8 SoCs
-
-config ARCH_QCOM
-	bool "Qualcomm Platforms"
-	select PINCTRL
-	help
-	  This enables support for the ARMv8 based Qualcomm chipsets.
-
-config ARCH_SEATTLE
-	bool "AMD Seattle SoC Family"
-	help
-	  This enables support for AMD Seattle SOC Family
-
-config ARCH_TEGRA
-	bool "NVIDIA Tegra SoC Family"
-	select ARCH_HAS_RESET_CONTROLLER
-	select ARCH_REQUIRE_GPIOLIB
-	select CLKDEV_LOOKUP
-	select CLKSRC_MMIO
-	select CLKSRC_OF
-	select GENERIC_CLOCKEVENTS
-	select HAVE_CLK
-	select PINCTRL
-	select RESET_CONTROLLER
-	help
-	  This enables support for the NVIDIA Tegra SoC family.
-
-config ARCH_TEGRA_132_SOC
-	bool "NVIDIA Tegra132 SoC"
-	depends on ARCH_TEGRA
-	select PINCTRL_TEGRA124
-	select USB_ULPI if USB_PHY
-	select USB_ULPI_VIEWPORT if USB_PHY
-	help
-	  Enable support for NVIDIA Tegra132 SoC, based on the Denver
-	  ARMv8 CPU.  The Tegra132 SoC is similar to the Tegra124 SoC,
-	  but contains an NVIDIA Denver CPU complex in place of
-	  Tegra124's "4+1" Cortex-A15 CPU complex.
-
-config ARCH_SPRD
-	bool "Spreadtrum SoC platform"
-	help
-	  Support for Spreadtrum ARM based SoCs
-
-config ARCH_THUNDER
-	bool "Cavium Inc. Thunder SoC Family"
-	help
-	  This enables support for Cavium's Thunder Family of SoCs.
-
-config ARCH_VEXPRESS
-	bool "ARMv8 software model (Versatile Express)"
-	select ARCH_REQUIRE_GPIOLIB
-	select COMMON_CLK_VERSATILE
-	select POWER_RESET_VEXPRESS
-	select VEXPRESS_CONFIG
-	help
-	  This enables support for the ARMv8 software model (Versatile
-	  Express).
-
-config ARCH_XGENE
-	bool "AppliedMicro X-Gene SOC Family"
-	help
-	  This enables support for AppliedMicro X-Gene SOC Family
-
-config ARCH_ZYNQMP
-	bool "Xilinx ZynqMP Family"
-	help
-	  This enables support for Xilinx ZynqMP Family
-
-endmenu
+source "Kconfig.platforms"
 
 menu "Bus support"
 
diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
new file mode 100644
index 0000000..7de731e
--- /dev/null
+++ b/arch/arm64/Kconfig.platforms
@@ -0,0 +1,104 @@
+menu "Platform selection"
+
+config ARCH_EXYNOS
+	bool
+	help
+	  This enables support for Samsung Exynos SoC family
+
+config ARCH_EXYNOS7
+	bool "ARMv8 based Samsung Exynos7"
+	select ARCH_EXYNOS
+	select COMMON_CLK_SAMSUNG
+	select HAVE_S3C2410_WATCHDOG if WATCHDOG
+	select HAVE_S3C_RTC if RTC_CLASS
+	select PINCTRL
+	select PINCTRL_EXYNOS
+
+	help
+	  This enables support for Samsung Exynos7 SoC family
+
+config ARCH_FSL_LS2085A
+	bool "Freescale LS2085A SOC"
+	help
+	  This enables support for Freescale LS2085A SOC.
+
+config ARCH_HISI
+	bool "Hisilicon SoC Family"
+	help
+	  This enables support for Hisilicon ARMv8 SoC family
+
+config ARCH_MEDIATEK
+	bool "Mediatek MT65xx & MT81xx ARMv8 SoC"
+	select ARM_GIC
+	select PINCTRL
+	help
+	  Support for Mediatek MT65xx & MT81xx ARMv8 SoCs
+
+config ARCH_QCOM
+	bool "Qualcomm Platforms"
+	select PINCTRL
+	help
+	  This enables support for the ARMv8 based Qualcomm chipsets.
+
+config ARCH_SEATTLE
+	bool "AMD Seattle SoC Family"
+	help
+	  This enables support for AMD Seattle SOC Family
+
+config ARCH_TEGRA
+	bool "NVIDIA Tegra SoC Family"
+	select ARCH_HAS_RESET_CONTROLLER
+	select ARCH_REQUIRE_GPIOLIB
+	select CLKDEV_LOOKUP
+	select CLKSRC_MMIO
+	select CLKSRC_OF
+	select GENERIC_CLOCKEVENTS
+	select HAVE_CLK
+	select PINCTRL
+	select RESET_CONTROLLER
+	help
+	  This enables support for the NVIDIA Tegra SoC family.
+
+config ARCH_TEGRA_132_SOC
+	bool "NVIDIA Tegra132 SoC"
+	depends on ARCH_TEGRA
+	select PINCTRL_TEGRA124
+	select USB_ULPI if USB_PHY
+	select USB_ULPI_VIEWPORT if USB_PHY
+	help
+	  Enable support for NVIDIA Tegra132 SoC, based on the Denver
+	  ARMv8 CPU.  The Tegra132 SoC is similar to the Tegra124 SoC,
+	  but contains an NVIDIA Denver CPU complex in place of
+	  Tegra124's "4+1" Cortex-A15 CPU complex.
+
+config ARCH_SPRD
+	bool "Spreadtrum SoC platform"
+	help
+	  Support for Spreadtrum ARM based SoCs
+
+config ARCH_THUNDER
+	bool "Cavium Inc. Thunder SoC Family"
+	help
+	  This enables support for Cavium's Thunder Family of SoCs.
+
+config ARCH_VEXPRESS
+	bool "ARMv8 software model (Versatile Express)"
+	select ARCH_REQUIRE_GPIOLIB
+	select COMMON_CLK_VERSATILE
+	select POWER_RESET_VEXPRESS
+	select VEXPRESS_CONFIG
+	help
+	  This enables support for the ARMv8 software model (Versatile
+	  Express).
+
+config ARCH_XGENE
+	bool "AppliedMicro X-Gene SOC Family"
+	help
+	  This enables support for AppliedMicro X-Gene SOC Family
+
+config ARCH_ZYNQMP
+	bool "Xilinx ZynqMP Family"
+	help
+	  This enables support for Xilinx ZynqMP Family
+
+endmenu
-- 
2.1.4
