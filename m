From: horms@verge.net.au (Simon Horman)
Date: Fri, 31 Aug 2012 10:28:14 +0900
Subject: [PATCH 03/11] ARM: mach-shmobile: marzen: defconfig update
In-Reply-To: <1346376502-12114-1-git-send-email-horms@verge.net.au>
References: <1346376502-12114-1-git-send-email-horms@verge.net.au>
Message-ID: <1346376502-12114-4-git-send-email-horms@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update marzen defconfig
* Enable MMC Block device as SDHI hw is now supported.
* Default to NFS root, this is consistent with many other
  shmobile boards
* Enable UNIX which is required by udevd

Other changes are noise due to using make savedefconfig
to create the new defconfig.

Cc: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms@verge.net.au>
---
 arch/arm/configs/marzen_defconfig | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/arm/configs/marzen_defconfig b/arch/arm/configs/marzen_defconfig
index bf42ad2..cd2dc21 100644
--- a/arch/arm/configs/marzen_defconfig
+++ b/arch/arm/configs/marzen_defconfig
@@ -1,13 +1,14 @@
 # CONFIG_ARM_PATCH_PHYS_VIRT is not set
 CONFIG_EXPERIMENTAL=y
 CONFIG_KERNEL_LZMA=y
+CONFIG_NO_HZ=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=16
 CONFIG_SYSCTL_SYSCALL=y
 CONFIG_EMBEDDED=y
 CONFIG_SLAB=y
-# CONFIG_BLOCK is not set
+# CONFIG_IOSCHED_CFQ is not set
 CONFIG_ARCH_SHMOBILE=y
 CONFIG_ARCH_R8A7779=y
 CONFIG_MACH_MARZEN=y
@@ -21,7 +22,6 @@ CONFIG_ARM_ERRATA_458693=y
 CONFIG_ARM_ERRATA_460075=y
 CONFIG_ARM_ERRATA_743622=y
 CONFIG_ARM_ERRATA_754322=y
-CONFIG_NO_HZ=y
 CONFIG_SMP=y
 # CONFIG_ARM_CPU_TOPOLOGY is not set
 CONFIG_AEABI=y
@@ -29,13 +29,16 @@ CONFIG_AEABI=y
 CONFIG_HIGHMEM=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
-CONFIG_CMDLINE="console=ttySC2,115200 earlyprintk=sh-sci.2,115200 ignore_loglevel"
+CONFIG_CMDLINE="console=ttySC2,115200 earlyprintk=sh-sci.2,115200 ignore_loglevel root=/dev/nfs ip=on"
 CONFIG_CMDLINE_FORCE=y
 CONFIG_KEXEC=y
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
 CONFIG_PM_RUNTIME=y
 CONFIG_NET=y
+CONFIG_UNIX=y
 CONFIG_INET=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
 # CONFIG_IPV6 is not set
 # CONFIG_WIRELESS is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
@@ -69,16 +72,16 @@ CONFIG_SERIAL_SH_SCI_CONSOLE=y
 CONFIG_GPIO_SYSFS=y
 # CONFIG_HWMON is not set
 CONFIG_SSB=y
-# CONFIG_HID_SUPPORT is not set
 # CONFIG_USB_SUPPORT is not set
 CONFIG_MMC=y
 CONFIG_MMC_SDHI=y
 CONFIG_UIO=y
 CONFIG_UIO_PDRV_GENIRQ=y
 # CONFIG_IOMMU_SUPPORT is not set
-# CONFIG_FILE_LOCKING is not set
 CONFIG_TMPFS=y
 # CONFIG_MISC_FILESYSTEMS is not set
+CONFIG_NFS_FS=y
+CONFIG_ROOT_NFS=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_INFO=y
 CONFIG_DEBUG_INFO_REDUCED=y
-- 
1.7.10.2.484.gcd07cc5
