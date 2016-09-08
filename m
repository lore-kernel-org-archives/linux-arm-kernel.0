From: robh@kernel.org (Rob Herring)
Date: Thu,  8 Sep 2016 13:59:32 -0500
Subject: [PATCH 1/3] config: android: move device mapper options to recommended
Message-ID: <20160908185934.18098-1-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_MD is in recommended, but other dependent options like DM_CRYPT
and DM_VERITY options are in base. The result is the options in base don't
get enabled when applying both base and recommended fragments. Move all
the options to recommended.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 kernel/configs/android-base.config        | 4 ----
 kernel/configs/android-recommended.config | 4 ++++
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/configs/android-base.config b/kernel/configs/android-base.config
index 9f748ed..19eb7ac 100644
--- a/kernel/configs/android-base.config
+++ b/kernel/configs/android-base.config
@@ -11,7 +11,6 @@ CONFIG_ANDROID_LOW_MEMORY_KILLER=y
 CONFIG_ARMV8_DEPRECATED=y
 CONFIG_ASHMEM=y
 CONFIG_AUDIT=y
-CONFIG_BLK_DEV_DM=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_CGROUPS=y
 CONFIG_CGROUP_CPUACCT=y
@@ -19,9 +18,6 @@ CONFIG_CGROUP_DEBUG=y
 CONFIG_CGROUP_FREEZER=y
 CONFIG_CGROUP_SCHED=y
 CONFIG_CP15_BARRIER_EMULATION=y
-CONFIG_DM_CRYPT=y
-CONFIG_DM_VERITY=y
-CONFIG_DM_VERITY_FEC=y
 CONFIG_EMBEDDED=y
 CONFIG_FB=y
 CONFIG_HIGH_RES_TIMERS=y
diff --git a/kernel/configs/android-recommended.config b/kernel/configs/android-recommended.config
index e3b953e..297756b 100644
--- a/kernel/configs/android-recommended.config
+++ b/kernel/configs/android-recommended.config
@@ -6,12 +6,16 @@
 # CONFIG_PM_WAKELOCKS_GC is not set
 # CONFIG_VT is not set
 CONFIG_BACKLIGHT_LCD_SUPPORT=y
+CONFIG_BLK_DEV_DM=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=8192
 CONFIG_COMPACTION=y
 CONFIG_DEBUG_RODATA=y
+CONFIG_DM_CRYPT=y
 CONFIG_DM_UEVENT=y
+CONFIG_DM_VERITY=y
+CONFIG_DM_VERITY_FEC=y
 CONFIG_DRAGONRISE_FF=y
 CONFIG_ENABLE_DEFAULT_TRACERS=y
 CONFIG_EXT4_FS=y
-- 
2.9.3
