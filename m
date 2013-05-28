From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 28 May 2013 16:43:54 +0200
Subject: [PATCH] ARM: nomadik: update defconfig base
Message-ID: <1369752234-27653-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update the Nomadik defconfig enabling:
- GPIO keyboard input
- Regulators
- LED class driver
- LED heartbeat trigger

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/configs/nhk8815_defconfig | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/configs/nhk8815_defconfig b/arch/arm/configs/nhk8815_defconfig
index 606a080..e4cb5a4 100644
--- a/arch/arm/configs/nhk8815_defconfig
+++ b/arch/arm/configs/nhk8815_defconfig
@@ -48,7 +48,6 @@ CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_MTD=y
 CONFIG_MTD_TESTS=m
 CONFIG_MTD_CMDLINE_PARTS=y
-CONFIG_MTD_CHAR=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_NAND_ECC_SMC=y
 CONFIG_MTD_NAND=y
@@ -81,6 +80,7 @@ CONFIG_PPP_SYNC_TTY=m
 # CONFIG_INPUT_MOUSEDEV is not set
 CONFIG_INPUT_EVDEV=y
 # CONFIG_KEYBOARD_ATKBD is not set
+CONFIG_KEYBOARD_GPIO=y
 # CONFIG_MOUSE_PS2 is not set
 # CONFIG_SERIO is not set
 # CONFIG_LEGACY_PTYS is not set
@@ -93,10 +93,16 @@ CONFIG_I2C_GPIO=y
 CONFIG_I2C_NOMADIK=y
 CONFIG_DEBUG_GPIO=y
 # CONFIG_HWMON is not set
+CONFIG_REGULATOR=y
 CONFIG_MMC=y
 CONFIG_MMC_UNSAFE_RESUME=y
 # CONFIG_MMC_BLOCK_BOUNCE is not set
 CONFIG_MMC_ARMMMCI=y
+CONFIG_NEW_LEDS=y
+CONFIG_LEDS_CLASS=y
+CONFIG_LEDS_GPIO=y
+CONFIG_LEDS_TRIGGERS=y
+CONFIG_LEDS_TRIGGER_HEARTBEAT=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_PL031=y
 CONFIG_DMADEVICES=y
-- 
1.8.1.4
