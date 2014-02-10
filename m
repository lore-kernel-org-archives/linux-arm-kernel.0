From: mohit.kumar@st.com (Mohit Kumar)
Date: Mon, 10 Feb 2014 14:21:54 +0530
Subject: [PATCH V5 3/8] SPEAr13xx: defconfig: Update
In-Reply-To: <cover.1391871170.git.pratyush.anand@st.com>
References: <cover.1391871170.git.pratyush.anand@st.com>
Message-ID: <b3c7a77237ec85ffb4c880e168df6687bb13ef08.1391871170.git.pratyush.anand@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable EABI, VFP and NFS configs in default configuration file for
SPEAr13xx.

Signed-off-by: Mohit Kumar <mohit.kumar@st.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Pratyush Anand <pratyush.anand@st.com>
Cc: spear-devel at list.st.com
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm/configs/spear13xx_defconfig | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/configs/spear13xx_defconfig b/arch/arm/configs/spear13xx_defconfig
index 82eaa55..1e0bb6f 100644
--- a/arch/arm/configs/spear13xx_defconfig
+++ b/arch/arm/configs/spear13xx_defconfig
@@ -14,10 +14,18 @@ CONFIG_MACH_SPEAR1340=y
 CONFIG_SMP=y
 # CONFIG_SMP_ON_UP is not set
 # CONFIG_ARM_CPU_TOPOLOGY is not set
+CONFIG_AEABI=y
 CONFIG_ARM_APPENDED_DTB=y
 CONFIG_ARM_ATAG_DTB_COMPAT=y
+CONFIG_VFP=y
 CONFIG_BINFMT_MISC=y
 CONFIG_NET=y
+CONFIG_UNIX=y
+CONFIG_INET=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+CONFIG_IP_PNP_BOOTP=y
+CONFIG_NET_IPIP=y
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_MTD=y
 CONFIG_MTD_OF_PARTS=y
@@ -27,6 +35,7 @@ CONFIG_MTD_NAND=y
 CONFIG_MTD_NAND_FSMC=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=16384
+CONFIG_BLK_DEV_SD=y
 CONFIG_ATA=y
 # CONFIG_SATA_PMP is not set
 CONFIG_SATA_AHCI_PLATFORM=y
@@ -66,6 +75,7 @@ CONFIG_USB=y
 # CONFIG_USB_DEVICE_CLASS is not set
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_OHCI_HCD=y
+CONFIG_USB_STORAGE=y
 CONFIG_MMC=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SPEAR=y
@@ -79,11 +89,14 @@ CONFIG_EXT2_FS_SECURITY=y
 CONFIG_EXT3_FS=y
 CONFIG_EXT3_FS_SECURITY=y
 CONFIG_AUTOFS4_FS=m
+CONFIG_FUSE_FS=y
 CONFIG_MSDOS_FS=m
 CONFIG_VFAT_FS=m
 CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
 CONFIG_TMPFS=y
 CONFIG_JFFS2_FS=y
+CONFIG_NFS_FS=y
+CONFIG_ROOT_NFS=y
 CONFIG_NLS_DEFAULT="utf8"
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ASCII=m
-- 
1.8.1.2
