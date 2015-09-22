From: nm@ti.com (Nishanth Menon)
Date: Tue, 22 Sep 2015 10:42:26 -0500
Subject: [PATCH 2/2] ARM: configs: keystone: Add basic systemd related options
In-Reply-To: <1442936546-8295-1-git-send-email-nm@ti.com>
References: <1442936546-8295-1-git-send-email-nm@ti.com>
Message-ID: <1442936546-8295-3-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add basic options to bootup on systemd based distros such as debian.
See http://cgit.freedesktop.org/systemd/systemd/tree/README#n38 for
more information.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/configs/keystone_defconfig | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/configs/keystone_defconfig b/arch/arm/configs/keystone_defconfig
index a7ec63ee058d..5bcc9cf9d8f1 100644
--- a/arch/arm/configs/keystone_defconfig
+++ b/arch/arm/configs/keystone_defconfig
@@ -4,6 +4,12 @@ CONFIG_HIGH_RES_TIMERS=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
+CONFIG_CGROUPS=y
+CONFIG_CGROUP_FREEZER=y
+CONFIG_CGROUP_DEVICE=y
+CONFIG_CGROUP_CPUACCT=y
+CONFIG_CGROUP_SCHED=y
+CONFIG_BLK_CGROUP=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_SYSCTL_SYSCALL=y
 CONFIG_KALLSYMS_ALL=y
@@ -106,6 +112,7 @@ CONFIG_IP_SCTP=y
 CONFIG_VLAN_8021Q=y
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_DMA_CMA=y
 CONFIG_MTD=y
 CONFIG_MTD_CMDLINE_PARTS=y
@@ -170,6 +177,8 @@ CONFIG_TI_AEMIF=y
 CONFIG_KEYSTONE_IRQ=y
 CONFIG_EXT4_FS=y
 CONFIG_EXT4_FS_POSIX_ACL=y
+CONFIG_FANOTIFY=y
+CONFIG_AUTOFS4_FS=y
 CONFIG_MSDOS_FS=y
 CONFIG_VFAT_FS=y
 CONFIG_NTFS_FS=y
-- 
2.1.4
