From: tushar.behera@linaro.org (Tushar Behera)
Date: Wed, 29 Aug 2012 10:16:25 +0530
Subject: [PATCH 2/2] DMA: PL330: Set the capability of pdm0 and pdm1 as
 DMA_PRIVATE
In-Reply-To: <1346215585-31023-1-git-send-email-tushar.behera@linaro.org>
References: <1346215585-31023-1-git-send-email-tushar.behera@linaro.org>
Message-ID: <1346215585-31023-3-git-send-email-tushar.behera@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DMA clients pdma0 and pdma1 are internal to the SoC and are used only
by dedicated peripherals. Since they cannot be used for generic
purpose, their capability should be set as DMA_PRIVATE.

CC: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
---
 drivers/dma/pl330.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index e4feba6..600ea5e 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -2954,6 +2954,7 @@ pl330_probe(struct amba_device *adev, const struct amba_id *id)
 		if (pi->pcfg.num_peri) {
 			dma_cap_set(DMA_SLAVE, pd->cap_mask);
 			dma_cap_set(DMA_CYCLIC, pd->cap_mask);
+			dma_cap_set(DMA_PRIVATE, pd->cap_mask);
 		}
 	}
 
-- 
1.7.4.1
