From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 18 May 2015 17:24:41 +0200
Subject: [PATCH] ARM: xz: do not try to use a ramdisk in defconfig
Message-ID: <96091291.NVWbJdm5EK@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The original zx defconfig file looks for a ./rootfs.cpio file,
but that breaks with

  scripts/gen_initramfs_list.sh: Cannot open 'initramfs.cpio.gz'

when trying to build this kernel. Anybody who relies on the
current behavior should change their build scripts to append
the initramfs manually, as this patch removes that default
in order to help autmatic testing.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I'm applying this directly to the next/defconfig branch to kernel the
kernelci builds.

diff --git a/arch/arm/configs/zx_defconfig b/arch/arm/configs/zx_defconfig
index d411cd6bdb7f..b200bb0fecdd 100644
--- a/arch/arm/configs/zx_defconfig
+++ b/arch/arm/configs/zx_defconfig
@@ -13,7 +13,6 @@ CONFIG_RT_GROUP_SCHED=y
 CONFIG_NAMESPACES=y
 CONFIG_USER_NS=y
 CONFIG_BLK_DEV_INITRD=y
-CONFIG_INITRAMFS_SOURCE="initramfs.cpio.gz"
 CONFIG_SYSCTL_SYSCALL=y
 CONFIG_KALLSYMS_ALL=y
 CONFIG_EMBEDDED=y
