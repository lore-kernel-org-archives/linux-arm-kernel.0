From: josephl@nvidia.com (Joseph Lo)
Date: Mon, 8 Oct 2012 18:23:57 +0800
Subject: [PATCH] ARM: tegra: rename the file of "sleep-tXX" to "sleep-tegraXX"
Message-ID: <1349691837-30488-1-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For the naming consistency under the mach-tegra, we re-name the file of
"sleep-tXX" to "sleep-tegraXX" (e.g., sleep-t30 to sleep-tegra30).

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
 arch/arm/mach-tegra/Makefile                       |    4 ++--
 .../mach-tegra/{sleep-t20.S => sleep-tegra20.S}    |    0
 .../mach-tegra/{sleep-t30.S => sleep-tegra30.S}    |    0
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename arch/arm/mach-tegra/{sleep-t20.S => sleep-tegra20.S} (100%)
 rename arch/arm/mach-tegra/{sleep-t30.S => sleep-tegra30.S} (100%)

diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
index 9aa653b..e6929c6 100644
--- a/arch/arm/mach-tegra/Makefile
+++ b/arch/arm/mach-tegra/Makefile
@@ -13,10 +13,10 @@ obj-$(CONFIG_CPU_IDLE)			+= sleep.o
 obj-$(CONFIG_ARCH_TEGRA_2x_SOC)         += tegra20_clocks.o
 obj-$(CONFIG_ARCH_TEGRA_2x_SOC)         += tegra20_clocks_data.o
 obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= tegra2_emc.o
-obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= sleep-t20.o
+obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= sleep-tegra20.o
 obj-$(CONFIG_ARCH_TEGRA_3x_SOC)		+= tegra30_clocks.o
 obj-$(CONFIG_ARCH_TEGRA_3x_SOC)		+= tegra30_clocks_data.o
-obj-$(CONFIG_ARCH_TEGRA_3x_SOC)		+= sleep-t30.o
+obj-$(CONFIG_ARCH_TEGRA_3x_SOC)		+= sleep-tegra30.o
 obj-$(CONFIG_SMP)			+= platsmp.o headsmp.o
 obj-$(CONFIG_SMP)                       += reset.o
 obj-$(CONFIG_HOTPLUG_CPU)               += hotplug.o
diff --git a/arch/arm/mach-tegra/sleep-t20.S b/arch/arm/mach-tegra/sleep-tegra20.S
similarity index 100%
rename from arch/arm/mach-tegra/sleep-t20.S
rename to arch/arm/mach-tegra/sleep-tegra20.S
diff --git a/arch/arm/mach-tegra/sleep-t30.S b/arch/arm/mach-tegra/sleep-tegra30.S
similarity index 100%
rename from arch/arm/mach-tegra/sleep-t30.S
rename to arch/arm/mach-tegra/sleep-tegra30.S
-- 
1.7.0.4
