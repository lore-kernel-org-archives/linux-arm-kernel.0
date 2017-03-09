From: mylene.josserand@free-electrons.com (=?UTF-8?q?Myl=C3=A8ne=20Josserand?=)
Date: Thu,  9 Mar 2017 10:56:00 +0100
Subject: [PATCH v2 1/3] ASoC: sun8i-codec: Fix space on audio-routing widget
In-Reply-To: <20170309095602.13809-1-mylene.josserand@free-electrons.com>
References: <20170309095602.13809-1-mylene.josserand@free-electrons.com>
Message-ID: <20170309095602.13809-2-mylene.josserand@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

An unwanted space is present in an audio widget's name on the dapm
routing. It causes an error on the recognition of this widget (error:
("no dapm match for AIF1 Slot 0 Right").

Remove the space fixes it.

Signed-off-by: Myl?ne Josserand <mylene.josserand@free-electrons.com>
---
 sound/soc/sunxi/sun8i-codec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
index a75a983974d9..90cda9569503 100644
--- a/sound/soc/sunxi/sun8i-codec.c
+++ b/sound/soc/sunxi/sun8i-codec.c
@@ -335,7 +335,7 @@ static const struct snd_soc_dapm_route sun8i_codec_dapm_routes[] = {
 	/* DAC Mixer Routes */
 	{ "Left Digital DAC Mixer", "AIF1 Slot 0 Digital DAC Playback Switch",
 	  "Digital Left DAC"},
-	{ "Right Digital DAC Mixer", "AIF1 Slot 0 Digital DAC Playback Switch ",
+	{ "Right Digital DAC Mixer", "AIF1 Slot 0 Digital DAC Playback Switch",
 	  "Digital Right DAC"},
 };
 
-- 
2.11.0
