From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Wed, 21 Nov 2012 14:26:51 +0100
Subject: [PATCH 1/1] ARM: OMAP2+: enable devtmpfs and devtmpfs automount
Message-ID: <1353504411-19811-1-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since udev-182, udev no longer creates device nodes under /dev
and this has to be managed by the kernel devtmpfs filesystem.

This means that a kernel built with the current OMAP2+ config
will not boot on a system with a recent udev.

Also, it is good to have /dev automatically mounted since some
non-initramfs based setups assumes this and don't manually mount it.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 arch/arm/configs/omap2plus_defconfig |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 6230304..6333e96 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -65,6 +65,8 @@ CONFIG_MAC80211_RC_PID=y
 CONFIG_MAC80211_RC_DEFAULT_PID=y
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_CONNECTOR=y
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_MTD=y
 CONFIG_MTD_CMDLINE_PARTS=y
 CONFIG_MTD_CHAR=y
-- 
1.7.7.6
