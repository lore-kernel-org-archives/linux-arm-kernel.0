From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed,  4 Dec 2013 15:27:52 -0700
Subject: [PATCH 1/2] ARM: tegra: rebuild tegra_defconfig
Message-ID: <1386196073-25193-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

This separates out "NULL" changes from future real changes.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/configs/tegra_defconfig | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index 4934295bb4f0..4a293393f415 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -36,8 +36,8 @@ CONFIG_PCIEPORTBUS=y
 CONFIG_SMP=y
 CONFIG_PREEMPT=y
 CONFIG_AEABI=y
-# CONFIG_OABI_COMPAT is not set
 CONFIG_HIGHMEM=y
+CONFIG_CMA=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_KEXEC=y
@@ -63,7 +63,6 @@ CONFIG_INET_ESP=y
 # CONFIG_INET_LRO is not set
 # CONFIG_INET_DIAG is not set
 CONFIG_IPV6=y
-CONFIG_IPV6_PRIVACY=y
 CONFIG_IPV6_ROUTER_PREF=y
 CONFIG_IPV6_OPTIMISTIC_DAD=y
 CONFIG_INET6_AH=y
@@ -85,7 +84,6 @@ CONFIG_RFKILL_GPIO=y
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 # CONFIG_FIRMWARE_IN_KERNEL is not set
-CONFIG_CMA=y
 CONFIG_DMA_CMA=y
 CONFIG_MTD=y
 CONFIG_MTD_M25P80=y
@@ -164,7 +162,6 @@ CONFIG_MEDIA_CAMERA_SUPPORT=y
 CONFIG_MEDIA_USB_SUPPORT=y
 CONFIG_USB_VIDEO_CLASS=m
 CONFIG_DRM=y
-CONFIG_TEGRA_HOST1X=y
 CONFIG_DRM_TEGRA=y
 CONFIG_BACKLIGHT_LCD_SUPPORT=y
 # CONFIG_LCD_CLASS_DEVICE is not set
@@ -256,16 +253,15 @@ CONFIG_ROOT_NFS=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_PRINTK_TIME=y
+CONFIG_DEBUG_INFO=y
 CONFIG_MAGIC_SYSRQ=y
-CONFIG_DEBUG_FS=y
+CONFIG_DEBUG_SLAB=y
+CONFIG_DEBUG_VM=y
 CONFIG_DETECT_HUNG_TASK=y
 CONFIG_SCHEDSTATS=y
 CONFIG_TIMER_STATS=y
-CONFIG_DEBUG_SLAB=y
 # CONFIG_DEBUG_PREEMPT is not set
 CONFIG_DEBUG_MUTEXES=y
-CONFIG_DEBUG_INFO=y
-CONFIG_DEBUG_VM=y
 CONFIG_DEBUG_SG=y
 CONFIG_DEBUG_LL=y
 CONFIG_EARLY_PRINTK=y
-- 
1.8.1.5
