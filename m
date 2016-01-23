From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sat, 23 Jan 2016 17:55:30 +0900
Subject: [PATCH] ARM: tegra: remove redundant ARM_L1_CACHE_SHIFT_6 select
Message-ID: <1453539330-11903-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These two are both ARMv7 SoCs.  They need not explicitly select
ARM_L1_CACHE_SHIFT_6 because it is enabled along with CPU_V7.

Refer to commit a092f2b15399 ("ARM: 7291/1: cache: assume 64-byte L1
cachelines for ARMv7 CPUs").

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/soc/tegra/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/soc/tegra/Kconfig b/drivers/soc/tegra/Kconfig
index d0c3c3e..03089ad 100644
--- a/drivers/soc/tegra/Kconfig
+++ b/drivers/soc/tegra/Kconfig
@@ -31,7 +31,6 @@ config ARCH_TEGRA_3x_SOC
 config ARCH_TEGRA_114_SOC
 	bool "Enable support for Tegra114 family"
 	select ARM_ERRATA_798181 if SMP
-	select ARM_L1_CACHE_SHIFT_6
 	select HAVE_ARM_ARCH_TIMER
 	select PINCTRL_TEGRA114
 	select TEGRA_TIMER
@@ -41,7 +40,6 @@ config ARCH_TEGRA_114_SOC
 
 config ARCH_TEGRA_124_SOC
 	bool "Enable support for Tegra124 family"
-	select ARM_L1_CACHE_SHIFT_6
 	select HAVE_ARM_ARCH_TIMER
 	select PINCTRL_TEGRA124
 	select TEGRA_TIMER
-- 
1.9.1
