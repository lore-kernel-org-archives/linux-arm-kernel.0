From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 29 May 2015 15:25:26 +0200
Subject: [PATCH/RFC 2/2] ARM: multi_v7_defconfig: Make fbdev support modular
In-Reply-To: <1432905926-31606-1-git-send-email-geert@linux-m68k.org>
References: <1432905926-31606-1-git-send-email-geert@linux-m68k.org>
Message-ID: <1432905926-31606-2-git-send-email-geert@linux-m68k.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Make fbdev support modular to reduce kernel size (-158 KiB):

       text    data     bss     dec     hex   filename
    11581470 1387196  338264 13306930  cb0c32 vmlinux.before
    11430531 1384340  330584 13145455  c8956f vmlinux.after

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
This one is more controversial:
  - Does anyone need fbdev for boot-testing?
  - This disables two drivers that cannot be modular (FB_WM8505 and
    FB_SIMPLE), and the PLAT_VERSATILE_CLCD helper support.

 arch/arm/configs/multi_v7_defconfig | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 9b4e33d5b15e340f..af94ade61b1400d6 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -436,18 +436,15 @@ CONFIG_DRM_EXYNOS_HDMI=y
 CONFIG_DRM_RCAR_DU=m
 CONFIG_DRM_TEGRA=m
 CONFIG_DRM_PANEL_SIMPLE=m
-CONFIG_FB=y
-CONFIG_FB_ARMCLCD=y
-CONFIG_FB_WM8505=y
-CONFIG_FB_SH_MOBILE_LCDC=y
-CONFIG_FB_SIMPLE=y
+CONFIG_FB_ARMCLCD=m
+CONFIG_FB_SH_MOBILE_LCDC=m
 CONFIG_FB_SH_MOBILE_MERAM=y
 CONFIG_BACKLIGHT_LCD_SUPPORT=y
 CONFIG_BACKLIGHT_CLASS_DEVICE=y
 CONFIG_LCD_PLATFORM=m
 CONFIG_BACKLIGHT_PWM=y
 CONFIG_BACKLIGHT_AS3711=y
-CONFIG_FRAMEBUFFER_CONSOLE=y
+CONFIG_FRAMEBUFFER_CONSOLE=m
 CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
 CONFIG_SOUND=m
 CONFIG_SND=m
-- 
1.9.1
