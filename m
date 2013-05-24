From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 24 May 2013 08:58:13 +0200
Subject: [PATCH] ARM: ux500: update defconfig base
Message-ID: <1369378693-27184-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

Update the defconfig removing/adding selections due to
Kconfig changes, and select some new hardware drivers that
have been matured in the tree. For example:

- CONFIG_NO_HZ and CONFIG_HIGH_RES_TIMERS come from the
  make oldconfig changes after the recent changes to
  how NOHZ is handled.
- The U5500 config option is now gone as the machine is
  deleted. So is the AB5500 driver.
- CPU_IDLE selected explicitly.
- LP5521 Kconfig has been moved around.
- AB8500 core is default-selected, as is the AB8500 USB
  transciever.
- The battery and charging management drivers for the
  AB8500 are not selected again.
- Select the crypto devices that have been shaped up
  to work properly.

Cc: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/configs/u8500_defconfig | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/arch/arm/configs/u8500_defconfig b/arch/arm/configs/u8500_defconfig
index acb62cf..da0614a 100644
--- a/arch/arm/configs/u8500_defconfig
+++ b/arch/arm/configs/u8500_defconfig
@@ -1,6 +1,7 @@
-CONFIG_EXPERIMENTAL=y
 # CONFIG_SWAP is not set
 CONFIG_SYSVIPC=y
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_KALLSYMS_ALL=y
 CONFIG_MODULES=y
@@ -9,10 +10,7 @@ CONFIG_MODULE_UNLOAD=y
 CONFIG_ARCH_U8500=y
 CONFIG_MACH_HREFV60=y
 CONFIG_MACH_SNOWBALL=y
-CONFIG_MACH_U5500=y
 CONFIG_MACH_UX500_DT=y
-CONFIG_NO_HZ=y
-CONFIG_HIGH_RES_TIMERS=y
 CONFIG_SMP=y
 CONFIG_NR_CPUS=2
 CONFIG_PREEMPT=y
@@ -20,6 +18,7 @@ CONFIG_AEABI=y
 CONFIG_CMDLINE="root=/dev/ram0 console=ttyAMA2,115200n8"
 CONFIG_CPU_FREQ=y
 CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
+CONFIG_CPU_IDLE=y
 CONFIG_VFP=y
 CONFIG_NEON=y
 CONFIG_PM_RUNTIME=y
@@ -36,7 +35,6 @@ CONFIG_CAIF=y
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=65536
-CONFIG_AB8500_PWM=y
 CONFIG_SENSORS_BH1780=y
 CONFIG_NETDEVICES=y
 CONFIG_SMSC911X=y
@@ -60,42 +58,33 @@ CONFIG_VT_HW_CONSOLE_BINDING=y
 CONFIG_SERIAL_AMBA_PL011=y
 CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
 CONFIG_HW_RANDOM=y
-CONFIG_HW_RANDOM_NOMADIK=y
 CONFIG_SPI=y
 CONFIG_SPI_PL022=y
 CONFIG_GPIO_STMPE=y
 CONFIG_GPIO_TC3589X=y
-# CONFIG_POWER_SUPPLY is not set
-# CONFIG_AB8500_BM is not set
-# CONFIG_AB8500_BATTERY_THERM_ON_BATCTRL is not set
 CONFIG_THERMAL=y
 CONFIG_CPU_THERMAL=y
 CONFIG_WATCHDOG=y
 CONFIG_MFD_STMPE=y
 CONFIG_MFD_TC3589X=y
-CONFIG_AB5500_CORE=y
-CONFIG_AB8500_CORE=y
-CONFIG_REGULATOR=y
-CONFIG_REGULATOR_AB8500=y
-CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_REGULATOR_GPIO=y
-# CONFIG_HID_SUPPORT is not set
+CONFIG_REGULATOR_AB8500=y
 CONFIG_USB=y
 CONFIG_USB_MUSB_HDRC=y
 CONFIG_USB_MUSB_UX500=y
 CONFIG_USB_PHY=y
+CONFIG_AB8500_USB=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_MUSB_HDRC=y
 CONFIG_USB_ETH=m
-CONFIG_AB8500_USB=y
 CONFIG_MMC=y
 CONFIG_MMC_CLKGATE=y
 CONFIG_MMC_ARMMMCI=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
 CONFIG_LEDS_LM3530=y
-CONFIG_LEDS_LP5521=y
 CONFIG_LEDS_GPIO=y
+CONFIG_LEDS_LP5521=y
 CONFIG_LEDS_TRIGGERS=y
 CONFIG_LEDS_TRIGGER_HEARTBEAT=y
 CONFIG_RTC_CLASS=y
@@ -115,7 +104,6 @@ CONFIG_EXT4_FS=y
 CONFIG_VFAT_FS=y
 CONFIG_TMPFS=y
 CONFIG_TMPFS_POSIX_ACL=y
-CONFIG_CONFIGFS_FS=m
 # CONFIG_MISC_FILESYSTEMS is not set
 CONFIG_NFS_FS=y
 CONFIG_ROOT_NFS=y
@@ -129,3 +117,7 @@ CONFIG_DEBUG_KERNEL=y
 CONFIG_DEBUG_INFO=y
 # CONFIG_FTRACE is not set
 CONFIG_DEBUG_USER=y
+CONFIG_CRYPTO_DEV_UX500=y
+CONFIG_CRYPTO_DEV_UX500_CRYP=y
+CONFIG_CRYPTO_DEV_UX500_HASH=y
+CONFIG_CRYPTO_DEV_UX500_DEBUG=y
-- 
1.7.11.3
