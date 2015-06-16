From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 16 Jun 2015 10:36:04 +0200
Subject: [PATCH] ARM: ep93xx: add LEDs and triggers to defconfig
Message-ID: <1434443764-25973-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The EP93xx has two designated LEDs (not always connected): a
green and a red one. These are registered in the core, so let's
enable the driver and some triggers.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/configs/ep93xx_defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/configs/ep93xx_defconfig b/arch/arm/configs/ep93xx_defconfig
index b3c32d0d4573..9a5205abc7c3 100644
--- a/arch/arm/configs/ep93xx_defconfig
+++ b/arch/arm/configs/ep93xx_defconfig
@@ -99,6 +99,11 @@ CONFIG_USB_SERIAL_CONSOLE=y
 CONFIG_USB_SERIAL_PL2303=y
 CONFIG_MMC=y
 CONFIG_MMC_SPI=y
+CONFIG_NEW_LEDS=y
+CONFIG_LEDS_CLASS=y
+CONFIG_LEDS_GPIO=y
+CONFIG_LEDS_TRIGGERS=y
+CONFIG_LEDS_TRIGGER_HEARTBEAT=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_DS1307=y
 CONFIG_RTC_DRV_M48T86=y
-- 
1.9.3
