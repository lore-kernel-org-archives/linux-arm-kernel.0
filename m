From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 17 Sep 2017 16:26:18 +0200
Subject: [PATCH] ARM: defconfig: update Gemini defconfig
Message-ID: <20170917142618.2126-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This updates the Gemini defconfig with drivers merged
for v4.13 or v4.14:
- ATA driver is merged
- DMA driver is merged
- RTC driver gets selected from default Kconfig

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ARM SoC folks: please apply this directly for v4.14-rc:s.
---
 arch/arm/configs/gemini_defconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/configs/gemini_defconfig b/arch/arm/configs/gemini_defconfig
index d2d75fa664a6..2a63fa10c813 100644
--- a/arch/arm/configs/gemini_defconfig
+++ b/arch/arm/configs/gemini_defconfig
@@ -32,6 +32,7 @@ CONFIG_BLK_DEV_RAM_SIZE=16384
 CONFIG_BLK_DEV_SD=y
 # CONFIG_SCSI_LOWLEVEL is not set
 CONFIG_ATA=y
+CONFIG_PATA_FTIDE010=y
 CONFIG_INPUT_EVDEV=y
 CONFIG_KEYBOARD_GPIO=y
 # CONFIG_INPUT_MOUSE is not set
@@ -55,8 +56,8 @@ CONFIG_LEDS_GPIO=y
 CONFIG_LEDS_TRIGGERS=y
 CONFIG_LEDS_TRIGGER_HEARTBEAT=y
 CONFIG_RTC_CLASS=y
-CONFIG_RTC_DRV_GEMINI=y
 CONFIG_DMADEVICES=y
+CONFIG_AMBA_PL08X=y
 # CONFIG_DNOTIFY is not set
 CONFIG_TMPFS=y
 CONFIG_TMPFS_POSIX_ACL=y
-- 
2.13.5
