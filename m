From: tony@atomide.com (Tony Lindgren)
Date: Tue, 28 Sep 2010 09:50:33 -0700
Subject: [PATCH] omap: Fix compile dependency to LEDS_CLASS
Message-ID: <20100928165032.GC3117@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If we LEDS_CLASS is not selected, we will get undefined reference
to `led_classdev_register'.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index e39a417..a92cb49 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -33,7 +33,7 @@ config OMAP_DEBUG_DEVICES
 config OMAP_DEBUG_LEDS
 	bool
 	depends on OMAP_DEBUG_DEVICES
-	default y if LEDS
+	default y if LEDS_CLASS
 
 config OMAP_RESET_CLOCKS
 	bool "Reset unused clocks during boot"
