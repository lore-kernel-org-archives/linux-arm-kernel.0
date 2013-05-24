From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 24 May 2013 12:36:09 +0100
Subject: [PATCHv3 4/5] arm: fix up ARM_ARCH_TIMER selects
In-Reply-To: <1369395370-21358-1-git-send-email-mark.rutland@arm.com>
References: <1369395370-21358-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1369395370-21358-5-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In 8a4da6e: "arm: arch_timer: move core to drivers/clocksource", the
selection of ARM_ARCH_TIMER was indirected via HAVE_ARM_ARCH_TIMER,
though mach-exynos's selection of ARM_ARCH_TIMER was missed, and since
then mach-shmobile, mach-tegra, and mach-virt have begun selecting
ARM_ARCH_TIMER. This can lead to architected timer support erroneously
appearing to not be selected in menuconfig.

This patch fixes up the Kconfigs for those platforms to select
HAVE_ARM_ARCH_TIMER.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Stephen Warren <swarren@nvidia.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked-by: Simon Horman <horms+renesas@verge.net.au>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-exynos/Kconfig   | 2 +-
 arch/arm/mach-shmobile/Kconfig | 4 ++--
 arch/arm/mach-tegra/Kconfig    | 2 +-
 arch/arm/mach-virt/Kconfig     | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index d19edff..3c3f36a 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -76,7 +76,7 @@ config SOC_EXYNOS5440
 	default y
 	depends on ARCH_EXYNOS5
 	select ARCH_HAS_OPP
-	select ARM_ARCH_TIMER
+	select HAVE_ARM_ARCH_TIMER
 	select AUTO_ZRELADDR
 	select PINCTRL
 	select PINCTRL_EXYNOS5440
diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 1a517e2..767a6c3 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -23,7 +23,7 @@ config ARCH_R8A73A4
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_GIC
 	select CPU_V7
-	select ARM_ARCH_TIMER
+	select HAVE_ARM_ARCH_TIMER
 	select SH_CLK_CPG
 	select RENESAS_IRQC
 
@@ -56,7 +56,7 @@ config ARCH_R8A7790
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_GIC
 	select CPU_V7
-	select ARM_ARCH_TIMER
+	select HAVE_ARM_ARCH_TIMER
 	select SH_CLK_CPG
 	select RENESAS_IRQC
 
diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
index 84d72fc..65c5ae6 100644
--- a/arch/arm/mach-tegra/Kconfig
+++ b/arch/arm/mach-tegra/Kconfig
@@ -60,7 +60,7 @@ config ARCH_TEGRA_3x_SOC
 
 config ARCH_TEGRA_114_SOC
 	bool "Enable support for Tegra114 family"
-	select ARM_ARCH_TIMER
+	select HAVE_ARM_ARCH_TIMER
 	select ARM_GIC
 	select ARM_L1_CACHE_SHIFT_6
 	select CPU_FREQ_TABLE if CPU_FREQ
diff --git a/arch/arm/mach-virt/Kconfig b/arch/arm/mach-virt/Kconfig
index 8958f0d..081d469 100644
--- a/arch/arm/mach-virt/Kconfig
+++ b/arch/arm/mach-virt/Kconfig
@@ -2,7 +2,7 @@ config ARCH_VIRT
 	bool "Dummy Virtual Machine" if ARCH_MULTI_V7
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_GIC
-	select ARM_ARCH_TIMER
+	select HAVE_ARM_ARCH_TIMER
 	select ARM_PSCI
 	select HAVE_SMP
 	select CPU_V7
-- 
1.8.1.1
