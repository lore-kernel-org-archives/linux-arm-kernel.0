From: kbeldan@baylibre.com (Karl Beldan)
Date: Fri, 19 Aug 2016 16:48:02 +0000
Subject: [PATCH] ARM: davinci_all_defconfig: Enable some UBI modules
Message-ID: <20160819164803.10562-1-kbeldan@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables UBI+UBIFS to handle the NAND MTDs, including the useful
MTD_UBI_BLOCK.

Signed-off-by: Karl Beldan <kbeldan@baylibre.com>
---
 arch/arm/configs/davinci_all_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/davinci_all_defconfig
index cc94af9d..5e5dd6b 100644
--- a/arch/arm/configs/davinci_all_defconfig
+++ b/arch/arm/configs/davinci_all_defconfig
@@ -66,6 +66,8 @@ CONFIG_MTD_M25P80=m
 CONFIG_MTD_NAND=m
 CONFIG_MTD_NAND_DAVINCI=m
 CONFIG_MTD_SPI_NOR=m
+CONFIG_MTD_UBI=m
+CONFIG_MTD_UBI_BLOCK=y
 CONFIG_BLK_DEV_LOOP=m
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=1
@@ -188,6 +190,7 @@ CONFIG_MSDOS_FS=y
 CONFIG_VFAT_FS=y
 CONFIG_TMPFS=y
 CONFIG_JFFS2_FS=m
+CONFIG_UBIFS_FS=m
 CONFIG_CRAMFS=y
 CONFIG_MINIX_FS=m
 CONFIG_NFS_FS=y
-- 
2.9.2
