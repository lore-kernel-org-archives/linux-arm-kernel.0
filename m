From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 12 Jan 2011 15:39:07 +0100
Subject: [PATCH 3/6] dmaengine: at_hdmac: no need set ACK in new descriptor
In-Reply-To: <1292435416-16927-1-git-send-email-nicolas.ferre@atmel.com>
References: <1292435416-16927-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <1294843150-6962-2-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Following descriptor flow in at_hdmac driver, descriptor comming from
atc_desc_get() as already DMA_CTRL_ACK flag set. No need to set it again.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/dma/at_hdmac.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index a4dd4bc..4f83431 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -583,7 +583,6 @@ atc_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
 		desc->lli.ctrlb = ctrlb;
 
 		desc->txd.cookie = 0;
-		async_tx_ack(&desc->txd);
 
 		if (!first) {
 			first = desc;
-- 
1.7.3
