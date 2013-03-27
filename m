From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 27 Mar 2013 17:11:51 +0000
Subject: [PATCH 4/5] arm: fix up ARM_ARCH_TIMER selects
In-Reply-To: <1364404312-4427-1-git-send-email-mark.rutland@arm.com>
References: <1364404312-4427-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1364404312-4427-5-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In 8a4da6e: "arm: arch_timer: move core to drivers/clocksource", the
selection of ARM_ARCH_TIMER was indirected via HAVE_ARM_ARCH_TIMER,
though mach-exynos's selection of ARM_ARCH_TIMER was missed, and since
then mach-virt and mach-tegra have begun selecting ARM_ARCH_TIMER. This
can lead to architected timer support erroneously appearing to not be
selected in menuconfig.

This patch fixes up the Kconfigs for those platforms to select
HAVE_ARM_ARCH_TIMER.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-exynos/Kconfig | 2 +-
 arch/arm/mach-tegra/Kconfig  | 2 +-
 arch/arm/mach-virt/Kconfig   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index 70f94c8..fd45ec0 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -72,7 +72,7 @@ config SOC_EXYNOS5440
 	bool "SAMSUNG EXYNOS5440"
 	default y
 	depends on ARCH_EXYNOS5
-	select ARM_ARCH_TIMER
+	select HAVE_ARM_ARCH_TIMER
 	select AUTO_ZRELADDR
 	select PINCTRL
 	select PINCTRL_EXYNOS5440
diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
index d1c4893..2a4c9b8 100644
--- a/arch/arm/mach-tegra/Kconfig
+++ b/arch/arm/mach-tegra/Kconfig
@@ -45,7 +45,7 @@ config ARCH_TEGRA_3x_SOC
 
 config ARCH_TEGRA_114_SOC
 	bool "Enable support for Tegra114 family"
-	select ARM_ARCH_TIMER
+	select HAVE_ARM_ARCH_TIMER
 	select ARM_GIC
 	select ARM_L1_CACHE_SHIFT_6
 	select CPU_V7
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
