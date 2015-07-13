From: 21cnbao@gmail.com (Barry Song)
Date: Mon, 13 Jul 2015 14:41:56 +0000
Subject: [PATCH 1/5] ARM: prima2_defconfig: fix the outdated defconfig
Message-ID: <1436798516-4206-1-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

this patch is againest v4.2-rc1, by doing:

 $ make ARCH=arm prima2_defconfig
 $ make ARCH=arm savedefconfig
 $ cp defconfig arch/arm/configs/prima2_defconfig

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/configs/prima2_defconfig | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/arm/configs/prima2_defconfig b/arch/arm/configs/prima2_defconfig
index f610230..ded0cad 100644
--- a/arch/arm/configs/prima2_defconfig
+++ b/arch/arm/configs/prima2_defconfig
@@ -1,4 +1,3 @@
-CONFIG_EXPERIMENTAL=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_RELAY=y
@@ -11,14 +10,12 @@ CONFIG_PARTITION_ADVANCED=y
 CONFIG_BSD_DISKLABEL=y
 CONFIG_SOLARIS_X86_PARTITION=y
 CONFIG_ARCH_SIRF=y
-# CONFIG_SWP_EMULATE is not set
 CONFIG_SMP=y
 CONFIG_SCHED_MC=y
 CONFIG_PREEMPT=y
 CONFIG_AEABI=y
 CONFIG_KEXEC=y
 CONFIG_BINFMT_MISC=y
-CONFIG_PM=y
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
@@ -60,12 +57,12 @@ CONFIG_ROMFS_FS=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ASCII=y
 CONFIG_NLS_ISO8859_1=y
-CONFIG_MAGIC_SYSRQ=y
+CONFIG_DEBUG_INFO=y
 CONFIG_DEBUG_SECTION_MISMATCH=y
+CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
 # CONFIG_DEBUG_PREEMPT is not set
 CONFIG_DEBUG_RT_MUTEXES=y
 CONFIG_DEBUG_SPINLOCK=y
 CONFIG_DEBUG_MUTEXES=y
-CONFIG_DEBUG_INFO=y
 CONFIG_CRC_CCITT=y
-- 
2.3.5
