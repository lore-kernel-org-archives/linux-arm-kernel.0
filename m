From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon,  9 Jan 2012 10:32:48 +0100
Subject: [PATCH 2/4] ASoC: i.MX: Add missing dma_async_issue_pending
In-Reply-To: <1326101570-3716-1-git-send-email-s.hauer@pengutronix.de>
References: <1326101570-3716-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1326101570-3716-3-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 sound/soc/imx/imx-pcm-dma-mx2.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/imx/imx-pcm-dma-mx2.c b/sound/soc/imx/imx-pcm-dma-mx2.c
index 43fdc24f..88aa95c 100644
--- a/sound/soc/imx/imx-pcm-dma-mx2.c
+++ b/sound/soc/imx/imx-pcm-dma-mx2.c
@@ -204,6 +204,7 @@ static int snd_imx_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 		dmaengine_submit(iprtd->desc);
+		dma_async_issue_pending(iprtd->dma_chan);
 
 		break;
 
-- 
1.7.7.3
