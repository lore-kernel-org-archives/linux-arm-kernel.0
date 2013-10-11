From: josephl@nvidia.com (Joseph Lo)
Date: Fri, 11 Oct 2013 17:57:30 +0800
Subject: [PATCH V2 2/4] ARM: tegra: CPU hotplug support for Tegra124
In-Reply-To: <1381485452-3561-1-git-send-email-josephl@nvidia.com>
References: <1381485452-3561-1-git-send-email-josephl@nvidia.com>
Message-ID: <1381485452-3561-3-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The procedure of CPU hotplug for Tegra124 is same with Tegra114. We
re-use the same function with it.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
V2:
* no change
---
 arch/arm/mach-tegra/Makefile  | 1 +
 arch/arm/mach-tegra/hotplug.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
index 97eb48e..04ca2b3 100644
--- a/arch/arm/mach-tegra/Makefile
+++ b/arch/arm/mach-tegra/Makefile
@@ -35,5 +35,6 @@ obj-$(CONFIG_ARCH_TEGRA_114_SOC)	+= pm-tegra30.o
 ifeq ($(CONFIG_CPU_IDLE),y)
 obj-$(CONFIG_ARCH_TEGRA_114_SOC)	+= cpuidle-tegra114.o
 endif
+obj-$(CONFIG_ARCH_TEGRA_124_SOC)	+= sleep-tegra30.o
 
 obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= board-paz00.o
diff --git a/arch/arm/mach-tegra/hotplug.c b/arch/arm/mach-tegra/hotplug.c
index 04de2e8..ff26af2 100644
--- a/arch/arm/mach-tegra/hotplug.c
+++ b/arch/arm/mach-tegra/hotplug.c
@@ -57,4 +57,6 @@ void __init tegra_hotplug_init(void)
 		tegra_hotplug_shutdown = tegra30_hotplug_shutdown;
 	if (IS_ENABLED(CONFIG_ARCH_TEGRA_114_SOC) && tegra_chip_id == TEGRA114)
 		tegra_hotplug_shutdown = tegra30_hotplug_shutdown;
+	if (IS_ENABLED(CONFIG_ARCH_TEGRA_124_SOC) && tegra_chip_id == TEGRA124)
+		tegra_hotplug_shutdown = tegra30_hotplug_shutdown;
 }
-- 
1.8.4
