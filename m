From: marex@denx.de (Marek Vasut)
Date: Wed, 19 Dec 2012 18:33:01 +0100
Subject: [PATCH 3/8] arm: mxs: Enable UBI and UBIFS
In-Reply-To: <1355938386-14582-1-git-send-email-marex@denx.de>
References: <1355938386-14582-1-git-send-email-marex@denx.de>
Message-ID: <1355938386-14582-4-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The UBIFS is commonly used filesystem, enable it.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/configs/mxs_defconfig |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/configs/mxs_defconfig b/arch/arm/configs/mxs_defconfig
index 8b4b6c9..69efd38 100644
--- a/arch/arm/configs/mxs_defconfig
+++ b/arch/arm/configs/mxs_defconfig
@@ -56,6 +56,7 @@ CONFIG_MTD_BLOCK=y
 CONFIG_MTD_DATAFLASH=y
 CONFIG_MTD_NAND=y
 CONFIG_MTD_NAND_GPMI_NAND=y
+CONFIG_MTD_UBI=y
 # CONFIG_BLK_DEV is not set
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
@@ -138,7 +139,8 @@ CONFIG_FSCACHE_STATS=y
 CONFIG_CACHEFILES=m
 CONFIG_TMPFS=y
 CONFIG_TMPFS_POSIX_ACL=y
-# CONFIG_MISC_FILESYSTEMS is not set
+CONFIG_UBIFS_FS=y
+CONFIG_UBIFS_FS_ADVANCED_COMPR=y
 CONFIG_NFS_FS=y
 CONFIG_NFS_V3_ACL=y
 CONFIG_NFS_V4=y
-- 
1.7.10.4
