From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Wed, 26 Mar 2014 14:30:53 +0100
Subject: [PATCH] ARM: u300: u300_defconfig: Enable PARTITION_ADVANCED
Message-ID: <1395840653-11518-1-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since there are SD-card support in u300, it's reasonable to
support partitions for block devices as default.

While updating the defconfig, we rebase it towards Kconfig changes.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 arch/arm/configs/u300_defconfig |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/u300_defconfig b/arch/arm/configs/u300_defconfig
index fd81a1b..aaa95ab 100644
--- a/arch/arm/configs/u300_defconfig
+++ b/arch/arm/configs/u300_defconfig
@@ -11,6 +11,7 @@ CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_LBDAF is not set
 # CONFIG_BLK_DEV_BSG is not set
+CONFIG_PARTITION_ADVANCED=y
 # CONFIG_IOSCHED_CFQ is not set
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_U300=y
@@ -21,7 +22,6 @@ CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_CMDLINE="root=/dev/ram0 rw rootfstype=rootfs console=ttyAMA0,115200n8 lpj=515072"
 CONFIG_CPU_IDLE=y
-CONFIG_FPE_NWFPE=y
 # CONFIG_SUSPEND is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 # CONFIG_PREVENT_FIRMWARE_BUILD is not set
@@ -64,8 +64,8 @@ CONFIG_TMPFS=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_PRINTK_TIME=y
+CONFIG_DEBUG_INFO=y
 CONFIG_DEBUG_FS=y
 # CONFIG_SCHED_DEBUG is not set
 CONFIG_TIMER_STATS=y
 # CONFIG_DEBUG_PREEMPT is not set
-CONFIG_DEBUG_INFO=y
-- 
1.7.9.5
