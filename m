From: bhumirks@gmail.com (Bhumika Goyal)
Date: Mon, 14 Aug 2017 17:08:44 +0530
Subject: [PATCH 05/11] ASoC: omap: make snd_soc_platform_driver const
In-Reply-To: <1502710730-18912-1-git-send-email-bhumirks@gmail.com>
References: <1502710730-18912-1-git-send-email-bhumirks@gmail.com>
Message-ID: <1502710730-18912-6-git-send-email-bhumirks@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make this const as it is only passed as the 2nd argument to the
function devm_snd_soc_register_platform, which is of type const.
Done using Coccinelle.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 sound/soc/omap/omap-pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
index 94e9ff7..1283473 100644
--- a/sound/soc/omap/omap-pcm.c
+++ b/sound/soc/omap/omap-pcm.c
@@ -243,7 +243,7 @@ static int omap_pcm_new(struct snd_soc_pcm_runtime *rtd)
 	return ret;
 }
 
-static struct snd_soc_platform_driver omap_soc_platform = {
+static const struct snd_soc_platform_driver omap_soc_platform = {
 	.ops		= &omap_pcm_ops,
 	.pcm_new	= omap_pcm_new,
 	.pcm_free	= omap_pcm_free_dma_buffers,
-- 
1.9.1
