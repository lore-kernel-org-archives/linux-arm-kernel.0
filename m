From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue,  5 Mar 2013 16:13:35 +0100
Subject: [PATCH] ARM: mxs: cfa10049: Fix fb initialisation function
Message-ID: <1362496415-6986-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 1fe42740 ("ARM: dts: mxs: Add the LCD to the 10049 board") seem
to have been applied with some fuzzyness, and the framebuffer
initialisation code for the CFA-10049 ended up in the CFA-10037
initialisation function.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/mach-mxs/mach-mxs.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-mxs/mach-mxs.c b/arch/arm/mach-mxs/mach-mxs.c
index 0521867..3218f1f 100644
--- a/arch/arm/mach-mxs/mach-mxs.c
+++ b/arch/arm/mach-mxs/mach-mxs.c
@@ -402,17 +402,17 @@ static void __init cfa10049_init(void)
 {
 	enable_clk_enet_out();
 	update_fec_mac_prop(OUI_CRYSTALFONTZ);
+
+	mxsfb_pdata.mode_list = cfa10049_video_modes;
+	mxsfb_pdata.mode_count = ARRAY_SIZE(cfa10049_video_modes);
+	mxsfb_pdata.default_bpp = 32;
+	mxsfb_pdata.ld_intf_width = STMLCDIF_18BIT;
 }
 
 static void __init cfa10037_init(void)
 {
 	enable_clk_enet_out();
 	update_fec_mac_prop(OUI_CRYSTALFONTZ);
-
-	mxsfb_pdata.mode_list = cfa10049_video_modes;
-	mxsfb_pdata.mode_count = ARRAY_SIZE(cfa10049_video_modes);
-	mxsfb_pdata.default_bpp = 32;
-	mxsfb_pdata.ld_intf_width = STMLCDIF_18BIT;
 }
 
 static void __init apf28_init(void)
-- 
1.7.10.4
