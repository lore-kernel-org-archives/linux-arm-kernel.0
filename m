From: josephl@nvidia.com (Joseph Lo)
Date: Wed, 3 Jul 2013 17:55:48 +0800
Subject: [PATCH] ARM: tegra114: Enable Cortex-A15 errata 798181
Message-ID: <1372845348-27089-1-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The commit 93dc688 (ARM: 7684/1: errata: Workaround for Cortex-A15
erratum 798181 (TLBI/DSB operations)) introduecd a workaround for
Cortex-A15 errata 798181. Enabling it for Tegra114.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
 arch/arm/mach-tegra/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
index ef3a8da..add345e 100644
--- a/arch/arm/mach-tegra/Kconfig
+++ b/arch/arm/mach-tegra/Kconfig
@@ -59,6 +59,7 @@ config ARCH_TEGRA_3x_SOC
 config ARCH_TEGRA_114_SOC
 	bool "Enable support for Tegra114 family"
 	select HAVE_ARM_ARCH_TIMER
+	select ARM_ERRATA_798181
 	select ARM_GIC
 	select ARM_L1_CACHE_SHIFT_6
 	select CPU_V7
-- 
1.8.3.2
