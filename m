From: tony@atomide.com (Tony Lindgren)
Date: Fri, 30 Apr 2010 12:57:17 -0700
Subject: [PATCH] omap2/3/4: Set CONFIG_FB_OMAP=m in omap3_defconfig
Message-ID: <mailman.350.1272934345.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Looks like CONFIG_FB_OMAP prevents somehow mounting root on MMC
at least on zoom3 for multi-omap. Disable CONFIG_FB until the
omap FB code is fixed.

This allows booting omap3_defconfig on various omaps. Tested on
2420-n8x0, 3430-n900, 3630-zoom3 and 4430-blaze. Note that n8x0
still has issues with starting user space because of TLS and
VFP.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/configs/omap3_defconfig b/arch/arm/configs/omap3_defconfig
index 7855edb..9ed6de8 100644
--- a/arch/arm/configs/omap3_defconfig
+++ b/arch/arm/configs/omap3_defconfig
@@ -1359,7 +1359,7 @@ CONFIG_FB_TILEBLITTING=y
 # CONFIG_FB_METRONOME is not set
 # CONFIG_FB_MB862XX is not set
 # CONFIG_FB_BROADSHEET is not set
-CONFIG_FB_OMAP=y
+CONFIG_FB_OMAP=m
 CONFIG_FB_OMAP_LCD_VGA=y
 # CONFIG_FB_OMAP_031M3R is not set
 # CONFIG_FB_OMAP_048M3R is not set

--Zi0sgQQBxRFxMTsj--
