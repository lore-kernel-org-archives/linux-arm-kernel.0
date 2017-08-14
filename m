From: bhumirks@gmail.com (Bhumika Goyal)
Date: Mon, 14 Aug 2017 17:08:43 +0530
Subject: [PATCH 04/11] ASoC: nuc900: make snd_soc_platform_driver const
In-Reply-To: <1502710730-18912-1-git-send-email-bhumirks@gmail.com>
References: <1502710730-18912-1-git-send-email-bhumirks@gmail.com>
Message-ID: <1502710730-18912-5-git-send-email-bhumirks@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make this const as it is only passed as the 2nd argument to the
function devm_snd_soc_register_platform, which is of type const.
Done using Coccinelle

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 sound/soc/nuc900/nuc900-pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/nuc900/nuc900-pcm.c b/sound/soc/nuc900/nuc900-pcm.c
index 2cca055..cd0486c 100644
--- a/sound/soc/nuc900/nuc900-pcm.c
+++ b/sound/soc/nuc900/nuc900-pcm.c
@@ -299,7 +299,7 @@ static int nuc900_dma_new(struct snd_soc_pcm_runtime *rtd)
 	return 0;
 }
 
-static struct snd_soc_platform_driver nuc900_soc_platform = {
+static const struct snd_soc_platform_driver nuc900_soc_platform = {
 	.ops		= &nuc900_dma_ops,
 	.pcm_new	= nuc900_dma_new,
 };
-- 
1.9.1
