From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Fri,  1 Dec 2017 07:05:28 +0100
Subject: [PATCH v2 05/27] drm/sun4i: Remove setting default values in DE2
 driver
In-Reply-To: <20171201060550.10392-1-jernej.skrabec@siol.net>
References: <20171201060550.10392-1-jernej.skrabec@siol.net>
Message-ID: <20171201060550.10392-6-jernej.skrabec@siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Premultiply and color key control registers are already set to zero by
initialization code few lines above. Furthermore, it seems that
colorkeying doesn't really work. It's not used in BSP driver and
experiments with it all failed.

Just remove the code.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun8i_mixer.c | 4 ----
 drivers/gpu/drm/sun4i/sun8i_mixer.h | 2 --
 2 files changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
index b947ee2e4fe4..f4a7fa0ba7ad 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -320,14 +320,10 @@ static int sun8i_mixer_bind(struct device *dev, struct device *master,
 	/* Initialize blender */
 	regmap_write(mixer->engine.regs, SUN8I_MIXER_BLEND_FCOLOR_CTL,
 		     SUN8I_MIXER_BLEND_FCOLOR_CTL_DEF);
-	regmap_write(mixer->engine.regs, SUN8I_MIXER_BLEND_PREMULTIPLY,
-		     SUN8I_MIXER_BLEND_PREMULTIPLY_DEF);
 	regmap_write(mixer->engine.regs, SUN8I_MIXER_BLEND_BKCOLOR,
 		     SUN8I_MIXER_BLEND_BKCOLOR_DEF);
 	regmap_write(mixer->engine.regs, SUN8I_MIXER_BLEND_MODE(0),
 		     SUN8I_MIXER_BLEND_MODE_DEF);
-	regmap_write(mixer->engine.regs, SUN8I_MIXER_BLEND_CK_CTL,
-		     SUN8I_MIXER_BLEND_CK_CTL_DEF);
 
 	regmap_write(mixer->engine.regs,
 		     SUN8I_MIXER_BLEND_ATTR_FCOLOR(0),
diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.h b/drivers/gpu/drm/sun4i/sun8i_mixer.h
index a7fe013c1d4a..db005a4bca43 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.h
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.h
@@ -48,10 +48,8 @@
 /* The following numbers are some still unknown magic numbers */
 #define SUN8I_MIXER_BLEND_ATTR_FCOLOR_DEF	0xff000000
 #define SUN8I_MIXER_BLEND_FCOLOR_CTL_DEF	0x00000101
-#define SUN8I_MIXER_BLEND_PREMULTIPLY_DEF	0x0
 #define SUN8I_MIXER_BLEND_BKCOLOR_DEF		0xff000000
 #define SUN8I_MIXER_BLEND_MODE_DEF		0x03010301
-#define SUN8I_MIXER_BLEND_CK_CTL_DEF		0x0
 
 #define SUN8I_MIXER_BLEND_OUTCTL_INTERLACED	BIT(1)
 
-- 
2.15.1
