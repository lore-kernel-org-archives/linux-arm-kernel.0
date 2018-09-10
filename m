From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 10 Sep 2018 14:45:23 -0300
Subject: [PATCH] ARM: imx_v6_v7_defconfig: Select CONFIG_TMPFS_POSIX_ACL
Message-ID: <1536601523-11797-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Andreas M?ller reports:

"Fixes:

| Sep 04 09:05:10 imx6qdl-variscite-som systemd-udevd[220]: Failed to apply ACL on /dev/v4l-subdev0: Operation not supported
| Sep 04 09:05:10 imx6qdl-variscite-som systemd-udevd[224]: Failed to apply ACL on /dev/v4l-subdev1: Operation not supported
| Sep 04 09:05:10 imx6qdl-variscite-som systemd-udevd[215]: Failed to apply ACL on /dev/v4l-subdev10: Operation not supported
| Sep 04 09:05:10 imx6qdl-variscite-som systemd-udevd[228]: Failed to apply ACL on /dev/v4l-subdev2: Operation not supported
| Sep 04 09:05:10 imx6qdl-variscite-som systemd-udevd[232]: Failed to apply ACL on /dev/v4l-subdev5: Operation not supported
| Sep 04 09:05:10 imx6qdl-variscite-som systemd-udevd[217]: Failed to apply ACL on /dev/v4l-subdev11: Operation not supported
| Sep 04 09:05:10 imx6qdl-variscite-som systemd-udevd[214]: Failed to apply ACL on /dev/dri/card1: Operation not supported
| Sep 04 09:05:10 imx6qdl-variscite-som systemd-udevd[216]: Failed to apply ACL on /dev/v4l-subdev8: Operation not supported
| Sep 04 09:05:10 imx6qdl-variscite-som systemd-udevd[226]: Failed to apply ACL on /dev/v4l-subdev9: Operation not supported

and nasty follow-ups: Starting weston from sddm as unpriviledged user fails
with some hints on missing access rights."

Select the CONFIG_TMPFS_POSIX_ACL option to fix these issues.

Reported-by: Andreas M?ller <schnitzeltony@gmail.com>
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index e0c6b7c..1ad5736 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -414,6 +414,7 @@ CONFIG_ZISOFS=y
 CONFIG_UDF_FS=m
 CONFIG_MSDOS_FS=m
 CONFIG_VFAT_FS=y
+CONFIG_TMPFS_POSIX_ACL=y
 CONFIG_JFFS2_FS=y
 CONFIG_UBIFS_FS=y
 CONFIG_NFS_FS=y
-- 
2.7.4
