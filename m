From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Thu, 28 Jan 2016 14:25:32 -0700
Subject: [PATCH net-next 08/40] net: fec: move cbd_bufaddr assignment closer
 to the mapping function
In-Reply-To: <1454016364-30985-1-git-send-email-troy.kisky@boundarydevices.com>
References: <1454016364-30985-1-git-send-email-troy.kisky@boundarydevices.com>
Message-ID: <1454016364-30985-9-git-send-email-troy.kisky@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index b87f80d..15a93f90 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -476,6 +476,8 @@ static int fec_enet_txq_submit_skb(struct fec_enet_priv_tx_q *txq,
 				estatus |= BD_ENET_TX_TS;
 		}
 	}
+	bdp->cbd_bufaddr = addr;
+	bdp->cbd_datlen = buflen;
 
 	if (fep->bufdesc_ex) {
 
@@ -499,8 +501,6 @@ static int fec_enet_txq_submit_skb(struct fec_enet_priv_tx_q *txq,
 	/* Save skb pointer */
 	txq->tx_skbuff[index] = skb;
 
-	bdp->cbd_datlen = buflen;
-	bdp->cbd_bufaddr = addr;
 	/* Make sure the updates to rest of the descriptor are performed before
 	 * transferring ownership.
 	 */
-- 
2.5.0
