From: vince@kyllikki.org (Vincent Sanders)
Date: Mon, 13 Sep 2010 16:13:47 +0100
Subject: [PATCH 4/9] Remove unused n8x0 default configuration
In-Reply-To: <1284390832-7181-1-git-send-email-vince@kyllikki.org>
References: <1284390832-7181-1-git-send-email-vince@kyllikki.org>
Message-ID: <1284390832-7181-5-git-send-email-vince@kyllikki.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vincent Sanders <vince@simtec.co.uk>

The n8x0 default configuration has not built throughout the 2.6.36
series (since 2.6.35-git1). The link has failed with

arch/arm/plat-omap/built-in.o: In function `newled_init':
/var/tmp/kernel-orig/arch/arm/plat-omap/debug-leds.c:249: undefined reference to `led_classdev_register'

In addition there is a modpost warning about six section mismatches

This configuration appers to be unused by the maintainer so remove it.

Signed-off-by: Vincent Sanders <vince@kyllikki.org>
---
 arch/arm/configs/n8x0_defconfig |   94 ---------------------------------------
 1 files changed, 0 insertions(+), 94 deletions(-)
 delete mode 100644 arch/arm/configs/n8x0_defconfig

diff --git a/arch/arm/configs/n8x0_defconfig b/arch/arm/configs/n8x0_defconfig
deleted file mode 100644
index 56aebb6..0000000
--- a/arch/arm/configs/n8x0_defconfig
+++ /dev/null
@@ -1,94 +0,0 @@
-CONFIG_EXPERIMENTAL=y
-CONFIG_SYSVIPC=y
-CONFIG_LOG_BUF_SHIFT=14
-CONFIG_BLK_DEV_INITRD=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-# CONFIG_LBDAF is not set
-# CONFIG_BLK_DEV_BSG is not set
-# CONFIG_IOSCHED_DEADLINE is not set
-CONFIG_ARCH_OMAP=y
-CONFIG_ARCH_OMAP2=y
-CONFIG_OMAP_RESET_CLOCKS=y
-# CONFIG_OMAP_MUX is not set
-# CONFIG_OMAP_MCBSP is not set
-CONFIG_OMAP_MBOX_FWK=y
-CONFIG_OMAP_32K_TIMER=y
-CONFIG_ARCH_OMAP2420=y
-CONFIG_MACH_NOKIA_N8X0=y
-CONFIG_AEABI=y
-CONFIG_LEDS=y
-CONFIG_ZBOOT_ROM_TEXT=0x10C08000
-CONFIG_ZBOOT_ROM_BSS=0x10200000
-CONFIG_CMDLINE="root=/dev/mmcblk0p2 console=ttyS2,115200n8 debug earlyprintk rootwait"
-CONFIG_FPE_NWFPE=y
-CONFIG_VFP=y
-CONFIG_PM=y
-CONFIG_PM_RUNTIME=y
-CONFIG_NET=y
-CONFIG_UNIX=y
-CONFIG_INET=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
-# CONFIG_INET_LRO is not set
-# CONFIG_IPV6 is not set
-CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
-CONFIG_MTD=y
-CONFIG_MTD_CMDLINE_PARTS=y
-CONFIG_MTD_ONENAND=y
-CONFIG_MTD_ONENAND_OMAP2=y
-CONFIG_MTD_ONENAND_OTP=y
-CONFIG_BLK_DEV_RAM=y
-# CONFIG_MISC_DEVICES is not set
-# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
-# CONFIG_INPUT_KEYBOARD is not set
-# CONFIG_INPUT_MOUSE is not set
-CONFIG_SERIAL_8250=y
-CONFIG_SERIAL_8250_CONSOLE=y
-# CONFIG_LEGACY_PTYS is not set
-# CONFIG_HW_RANDOM is not set
-CONFIG_I2C=y
-# CONFIG_I2C_COMPAT is not set
-# CONFIG_I2C_HELPER_AUTO is not set
-CONFIG_I2C_OMAP=y
-CONFIG_SPI=y
-CONFIG_SPI_OMAP24XX=y
-# CONFIG_HWMON is not set
-CONFIG_MENELAUS=y
-CONFIG_REGULATOR=y
-# CONFIG_VGA_CONSOLE is not set
-# CONFIG_HID_SUPPORT is not set
-CONFIG_USB=y
-CONFIG_USB_DEBUG=y
-CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
-CONFIG_USB_DEVICEFS=y
-CONFIG_USB_SUSPEND=y
-# CONFIG_USB_OTG_WHITELIST is not set
-CONFIG_USB_MUSB_HDRC=y
-CONFIG_USB_MUSB_OTG=y
-CONFIG_USB_GADGET_MUSB_HDRC=y
-# CONFIG_MUSB_PIO_ONLY is not set
-CONFIG_USB_MUSB_DEBUG=y
-CONFIG_USB_GADGET=y
-CONFIG_USB_GADGET_DEBUG=y
-CONFIG_USB_GADGET_DEBUG_FILES=y
-CONFIG_USB_ETH=m
-CONFIG_USB_ETH_EEM=y
-CONFIG_MMC=y
-CONFIG_MMC_OMAP=y
-CONFIG_EXT3_FS=y
-CONFIG_INOTIFY=y
-CONFIG_VFAT_FS=y
-CONFIG_TMPFS=y
-CONFIG_JFFS2_FS=y
-CONFIG_JFFS2_SUMMARY=y
-CONFIG_JFFS2_COMPRESSION_OPTIONS=y
-CONFIG_JFFS2_LZO=y
-CONFIG_PRINTK_TIME=y
-CONFIG_DEBUG_KERNEL=y
-CONFIG_DEBUG_INFO=y
-# CONFIG_RCU_CPU_STALL_DETECTOR is not set
-CONFIG_DEBUG_USER=y
-CONFIG_DEBUG_ERRORS=y
-CONFIG_CRC_CCITT=y
-- 
1.7.0.4
