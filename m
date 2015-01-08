From: mikko.perttunen@kapsi.fi (Mikko Perttunen)
Date: Thu,  8 Jan 2015 15:22:15 +0200
Subject: [PATCH v7 12/16] cpufreq: tegra: Rename tegra-cpufreq to
 tegra20-cpufreq
In-Reply-To: <1420723339-30735-1-git-send-email-mikko.perttunen@kapsi.fi>
References: <1420723339-30735-1-git-send-email-mikko.perttunen@kapsi.fi>
Message-ID: <1420723339-30735-13-git-send-email-mikko.perttunen@kapsi.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tuomas Tynkkynen <ttynkkynen@nvidia.com>

The Tegra124 will use a different driver for frequency scaling, so
rename the old driver (which handles only Tegra20) appropriately.

Signed-off-by: Tuomas Tynkkynen <ttynkkynen@nvidia.com>
Signed-off-by: Mikko Perttunen <mikko.perttunen@kapsi.fi>
---
 drivers/cpufreq/Kconfig.arm                            | 6 +++---
 drivers/cpufreq/Makefile                               | 2 +-
 drivers/cpufreq/{tegra-cpufreq.c => tegra20-cpufreq.c} | 0
 3 files changed, 4 insertions(+), 4 deletions(-)
 rename drivers/cpufreq/{tegra-cpufreq.c => tegra20-cpufreq.c} (100%)

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 0f9a2c3..22ccc07 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -241,12 +241,12 @@ config ARM_SPEAR_CPUFREQ
 	help
 	  This adds the CPUFreq driver support for SPEAr SOCs.
 
-config ARM_TEGRA_CPUFREQ
-	bool "TEGRA CPUFreq support"
+config ARM_TEGRA20_CPUFREQ
+	bool "Tegra20 CPUFreq support"
 	depends on ARCH_TEGRA
 	default y
 	help
-	  This adds the CPUFreq driver support for TEGRA SOCs.
+	  This adds the CPUFreq driver support for Tegra20 SOCs.
 
 config ARM_PXA2xx_CPUFREQ
 	tristate "Intel PXA2xx CPUfreq driver"
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index 8b4220a..3f9a3a8 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -75,7 +75,7 @@ obj-$(CONFIG_ARM_S5PV210_CPUFREQ)	+= s5pv210-cpufreq.o
 obj-$(CONFIG_ARM_SA1100_CPUFREQ)	+= sa1100-cpufreq.o
 obj-$(CONFIG_ARM_SA1110_CPUFREQ)	+= sa1110-cpufreq.o
 obj-$(CONFIG_ARM_SPEAR_CPUFREQ)		+= spear-cpufreq.o
-obj-$(CONFIG_ARM_TEGRA_CPUFREQ)		+= tegra-cpufreq.o
+obj-$(CONFIG_ARM_TEGRA20_CPUFREQ)	+= tegra20-cpufreq.o
 obj-$(CONFIG_ARM_VEXPRESS_SPC_CPUFREQ)	+= vexpress-spc-cpufreq.o
 
 ##################################################################################
diff --git a/drivers/cpufreq/tegra-cpufreq.c b/drivers/cpufreq/tegra20-cpufreq.c
similarity index 100%
rename from drivers/cpufreq/tegra-cpufreq.c
rename to drivers/cpufreq/tegra20-cpufreq.c
-- 
2.2.1
