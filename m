From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 11 Mar 2018 14:53:07 +0100
Subject: [PATCH 10/10] ARM: defconfig: Configure Versatile boards to use PL111
 DRM
In-Reply-To: <20180311135307.6271-1-linus.walleij@linaro.org>
References: <20180311135307.6271-1-linus.walleij@linaro.org>
Message-ID: <20180311135307.6271-11-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DRM driver is now finalized for the Versatile board family,
so switch the defconfig to use this driver instead of the old
fbdev driver.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/configs/versatile_defconfig | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/arm/configs/versatile_defconfig b/arch/arm/configs/versatile_defconfig
index 6a3e5774247e..df68dc4056e5 100644
--- a/arch/arm/configs/versatile_defconfig
+++ b/arch/arm/configs/versatile_defconfig
@@ -12,6 +12,7 @@ CONFIG_PARTITION_ADVANCED=y
 CONFIG_ARCH_VERSATILE=y
 CONFIG_AEABI=y
 CONFIG_OABI_COMPAT=y
+CONFIG_CMA=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_CMDLINE="root=1f03 mem=32M"
@@ -49,16 +50,20 @@ CONFIG_SERIAL_8250_SHARE_IRQ=y
 CONFIG_SERIAL_8250_RSA=y
 CONFIG_SERIAL_AMBA_PL011=y
 CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
-CONFIG_I2C=y
 CONFIG_I2C_CHARDEV=m
 CONFIG_I2C_VERSATILE=y
 CONFIG_SPI=y
 CONFIG_GPIOLIB=y
 CONFIG_GPIO_PL061=y
 # CONFIG_HWMON is not set
-CONFIG_FB=y
-CONFIG_FB_ARMCLCD=y
-CONFIG_FRAMEBUFFER_CONSOLE=y
+CONFIG_DRM=y
+CONFIG_DRM_PANEL_ARM_VERSATILE=y
+CONFIG_DRM_PANEL_SIMPLE=y
+CONFIG_DRM_PL111=y
+CONFIG_FB_MODE_HELPERS=y
+CONFIG_BACKLIGHT_LCD_SUPPORT=y
+CONFIG_BACKLIGHT_CLASS_DEVICE=y
+CONFIG_LOGO=y
 CONFIG_SOUND=y
 CONFIG_SND=m
 CONFIG_SND_ARMAACI=m
-- 
2.14.3
