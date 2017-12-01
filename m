From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Fri,  1 Dec 2017 07:05:27 +0100
Subject: [PATCH v2 04/27] drm/sun4i: Fix debug message in DE2
In-Reply-To: <20171201060550.10392-1-jernej.skrabec@siol.net>
References: <20171201060550.10392-1-jernej.skrabec@siol.net>
Message-ID: <20171201060550.10392-5-jernej.skrabec@siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Debug message would print "Enabling" even when disabling plane.

Fix it.

Fixes: 9d75b8c0b999 (drm/sun4i: add support for Allwinner DE2 mixers)

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun8i_mixer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
index d3dee6131209..b947ee2e4fe4 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -44,7 +44,8 @@ void sun8i_mixer_layer_enable(struct sun8i_mixer *mixer,
 	/* Currently the first UI channel is used */
 	int chan = mixer->cfg->vi_num;
 
-	DRM_DEBUG_DRIVER("Enabling layer %d in channel %d\n", layer, chan);
+	DRM_DEBUG_DRIVER("%sabling layer %d in channel %d\n",
+			 enable ? "En" : "Dis", layer, chan);
 
 	if (enable)
 		val = SUN8I_MIXER_CHAN_UI_LAYER_ATTR_EN;
-- 
2.15.1
