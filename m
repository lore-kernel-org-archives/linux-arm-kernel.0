From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Fri,  1 Dec 2017 07:05:24 +0100
Subject: [PATCH v2 01/27] drm/sun4i: Fix format mask in DE2 driver
In-Reply-To: <20171201060550.10392-1-jernej.skrabec@siol.net>
References: <20171201060550.10392-1-jernej.skrabec@siol.net>
Message-ID: <20171201060550.10392-2-jernej.skrabec@siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Format mask is one bit too short. Fix it.

Fixes: 9d75b8c0b999 (drm/sun4i: add support for Allwinner DE2 mixers)

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun8i_mixer.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.h b/drivers/gpu/drm/sun4i/sun8i_mixer.h
index 4785ac090b8c..c142fbb8661e 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.h
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.h
@@ -80,7 +80,7 @@
 
 #define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_EN		BIT(0)
 #define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_MODE_MASK	GENMASK(2, 1)
-#define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_FBFMT_MASK	GENMASK(11, 8)
+#define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_FBFMT_MASK	GENMASK(12, 8)
 #define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_MASK	GENMASK(31, 24)
 #define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_MODE_DEF	(1 << 1)
 #define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_FBFMT_ARGB8888	(0 << 8)
-- 
2.15.1
