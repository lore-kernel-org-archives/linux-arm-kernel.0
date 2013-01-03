From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed,  2 Jan 2013 22:55:21 -0700
Subject: [PATCH 6/6] ARM: bcm2835: defconfig updates
In-Reply-To: <1357192521-13025-1-git-send-email-swarren@wwwdotorg.org>
References: <1357192521-13025-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1357192521-13025-6-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have an SDHCI driver, enable the block layer, and common
filesystems; MSDOS/VFAT for the SoC-required firmware partition, ext2/3/4
for a root partition.

Add tmpfs, NFS, file locking, file notify, networking, and NLS to support
distro expectations.

Enable GPIO_SYSFS to allow GPIO twiddling from user-space; likely a
common activity on this hardware.

Enable I2C.

Remove bogus CONFIG_DEFAULT_MMAP_MIN_ADDR so that applications running as
non-root actually work; without this, execve() immediately triggers
SIGKILL. This setting was sourced from some downstream defconfig early
during upstream Raspberry Pi support development.

Other non-semantic diffs due to rebuilding defconfig using the latest
Kconfig defaults etc.

Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>
---
 arch/arm/configs/bcm2835_defconfig |   43 +++++++++++++++++++++++++++---------
 1 file changed, 33 insertions(+), 10 deletions(-)

diff --git a/arch/arm/configs/bcm2835_defconfig b/arch/arm/configs/bcm2835_defconfig
index 74e27f0..af472e4 100644
--- a/arch/arm/configs/bcm2835_defconfig
+++ b/arch/arm/configs/bcm2835_defconfig
@@ -1,11 +1,10 @@
-CONFIG_EXPERIMENTAL=y
 # CONFIG_LOCALVERSION_AUTO is not set
 CONFIG_SYSVIPC=y
-CONFIG_BSD_PROCESS_ACCT=y
-CONFIG_BSD_PROCESS_ACCT_V3=y
 CONFIG_FHANDLE=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
+CONFIG_BSD_PROCESS_ACCT=y
+CONFIG_BSD_PROCESS_ACCT_V3=y
 CONFIG_LOG_BUF_SHIFT=18
 CONFIG_CGROUP_FREEZER=y
 CONFIG_CGROUP_DEVICE=y
@@ -30,13 +29,10 @@ CONFIG_EMBEDDED=y
 CONFIG_PROFILING=y
 CONFIG_OPROFILE=y
 CONFIG_JUMP_LABEL=y
-# CONFIG_BLOCK is not set
 CONFIG_ARCH_BCM2835=y
 CONFIG_PREEMPT_VOLUNTARY=y
 CONFIG_AEABI=y
-CONFIG_COMPACTION=y
 CONFIG_KSM=y
-CONFIG_DEFAULT_MMAP_MIN_ADDR=65536
 CONFIG_CLEANCACHE=y
 CONFIG_SECCOMP=y
 CONFIG_CC_STACKPROTECTOR=y
@@ -45,6 +41,11 @@ CONFIG_CRASH_DUMP=y
 CONFIG_VFP=y
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
 # CONFIG_SUSPEND is not set
+CONFIG_NET=y
+CONFIG_UNIX=y
+CONFIG_INET=y
+CONFIG_NETWORK_SECMARK=y
+# CONFIG_WIRELESS is not set
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 # CONFIG_STANDALONE is not set
@@ -53,20 +54,42 @@ CONFIG_DEVTMPFS_MOUNT=y
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO is not set
 # CONFIG_VT is not set
-# CONFIG_UNIX98_PTYS is not set
 # CONFIG_LEGACY_PTYS is not set
 # CONFIG_DEVKMEM is not set
 CONFIG_SERIAL_AMBA_PL011=y
 CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
 CONFIG_TTY_PRINTK=y
 # CONFIG_HW_RANDOM is not set
+CONFIG_I2C=y
+CONFIG_I2C_CHARDEV=y
+CONFIG_I2C_BCM2835=y
+CONFIG_GPIO_SYSFS=y
 # CONFIG_HWMON is not set
 # CONFIG_USB_SUPPORT is not set
+CONFIG_MMC=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_PLTFM=y
+CONFIG_MMC_SDHCI_BCM2835=y
 # CONFIG_IOMMU_SUPPORT is not set
-# CONFIG_FILE_LOCKING is not set
-# CONFIG_DNOTIFY is not set
-# CONFIG_INOTIFY_USER is not set
+CONFIG_EXT2_FS=y
+CONFIG_EXT2_FS_XATTR=y
+CONFIG_EXT2_FS_POSIX_ACL=y
+CONFIG_EXT3_FS=y
+CONFIG_EXT3_FS_POSIX_ACL=y
+CONFIG_EXT4_FS=y
+CONFIG_EXT4_FS_POSIX_ACL=y
+CONFIG_FANOTIFY=y
+CONFIG_MSDOS_FS=y
+CONFIG_VFAT_FS=y
+CONFIG_TMPFS=y
+CONFIG_TMPFS_POSIX_ACL=y
 # CONFIG_MISC_FILESYSTEMS is not set
+CONFIG_NFS_FS=y
+CONFIG_NFSD=y
+CONFIG_NLS_CODEPAGE_437=y
+CONFIG_NLS_ASCII=y
+CONFIG_NLS_ISO8859_1=y
+CONFIG_NLS_UTF8=y
 CONFIG_PRINTK_TIME=y
 # CONFIG_ENABLE_WARN_DEPRECATED is not set
 # CONFIG_ENABLE_MUST_CHECK is not set
-- 
1.7.10.4
