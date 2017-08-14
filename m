From: bhumirks@gmail.com (Bhumika Goyal)
Date: Mon, 14 Aug 2017 17:08:47 +0530
Subject: [PATCH 08/11] ASoC: samsung: make snd_soc_platform_driver const
In-Reply-To: <1502710730-18912-1-git-send-email-bhumirks@gmail.com>
References: <1502710730-18912-1-git-send-email-bhumirks@gmail.com>
Message-ID: <1502710730-18912-9-git-send-email-bhumirks@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make this const as it is only passed as the 2nd argument to the function
devm_snd_soc_register_platform, which is of type const.
Done using Coccinelle.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 sound/soc/samsung/idma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/samsung/idma.c b/sound/soc/samsung/idma.c
index 3e40815..ee16e4c 100644
--- a/sound/soc/samsung/idma.c
+++ b/sound/soc/samsung/idma.c
@@ -399,7 +399,7 @@ void idma_reg_addr_init(void __iomem *regs, dma_addr_t addr)
 }
 EXPORT_SYMBOL_GPL(idma_reg_addr_init);
 
-static struct snd_soc_platform_driver asoc_idma_platform = {
+static const struct snd_soc_platform_driver asoc_idma_platform = {
 	.ops = &idma_ops,
 	.pcm_new = idma_new,
 	.pcm_free = idma_free,
-- 
1.9.1
