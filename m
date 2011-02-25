From: eric@eukrea.com (=?UTF-8?q?Eric=20B=C3=A9nard?=)
Date: Fri, 25 Feb 2011 13:47:46 +0100
Subject: [PATCH] eukrea-tlv320: fix platform_name
Message-ID: <1298638066-4049-1-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit f0fba2ad1b6b53d5360125c41953b7afcd6deff0 included a mistake
on the name of the platform in the snd_soc_dai_link structure.

Signed-off-by: Eric B?nard <eric@eukrea.com>
---
 sound/soc/imx/eukrea-tlv320.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/imx/eukrea-tlv320.c b/sound/soc/imx/eukrea-tlv320.c
index e20c9e1..1e9bcca 100644
--- a/sound/soc/imx/eukrea-tlv320.c
+++ b/sound/soc/imx/eukrea-tlv320.c
@@ -79,7 +79,7 @@ static struct snd_soc_dai_link eukrea_tlv320_dai = {
 	.name		= "tlv320aic23",
 	.stream_name	= "TLV320AIC23",
 	.codec_dai_name	= "tlv320aic23-hifi",
-	.platform_name	= "imx-pcm-audio.0",
+	.platform_name	= "imx-fiq-pcm-audio.0",
 	.codec_name	= "tlv320aic23-codec.0-001a",
 	.cpu_dai_name	= "imx-ssi.0",
 	.ops		= &eukrea_tlv320_snd_ops,
-- 
1.7.4
