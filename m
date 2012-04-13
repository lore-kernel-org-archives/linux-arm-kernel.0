From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 13 Apr 2012 10:21:50 +0200
Subject: [PATCH] ARM: ux500: update defconfig
Message-ID: <1334305310-19863-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

Some new drivers and changed Kconfig dependencies for the v3.4
kernel affecting the U8500 defconfig:

- The SOC config options are now brought in by default
- No need to explicitly select misc devices anymore
- I2C is selected by default
- We now have support for charging from the AB8500 so compile
  in this
- The regulator framework needs to be explictly selected

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/configs/u8500_defconfig |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/arm/configs/u8500_defconfig b/arch/arm/configs/u8500_defconfig
index 889d73a..7e84f45 100644
--- a/arch/arm/configs/u8500_defconfig
+++ b/arch/arm/configs/u8500_defconfig
@@ -8,8 +8,6 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_LBDAF is not set
 # CONFIG_BLK_DEV_BSG is not set
 CONFIG_ARCH_U8500=y
-CONFIG_UX500_SOC_DB5500=y
-CONFIG_UX500_SOC_DB8500=y
 CONFIG_MACH_HREFV60=y
 CONFIG_MACH_SNOWBALL=y
 CONFIG_MACH_U5500=y
@@ -39,7 +37,6 @@ CONFIG_CAIF=y
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=65536
-CONFIG_MISC_DEVICES=y
 CONFIG_AB8500_PWM=y
 CONFIG_SENSORS_BH1780=y
 CONFIG_NETDEVICES=y
@@ -65,16 +62,18 @@ CONFIG_SERIAL_AMBA_PL011=y
 CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
 CONFIG_HW_RANDOM=y
 CONFIG_HW_RANDOM_NOMADIK=y
-CONFIG_I2C=y
-CONFIG_I2C_NOMADIK=y
 CONFIG_SPI=y
 CONFIG_SPI_PL022=y
 CONFIG_GPIO_STMPE=y
 CONFIG_GPIO_TC3589X=y
+CONFIG_POWER_SUPPLY=y
+CONFIG_AB8500_BM=y
+CONFIG_AB8500_BATTERY_THERM_ON_BATCTRL=y
 CONFIG_MFD_STMPE=y
 CONFIG_MFD_TC3589X=y
 CONFIG_AB5500_CORE=y
 CONFIG_AB8500_CORE=y
+CONFIG_REGULATOR=y
 CONFIG_REGULATOR_AB8500=y
 # CONFIG_HID_SUPPORT is not set
 CONFIG_USB_GADGET=y
-- 
1.7.9.2
