From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 30 Oct 2015 15:20:59 +0100
Subject: [PATCH 13/19] drm: sun4i: tv: Add NTSC output standard
In-Reply-To: <1446214865-3972-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1446214865-3972-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1446214865-3972-14-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the settings to support the NTSC standard.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpu/drm/sun4i/sun4i_tv.c | 45 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tv.c b/drivers/gpu/drm/sun4i/sun4i_tv.c
index 4b95d04ff457..b460406d744c 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tv.c
@@ -175,24 +175,69 @@ struct sun4i_tv {
 	struct sun4i_drv	*drv;
 };
 
+struct video_levels ntsc_video_levels = {
+	.black = 282,	.blank = 240,
+};
+
 struct video_levels pal_video_levels = {
 	.black = 252,	.blank = 252,
 };
 
+struct burst_levels ntsc_burst_levels = {
+	.cb = 79,	.cr = 0,
+};
+
 struct burst_levels pal_burst_levels = {
 	.cb = 40,	.cr = 40,
 };
 
+struct color_gains ntsc_color_gains = {
+	.cb = 160,	.cr = 160,
+};
+
 struct color_gains pal_color_gains = {
 	.cb = 224,	.cr = 224,
 };
 
+struct resync_parameters ntsc_resync_parameters = {
+	.field = false,	.line = 14,	.pixel = 12,
+};
+
 struct resync_parameters pal_resync_parameters = {
 	.field = true,	.line = 13,	.pixel = 12,
 };
 
 struct tv_mode tv_modes[] = {
 	{
+		.name		= "NTSC",
+		.mode		= SUN4I_TVE_CFG0_RES_480i,
+		.chroma_freq	= 0x21f07c1f,
+		.yc_en		= true,
+		.dac3_en	= true,
+		.dac_bit25_en	= true,
+
+		.back_porch	= 118,
+		.front_porch	= 32,
+		.line_number	= 525,
+
+		.hdisplay	= 720,
+		.hfront_porch	= 18,
+		.hsync_len	= 2,
+		.hback_porch	= 118,
+
+		.vdisplay	= 480,
+		.vfront_porch	= 26,
+		.vsync_len	= 2,
+		.vback_porch	= 17,
+
+		.vblank_level	= 240,
+
+		.color_gains	= &ntsc_color_gains,
+		.burst_levels	= &ntsc_burst_levels,
+		.video_levels	= &ntsc_video_levels,
+		.resync_params	= &ntsc_resync_parameters,
+	},
+	{
 		.name		= "PAL",
 		.mode		= SUN4I_TVE_CFG0_RES_576i,
 		.chroma_freq	= 0x2a098acb,
-- 
2.6.2
