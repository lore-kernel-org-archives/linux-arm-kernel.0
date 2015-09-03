From: linux.amoon@gmail.com (Anand Moon)
Date: Thu,  3 Sep 2015 18:11:50 +0000
Subject: [PATCHv7] ARM: exynos_defconfig: Enable LEDS for Odroid-XU3/XU4
Message-ID: <1441303910-3266-1-git-send-email-linux.amoon@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Earlier design of the LED for Odroid XU3 was using gpio-leds
Now It was change to using both pwm-leds and gpio-leds.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

---
Changes from last version
dropped following option.
  CONFIG_LEDS_CLASS_FLASH
  CONFIG_TRIGGER_ONESHOT
  CONFIG_LEDS_TRIGGER_TIMER
  CONFIG_TRIGGER_GPIO
fixed the From address
fixed the commit message.
---
 arch/arm/configs/exynos_defconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index 9504e77..bd6b7f7 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -163,6 +163,12 @@ CONFIG_MMC_SDHCI_S3C_DMA=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_IDMAC=y
 CONFIG_MMC_DW_EXYNOS=y
+CONFIG_NEW_LEDS=y
+CONFIG_LEDS_CLASS=y
+CONFIG_LEDS_GPIO=y
+CONFIG_LEDS_PWM=y
+CONFIG_LEDS_TRIGGERS=y
+CONFIG_LEDS_TRIGGER_HEARTBEAT=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_MAX77686=y
 CONFIG_RTC_DRV_MAX77802=y
-- 
2.1.4
