From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 24 Nov 2016 19:46:49 +0800
Subject: [PATCH resend v3] ASoC: sun4i-codec: Add "Right Mixer" to "Line Out
 Mono Diff." route
Message-ID: <20161124114649.5188-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mono differential output for "Line Out" downmixes the stereo audio
from the mixer, instead of just taking the left channel.

Add a route from the "Right Mixer" to "Line Out Source Playback Route"
through the "Mono Differential" path, so DAPM doesn't shut down
everything if the left channel is muted.

Fixes: 0f909f98d7cb ("ASoC: sun4i-codec: Add support for A31 Line Out
		      playback")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

This patch seems to have fallen through the cracks.

---
 sound/soc/sunxi/sun4i-codec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index 092fdcf6de95..b11b0ad4dfbe 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -1047,6 +1047,7 @@ static const struct snd_soc_dapm_route sun6i_codec_codec_dapm_routes[] = {
 	{ "Line Out Source Playback Route", "Stereo", "Left Mixer" },
 	{ "Line Out Source Playback Route", "Stereo", "Right Mixer" },
 	{ "Line Out Source Playback Route", "Mono Differential", "Left Mixer" },
+	{ "Line Out Source Playback Route", "Mono Differential", "Right Mixer" },
 	{ "LINEOUT", NULL, "Line Out Source Playback Route" },
 
 	/* ADC Routes */
-- 
2.10.2
