From: festevam@gmail.com (Fabio Estevam)
Date: Fri,  5 Sep 2014 11:34:23 -0300
Subject: [PATCH] ARM: imx_v4_v5_defconfig: Select CONFIG_IMX_WEIM
Message-ID: <1409927663-8871-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

The imx weim driver is used by some mx27/mx1 boards, so let's enable it by
default.

Generated this patch by doing:

- make imx_v4_v5_defconfig
- make menuconfig and manually select CONFIG_IMX_WEIM
- make savedefconfig
- cp defconfig arch/arm/configs/imx_v4_v5_defconfig

,which results in some additional cleanups.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/configs/imx_v4_v5_defconfig | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/arm/configs/imx_v4_v5_defconfig b/arch/arm/configs/imx_v4_v5_defconfig
index a3fb866..e688741 100644
--- a/arch/arm/configs/imx_v4_v5_defconfig
+++ b/arch/arm/configs/imx_v4_v5_defconfig
@@ -21,7 +21,6 @@ CONFIG_ARCH_MULTI_V4T=y
 CONFIG_ARCH_MULTI_V5=y
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_MXC=y
-CONFIG_MXC_IRQ_PRIOR=y
 CONFIG_MACH_SCB9328=y
 CONFIG_MACH_APF9328=y
 CONFIG_MACH_MX21ADS=y
@@ -38,8 +37,6 @@ CONFIG_PREEMPT=y
 CONFIG_AEABI=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
-CONFIG_FPE_NWFPE=y
-CONFIG_FPE_NWFPE_XP=y
 CONFIG_PM_DEBUG=y
 CONFIG_NET=y
 CONFIG_PACKET=y
@@ -58,6 +55,7 @@ CONFIG_NETFILTER=y
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
+CONFIG_IMX_WEIM=y
 CONFIG_MTD=y
 CONFIG_MTD_CMDLINE_PARTS=y
 CONFIG_MTD_BLOCK=y
@@ -73,8 +71,8 @@ CONFIG_MTD_NAND_MXC=y
 CONFIG_MTD_UBI=y
 CONFIG_EEPROM_AT24=y
 CONFIG_EEPROM_AT25=y
-CONFIG_ATA=y
 CONFIG_BLK_DEV_SD=y
+CONFIG_ATA=y
 CONFIG_PATA_IMX=y
 CONFIG_NETDEVICES=y
 CONFIG_CS89x0=y
@@ -97,10 +95,8 @@ CONFIG_SERIAL_8250=m
 CONFIG_SERIAL_IMX=y
 CONFIG_SERIAL_IMX_CONSOLE=y
 # CONFIG_HW_RANDOM is not set
-CONFIG_I2C=y
 CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_IMX=y
-CONFIG_SPI=y
 CONFIG_SPI_IMX=y
 CONFIG_SPI_SPIDEV=y
 CONFIG_GPIO_SYSFS=y
@@ -127,10 +123,7 @@ CONFIG_VIDEO_CODA=y
 CONFIG_SOC_CAMERA_OV2640=y
 CONFIG_FB=y
 CONFIG_FB_IMX=y
-CONFIG_BACKLIGHT_LCD_SUPPORT=y
-CONFIG_LCD_CLASS_DEVICE=y
 CONFIG_LCD_L4F00242T03=y
-CONFIG_BACKLIGHT_CLASS_DEVICE=y
 CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_LOGO=y
 CONFIG_SOUND=y
-- 
1.9.1
