From: vincent.stehle@freescale.com (=?UTF-8?q?Vincent=20Stehl=C3=A9?=)
Date: Wed, 3 Jul 2013 10:12:59 +0200
Subject: [PATCH linux-next 2/2] arm: multi_v7_defconfig: add support for NFS
 root
In-Reply-To: <1372839179-14542-1-git-send-email-vincent.stehle@freescale.com>
References: <1372839179-14542-1-git-send-email-vincent.stehle@freescale.com>
Message-ID: <1372839179-14542-3-git-send-email-vincent.stehle@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the necessary config options, to allow booting with NFS root on an i.MX6
sabre sd.

Signed-off-by: Vincent Stehl? <vincent.stehle@freescale.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Olof Johansson <olof@lixom.net>
---
 arch/arm/configs/multi_v7_defconfig |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index cc8723a..81eac83 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -47,6 +47,8 @@ CONFIG_ARM_APPENDED_DTB=y
 CONFIG_NET=y
 CONFIG_UNIX=y
 CONFIG_INET=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_BLK_DEV_SD=y
@@ -149,6 +151,10 @@ CONFIG_PWM=y
 CONFIG_PWM_VT8500=y
 CONFIG_EXT4_FS=y
 CONFIG_TMPFS=y
+CONFIG_NFS_FS=y
+CONFIG_NFS_V3_ACL=y
+CONFIG_NFS_V4=y
+CONFIG_ROOT_NFS=y
 CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_FS=y
 CONFIG_DEBUG_KERNEL=y
-- 
1.7.10.4
