From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 11 Mar 2018 14:53:05 +0100
Subject: [PATCH 08/10] ARM: defconfig: Switch RealView boards to use P111 DRM
In-Reply-To: <20180311135307.6271-1-linus.walleij@linaro.org>
References: <20180311135307.6271-1-linus.walleij@linaro.org>
Message-ID: <20180311135307.6271-9-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DRM driver is now finalized for the RealView board family,
so switch the defconfig to use this driver instead of the old
fbdev driver.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/configs/realview_defconfig | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm/configs/realview_defconfig b/arch/arm/configs/realview_defconfig
index 95bd20b2a4d2..cc9fa24d4b8f 100644
--- a/arch/arm/configs/realview_defconfig
+++ b/arch/arm/configs/realview_defconfig
@@ -21,6 +21,7 @@ CONFIG_MACH_REALVIEW_PB1176=y
 CONFIG_MACH_REALVIEW_PBA8=y
 CONFIG_MACH_REALVIEW_PBX=y
 CONFIG_SMP=y
+CONFIG_CMA=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_CMDLINE="root=/dev/nfs nfsroot=10.1.69.3:/work/nfsroot ip=dhcp console=ttyAMA0 mem=128M"
@@ -60,9 +61,12 @@ CONFIG_I2C_VERSATILE=y
 CONFIG_SPI=y
 CONFIG_GPIOLIB=y
 # CONFIG_HWMON is not set
-CONFIG_FB=y
-CONFIG_FB_ARMCLCD=y
-CONFIG_FRAMEBUFFER_CONSOLE=y
+CONFIG_DRM=y
+CONFIG_DRM_PANEL_SIMPLE=y
+CONFIG_DRM_PL111=y
+CONFIG_FB_MODE_HELPERS=y
+CONFIG_BACKLIGHT_LCD_SUPPORT=y
+CONFIG_BACKLIGHT_CLASS_DEVICE=y
 CONFIG_LOGO=y
 # CONFIG_LOGO_LINUX_MONO is not set
 # CONFIG_LOGO_LINUX_VGA16 is not set
-- 
2.14.3
