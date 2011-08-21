From: b29396@freescale.com (Dong Aisheng)
Date: Mon, 22 Aug 2011 00:02:46 +0800
Subject: [PATCH 2/2] ASoC: mxs-sgtl5000: add record function
Message-ID: <1313942566-21433-1-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Dong Aisheng <b29396@freescale.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lrg@ti.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Wolfram Sang <w.sang@pengutronix.de>
---
 sound/soc/mxs/mxs-sgtl5000.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/sound/soc/mxs/mxs-sgtl5000.c b/sound/soc/mxs/mxs-sgtl5000.c
index a0d89c9..7fbeaec 100644
--- a/sound/soc/mxs/mxs-sgtl5000.c
+++ b/sound/soc/mxs/mxs-sgtl5000.c
@@ -85,13 +85,21 @@ static struct snd_soc_ops mxs_sgtl5000_hifi_ops = {
 
 static struct snd_soc_dai_link mxs_sgtl5000_dai[] = {
 	{
-		.name		= "HiFi",
+		.name		= "HiFi Tx",
 		.stream_name	= "HiFi Playback",
 		.codec_dai_name	= "sgtl5000",
 		.codec_name	= "sgtl5000.0-000a",
 		.cpu_dai_name	= "mxs-saif.0",
 		.platform_name	= "mxs-pcm-audio.0",
 		.ops		= &mxs_sgtl5000_hifi_ops,
+	}, {
+		.name		= "HiFi Rx",
+		.stream_name	= "HiFi Capture",
+		.codec_dai_name	= "sgtl5000",
+		.codec_name	= "sgtl5000.0-000a",
+		.cpu_dai_name	= "mxs-saif.1",
+		.platform_name	= "mxs-pcm-audio.1",
+		.ops		= &mxs_sgtl5000_hifi_ops,
 	},
 };
 
-- 
1.7.0.4
