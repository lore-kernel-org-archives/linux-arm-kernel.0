From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri,  7 Jun 2013 19:40:56 +0200
Subject: [PATCH] cpuidle: fix ARCH_NEEDS_CPU_IDLE_COUPLED dependency warning
Message-ID: <1370626856-2876-1-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Before the commit d6f346f2d2bf511c2c59176121a6e42ce60173a0, the
ARCH_NEEDS_CPU_IDLE_COUPLED option was wrongly not depending on the CPU_IDLE
and the Kconfig for OMAP / TEGRA was not checking this dependency when setting
the option.

With this patch, the ARCH_NEEDS_CPU_IDLE_COUPLED has been moved under the
CPU_IDLE option. The dependency has been fixed in the relevant arch's Kconfig.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-omap2/Kconfig |    2 +-
 arch/arm/mach-tegra/Kconfig |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index f49cd51..831e89e 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -83,7 +83,7 @@ config ARCH_OMAP4
 	depends on ARCH_OMAP2PLUS
 	depends on ARCH_MULTI_V7
 	select ARCH_HAS_OPP
-	select ARCH_NEEDS_CPU_IDLE_COUPLED if SMP
+	select ARCH_NEEDS_CPU_IDLE_COUPLED if (SMP && CPU_IDLE)
 	select ARM_CPU_SUSPEND if PM
 	select ARM_ERRATA_720789
 	select ARM_GIC
diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
index 84d72fc..04c6221 100644
--- a/arch/arm/mach-tegra/Kconfig
+++ b/arch/arm/mach-tegra/Kconfig
@@ -23,7 +23,7 @@ menu "NVIDIA Tegra options"
 
 config ARCH_TEGRA_2x_SOC
 	bool "Enable support for Tegra20 family"
-	select ARCH_NEEDS_CPU_IDLE_COUPLED if SMP
+	select ARCH_NEEDS_CPU_IDLE_COUPLED if (SMP && CPU_IDLE)
 	select ARM_ERRATA_720789
 	select ARM_ERRATA_754327 if SMP
 	select ARM_ERRATA_764369 if SMP
-- 
1.7.9.5
