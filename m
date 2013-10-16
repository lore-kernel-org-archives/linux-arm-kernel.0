From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 16 Oct 2013 21:58:29 +0530
Subject: [PATCH 11/28] dmaengine: imx-sdma: use DMA_COMPLETE for dma
 completion status
In-Reply-To: <1381940926-25564-1-git-send-email-vinod.koul@intel.com>
References: <1381940926-25564-1-git-send-email-vinod.koul@intel.com>
Message-ID: <1381940926-25564-12-git-send-email-vinod.koul@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
CC: Acked-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/dma/imx-sdma.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index fc43603..0e03b31 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -638,7 +638,7 @@ static void mxc_sdma_handle_channel_normal(struct sdma_channel *sdmac)
 	if (error)
 		sdmac->status = DMA_ERROR;
 	else
-		sdmac->status = DMA_SUCCESS;
+		sdmac->status = DMA_COMPLETE;
 
 	dma_cookie_complete(&sdmac->desc);
 	if (sdmac->desc.callback)
-- 
1.7.0.4
