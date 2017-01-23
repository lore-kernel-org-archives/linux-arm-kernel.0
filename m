From: afzal.mohd.ma@gmail.com (afzal mohammed)
Date: Tue, 24 Jan 2017 03:34:06 +0530
Subject: [PATCH] ARM: vf610m4: defconfig: enable EXT4 filesystem
Message-ID: <20170123220406.5320-1-afzal.mohd.ma@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable EXT4_FS to have rootfs in EXT[2-4].

Other changes are result of savedefconfig keeping minimal config (even
without enabling EXT4_FS, these would be present).

Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>
---

Hi Shawn,

i am not sure about the route for this patch, sending it you as the
Vybrid maintainer. Last (& the only) change to this file was picked
by Arnd.

Regards
afzal

 arch/arm/configs/vf610m4_defconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/configs/vf610m4_defconfig b/arch/arm/configs/vf610m4_defconfig
index aeb2482c492e..b7ecb83a95b6 100644
--- a/arch/arm/configs/vf610m4_defconfig
+++ b/arch/arm/configs/vf610m4_defconfig
@@ -7,7 +7,6 @@ CONFIG_BLK_DEV_INITRD=y
 CONFIG_KALLSYMS_ALL=y
 CONFIG_EMBEDDED=y
 # CONFIG_MMU is not set
-CONFIG_ARM_SINGLE_ARMV7M=y
 CONFIG_ARCH_MXC=y
 CONFIG_SOC_VF610=y
 CONFIG_SET_MEM_PARAM=y
@@ -38,5 +37,5 @@ CONFIG_SERIAL_FSL_LPUART_CONSOLE=y
 CONFIG_MFD_SYSCON=y
 # CONFIG_HID is not set
 # CONFIG_USB_SUPPORT is not set
+CONFIG_EXT4_FS=y
 # CONFIG_MISC_FILESYSTEMS is not set
-# CONFIG_FTRACE is not set
-- 
2.11.0
