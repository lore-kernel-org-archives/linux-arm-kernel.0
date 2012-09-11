From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 11 Sep 2012 12:15:10 -0600
Subject: [PATCH] ARM: tegra: config: enable RTC for Cardhu and Whistler
Message-ID: <1347387310-13087-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Enable CONFIG_RTC_DRV_TPS65910, CONFIG_RTC_DRV_MAX8907, and some RTC
options that Kconfig help implies should typically be enabled;
RTC_INTF_SYSFS, INTF_PROC, RTC_INTF_DEV.

While rebuilding defconfig:

* Removed entry for HOTPLUG_CPU since it is now implied by PM_SLEEP_SMP.
* Enabled MEDIA_USB_SUPPORT, which is a requirement to keep
  USB_VIDEO_CLASS=m.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/configs/tegra_defconfig |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index ef2c679..adcf3c2 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -31,7 +31,6 @@ CONFIG_TEGRA_PCI=y
 CONFIG_TEGRA_DEBUG_UART_AUTO_ODMDATA=y
 CONFIG_TEGRA_EMC_SCALING_ENABLE=y
 CONFIG_SMP=y
-CONFIG_HOTPLUG_CPU=y
 CONFIG_PREEMPT=y
 CONFIG_AEABI=y
 # CONFIG_OABI_COMPAT is not set
@@ -137,9 +136,8 @@ CONFIG_REGULATOR_TPS6586X=y
 CONFIG_REGULATOR_TPS65910=y
 CONFIG_MEDIA_SUPPORT=y
 CONFIG_MEDIA_CAMERA_SUPPORT=y
+CONFIG_MEDIA_USB_SUPPORT=y
 CONFIG_USB_VIDEO_CLASS=m
-# CONFIG_USB_VIDEO_CLASS_INPUT_EVDEV is not set
-# CONFIG_USB_GSPCA is not set
 CONFIG_SOUND=y
 CONFIG_SND=y
 # CONFIG_SND_SUPPORT_OLD_API is not set
@@ -170,7 +168,11 @@ CONFIG_LEDS_GPIO=y
 CONFIG_LEDS_TRIGGERS=y
 CONFIG_LEDS_TRIGGER_GPIO=y
 CONFIG_RTC_CLASS=y
+CONFIG_RTC_INTF_SYSFS=y
+CONFIG_RTC_INTF_PROC=y
+CONFIG_RTC_INTF_DEV=y
 CONFIG_RTC_DRV_MAX8907=y
+CONFIG_RTC_DRV_TPS65910=y
 CONFIG_RTC_DRV_EM3027=y
 CONFIG_RTC_DRV_TEGRA=y
 CONFIG_STAGING=y
-- 
1.7.0.4
