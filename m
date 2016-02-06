From: swarren@wwwdotorg.org (Stephen Warren)
Date: Sat,  6 Feb 2016 11:03:44 -0700
Subject: [PATCH 1/3] ARM: bcm2835_defconfig: rebuild on next-20160205
Message-ID: <1454781826-10571-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This separates explicit changes desired in later patches from "automatic"
or irrelevant changes caused solely by Kconfig changes.

make ARCH=arm bcm2835_defconfig
make ARCH=arm savedefconfig
mv defconfig arch/arm/configs/bcm2835_defconfig

Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>
---
This series is based on top of next-20160205.

You may want to squash all 3 commits together when applying to reduce
the number of defconfig patches; that's fine by me.

 arch/arm/configs/bcm2835_defconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/configs/bcm2835_defconfig b/arch/arm/configs/bcm2835_defconfig
index 72def201c4fd..e95dcb16d65d 100644
--- a/arch/arm/configs/bcm2835_defconfig
+++ b/arch/arm/configs/bcm2835_defconfig
@@ -6,13 +6,13 @@ CONFIG_HIGH_RES_TIMERS=y
 CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_BSD_PROCESS_ACCT_V3=y
 CONFIG_LOG_BUF_SHIFT=18
+CONFIG_CFS_BANDWIDTH=y
+CONFIG_RT_GROUP_SCHED=y
 CONFIG_CGROUP_FREEZER=y
-CONFIG_CGROUP_DEVICE=y
 CONFIG_CPUSETS=y
+CONFIG_CGROUP_DEVICE=y
 CONFIG_CGROUP_CPUACCT=y
 CONFIG_CGROUP_PERF=y
-CONFIG_CFS_BANDWIDTH=y
-CONFIG_RT_GROUP_SCHED=y
 CONFIG_NAMESPACES=y
 CONFIG_SCHED_AUTOGROUP=y
 CONFIG_RELAY=y
-- 
1.9.1
