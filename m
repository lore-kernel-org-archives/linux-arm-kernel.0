From: josephl@nvidia.com (Joseph Lo)
Date: Mon, 7 Oct 2013 15:31:19 +0800
Subject: [PATCH 1/7] ARM: tegra: add Tegra124 SoC support
In-Reply-To: <1381131085-26116-1-git-send-email-josephl@nvidia.com>
References: <1381131085-26116-1-git-send-email-josephl@nvidia.com>
Message-ID: <1381131085-26116-2-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Tegra124 SoC support that base on CortexA15MP Core.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
 arch/arm/mach-tegra/Kconfig | 8 ++++++++
 arch/arm/mach-tegra/tegra.c | 1 +
 2 files changed, 9 insertions(+)

diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
index 67a76f2..92272e0 100644
--- a/arch/arm/mach-tegra/Kconfig
+++ b/arch/arm/mach-tegra/Kconfig
@@ -61,6 +61,14 @@ config ARCH_TEGRA_114_SOC
 	  Support for NVIDIA Tegra T114 processor family, based on the
 	  ARM CortexA15MP CPU
 
+config ARCH_TEGRA_124_SOC
+	bool "Enable support for Tegra124 family"
+	select ARM_L1_CACHE_SHIFT_6
+	select HAVE_ARM_ARCH_TIMER
+	help
+	  Support for NVIDIA Tegra T124 processor family, based on the
+	  ARM CortexA15MP CPU
+
 config TEGRA_AHB
 	bool "Enable AHB driver for NVIDIA Tegra SoCs"
 	default y
diff --git a/arch/arm/mach-tegra/tegra.c b/arch/arm/mach-tegra/tegra.c
index 40b031c..80b801a 100644
--- a/arch/arm/mach-tegra/tegra.c
+++ b/arch/arm/mach-tegra/tegra.c
@@ -181,6 +181,7 @@ static void __init tegra_dt_init_late(void)
 }
 
 static const char * const tegra_dt_board_compat[] = {
+	"nvidia,tegra124",
 	"nvidia,tegra114",
 	"nvidia,tegra30",
 	"nvidia,tegra20",
-- 
1.8.4
