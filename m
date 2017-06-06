From: ruxandra.radulescu@nxp.com (Ioana Radulescu)
Date: Tue, 6 Jun 2017 10:00:30 -0500
Subject: [PATCH 07/18] staging: fsl-dpaa2/eth: Don't use GFP_DMA
In-Reply-To: <20170606150041.10955-1-ruxandra.radulescu@nxp.com>
References: <20170606150041.10955-1-ruxandra.radulescu@nxp.com>
Message-ID: <20170606150041.10955-8-ruxandra.radulescu@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Don't use GFP_DMA when allocating memory for the hash key,
as we don't actually need to allocate from the lowest zone.

Signed-off-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>
---
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
index bf6f300affa7..57628cd3ecf2 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
@@ -1996,7 +1996,7 @@ static int dpaa2_eth_set_hash(struct net_device *net_dev, u64 flags)
 		priv->rx_hash_fields |= hash_fields[i].rxnfc_field;
 	}
 
-	dma_mem = kzalloc(DPAA2_CLASSIFIER_DMA_SIZE, GFP_DMA | GFP_KERNEL);
+	dma_mem = kzalloc(DPAA2_CLASSIFIER_DMA_SIZE, GFP_KERNEL);
 	if (!dma_mem)
 		return -ENOMEM;
 
-- 
2.11.0
