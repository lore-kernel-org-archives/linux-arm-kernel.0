From: mpa@pengutronix.de (Markus Pargmann)
Date: Sun, 14 Apr 2013 13:42:48 +0200
Subject: [PATCH v3 04/15] ASoC: dmaengine-pcm: Fix pcm_request_chan function
 name
In-Reply-To: <1365939779-4507-1-git-send-email-mpa@pengutronix.de>
References: <1365939779-4507-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1365939779-4507-5-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Pargmann <mpa@pengutrnoix.de>

dmaengine_pcm.c implements snd_dmaengine_pcm_request_channel. This
function fixes all function calls to the shorter
snd_dmaengine_pcm_request_chan.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 include/sound/dmaengine_pcm.h         | 2 +-
 sound/soc/soc-generic-dmaengine-pcm.c | 2 +-
 sound/soc/spear/spear_pcm.c           | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/sound/dmaengine_pcm.h b/include/sound/dmaengine_pcm.h
index b346098..b7dbec0 100644
--- a/include/sound/dmaengine_pcm.h
+++ b/include/sound/dmaengine_pcm.h
@@ -47,7 +47,7 @@ int snd_dmaengine_pcm_open_request_chan(struct snd_pcm_substream *substream,
 	dma_filter_fn filter_fn, void *filter_data);
 int snd_dmaengine_pcm_close_release_chan(struct snd_pcm_substream *substream);
 
-struct dma_chan *snd_dmaengine_pcm_request_chan(dma_filter_fn filter_fn,
+struct dma_chan *snd_dmaengine_pcm_request_channel(dma_filter_fn filter_fn,
 	void *filter_data);
 struct dma_chan *snd_dmaengine_pcm_get_chan(struct snd_pcm_substream *substream);
 
diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
index f752577..9480087 100644
--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -117,7 +117,7 @@ static struct dma_chan *dmaengine_pcm_compat_request_channel(
 	if (pcm->config->compat_request_channel)
 	    return pcm->config->compat_request_channel(rtd, substream);
 
-	return snd_dmaengine_pcm_request_chan(pcm->config->compat_filter_fn,
+	return snd_dmaengine_pcm_request_channel(pcm->config->compat_filter_fn,
 		snd_soc_dai_get_dma_data(rtd->cpu_dai, substream));
 }
 
diff --git a/sound/soc/spear/spear_pcm.c b/sound/soc/spear/spear_pcm.c
index a8222ae..10fc7c9 100644
--- a/sound/soc/spear/spear_pcm.c
+++ b/sound/soc/spear/spear_pcm.c
@@ -38,7 +38,7 @@ static struct dma_chan *spear_pcm_request_chan(struct snd_soc_pcm_runtime *rtd,
 
 	dma_data = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
 
-	return snd_dmaengine_pcm_request_chan(dma_data->filter, dma_data);
+	return snd_dmaengine_pcm_request_channel(dma_data->filter, dma_data);
 }
 
 static const struct snd_dmaengine_pcm_config spear_dmaengine_pcm_config = {
-- 
1.8.1.5
