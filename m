From: mpa@pengutronix.de (Markus Pargmann)
Date: Sun, 10 Mar 2013 19:33:06 +0100
Subject: [PATCH 05/10] ASoC: pcm030 audio fabric: remove __init from probe
In-Reply-To: <1362940391-8338-1-git-send-email-mpa@pengutronix.de>
References: <1362940391-8338-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1362940391-8338-6-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove probe function from the init section.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 sound/soc/fsl/pcm030-audio-fabric.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/pcm030-audio-fabric.c b/sound/soc/fsl/pcm030-audio-fabric.c
index 8e52c14..eb43738 100644
--- a/sound/soc/fsl/pcm030-audio-fabric.c
+++ b/sound/soc/fsl/pcm030-audio-fabric.c
@@ -51,7 +51,7 @@ static struct snd_soc_card pcm030_card = {
 	.num_links = ARRAY_SIZE(pcm030_fabric_dai),
 };
 
-static int __init pcm030_fabric_probe(struct platform_device *op)
+static int pcm030_fabric_probe(struct platform_device *op)
 {
 	struct device_node *np = op->dev.of_node;
 	struct device_node *platform_np;
-- 
1.8.1.5
