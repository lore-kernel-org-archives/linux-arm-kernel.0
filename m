From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 16 Oct 2013 21:58:25 +0530
Subject: [PATCH 07/28] dmaengine: dmatest: use DMA_COMPLETE for dma completion
 status
In-Reply-To: <1381940926-25564-1-git-send-email-vinod.koul@intel.com>
References: <1381940926-25564-1-git-send-email-vinod.koul@intel.com>
Message-ID: <1381940926-25564-8-git-send-email-vinod.koul@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 drivers/dma/dmatest.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
index 92f796c..59e287f 100644
--- a/drivers/dma/dmatest.c
+++ b/drivers/dma/dmatest.c
@@ -740,7 +740,7 @@ static int dmatest_func(void *data)
 					  len, 0);
 			failed_tests++;
 			continue;
-		} else if (status != DMA_SUCCESS) {
+		} else if (status != DMA_COMPLETE) {
 			enum dmatest_error_type type = (status == DMA_ERROR) ?
 				DMATEST_ET_DMA_ERROR : DMATEST_ET_DMA_IN_PROGRESS;
 			thread_result_add(info, result, type,
-- 
1.7.0.4
