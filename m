From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 16 Mar 2018 14:10:09 -0300
Subject: [PATCH v2] ARM: mxs_defconfig: Re-sync defconfig
Message-ID: <1521220209-27621-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Re-sync the defconfig by doing:

make savedefconfig
cp defconfig arch/arm/configs/mxs_defconfig

So keep it in sync to help further changes in defconfig.

The explanation for removing the Kconfig symbols:

CONFIG_FHANDLE=y: verified that it is still selected
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set: verified that it is still not
selected
CONFIG_DEVPTS_MULTIPLE_INSTANCES=y: does not exist anymore
# CONFIG_DEVKMEM is not set: verified that it is still not selected
CONFIG_NVMEM=y: verified that it is still selected
CONFIG_LOCKUP_DETECTOR=y: need to select CONFIG_SOFTLOCKUP_DETECTOR now
CONFIG_TIMER_STATS=y: does not exist anymore

Boot tested on a imx28evk.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
Changes since v1:
- Keep the changes to a minimum and explain the reason for
the each one of the removed options (Arnd).

 arch/arm/configs/mxs_defconfig | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/arch/arm/configs/mxs_defconfig b/arch/arm/configs/mxs_defconfig
index bbfb675..a508eb3 100644
--- a/arch/arm/configs/mxs_defconfig
+++ b/arch/arm/configs/mxs_defconfig
@@ -1,5 +1,4 @@
 CONFIG_SYSVIPC=y
-CONFIG_FHANDLE=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_TASKSTATS=y
@@ -62,14 +61,13 @@ CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_NETDEVICES=y
 CONFIG_ENC28J60=y
-CONFIG_SMSC_PHY=y
 CONFIG_ICPLUS_PHY=y
-CONFIG_REALTEK_PHY=y
 CONFIG_MICREL_PHY=y
+CONFIG_REALTEK_PHY=y
+CONFIG_SMSC_PHY=y
 CONFIG_USB_USBNET=y
 CONFIG_USB_NET_SMSC95XX=y
 # CONFIG_WLAN is not set
-# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
 CONFIG_INPUT_EVDEV=y
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
@@ -77,9 +75,7 @@ CONFIG_INPUT_TOUCHSCREEN=y
 CONFIG_TOUCHSCREEN_MXS_LRADC=y
 CONFIG_TOUCHSCREEN_TSC2007=m
 # CONFIG_SERIO is not set
-CONFIG_DEVPTS_MULTIPLE_INSTANCES=y
 # CONFIG_LEGACY_PTYS is not set
-# CONFIG_DEVKMEM is not set
 CONFIG_SERIAL_AMBA_PL011=y
 CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
 CONFIG_SERIAL_MXS_AUART=y
@@ -138,11 +134,10 @@ CONFIG_RTC_DRV_STMP=y
 CONFIG_DMADEVICES=y
 CONFIG_MXS_DMA=y
 CONFIG_IIO=y
-CONFIG_IIO_SYSFS_TRIGGER=y
 CONFIG_MXS_LRADC_ADC=y
+CONFIG_IIO_SYSFS_TRIGGER=y
 CONFIG_PWM=y
 CONFIG_PWM_MXS=y
-CONFIG_NVMEM=y
 CONFIG_NVMEM_MXS_OCOTP=y
 CONFIG_EXT4_FS=y
 # CONFIG_DNOTIFY is not set
@@ -172,8 +167,7 @@ CONFIG_FRAME_WARN=2048
 CONFIG_UNUSED_SYMBOLS=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
-CONFIG_LOCKUP_DETECTOR=y
-CONFIG_TIMER_STATS=y
+CONFIG_SOFTLOCKUP_DETECTOR=y
 CONFIG_PROVE_LOCKING=y
 CONFIG_BLK_DEV_IO_TRACE=y
 CONFIG_STRICT_DEVMEM=y
-- 
2.7.4
