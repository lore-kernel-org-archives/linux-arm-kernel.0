From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Sat, 24 Nov 2012 10:34:02 +0100
Subject: [PATCH 1/1] ARM: OMAP2+: enable support for GPIO connected LEDs
Message-ID: <1353749642-30255-1-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Many OMAP boards use GPIO LEDs to notify status to the user
on boot. So, it is good to have by default support for GPIO
connected LEDs as well as some commonly used triggers.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 arch/arm/configs/omap2plus_defconfig |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 6333e96..7c6cbdf 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -193,6 +193,14 @@ CONFIG_MMC_UNSAFE_RESUME=y
 CONFIG_SDIO_UART=y
 CONFIG_MMC_OMAP=y
 CONFIG_MMC_OMAP_HS=y
+CONFIG_NEW_LEDS=y
+CONFIG_LEDS_CLASS=y
+CONFIG_LEDS_GPIO=y
+CONFIG_LEDS_TRIGGERS=y
+CONFIG_LEDS_TRIGGER_HEARTBEAT=y
+CONFIG_LEDS_TRIGGER_BACKLIGHT=y
+CONFIG_LEDS_TRIGGER_GPIO=y
+CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_TWL92330=y
 CONFIG_RTC_DRV_TWL4030=y
-- 
1.7.7.6
