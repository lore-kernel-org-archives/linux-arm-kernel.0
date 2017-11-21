From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue, 21 Nov 2017 17:28:25 +0100
Subject: [PATCH 4/4] ARM: configs: Add missing config for DART-MX6 SoM
In-Reply-To: <1511281705-30849-1-git-send-email-narmstrong@baylibre.com>
References: <1511281705-30849-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1511281705-30849-5-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the missing configs for the DART-MX6 SoM support :
- SERDEV bluetooth driver + SERIAL_DEV_BUS configs
- WL18XX driver
- DEFAULT_ON Led Trigger

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 0d44949..abd06c3 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -80,6 +80,7 @@ CONFIG_CAN=y
 CONFIG_CAN_FLEXCAN=y
 CONFIG_BT=y
 CONFIG_BT_HCIUART=y
+CONFIG_BT_HCIUART_SERDEV=y
 CONFIG_BT_HCIUART_H4=y
 CONFIG_BT_HCIUART_LL=y
 CONFIG_CFG80211=y
@@ -155,6 +156,7 @@ CONFIG_USB_USBNET=y
 CONFIG_USB_NET_CDC_EEM=m
 CONFIG_BRCMFMAC=m
 CONFIG_WL12XX=m
+CONFIG_WL18XX=m
 CONFIG_WLCORE_SDIO=m
 # CONFIG_WILINK_PLATFORM_DATA is not set
 CONFIG_INPUT_EVDEV=y
@@ -185,6 +187,8 @@ CONFIG_SERIAL_IMX=y
 CONFIG_SERIAL_IMX_CONSOLE=y
 CONFIG_SERIAL_FSL_LPUART=y
 CONFIG_SERIAL_FSL_LPUART_CONSOLE=y
+CONFIG_SERIAL_DEV_BUS=y
+CONFIG_SERIAL_DEV_CTRL_TTYPORT=y
 # CONFIG_I2C_COMPAT is not set
 CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_MUX=y
@@ -248,6 +252,7 @@ CONFIG_VIDEO_OV5640=m
 CONFIG_SOC_CAMERA_OV2640=y
 CONFIG_IMX_IPUV3_CORE=y
 CONFIG_DRM=y
+CONFIG_DRM_PANEL_LVDS=y
 CONFIG_DRM_PANEL_SIMPLE=y
 CONFIG_DRM_DW_HDMI_AHB_AUDIO=m
 CONFIG_DRM_DW_HDMI_CEC=y
@@ -340,6 +345,7 @@ CONFIG_LEDS_TRIGGER_ONESHOT=y
 CONFIG_LEDS_TRIGGER_HEARTBEAT=y
 CONFIG_LEDS_TRIGGER_BACKLIGHT=y
 CONFIG_LEDS_TRIGGER_GPIO=y
+CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_INTF_DEV_UIE_EMUL=y
 CONFIG_RTC_DRV_DS1307=y
-- 
2.7.4
