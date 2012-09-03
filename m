From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 03 Sep 2012 17:59:33 +0100
Subject: [RFC 2/3] Fix "ASoC: dmaengine: Don't use runtime private data for
 dmaengine data"
In-Reply-To: <20120903165832.GA31511@n2100.arm.linux.org.uk>
References: <20120903165832.GA31511@n2100.arm.linux.org.uk>
Message-ID: <E1T8Zzp-0002vv-7e@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The above commit was not initializing the correct substream runtime
member with the ASoC DMA engine runtime data.  Fix that.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 sound/soc/soc-dmaengine-pcm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/soc-dmaengine-pcm.c b/sound/soc/soc-dmaengine-pcm.c
index 27fa5ad..6fb9a2a 100644
--- a/sound/soc/soc-dmaengine-pcm.c
+++ b/sound/soc/soc-dmaengine-pcm.c
@@ -293,7 +293,7 @@ int snd_dmaengine_pcm_open(struct snd_pcm_substream *substream,
 		return ret;
 	}
 
-	substream->runtime->private_data = prtd;
+	substream->runtime->dmaengine_data = prtd;
 
 	return 0;
 }
-- 
1.7.4.4
