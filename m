From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri,  4 Oct 2013 15:42:57 +0200
Subject: [PATCH v2] ARM: h3600: update defconfig
Message-ID: <1380894177-17748-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This updates the h3600 defconfig against the latest kernel with
some small options coming and going due to Kconfig structure,
then modernize it to:

- Configure for low latency preemptive kernel
- Configure for tickless idle
- Enable HRtimers

Tested on the iPAQ h3630.

Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Skip switching on EABI compilation. This leads to errors when
  loading modules.
---
 arch/arm/configs/h3600_defconfig | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/arch/arm/configs/h3600_defconfig b/arch/arm/configs/h3600_defconfig
index 317960f..0142ec3 100644
--- a/arch/arm/configs/h3600_defconfig
+++ b/arch/arm/configs/h3600_defconfig
@@ -1,5 +1,6 @@
-CONFIG_EXPERIMENTAL=y
 CONFIG_SYSVIPC=y
+CONFIG_NO_HZ_IDLE=y
+CONFIG_HIGH_RES_TIMERS=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_MODULES=y
@@ -11,11 +12,11 @@ CONFIG_ARCH_SA1100=y
 CONFIG_SA1100_H3600=y
 CONFIG_PCCARD=y
 CONFIG_PCMCIA_SA1100=y
+CONFIG_PREEMPT=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
 # CONFIG_CPU_FREQ_STAT is not set
 CONFIG_FPE_NWFPE=y
-CONFIG_PM=y
 CONFIG_NET=y
 CONFIG_UNIX=y
 CONFIG_INET=y
@@ -24,13 +25,10 @@ CONFIG_IRDA=m
 CONFIG_IRLAN=m
 CONFIG_IRNET=m
 CONFIG_IRCOMM=m
-CONFIG_SA1100_FIR=m
 # CONFIG_WIRELESS is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_MTD=y
-CONFIG_MTD_PARTITIONS=y
 CONFIG_MTD_REDBOOT_PARTS=y
-CONFIG_MTD_CHAR=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_CFI=y
 CONFIG_MTD_CFI_ADV_OPTIONS=y
@@ -41,19 +39,15 @@ CONFIG_MTD_SA1100=y
 CONFIG_BLK_DEV_LOOP=m
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=8192
-# CONFIG_MISC_DEVICES is not set
 CONFIG_IDE=y
 CONFIG_BLK_DEV_IDECS=y
 CONFIG_NETDEVICES=y
-# CONFIG_NETDEV_1000 is not set
-# CONFIG_NETDEV_10000 is not set
-# CONFIG_WLAN is not set
-CONFIG_NET_PCMCIA=y
 CONFIG_PCMCIA_PCNET=y
 CONFIG_PPP=m
-CONFIG_PPP_ASYNC=m
-CONFIG_PPP_DEFLATE=m
 CONFIG_PPP_BSDCOMP=m
+CONFIG_PPP_DEFLATE=m
+CONFIG_PPP_ASYNC=m
+# CONFIG_WLAN is not set
 # CONFIG_KEYBOARD_ATKBD is not set
 CONFIG_KEYBOARD_GPIO=y
 # CONFIG_INPUT_MOUSE is not set
@@ -64,8 +58,6 @@ CONFIG_SERIAL_SA1100_CONSOLE=y
 # CONFIG_HWMON is not set
 CONFIG_FB=y
 CONFIG_FB_SA1100=y
-# CONFIG_VGA_CONSOLE is not set
-# CONFIG_HID_SUPPORT is not set
 # CONFIG_USB_SUPPORT is not set
 CONFIG_EXT2_FS=y
 CONFIG_MSDOS_FS=m
@@ -74,6 +66,4 @@ CONFIG_JFFS2_FS=y
 CONFIG_CRAMFS=m
 CONFIG_NFS_FS=y
 CONFIG_NFSD=m
-CONFIG_SMB_FS=m
 CONFIG_NLS=y
-# CONFIG_RCU_CPU_STALL_DETECTOR is not set
-- 
1.8.3.1
