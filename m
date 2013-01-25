From: josephl@nvidia.com (Joseph Lo)
Date: Fri, 25 Jan 2013 14:38:32 +0800
Subject: [PATCH] ARM: tegra: fix compile error when disable CPU_IDLE
Message-ID: <1359095912-32455-1-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The "sleep.S" file has many functions that be shared by different module
currently. Not just for CPU idle driver. Make it build as default now.

Reported-by: Rhyland Klein <rklein@nvidia.com>
Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
 arch/arm/mach-tegra/Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
index 432f2a5..200faf2 100644
--- a/arch/arm/mach-tegra/Makefile
+++ b/arch/arm/mach-tegra/Makefile
@@ -6,10 +6,9 @@ obj-y					+= pmc.o
 obj-y					+= flowctrl.o
 obj-y					+= powergate.o
 obj-y					+= apbio.o
-obj-y					+= pm.o
+obj-y					+= pm.o sleep.o
 obj-y					+= reset.o reset-handler.o
 obj-$(CONFIG_CPU_IDLE)			+= cpuidle.o
-obj-$(CONFIG_CPU_IDLE)			+= sleep.o
 obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= tegra20_speedo.o
 obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= tegra2_emc.o
 obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= sleep-tegra20.o
-- 
1.8.0.3
