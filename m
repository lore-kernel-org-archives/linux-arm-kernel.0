From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 13 Jun 2014 18:01:11 +0200
Subject: [PATCH 09/14] ARM: Remove ARCH_HAS_CPUFREQ config option
In-Reply-To: <1402675276-538682-1-git-send-email-arnd@arndb.de>
References: <1402675276-538682-1-git-send-email-arnd@arndb.de>
Message-ID: <1402675276-538682-10-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Boyd <sboyd@codeaurora.org>

This config exists entirely to hide the cpufreq menu from the
kernel configuration unless a platform has selected it. Nothing
is actually built if this config is 'Y' and it just leads to more
patches that add a select under a platform Kconfig so that some
other CPUfreq option can be chosen. Let's remove the option so
that we can always enable CPUfreq drivers on ARM platforms.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig               | 17 -----------------
 arch/arm/mach-davinci/Kconfig  |  1 -
 arch/arm/mach-exynos/Kconfig   |  1 -
 arch/arm/mach-highbank/Kconfig |  1 -
 arch/arm/mach-imx/Kconfig      |  3 ---
 arch/arm/mach-mvebu/Kconfig    |  1 -
 arch/arm/mach-omap2/Kconfig    |  1 -
 arch/arm/mach-shmobile/Kconfig |  2 --
 arch/arm/mach-spear/Kconfig    |  1 -
 arch/arm/mach-tegra/Kconfig    |  1 -
 arch/arm/mach-ux500/Kconfig    |  1 -
 arch/arm/mach-vexpress/Kconfig |  1 -
 arch/arm/mach-vt8500/Kconfig   |  1 -
 arch/arm/mach-zynq/Kconfig     |  1 -
 14 files changed, 33 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 87b63fd..9b8f528 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -175,13 +175,6 @@ config ARCH_HAS_ILOG2_U32
 config ARCH_HAS_ILOG2_U64
 	bool
 
-config ARCH_HAS_CPUFREQ
-	bool
-	help
-	  Internal node to signify that the ARCH has CPUFREQ support
-	  and that the relevant menu configurations are displayed for
-	  it.
-
 config ARCH_HAS_BANDGAP
 	bool
 
@@ -318,7 +311,6 @@ config ARCH_MULTIPLATFORM
 
 config ARCH_INTEGRATOR
 	bool "ARM Ltd. Integrator family"
-	select ARCH_HAS_CPUFREQ
 	select ARM_AMBA
 	select ARM_PATCH_PHYS_VIRT
 	select AUTO_ZRELADDR
@@ -538,7 +530,6 @@ config ARCH_DOVE
 
 config ARCH_KIRKWOOD
 	bool "Marvell Kirkwood"
-	select ARCH_HAS_CPUFREQ
 	select ARCH_REQUIRE_GPIOLIB
 	select CPU_FEROCEON
 	select GENERIC_CLOCKEVENTS
@@ -637,7 +628,6 @@ config ARCH_LPC32XX
 config ARCH_PXA
 	bool "PXA2xx/PXA3xx-based"
 	depends on MMU
-	select ARCH_HAS_CPUFREQ
 	select ARCH_MTD_XIP
 	select ARCH_REQUIRE_GPIOLIB
 	select ARM_CPU_SUSPEND if PM
@@ -707,7 +697,6 @@ config ARCH_RPC
 
 config ARCH_SA1100
 	bool "SA1100-based"
-	select ARCH_HAS_CPUFREQ
 	select ARCH_MTD_XIP
 	select ARCH_REQUIRE_GPIOLIB
 	select ARCH_SPARSEMEM_ENABLE
@@ -725,7 +714,6 @@ config ARCH_SA1100
 
 config ARCH_S3C24XX
 	bool "Samsung S3C24XX SoCs"
-	select ARCH_HAS_CPUFREQ
 	select ARCH_REQUIRE_GPIOLIB
 	select ATAGS
 	select CLKDEV_LOOKUP
@@ -746,7 +734,6 @@ config ARCH_S3C24XX
 
 config ARCH_S3C64XX
 	bool "Samsung S3C64XX"
-	select ARCH_HAS_CPUFREQ
 	select ARCH_REQUIRE_GPIOLIB
 	select ARM_AMBA
 	select ARM_VIC
@@ -809,7 +796,6 @@ config ARCH_S5PC100
 
 config ARCH_S5PV210
 	bool "Samsung S5PV210/S5PC110"
-	select ARCH_HAS_CPUFREQ
 	select ARCH_HAS_HOLES_MEMORYMODEL
 	select ARCH_SPARSEMEM_ENABLE
 	select ATAGS
@@ -845,7 +831,6 @@ config ARCH_DAVINCI
 config ARCH_OMAP1
 	bool "TI OMAP1"
 	depends on MMU
-	select ARCH_HAS_CPUFREQ
 	select ARCH_HAS_HOLES_MEMORYMODEL
 	select ARCH_OMAP
 	select ARCH_REQUIRE_GPIOLIB
@@ -2109,9 +2094,7 @@ endmenu
 
 menu "CPU Power Management"
 
-if ARCH_HAS_CPUFREQ
 source "drivers/cpufreq/Kconfig"
-endif
 
 source "drivers/cpuidle/Kconfig"
 
diff --git a/arch/arm/mach-davinci/Kconfig b/arch/arm/mach-davinci/Kconfig
index db18ef8..584e8d4 100644
--- a/arch/arm/mach-davinci/Kconfig
+++ b/arch/arm/mach-davinci/Kconfig
@@ -39,7 +39,6 @@ config ARCH_DAVINCI_DA830
 config ARCH_DAVINCI_DA850
 	bool "DA850/OMAP-L138/AM18x based system"
 	select ARCH_DAVINCI_DA8XX
-	select ARCH_HAS_CPUFREQ
 	select CP_INTC
 
 config ARCH_DAVINCI_DA8XX
diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index d58995c9..845031b 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -10,7 +10,6 @@
 config ARCH_EXYNOS
 	bool "Samsung EXYNOS" if ARCH_MULTI_V7
 	select ARCH_HAS_BANDGAP
-	select ARCH_HAS_CPUFREQ
 	select ARCH_HAS_HOLES_MEMORYMODEL
 	select ARCH_REQUIRE_GPIOLIB
 	select ARM_AMBA
diff --git a/arch/arm/mach-highbank/Kconfig b/arch/arm/mach-highbank/Kconfig
index 830b76e..a5960e2 100644
--- a/arch/arm/mach-highbank/Kconfig
+++ b/arch/arm/mach-highbank/Kconfig
@@ -1,7 +1,6 @@
 config ARCH_HIGHBANK
 	bool "Calxeda ECX-1000/2000 (Highbank/Midway)" if ARCH_MULTI_V7
 	select ARCH_DMA_ADDR_T_64BIT if ARM_LPAE
-	select ARCH_HAS_CPUFREQ
 	select ARCH_HAS_HOLES_MEMORYMODEL
 	select ARCH_HAS_OPP
 	select ARCH_SUPPORTS_BIG_ENDIAN
diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 8d42eab..b232340 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -1,6 +1,5 @@
 config ARCH_MXC
 	bool "Freescale i.MX family" if ARCH_MULTI_V4_V5 || ARCH_MULTI_V6_V7
-	select ARCH_HAS_CPUFREQ
 	select ARCH_HAS_OPP
 	select ARCH_REQUIRE_GPIOLIB
 	select ARM_CPU_SUSPEND if PM
@@ -99,7 +98,6 @@ config SOC_IMX25
 
 config SOC_IMX27
 	bool
-	select ARCH_HAS_CPUFREQ
 	select ARCH_HAS_OPP
 	select CPU_ARM926T
 	select IMX_HAVE_IOMUX_V1
@@ -124,7 +122,6 @@ config SOC_IMX35
 
 config SOC_IMX5
 	bool
-	select ARCH_HAS_CPUFREQ
 	select ARCH_HAS_OPP
 	select ARCH_MXC_IOMUX_V3
 	select MXC_TZIC
diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
index bcfe094..74e1ff2 100644
--- a/arch/arm/mach-mvebu/Kconfig
+++ b/arch/arm/mach-mvebu/Kconfig
@@ -85,7 +85,6 @@ config MACH_DOVE
 
 config MACH_KIRKWOOD
 	bool "Marvell Kirkwood boards" if ARCH_MULTI_V5
-	select ARCH_HAS_CPUFREQ
 	select ARCH_REQUIRE_GPIOLIB
 	select CPU_FEROCEON
 	select KIRKWOOD_CLK
diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 2085b3d..0006012 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -79,7 +79,6 @@ config SOC_DRA7XX
 config ARCH_OMAP2PLUS
 	bool
 	select ARCH_HAS_BANDGAP
-	select ARCH_HAS_CPUFREQ
 	select ARCH_HAS_HOLES_MEMORYMODEL
 	select ARCH_OMAP
 	select ARCH_REQUIRE_GPIOLIB
diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index dbd954e..270e5ca 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -85,7 +85,6 @@ config ARCH_R8A73A4
 	select CPU_V7
 	select SH_CLK_CPG
 	select RENESAS_IRQC
-	select ARCH_HAS_CPUFREQ
 	select ARCH_HAS_OPP
 	select SYS_SUPPORTS_SH_CMT
 	select SYS_SUPPORTS_SH_TMU
@@ -264,7 +263,6 @@ config MACH_KOELSCH
 config MACH_KZM9G
 	bool "KZM-A9-GT board"
 	depends on ARCH_SH73A0
-	select ARCH_HAS_CPUFREQ
 	select ARCH_HAS_OPP
 	select ARCH_REQUIRE_GPIOLIB
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
diff --git a/arch/arm/mach-spear/Kconfig b/arch/arm/mach-spear/Kconfig
index 0786249..90df202 100644
--- a/arch/arm/mach-spear/Kconfig
+++ b/arch/arm/mach-spear/Kconfig
@@ -14,7 +14,6 @@ if PLAT_SPEAR
 config ARCH_SPEAR13XX
 	bool "ST SPEAr13xx"
 	depends on ARCH_MULTI_V7 || PLAT_SPEAR_SINGLE
-	select ARCH_HAS_CPUFREQ
 	select ARM_GIC
 	select GPIO_SPEAR_SPICS
 	select HAVE_ARM_SCU if SMP
diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
index e16999e..8981ed4 100644
--- a/arch/arm/mach-tegra/Kconfig
+++ b/arch/arm/mach-tegra/Kconfig
@@ -1,6 +1,5 @@
 config ARCH_TEGRA
 	bool "NVIDIA Tegra" if ARCH_MULTI_V7
-	select ARCH_HAS_CPUFREQ
 	select ARCH_REQUIRE_GPIOLIB
 	select ARCH_SUPPORTS_TRUSTED_FOUNDATIONS
 	select ARM_GIC
diff --git a/arch/arm/mach-ux500/Kconfig b/arch/arm/mach-ux500/Kconfig
index b41a42d..9b93144 100644
--- a/arch/arm/mach-ux500/Kconfig
+++ b/arch/arm/mach-ux500/Kconfig
@@ -3,7 +3,6 @@ config ARCH_U8500
 	depends on MMU
 	select AB8500_CORE
 	select ABX500_CORE
-	select ARCH_HAS_CPUFREQ
 	select ARCH_REQUIRE_GPIOLIB
 	select ARM_AMBA
 	select ARM_ERRATA_754322
diff --git a/arch/arm/mach-vexpress/Kconfig b/arch/arm/mach-vexpress/Kconfig
index 90249cf..2e2e8bb 100644
--- a/arch/arm/mach-vexpress/Kconfig
+++ b/arch/arm/mach-vexpress/Kconfig
@@ -65,7 +65,6 @@ config ARCH_VEXPRESS_DCSCB
 
 config ARCH_VEXPRESS_SPC
 	bool "Versatile Express Serial Power Controller (SPC)"
-	select ARCH_HAS_CPUFREQ
 	select ARCH_HAS_OPP
 	select PM_OPP
 	help
diff --git a/arch/arm/mach-vt8500/Kconfig b/arch/arm/mach-vt8500/Kconfig
index 08f56a4..aaaa24f 100644
--- a/arch/arm/mach-vt8500/Kconfig
+++ b/arch/arm/mach-vt8500/Kconfig
@@ -1,6 +1,5 @@
 config ARCH_VT8500
 	bool
-	select ARCH_HAS_CPUFREQ
 	select ARCH_REQUIRE_GPIOLIB
 	select CLKDEV_LOOKUP
 	select VT8500_TIMER
diff --git a/arch/arm/mach-zynq/Kconfig b/arch/arm/mach-zynq/Kconfig
index 573e0db..0c164f8 100644
--- a/arch/arm/mach-zynq/Kconfig
+++ b/arch/arm/mach-zynq/Kconfig
@@ -1,6 +1,5 @@
 config ARCH_ZYNQ
 	bool "Xilinx Zynq ARM Cortex A9 Platform" if ARCH_MULTI_V7
-	select ARCH_HAS_CPUFREQ
 	select ARCH_HAS_OPP
 	select ARCH_SUPPORTS_BIG_ENDIAN
 	select ARM_AMBA
-- 
1.8.3.2
