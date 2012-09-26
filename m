From: vikram186@gmail.com (Vikram Narayanan)
Date: Wed, 26 Sep 2012 22:12:22 +0530
Subject: [PATCH] arm/omap: Replace board_ref_clock with enum values
Message-ID: <5063306E.8080200@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the enum for board_ref_clock from linux/wl12xx.h

Signed-off-by: Vikram Narayanan <vikram186@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: linux-omap at vger.kernel.org
---
I'm not subscribed to the list. So please keep me in Cc for the replies.

 arch/arm/mach-omap2/board-omap4panda.c       |    3 +--
 arch/arm/mach-omap2/board-zoom-peripherals.c |    3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index 70f6d1d..e188765 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -248,8 +248,7 @@ static struct platform_device omap_vwlan_device = {
 };
 
 static struct wl12xx_platform_data omap_panda_wlan_data  __initdata = {
-	/* PANDA ref clock is 38.4 MHz */
-	.board_ref_clock = 2,
+	.board_ref_clock = WL12XX_REFCLOCK_38, /* 38.4 MHz */
 };
 
 static struct twl6040_codec_data twl6040_codec = {
diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/mach-omap2/board-zoom-peripherals.c
index b797cb2..499dca7 100644
--- a/arch/arm/mach-omap2/board-zoom-peripherals.c
+++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
@@ -193,8 +193,7 @@ static struct platform_device omap_vwlan_device = {
 };
 
 static struct wl12xx_platform_data omap_zoom_wlan_data __initdata = {
-	/* ZOOM ref clock is 26 MHz */
-	.board_ref_clock = 1,
+	.board_ref_clock = WL12XX_REFCLOCK_26, /* 26 MHz */
 };
 
 static struct omap2_hsmmc_info mmc[] = {
-- 
1.7.4.1
