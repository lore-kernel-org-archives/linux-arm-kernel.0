From: wens@csie.org (Chen-Yu Tsai)
Date: Sun,  8 Jan 2017 02:57:06 +0800
Subject: [PATCH resend v3] ASoC: sun4i-codec: Add "Right Mixer" to "Line Out
 Mono Diff." route
Message-ID: <20170107185706.20413-1-wens@csie.org>
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
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---

Last sent 2016/11/24. Resending with Maxime's ack.

---
 sound/soc/sunxi/sun4i-codec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index 848af01692a0..c3aab10fa085 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -1058,6 +1058,7 @@ static const struct snd_soc_dapm_route sun6i_codec_codec_dapm_routes[] = {
 	{ "Line Out Source Playback Route", "Stereo", "Left Mixer" },
 	{ "Line Out Source Playback Route", "Stereo", "Right Mixer" },
 	{ "Line Out Source Playback Route", "Mono Differential", "Left Mixer" },
+	{ "Line Out Source Playback Route", "Mono Differential", "Right Mixer" },
 	{ "LINEOUT", NULL, "Line Out Source Playback Route" },
 
 	/* ADC Routes */
-- 
2.11.0
