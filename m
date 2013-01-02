From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed,  2 Jan 2013 14:34:15 -0700
Subject: [PATCH] ARM: tegra: fix Kconfig warnings when !SMP
Message-ID: <1357162455-24043-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Fix:

warning: (ARCH_TEGRA_2x_SOC) selects ARM_ERRATA_754327 which has unmet direct dependencies (CPU_V7 && SMP)
warning: (ARCH_TEGRA_2x_SOC) selects ARM_ERRATA_742230 which has unmet direct dependencies (CPU_V7 && SMP)

by selecting options only if SMP.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/mach-tegra/Kconfig |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
index b442f15..1ec7f80 100644
--- a/arch/arm/mach-tegra/Kconfig
+++ b/arch/arm/mach-tegra/Kconfig
@@ -6,9 +6,9 @@ config ARCH_TEGRA_2x_SOC
 	bool "Enable support for Tegra20 family"
 	select ARCH_REQUIRE_GPIOLIB
 	select ARM_ERRATA_720789
-	select ARM_ERRATA_742230
+	select ARM_ERRATA_742230 if SMP
 	select ARM_ERRATA_751472
-	select ARM_ERRATA_754327
+	select ARM_ERRATA_754327 if SMP
 	select ARM_ERRATA_764369 if SMP
 	select ARM_GIC
 	select CPU_FREQ_TABLE if CPU_FREQ
-- 
1.7.10.4
