From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 22 Apr 2011 19:41:59 +0200
Subject: [PATCH v2 3/5] dmaengine: at_hdmac: debug information sg_len for
	prep_slave_sg
In-Reply-To: <3ee5a0e314a22339ad7a15a5425045f5ed244eab.1301678094.git.nicolas.ferre@atmel.com>
References: <3ee5a0e314a22339ad7a15a5425045f5ed244eab.1301678094.git.nicolas.ferre@atmel.com>
Message-ID: <5c1f9b7a5843b1e476a3f3e98d4e8d2fa6065f16.1303493836.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/dma/at_hdmac.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index ed9d924..8f50a0f 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -687,7 +687,8 @@ atc_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 	struct scatterlist	*sg;
 	size_t			total_len = 0;
 
-	dev_vdbg(chan2dev(chan), "prep_slave_sg: %s f0x%lx\n",
+	dev_vdbg(chan2dev(chan), "prep_slave_sg (%d): %s f0x%lx\n",
+			sg_len,
 			direction == DMA_TO_DEVICE ? "TO DEVICE" : "FROM DEVICE",
 			flags);
 
-- 
1.7.3
