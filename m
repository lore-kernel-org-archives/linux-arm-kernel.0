From: lee.jones@linaro.org (Lee Jones)
Date: Tue,  9 Jul 2013 15:37:55 +0100
Subject: [PATCH 2/3] DMA: shdma: shdma_chan_filter() has to be in shdma-base.h
In-Reply-To: <1373380677-450-1-git-send-email-lee.jones@linaro.org>
References: <1373380677-450-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1373380677-450-3-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

shdma_chan_filter() is a function, provided by the shdma-base.c module,
move its declaration to the appropriate header.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 include/linux/sh_dma.h     |    2 --
 include/linux/shdma-base.h |    1 +
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/sh_dma.h b/include/linux/sh_dma.h
index b64d6be..4e83f3e 100644
--- a/include/linux/sh_dma.h
+++ b/include/linux/sh_dma.h
@@ -99,6 +99,4 @@ struct sh_dmae_pdata {
 #define CHCR_TE	0x00000002
 #define CHCR_IE	0x00000004
 
-bool shdma_chan_filter(struct dma_chan *chan, void *arg);
-
 #endif
diff --git a/include/linux/shdma-base.h b/include/linux/shdma-base.h
index a3728bf..9a93897 100644
--- a/include/linux/shdma-base.h
+++ b/include/linux/shdma-base.h
@@ -122,5 +122,6 @@ void shdma_chan_remove(struct shdma_chan *schan);
 int shdma_init(struct device *dev, struct shdma_dev *sdev,
 		    int chan_num);
 void shdma_cleanup(struct shdma_dev *sdev);
+bool shdma_chan_filter(struct dma_chan *chan, void *arg);
 
 #endif
-- 
1.7.10.4
