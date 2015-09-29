From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 29 Sep 2015 21:43:18 +0200
Subject: [PATCH 2/2] ASoC: sun4i-codec: Remove redundant SND_PCM_RATE_KNOT
In-Reply-To: <1443555798-16001-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1443555798-16001-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1443555798-16001-2-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SND_PCM_RATE_KNOT covers all the rate settings, even though some that
we don't support, while we also list all the rate we support. Simply remove
it.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 sound/soc/sunxi/sun4i-codec.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index 28834129bea3..e5d195fe491e 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -389,8 +389,7 @@ static struct snd_soc_dai_driver sun4i_codec_dai = {
 		.rate_max	= 192000,
 		.rates		= SNDRV_PCM_RATE_8000_48000 |
 				  SNDRV_PCM_RATE_96000 |
-				  SNDRV_PCM_RATE_192000 |
-				  SNDRV_PCM_RATE_KNOT,
+				  SNDRV_PCM_RATE_192000,
 		.formats	= SNDRV_PCM_FMTBIT_S16_LE |
 				  SNDRV_PCM_FMTBIT_S32_LE,
 		.sig_bits	= 24,
-- 
2.5.3
