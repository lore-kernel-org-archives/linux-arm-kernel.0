From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Thu,  3 Apr 2014 12:30:13 -0300
Subject: [PATCH 1/2] ARM: mvebu: Enable nfsroot in the defconfig
Message-ID: <1396539014-8673-1-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

NFSroot is very frequently used by developers to boot, so let's make
our lives simpler and enable it by default.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/configs/mvebu_v7_defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/configs/mvebu_v7_defconfig b/arch/arm/configs/mvebu_v7_defconfig
index a34713d..bfcc362 100644
--- a/arch/arm/configs/mvebu_v7_defconfig
+++ b/arch/arm/configs/mvebu_v7_defconfig
@@ -29,6 +29,9 @@ CONFIG_ARM_ATAG_DTB_COMPAT=y
 CONFIG_VFP=y
 CONFIG_NET=y
 CONFIG_INET=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+CONFIG_IP_PNP_BOOTP=y
 CONFIG_BT=y
 CONFIG_BT_MRVL=y
 CONFIG_BT_MRVL_SDIO=y
@@ -103,6 +106,8 @@ CONFIG_UDF_FS=m
 CONFIG_MSDOS_FS=y
 CONFIG_VFAT_FS=y
 CONFIG_TMPFS=y
+CONFIG_NFS_FS=y
+CONFIG_ROOT_NFS=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_CODEPAGE_850=y
 CONFIG_NLS_ISO8859_1=y
-- 
1.9.1
