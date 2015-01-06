From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue,  6 Jan 2015 14:20:07 +0100
Subject: [PATCH] ARM: tegra: Regenerate defconfig based on v3.19-rc1
Message-ID: <1420550407-4059-1-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

Removes the following entries from the default configuration:

- PM: enabled by default (via PM_SLEEP -> SUSPEND)
- RESOURCE_COUNTERS: removed

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
I intend to apply this to the for-3.20/defconfig branch if nobody
objects.

 arch/arm/configs/tegra_defconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index 3ea9c3377ccb..d199eb249151 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -8,7 +8,6 @@ CONFIG_CGROUPS=y
 CONFIG_CGROUP_DEBUG=y
 CONFIG_CGROUP_FREEZER=y
 CONFIG_CGROUP_CPUACCT=y
-CONFIG_RESOURCE_COUNTERS=y
 CONFIG_CGROUP_SCHED=y
 CONFIG_RT_GROUP_SCHED=y
 CONFIG_BLK_DEV_INITRD=y
@@ -46,7 +45,6 @@ CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
 CONFIG_CPU_IDLE=y
 CONFIG_VFP=y
 CONFIG_NEON=y
-CONFIG_PM=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
-- 
2.1.3
