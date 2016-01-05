From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue,  5 Jan 2016 15:02:09 +0100
Subject: [PATCH 2/2] ARM: versatile: enable the right LEDs
In-Reply-To: <1452002529-3335-1-git-send-email-linus.walleij@linaro.org>
References: <1452002529-3335-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1452002529-3335-3-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Versatile now only has device tree boot support, and the
device tree version does not support CONFIG_LEDS_VERSATILE.
Instead select CONFIG_LEDS_SYSCON and MFD_SYSCON, so we can
get LEDs support from the same generic driver that drives
most other ARM reference boards.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/configs/versatile_defconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/configs/versatile_defconfig b/arch/arm/configs/versatile_defconfig
index 75ef20462030..295408ea9dc7 100644
--- a/arch/arm/configs/versatile_defconfig
+++ b/arch/arm/configs/versatile_defconfig
@@ -54,6 +54,7 @@ CONFIG_SPI=y
 CONFIG_GPIOLIB=y
 CONFIG_GPIO_PL061=y
 # CONFIG_HWMON is not set
+CONFIG_MFD_SYSCON=y
 CONFIG_FB=y
 CONFIG_FB_ARMCLCD=y
 CONFIG_FRAMEBUFFER_CONSOLE=y
@@ -66,7 +67,7 @@ CONFIG_MMC=y
 CONFIG_MMC_ARMMMCI=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
-CONFIG_LEDS_VERSATILE=y
+CONFIG_LEDS_SYSCON=y
 CONFIG_LEDS_TRIGGERS=y
 CONFIG_LEDS_TRIGGER_HEARTBEAT=y
 CONFIG_LEDS_TRIGGER_CPU=y
-- 
2.4.3
