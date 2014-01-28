From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Wed, 29 Jan 2014 01:36:15 +0200
Subject: [PATCH v3 5/6] misc: enable fuse drivers
In-Reply-To: <1390952176-30402-1-git-send-email-pdeschrijver@nvidia.com>
References: <1390952176-30402-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <1390952176-30402-6-git-send-email-pdeschrijver@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable building the fuse drivers.

Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
---
 arch/arm/mach-tegra/Makefile |    4 ----
 drivers/misc/Makefile        |    1 +
 2 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
index 019bb17..92f8ab2 100644
--- a/arch/arm/mach-tegra/Makefile
+++ b/arch/arm/mach-tegra/Makefile
@@ -2,7 +2,6 @@ asflags-y				+= -march=armv7-a
 
 obj-y                                   += io.o
 obj-y                                   += irq.o
-obj-y					+= fuse.o
 obj-y					+= pmc.o
 obj-y					+= flowctrl.o
 obj-y					+= powergate.o
@@ -13,14 +12,12 @@ obj-y					+= reset-handler.o
 obj-y					+= sleep.o
 obj-y					+= tegra.o
 obj-$(CONFIG_CPU_IDLE)			+= cpuidle.o
-obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= tegra20_speedo.o
 obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= tegra2_emc.o
 obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= sleep-tegra20.o
 obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= pm-tegra20.o
 ifeq ($(CONFIG_CPU_IDLE),y)
 obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= cpuidle-tegra20.o
 endif
-obj-$(CONFIG_ARCH_TEGRA_3x_SOC)		+= tegra30_speedo.o
 obj-$(CONFIG_ARCH_TEGRA_3x_SOC)		+= sleep-tegra30.o
 obj-$(CONFIG_ARCH_TEGRA_3x_SOC)		+= pm-tegra30.o
 ifeq ($(CONFIG_CPU_IDLE),y)
@@ -29,7 +26,6 @@ endif
 obj-$(CONFIG_SMP)			+= platsmp.o headsmp.o
 obj-$(CONFIG_HOTPLUG_CPU)               += hotplug.o
 
-obj-$(CONFIG_ARCH_TEGRA_114_SOC)	+= tegra114_speedo.o
 obj-$(CONFIG_ARCH_TEGRA_114_SOC)	+= sleep-tegra30.o
 obj-$(CONFIG_ARCH_TEGRA_114_SOC)	+= pm-tegra30.o
 ifeq ($(CONFIG_CPU_IDLE),y)
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 99b9424..e243a8b 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -54,3 +54,4 @@ obj-$(CONFIG_LATTICE_ECP3_CONFIG)	+= lattice-ecp3-config.o
 obj-$(CONFIG_SRAM)		+= sram.o
 obj-y				+= mic/
 obj-$(CONFIG_GENWQE)		+= genwqe/
+obj-y				+= fuse/
-- 
1.7.7.rc0.72.g4b5ea.dirty
