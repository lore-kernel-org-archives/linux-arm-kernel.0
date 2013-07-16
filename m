From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 16 Jul 2013 16:17:22 -0600
Subject: [PATCH 3/4] ARM: tegra: sort Makefile and fix whitespace
In-Reply-To: <1374013043-4693-1-git-send-email-swarren@wwwdotorg.org>
References: <1374013043-4693-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1374013043-4693-3-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Sort Makefile alphabetically, and consistently use TABs not spaces for
all indentation.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/mach-tegra/Makefile | 41 +++++++++++++++++++----------------------
 1 file changed, 19 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
index efb1e01..6ac978b 100644
--- a/arch/arm/mach-tegra/Makefile
+++ b/arch/arm/mach-tegra/Makefile
@@ -1,34 +1,31 @@
 asflags-y				+= -march=armv7-a
 
-obj-y                                   += common.o
-obj-y                                   += io.o
-obj-y                                   += irq.o
+obj-y					+= apbio.o
+obj-y					+= board-harmony-pcie.o
+obj-y					+= board-paz00.o
+obj-y					+= common.o
+obj-$(CONFIG_CPU_IDLE)			+= cpuidle.o
+obj-$(CONFIG_CPU_IDLE)			+= cpuidle-tegra20.o
+obj-$(CONFIG_CPU_IDLE)			+= cpuidle-tegra30.o
+obj-$(CONFIG_CPU_IDLE)			+= cpuidle-tegra114.o
+obj-y					+= flowctrl.o
 obj-y					+= fuse.o
+obj-$(CONFIG_SMP)			+= headsmp.o
+obj-$(CONFIG_HOTPLUG_CPU)		+= hotplug.o
+obj-y					+= io.o
+obj-y					+= irq.o
+obj-$(CONFIG_TEGRA_PCI)			+= pcie.o
+obj-$(CONFIG_SMP)			+= platsmp.o
+obj-y					+= pm.o
 obj-y					+= pmc.o
-obj-y					+= flowctrl.o
 obj-y					+= powergate.o
-obj-y					+= apbio.o
-obj-y					+= pm.o
 obj-y					+= reset.o
 obj-y					+= reset-handler.o
-obj-y					+= sleep.o
 obj-y					+= tegra.o
-obj-$(CONFIG_CPU_IDLE)			+= cpuidle.o
-obj-y					+= tegra20_speedo.o
 obj-y					+= tegra2_emc.o
-obj-y					+= sleep-tegra20.o
-obj-$(CONFIG_CPU_IDLE)			+= cpuidle-tegra20.o
+obj-y					+= tegra20_speedo.o
 obj-y					+= tegra30_speedo.o
-obj-y					+= sleep-tegra30.o
-obj-$(CONFIG_CPU_IDLE)			+= cpuidle-tegra30.o
-obj-$(CONFIG_SMP)			+= platsmp.o headsmp.o
-obj-$(CONFIG_HOTPLUG_CPU)               += hotplug.o
-obj-$(CONFIG_TEGRA_PCI)			+= pcie.o
-
 obj-y					+= tegra114_speedo.o
+obj-y					+= sleep.o
+obj-y					+= sleep-tegra20.o
 obj-y					+= sleep-tegra30.o
-obj-$(CONFIG_CPU_IDLE)			+= cpuidle-tegra114.o
-
-obj-y		+= board-harmony-pcie.o
-
-obj-y		+= board-paz00.o
-- 
1.8.1.5
