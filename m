From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 30 Nov 2015 15:31:23 +0900
Subject: [PATCH] ARM: exynos_defconfig: Set recommended options for systemd
Message-ID: <1448865083-13272-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Set following options to recommended value by systemd (which also
matches the multi_v7 deconfig):
1. Enable AUTOFS4_FS - for systemd.automount [0];
2. Enable BLK_DEV_BSG - SG v4 for recend udev [0][1];
3. Disable UEVENT_HELPER_PATH - legacy hook for hotplug, forked for each
   uevent, slows down booting [0];

[0] http://cgit.freedesktop.org/systemd/systemd/tree/README
[1] http://patchwork.ozlabs.org/patch/47921/

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/configs/exynos_defconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index 409adc1eaf33..24dcd2bb1215 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -7,7 +7,6 @@ CONFIG_BLK_DEV_INITRD=y
 CONFIG_KALLSYMS_ALL=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
-# CONFIG_BLK_DEV_BSG is not set
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_ARCH_EXYNOS=y
 CONFIG_ARCH_EXYNOS3=y
@@ -44,7 +43,6 @@ CONFIG_IP_PNP_BOOTP=y
 CONFIG_IP_PNP_RARP=y
 CONFIG_CFG80211=y
 CONFIG_RFKILL_REGULATOR=y
-CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_DMA_CMA=y
@@ -217,6 +215,7 @@ CONFIG_PHY_EXYNOS5250_SATA=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
 CONFIG_EXT4_FS=y
+CONFIG_AUTOFS4_FS=y
 CONFIG_MSDOS_FS=y
 CONFIG_VFAT_FS=y
 CONFIG_TMPFS=y
-- 
1.9.1
