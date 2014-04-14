From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 14 Apr 2014 11:09:58 +0200
Subject: [PATCH] ARM: ux500: configure for CW1200 WLAN chip
Message-ID: <1397466598-14844-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CW1200 WLAN chip driver had been in the kernel for a while,
we only need to activate it for the Ux500 properly. The latter
require some elaborative work, but in the meantime, let's make
sure we atleast compile it in.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/configs/u8500_defconfig | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/configs/u8500_defconfig b/arch/arm/configs/u8500_defconfig
index 726b1fa786f7..d219d6a43238 100644
--- a/arch/arm/configs/u8500_defconfig
+++ b/arch/arm/configs/u8500_defconfig
@@ -34,7 +34,10 @@ CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
 CONFIG_NETFILTER=y
 CONFIG_PHONET=y
-# CONFIG_WIRELESS is not set
+CONFIG_CFG80211=y
+CONFIG_CFG80211_DEBUGFS=y
+CONFIG_MAC80211=y
+CONFIG_MAC80211_LEDS=y
 CONFIG_CAIF=y
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
@@ -45,7 +48,8 @@ CONFIG_SENSORS_BH1780=y
 CONFIG_NETDEVICES=y
 CONFIG_SMSC911X=y
 CONFIG_SMSC_PHY=y
-# CONFIG_WLAN is not set
+CONFIG_CW1200=y
+CONFIG_CW1200_WLAN_SDIO=y
 # CONFIG_INPUT_MOUSEDEV_PSAUX is not set
 CONFIG_INPUT_EVDEV=y
 # CONFIG_KEYBOARD_ATKBD is not set
@@ -93,7 +97,6 @@ CONFIG_LEDS_CLASS=y
 CONFIG_LEDS_LM3530=y
 CONFIG_LEDS_GPIO=y
 CONFIG_LEDS_LP5521=y
-CONFIG_LEDS_TRIGGERS=y
 CONFIG_LEDS_TRIGGER_HEARTBEAT=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_AB8500=y
-- 
1.9.0
