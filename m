From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 16 Jan 2013 23:32:04 -0200
Subject: [PATCH] ARM: mxs_defconfig: Select CONFIG_DEVTMPFS_MOUNT
Message-ID: <1358386324-23995-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Newer versions of udev (such as 182) requires CONFIG_DEVTMPFS_MOUNT to be 
selected, otherwise we get a stuck console:

Starting udev
Starting Bootlog daemon: bootlogd: cannot deduce real console device

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/configs/mxs_defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/mxs_defconfig b/arch/arm/configs/mxs_defconfig
index dfd5c82..fbbc5bb 100644
--- a/arch/arm/configs/mxs_defconfig
+++ b/arch/arm/configs/mxs_defconfig
@@ -48,6 +48,7 @@ CONFIG_CAN_BCM=m
 CONFIG_CAN_FLEXCAN=m
 # CONFIG_WIRELESS is not set
 CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
 # CONFIG_FIRMWARE_IN_KERNEL is not set
 CONFIG_MTD=y
 CONFIG_MTD_CMDLINE_PARTS=y
-- 
1.7.9.5
