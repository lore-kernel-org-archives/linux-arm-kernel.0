From: wens@csie.org (Chen-Yu Tsai)
Date: Mon,  7 Nov 2016 18:07:00 +0800
Subject: [PATCH v3 3/6] ASoC: sun4i-codec: Add "Right Mixer" to "Line Out Mono
 Diff." route
In-Reply-To: <20161107100703.5586-1-wens@csie.org>
References: <20161107100703.5586-1-wens@csie.org>
Message-ID: <20161107100703.5586-4-wens@csie.org>
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
 sound/soc/sunxi/sun4i-codec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index 6379efd21f00..006ca3c17e80 100644
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
