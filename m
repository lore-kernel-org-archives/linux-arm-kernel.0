From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 21 Feb 2017 21:42:30 +0100
Subject: [PATCH] ARM: deconfig: fix the moxart defconfig
Message-ID: <20170221204230.1861-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The moxart defconfig wasn't even building a kernel for Moxart,
it was building a kernel for V4T on the nothing platform. Switch
to MULTI_V4 and keep the right drivers, update a few selections.
Now it (presumably) builds a minimalist Moxart kernel again.

Cc: Jonas Jensen <jonas.jensen@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ARM SoC folks: ran into this when doing some moxart testing.
Please apply this directly for fixes or defconfigs wherever it
is applicable.
---
 arch/arm/configs/moxart_defconfig | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/configs/moxart_defconfig b/arch/arm/configs/moxart_defconfig
index a3cb76cfb828..b2ddd534867f 100644
--- a/arch/arm/configs/moxart_defconfig
+++ b/arch/arm/configs/moxart_defconfig
@@ -18,9 +18,8 @@ CONFIG_EMBEDDED=y
 # CONFIG_LBDAF is not set
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_DEADLINE is not set
-CONFIG_ARCH_MULTI_V4T=y
+CONFIG_ARCH_MULTI_V4=y
 # CONFIG_ARCH_MULTI_V7 is not set
-CONFIG_KEYBOARD_GPIO_POLLED=y
 CONFIG_ARCH_MOXART=y
 CONFIG_MACH_UC7112LX=y
 CONFIG_PREEMPT=y
@@ -94,12 +93,10 @@ CONFIG_SERIAL_8250_EXTENDED=y
 CONFIG_SERIAL_8250_SHARE_IRQ=y
 CONFIG_SERIAL_OF_PLATFORM=y
 # CONFIG_HW_RANDOM is not set
-CONFIG_DEBUG_GPIO=y
-CONFIG_GPIO_SYSFS=y
 CONFIG_GPIO_MOXART=y
-CONFIG_POWER_SUPPLY=y
 CONFIG_POWER_RESET=y
 CONFIG_POWER_RESET_GPIO=y
+CONFIG_POWER_SUPPLY=y
 # CONFIG_HWMON is not set
 CONFIG_WATCHDOG=y
 CONFIG_WATCHDOG_CORE=y
@@ -107,10 +104,13 @@ CONFIG_WATCHDOG_NOWAYOUT=y
 CONFIG_MOXART_WDT=y
 # CONFIG_USB_SUPPORT is not set
 CONFIG_MMC=y
-CONFIG_MMC_SDHCI_MOXART=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_PLTFM=y
+CONFIG_MMC_MOXART=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
 CONFIG_LEDS_GPIO=y
+CONFIG_LEDS_TRIGGERS=y
 CONFIG_LEDS_TRIGGER_TIMER=y
 CONFIG_LEDS_TRIGGER_ONESHOT=y
 CONFIG_LEDS_TRIGGER_HEARTBEAT=y
-- 
2.9.3
