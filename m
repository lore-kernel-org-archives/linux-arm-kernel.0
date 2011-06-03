From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri,  3 Jun 2011 15:15:57 +0100
Subject: [PATCH v6 13/14] ARM: SMP: automatically select ARM_GIC_VPPI
In-Reply-To: <1307110558-29710-1-git-send-email-marc.zyngier@arm.com>
References: <1307110558-29710-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1307110558-29710-14-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All SMP platforms are selecting ARM_GIC_VPPI.
Instead, make SMP select ARM_GIC_VPPI and remove select statements
from the platform code.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/Kconfig               |    1 +
 arch/arm/mach-msm/Kconfig      |    2 --
 arch/arm/mach-omap2/Kconfig    |    1 -
 arch/arm/mach-realview/Kconfig |    2 --
 arch/arm/mach-shmobile/Kconfig |    1 -
 arch/arm/mach-tegra/Kconfig    |    1 -
 arch/arm/mach-ux500/Kconfig    |    1 -
 arch/arm/mach-vexpress/Kconfig |    1 -
 arch/arm/plat-s5p/Kconfig      |    1 -
 9 files changed, 1 insertions(+), 10 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 9adc278..6094268 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1313,6 +1313,7 @@ config SMP
 		 ARCH_EXYNOS4 || ARCH_TEGRA || ARCH_U8500 || ARCH_VEXPRESS_CA9X4 || \
 		 ARCH_MSM_SCORPIONMP || ARCH_SHMOBILE
 	select USE_GENERIC_SMP_HELPERS
+	select ARM_GIC_VPPI
 	select HAVE_ARM_SCU if !ARCH_MSM_SCORPIONMP
 	help
 	  This enables support for systems with more than one CPU. If you have
diff --git a/arch/arm/mach-msm/Kconfig b/arch/arm/mach-msm/Kconfig
index 1ea7d6f..1516896 100644
--- a/arch/arm/mach-msm/Kconfig
+++ b/arch/arm/mach-msm/Kconfig
@@ -42,7 +42,6 @@ config ARCH_MSM8X60
 				  && !MACH_MSM8X60_FFA)
 	select ARCH_MSM_SCORPIONMP
 	select ARM_GIC
-	select ARM_GIC_VPPI
 	select CPU_V7
 	select MSM_V2_TLMM
 	select MSM_GPIOMUX
@@ -53,7 +52,6 @@ config ARCH_MSM8960
 	select ARCH_MSM_SCORPIONMP
 	select MACH_MSM8960_SIM if (!MACH_MSM8960_RUMI3)
 	select ARM_GIC
-	select ARM_GIC_VPPI
 	select CPU_V7
 	select MSM_V2_TLMM
 	select MSM_GPIOMUX
diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 284694c..19d5891 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -44,7 +44,6 @@ config ARCH_OMAP4
 	depends on ARCH_OMAP2PLUS
 	select CPU_V7
 	select ARM_GIC
-	select ARM_GIC_VPPI
 	select LOCAL_TIMERS if SMP
 	select PL310_ERRATA_588369
 	select PL310_ERRATA_727915
diff --git a/arch/arm/mach-realview/Kconfig b/arch/arm/mach-realview/Kconfig
index 12c7c56..b9a9805 100644
--- a/arch/arm/mach-realview/Kconfig
+++ b/arch/arm/mach-realview/Kconfig
@@ -38,7 +38,6 @@ config MACH_REALVIEW_PB11MP
 	bool "Support RealView(R) Platform Baseboard for ARM11MPCore"
 	select CPU_V6K
 	select ARM_GIC
-	select ARM_GIC_VPPI
 	select HAVE_PATA_PLATFORM
 	select ARCH_HAS_BARRIERS if SMP
 	help
@@ -77,7 +76,6 @@ config MACH_REALVIEW_PBA8
 config MACH_REALVIEW_PBX
 	bool "Support RealView(R) Platform Baseboard Explore"
 	select ARM_GIC
-	select ARM_GIC_VPPI
 	select HAVE_PATA_PLATFORM
 	select ARCH_SPARSEMEM_ENABLE if CPU_V7 && !REALVIEW_HIGH_PHYS_OFFSET
 	select ZONE_DMA if SPARSEMEM
diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index ddcf28c..0c8f6cf 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -26,7 +26,6 @@ config ARCH_SH73A0
 	select SH_CLK_CPG
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_GIC
-	select ARM_GIC_VPPI
 
 comment "SH-Mobile Board Type"
 
diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
index eabdd90..5ec1846 100644
--- a/arch/arm/mach-tegra/Kconfig
+++ b/arch/arm/mach-tegra/Kconfig
@@ -9,7 +9,6 @@ config ARCH_TEGRA_2x_SOC
 	bool "Tegra 2 family"
 	select CPU_V7
 	select ARM_GIC
-	select ARM_GIC_VPPI
 	select ARCH_REQUIRE_GPIOLIB
 	select USB_ARCH_HAS_EHCI if USB_SUPPORT
 	select USB_ULPI if USB_SUPPORT
diff --git a/arch/arm/mach-ux500/Kconfig b/arch/arm/mach-ux500/Kconfig
index d9ad4cf..f8b9392 100644
--- a/arch/arm/mach-ux500/Kconfig
+++ b/arch/arm/mach-ux500/Kconfig
@@ -4,7 +4,6 @@ config UX500_SOC_COMMON
 	bool
 	default y
 	select ARM_GIC
-	select ARM_GIC_VPPI
 	select HAS_MTU
 	select ARM_ERRATA_753970
 
diff --git a/arch/arm/mach-vexpress/Kconfig b/arch/arm/mach-vexpress/Kconfig
index 07a53aa..9311484 100644
--- a/arch/arm/mach-vexpress/Kconfig
+++ b/arch/arm/mach-vexpress/Kconfig
@@ -5,7 +5,6 @@ config ARCH_VEXPRESS_CA9X4
 	bool "Versatile Express Cortex-A9x4 tile"
 	select CPU_V7
 	select ARM_GIC
-	select ARM_GIC_VPPI
 	select ARM_ERRATA_720789
 	select ARM_ERRATA_751472
 	select ARM_ERRATA_753970
diff --git a/arch/arm/plat-s5p/Kconfig b/arch/arm/plat-s5p/Kconfig
index 46aba74..e98f5c5 100644
--- a/arch/arm/plat-s5p/Kconfig
+++ b/arch/arm/plat-s5p/Kconfig
@@ -11,7 +11,6 @@ config PLAT_S5P
 	default y
 	select ARM_VIC if !ARCH_EXYNOS4
 	select ARM_GIC if ARCH_EXYNOS4
-	select ARM_GIC_VPPI if ARCH_EXYNOS4
 	select NO_IOPORT
 	select ARCH_REQUIRE_GPIOLIB
 	select S3C_GPIO_TRACK
-- 
1.7.0.4
