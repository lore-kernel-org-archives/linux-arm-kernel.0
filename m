From: sebastien.szymanski@armadeus.com (=?UTF-8?q?S=C3=A9bastien=20Szymanski?=)
Date: Fri, 15 May 2015 15:44:28 +0200
Subject: [PATCH 2/2] ARM: imx_v6_v7_defconfig: updates for Armadeus Systems
 APF6 boards
In-Reply-To: <1431697468-19363-1-git-send-email-sebastien.szymanski@armadeus.com>
References: <1431697468-19363-1-git-send-email-sebastien.szymanski@armadeus.com>
Message-ID: <1431697468-19363-2-git-send-email-sebastien.szymanski@armadeus.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

APF6 Dual and Quad SoM have an wl1271 wifi/bt chip. This chip needs
CONFIG_BT_HCIUART_LL.
APF6Dev carrier board has a SX8654 I2C touchscreen controller.

Signed-off-by: S?bastien Szymanski <sebastien.szymanski@armadeus.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index fdeb1c8..3ad53ce 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -73,6 +73,7 @@ CONFIG_CAN=y
 CONFIG_CAN_FLEXCAN=y
 CONFIG_BT=y
 CONFIG_BT_HCIUART=y
+CONFIG_BT_HCIUART_LL=y
 CONFIG_BT_HCIUART_3WIRE=y
 CONFIG_CFG80211=y
 CONFIG_MAC80211=y
@@ -139,6 +140,10 @@ CONFIG_USB_RTL8152=m
 CONFIG_USB_USBNET=m
 CONFIG_USB_NET_CDC_EEM=m
 CONFIG_BRCMFMAC=m
+CONFIG_WL_TI=y
+CONFIG_WL12XX=m
+CONFIG_WLCORE_SDIO=m
+# CONFIG_WILINK_PLATFORM_DATA is not set
 # CONFIG_INPUT_MOUSEDEV_PSAUX is not set
 CONFIG_INPUT_EVDEV=y
 CONFIG_INPUT_EVBUG=m
@@ -151,6 +156,7 @@ CONFIG_TOUCHSCREEN_EGALAX=y
 CONFIG_TOUCHSCREEN_MC13783=y
 CONFIG_TOUCHSCREEN_TSC2007=y
 CONFIG_TOUCHSCREEN_STMPE=y
+CONFIG_TOUCHSCREEN_SX8654=y
 CONFIG_INPUT_MISC=y
 CONFIG_INPUT_MMA8450=y
 CONFIG_SERIO_SERPORT=m
-- 
2.0.5
