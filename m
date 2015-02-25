From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 25 Feb 2015 13:16:44 +0100
Subject: [PATCH 2/2] arm64: add LEDs and some trigger support to defconfig
Message-ID: <1424866604-3028-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since many boards for ARM, experimental or server alike, will
feature LEDs, let's include LED class and trigger support for
heartbeat and CPU in the defconfig. Many systems (such as the
ARM Juno) will use a system controller "syscon" to access the
LED registers, so include support for this as well.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Liviu Dudau <Liviu.Dudau@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm64/configs/defconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index be1f12a5a5f0..b715e194034c 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -122,6 +122,12 @@ CONFIG_MMC_ARMMMCI=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_PLTFM=y
 CONFIG_MMC_SPI=y
+CONFIG_NEW_LEDS=y
+CONFIG_LEDS_CLASS=y
+CONFIG_LEDS_SYSCON=y
+CONFIG_LEDS_TRIGGERS=y
+CONFIG_LEDS_TRIGGER_HEARTBEAT=y
+CONFIG_LEDS_TRIGGER_CPU=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_EFI=y
 CONFIG_RTC_DRV_XGENE=y
-- 
1.9.3
