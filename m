From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu,  6 Nov 2014 09:07:47 +0100
Subject: [PATCH 2/2] ARM: nomadik: configure in STMPE support
Message-ID: <1415261267-4204-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables the STMPE MFD, GPIO and keypad support by default on
the Nomadik builds. This expander is used on the NDK 15 board.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/configs/nhk8815_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/nhk8815_defconfig b/arch/arm/configs/nhk8815_defconfig
index 783f44c0dfc6..7d2ad30d9e70 100644
--- a/arch/arm/configs/nhk8815_defconfig
+++ b/arch/arm/configs/nhk8815_defconfig
@@ -80,6 +80,7 @@ CONFIG_PPP_SYNC_TTY=m
 CONFIG_INPUT_EVDEV=y
 # CONFIG_KEYBOARD_ATKBD is not set
 CONFIG_KEYBOARD_GPIO=y
+CONFIG_KEYBOARD_STMPE=y
 # CONFIG_MOUSE_PS2 is not set
 # CONFIG_SERIO is not set
 # CONFIG_LEGACY_PTYS is not set
@@ -89,7 +90,9 @@ CONFIG_HW_RANDOM=y
 CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_GPIO=y
 CONFIG_DEBUG_GPIO=y
+CONFIG_GPIO_STMPE=y
 # CONFIG_HWMON is not set
+CONFIG_MFD_STMPE=y
 CONFIG_REGULATOR=y
 CONFIG_MMC=y
 # CONFIG_MMC_BLOCK_BOUNCE is not set
-- 
1.9.3
