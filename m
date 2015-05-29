From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 29 May 2015 11:21:38 +0200
Subject: [PATCH 1/2] ARM: multi_v7_defconfig: Make sound support modular
Message-ID: <1432891299-22892-1-git-send-email-geert@linux-m68k.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Make sound support modular to reduce kernel size (-571 KiB):

       text    data     bss     dec     hex   filename
    12990441 1438820  342552 14771813  e16665 vmlinux.before
    12451039 1396476  339800 14187315  d87b33 vmlinux.after

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Against next-20150528
---
 arch/arm/configs/multi_v7_defconfig | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index a10e6fc179badb7a..dace65289bb75822 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -447,22 +447,22 @@ CONFIG_BACKLIGHT_PWM=y
 CONFIG_BACKLIGHT_AS3711=y
 CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
-CONFIG_SOUND=y
-CONFIG_SND=y
+CONFIG_SOUND=m
+CONFIG_SND=m
 CONFIG_SND_DYNAMIC_MINORS=y
 CONFIG_SND_USB_AUDIO=y
-CONFIG_SND_SOC=y
+CONFIG_SND_SOC=m
 CONFIG_SND_ATMEL_SOC=m
 CONFIG_SND_ATMEL_SOC_WM8904=m
 CONFIG_SND_SOC_SH4_FSI=m
 CONFIG_SND_SOC_RCAR=m
-CONFIG_SND_SOC_TEGRA=y
-CONFIG_SND_SOC_TEGRA_RT5640=y
-CONFIG_SND_SOC_TEGRA_WM8753=y
-CONFIG_SND_SOC_TEGRA_WM8903=y
-CONFIG_SND_SOC_TEGRA_TRIMSLICE=y
-CONFIG_SND_SOC_TEGRA_ALC5632=y
-CONFIG_SND_SOC_TEGRA_MAX98090=y
+CONFIG_SND_SOC_TEGRA=m
+CONFIG_SND_SOC_TEGRA_RT5640=m
+CONFIG_SND_SOC_TEGRA_WM8753=m
+CONFIG_SND_SOC_TEGRA_WM8903=m
+CONFIG_SND_SOC_TEGRA_TRIMSLICE=m
+CONFIG_SND_SOC_TEGRA_ALC5632=m
+CONFIG_SND_SOC_TEGRA_MAX98090=m
 CONFIG_SND_SOC_AK4642=m
 CONFIG_SND_SOC_WM8978=m
 CONFIG_USB=y
-- 
1.9.1
