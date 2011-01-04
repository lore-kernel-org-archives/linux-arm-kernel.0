From: nm@ti.com (Nishanth Menon)
Date: Tue,  4 Jan 2011 14:07:11 -0600
Subject: [PATCH 2/5] omap3: zoom: use static for pointer passing
In-Reply-To: <1294171634-13943-1-git-send-email-nm@ti.com>
References: <1294171634-13943-1-git-send-email-nm@ti.com>
Message-ID: <1294171634-13943-3-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

omap_zoom_wlan_data and zoom2_set_hs_extmute are not used beyond
the scope of zoom-peripherals directly, instead pointers are used.
make them static instead.

Fixes sparse warnings:
arch/arm/mach-omap2/board-zoom-peripherals.c:193:29: warning: symbol 'omap_zoom_wlan_data' was not declared. Should it be static?
arch/arm/mach-omap2/board-zoom-peripherals.c:245:6: warning: symbol 'zoom2_set_hs_extmute' was not declared. Should it be static?

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/board-zoom-peripherals.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/mach-omap2/board-zoom-peripherals.c
index 3fbd0ed..3d1f9ab 100644
--- a/arch/arm/mach-omap2/board-zoom-peripherals.c
+++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
@@ -190,7 +190,7 @@ static struct platform_device omap_vwlan_device = {
 	},
 };
 
-struct wl12xx_platform_data omap_zoom_wlan_data __initdata = {
+static struct wl12xx_platform_data omap_zoom_wlan_data __initdata = {
 	.irq = OMAP_GPIO_IRQ(OMAP_ZOOM_WLAN_IRQ_GPIO),
 	/* ZOOM ref clock is 26 MHz */
 	.board_ref_clock = 1,
@@ -242,7 +242,7 @@ static int zoom_twl_gpio_setup(struct device *dev,
 }
 
 /* EXTMUTE callback function */
-void zoom2_set_hs_extmute(int mute)
+static void zoom2_set_hs_extmute(int mute)
 {
 	gpio_set_value(ZOOM2_HEADSET_EXTMUTE_GPIO, mute);
 }
-- 
1.6.3.3
