From: zhangfei.gao@marvell.com (Zhangfei Gao)
Date: Fri, 20 Jul 2012 13:46:04 +0800
Subject: [PATCH 3/3] dmatest: add dmaengine_slave_config for DMA_MEMCPY
In-Reply-To: <1342763164-19208-1-git-send-email-zhangfei.gao@marvell.com>
References: <1342763164-19208-1-git-send-email-zhangfei.gao@marvell.com>
Message-ID: <1342763164-19208-4-git-send-email-zhangfei.gao@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Set direction to DMA_MEM_TO_MEM
DMA driver may require such configure info

Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
---
 drivers/dma/dmatest.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
index 24225f0..73bab68 100644
--- a/drivers/dma/dmatest.c
+++ b/drivers/dma/dmatest.c
@@ -261,6 +261,9 @@ static int dmatest_func(void *data)
 	int			src_cnt;
 	int			dst_cnt;
 	int			i;
+	struct dma_slave_config conf = {
+		.direction = DMA_MEM_TO_MEM,
+	};
 
 	thread_name = current->comm;
 	set_freezable();
@@ -361,6 +364,7 @@ static int dmatest_func(void *data)
 						     DMA_BIDIRECTIONAL);
 		}
 
+		dmaengine_slave_config(chan, &conf);
 
 		if (thread->type == DMA_MEMCPY)
 			tx = dev->device_prep_dma_memcpy(chan,
-- 
1.7.1
