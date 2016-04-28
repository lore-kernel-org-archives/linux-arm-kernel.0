From: moinejf@free.fr (Jean-Francois Moine)
Date: Thu, 28 Apr 2016 17:09:14 +0200
Subject: [PATCH v6 2/3] dmaengine: sun6i: Remove useless check
In-Reply-To: <cover.1461856751.git.moinejf@free.fr>
References: <cover.1461856751.git.moinejf@free.fr>
Message-ID: <863fcb55cd4c528f589b80307a9b76b0a7e1b64f.1461856751.git.moinejf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The transfer direction is now checked in set_config.
There is no need to check it twice.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 drivers/dma/sun6i-dma.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index cd436c6..80e426d 100644
--- a/drivers/dma/sun6i-dma.c
+++ b/drivers/dma/sun6i-dma.c
@@ -585,11 +585,6 @@ static struct dma_async_tx_descriptor *sun6i_dma_prep_slave_sg(
 	if (!sgl)
 		return NULL;
 
-	if (!is_slave_direction(dir)) {
-		dev_err(chan2dev(chan), "Invalid DMA direction\n");
-		return NULL;
-	}
-
 	ret = set_config(sdev, sconfig, dir, &lli_cfg);
 	if (ret) {
 		dev_err(chan2dev(chan), "Invalid DMA configuration\n");
-- 
2.8.1
