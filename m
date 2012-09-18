From: koba@kmckk.co.jp (Tetsuyuki Kobayashi)
Date: Tue, 18 Sep 2012 14:51:00 +0900
Subject: [PATCH] ARM: shmobile: kzm9g: Add ERRATAs in defconfig
In-Reply-To: <5057F3AD.7020200@kmckk.co.jp>
References: <5057F3AD.7020200@kmckk.co.jp>
Message-ID: <1347947460-15959-1-git-send-email-koba@kmckk.co.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SH73a0 SoC has Cortex-A9 core which revision is r2p8.
This patch adds the following ERRATAs to kzm9g_defconfig file.

ARM_ERRATA_743622
ARM_ERRATA_751472
ARM_ERRATA_754322
ARM_ERRATA_764369
PL310_ERRATA_588369
PL310_ERRATA_727915
PL310_ERRATA_769419

I updated kzm9g_defconfig by follwing commands

 make kzm9g_defconfig
 make kzm9g menuconfig
 (add above ERRATAs)
 make kzm9g savedefconfig
 cp defconfig arch/arm/configs/kzm9g_defconfig 

Signed-off-by: Tetsuyuki Kobayashi <koba@kmckk.co.jp>
---
 arch/arm/configs/kzm9g_defconfig |   15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/arm/configs/kzm9g_defconfig b/arch/arm/configs/kzm9g_defconfig
index 2388c86..80fa8ab 100644
--- a/arch/arm/configs/kzm9g_defconfig
+++ b/arch/arm/configs/kzm9g_defconfig
@@ -2,13 +2,14 @@
 CONFIG_EXPERIMENTAL=y
 # CONFIG_LOCALVERSION_AUTO is not set
 CONFIG_SYSVIPC=y
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=16
 CONFIG_NAMESPACES=y
 # CONFIG_UTS_NS is not set
 # CONFIG_IPC_NS is not set
-# CONFIG_USER_NS is not set
 # CONFIG_PID_NS is not set
 # CONFIG_NET_NS is not set
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
@@ -27,10 +28,14 @@ CONFIG_ARCH_SH73A0=y
 CONFIG_MACH_KZM9G=y
 CONFIG_MEMORY_START=0x41000000
 CONFIG_MEMORY_SIZE=0x1f000000
+CONFIG_PL310_ERRATA_588369=y
+CONFIG_PL310_ERRATA_727915=y
 CONFIG_ARM_ERRATA_743622=y
+CONFIG_ARM_ERRATA_751472=y
 CONFIG_ARM_ERRATA_754322=y
-CONFIG_NO_HZ=y
-CONFIG_HIGH_RES_TIMERS=y
+CONFIG_ARM_ERRATA_754327=y
+CONFIG_ARM_ERRATA_764369=y
+CONFIG_PL310_ERRATA_769419=y
 CONFIG_SMP=y
 CONFIG_SCHED_MC=y
 CONFIG_PREEMPT=y
@@ -96,9 +101,7 @@ CONFIG_SND=y
 # CONFIG_SND_USB is not set
 CONFIG_SND_SOC=y
 CONFIG_SND_SOC_SH4_FSI=y
-# CONFIG_HID_SUPPORT is not set
 CONFIG_USB=y
-CONFIG_USB_DEVICEFS=y
 CONFIG_USB_R8A66597_HCD=y
 CONFIG_USB_RENESAS_USBHS=y
 CONFIG_USB_STORAGE=y
@@ -119,12 +122,10 @@ CONFIG_SH_DMAE=y
 CONFIG_ASYNC_TX_DMA=y
 CONFIG_STAGING=y
 # CONFIG_DNOTIFY is not set
-CONFIG_INOTIFY_USER=y
 CONFIG_VFAT_FS=y
 CONFIG_TMPFS=y
 # CONFIG_MISC_FILESYSTEMS is not set
 CONFIG_NFS_FS=y
-CONFIG_NFS_V3=y
 CONFIG_NFS_V3_ACL=y
 CONFIG_NFS_V4=y
 CONFIG_NFS_V4_1=y
-- 
1.7.9.5
