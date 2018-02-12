From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 12 Feb 2018 23:35:02 +0100
Subject: [PATCH] ARM: defconfig: Update Gemini defconfig
Message-ID: <20180212223502.27371-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This updates the Gemini defconfig with a config that will bring
up most of the recently merged and updated devices to some
functional level:

- We enable high resolution timers (the right thing to do)
- Enable CMA for the framebuffer, and the new TVE200
  framebuffer driver and the Ilitek ILI9322 driver for
  graphics on the D-Link DIR-685.
- Enable networking and the new Cortina Gemini ethernet
  driver.
- Enable MDIO over GPIO and the Realtek PHY devices used on
  several of these systems.
- Enable some basic RT2x Wirelss configuration, as many of
  these devides have these wireless cards. (Explicitly disable
  the rest for now.)
- Enable I2C over GPIO and SPI over GPIO which is used on
  several of these devices.
- Enable the Thermal framework, GPIO fan control and LM75 sensor
  adding cooling on the D-Link DNS-313 with no userspace
  involved even if only the kernel is working, rock solid
  thermal for this platform.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ARM SoC folks: please apply this for fixes.
---
 arch/arm/configs/gemini_defconfig | 48 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 46 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/gemini_defconfig b/arch/arm/configs/gemini_defconfig
index 2a63fa10c813..7fb96a26dd12 100644
--- a/arch/arm/configs/gemini_defconfig
+++ b/arch/arm/configs/gemini_defconfig
@@ -1,6 +1,7 @@
 # CONFIG_LOCALVERSION_AUTO is not set
 CONFIG_SYSVIPC=y
 CONFIG_NO_HZ_IDLE=y
+CONFIG_HIGH_RES_TIMERS=y
 CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_USER_NS=y
 CONFIG_RELAY=y
@@ -12,10 +13,18 @@ CONFIG_ARCH_GEMINI=y
 CONFIG_PCI=y
 CONFIG_PREEMPT=y
 CONFIG_AEABI=y
+CONFIG_CMA=y
 CONFIG_CMDLINE="console=ttyS0,115200n8"
 CONFIG_KEXEC=y
 CONFIG_BINFMT_MISC=y
 CONFIG_PM=y
+CONFIG_NET=y
+CONFIG_UNIX=y
+CONFIG_INET=y
+CONFIG_NET_DSA=y
+CONFIG_CFG80211=y
+CONFIG_CFG80211_WEXT=y
+CONFIG_MAC80211=y
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
 CONFIG_MTD=y
@@ -33,6 +42,29 @@ CONFIG_BLK_DEV_SD=y
 # CONFIG_SCSI_LOWLEVEL is not set
 CONFIG_ATA=y
 CONFIG_PATA_FTIDE010=y
+CONFIG_NETDEVICES=y
+CONFIG_GEMINI_ETHERNET=y
+CONFIG_MDIO_BITBANG=y
+CONFIG_MDIO_GPIO=y
+CONFIG_REALTEK_PHY=y
+# CONFIG_USB_NET_DRIVERS is not set
+# CONFIG_WLAN_VENDOR_ADMTEK is not set
+# CONFIG_WLAN_VENDOR_ATH is not set
+# CONFIG_WLAN_VENDOR_ATMEL is not set
+# CONFIG_WLAN_VENDOR_BROADCOM is not set
+# CONFIG_WLAN_VENDOR_CISCO is not set
+# CONFIG_WLAN_VENDOR_INTEL is not set
+# CONFIG_WLAN_VENDOR_INTERSIL is not set
+# CONFIG_WLAN_VENDOR_MARVELL is not set
+# CONFIG_WLAN_VENDOR_MEDIATEK is not set
+CONFIG_RT2X00=y
+CONFIG_RT61PCI=y
+CONFIG_RT2800PCI=y
+# CONFIG_WLAN_VENDOR_REALTEK is not set
+# CONFIG_WLAN_VENDOR_RSI is not set
+# CONFIG_WLAN_VENDOR_ST is not set
+# CONFIG_WLAN_VENDOR_TI is not set
+# CONFIG_WLAN_VENDOR_ZYDAS is not set
 CONFIG_INPUT_EVDEV=y
 CONFIG_KEYBOARD_GPIO=y
 # CONFIG_INPUT_MOUSE is not set
@@ -43,12 +75,24 @@ CONFIG_SERIAL_8250_NR_UARTS=1
 CONFIG_SERIAL_8250_RUNTIME_UARTS=1
 CONFIG_SERIAL_OF_PLATFORM=y
 # CONFIG_HW_RANDOM is not set
-# CONFIG_HWMON is not set
+CONFIG_I2C_GPIO=y
+CONFIG_SPI=y
+CONFIG_SPI_GPIO=y
+CONFIG_SENSORS_GPIO_FAN=y
+CONFIG_SENSORS_LM75=y
+CONFIG_THERMAL=y
 CONFIG_WATCHDOG=y
-CONFIG_GEMINI_WATCHDOG=y
+CONFIG_REGULATOR=y
+CONFIG_REGULATOR_FIXED_VOLTAGE=y
+CONFIG_DRM=y
+CONFIG_DRM_PANEL_ILITEK_IL9322=y
+CONFIG_DRM_TVE200=y
+CONFIG_LOGO=y
 CONFIG_USB=y
 CONFIG_USB_MON=y
+CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_FOTG210_HCD=y
+CONFIG_USB_UHCI_HCD=y
 CONFIG_USB_STORAGE=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
-- 
2.14.3
