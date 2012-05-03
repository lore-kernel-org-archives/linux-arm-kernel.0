From: viresh.kumar@st.com (Viresh Kumar)
Date: Thu, 3 May 2012 16:07:10 +0530
Subject: [PATCH 2/2] SPEAr: Update defconfigs
In-Reply-To: <bd96eb0df2e50de1293a8df60d30ceea920fe2b0.1336041348.git.viresh.kumar@st.com>
References: <bd96eb0df2e50de1293a8df60d30ceea920fe2b0.1336041348.git.viresh.kumar@st.com>
Message-ID: <b4431690340af8d9892b2caa76b4921cdff5f1aa.1336041348.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates following configuration:
- Update MTD specific configurations
- Enables JFFS2 FS support
- Updates 6xx defconfig, with recent changes done by Arnd in 6xx Kconfig

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/configs/spear13xx_defconfig |    4 ++++
 arch/arm/configs/spear3xx_defconfig  |    4 ++++
 arch/arm/configs/spear6xx_defconfig  |    5 ++++-
 3 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/arch/arm/configs/spear13xx_defconfig b/arch/arm/configs/spear13xx_defconfig
index 587d1f3..1fdb826 100644
--- a/arch/arm/configs/spear13xx_defconfig
+++ b/arch/arm/configs/spear13xx_defconfig
@@ -20,6 +20,9 @@ CONFIG_BINFMT_MISC=y
 CONFIG_NET=y
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_MTD=y
+CONFIG_MTD_OF_PARTS=y
+CONFIG_MTD_CHAR=y
+CONFIG_MTD_BLOCK=y
 CONFIG_MTD_NAND=y
 CONFIG_MTD_NAND_FSMC=y
 CONFIG_BLK_DEV_RAM=y
@@ -81,6 +84,7 @@ CONFIG_MSDOS_FS=m
 CONFIG_VFAT_FS=m
 CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
 CONFIG_TMPFS=y
+CONFIG_JFFS2_FS=y
 CONFIG_NLS_DEFAULT="utf8"
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ASCII=m
diff --git a/arch/arm/configs/spear3xx_defconfig b/arch/arm/configs/spear3xx_defconfig
index 7ed4291..865980c 100644
--- a/arch/arm/configs/spear3xx_defconfig
+++ b/arch/arm/configs/spear3xx_defconfig
@@ -14,6 +14,9 @@ CONFIG_BINFMT_MISC=y
 CONFIG_NET=y
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_MTD=y
+CONFIG_MTD_OF_PARTS=y
+CONFIG_MTD_CHAR=y
+CONFIG_MTD_BLOCK=y
 CONFIG_MTD_NAND=y
 CONFIG_MTD_NAND_FSMC=y
 CONFIG_BLK_DEV_RAM=y
@@ -73,6 +76,7 @@ CONFIG_MSDOS_FS=m
 CONFIG_VFAT_FS=m
 CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
 CONFIG_TMPFS=y
+CONFIG_JFFS2_FS=y
 CONFIG_NLS_DEFAULT="utf8"
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ASCII=m
diff --git a/arch/arm/configs/spear6xx_defconfig b/arch/arm/configs/spear6xx_defconfig
index cf94bc7..a2a1265 100644
--- a/arch/arm/configs/spear6xx_defconfig
+++ b/arch/arm/configs/spear6xx_defconfig
@@ -8,11 +8,13 @@ CONFIG_MODVERSIONS=y
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_PLAT_SPEAR=y
 CONFIG_ARCH_SPEAR6XX=y
-CONFIG_BOARD_SPEAR600_DT=y
 CONFIG_BINFMT_MISC=y
 CONFIG_NET=y
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_MTD=y
+CONFIG_MTD_OF_PARTS=y
+CONFIG_MTD_CHAR=y
+CONFIG_MTD_BLOCK=y
 CONFIG_MTD_NAND=y
 CONFIG_MTD_NAND_FSMC=y
 CONFIG_BLK_DEV_RAM=y
@@ -64,6 +66,7 @@ CONFIG_MSDOS_FS=m
 CONFIG_VFAT_FS=m
 CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
 CONFIG_TMPFS=y
+CONFIG_JFFS2_FS=y
 CONFIG_NLS_DEFAULT="utf8"
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ASCII=m
-- 
1.7.9
