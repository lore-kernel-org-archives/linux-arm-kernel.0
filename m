From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 21 Dec 2016 12:16:12 +0100
Subject: [PATCH net-next 05/27] net: mvpp2: remove unused 'tx_skb' field of
 'struct mvpp2_tx_queue'
In-Reply-To: <1482318994-23488-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1482318994-23488-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1482318994-23488-6-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit remove a field of 'struct mvpp2_tx_queue' that is not used
anywhere.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/net/ethernet/marvell/mvpp2.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2.c b/drivers/net/ethernet/marvell/mvpp2.c
index 84eb5fb..fe854b3 100644
--- a/drivers/net/ethernet/marvell/mvpp2.c
+++ b/drivers/net/ethernet/marvell/mvpp2.c
@@ -823,9 +823,6 @@ struct mvpp2_tx_queue {
 	/* Per-CPU control of physical Tx queues */
 	struct mvpp2_txq_pcpu __percpu *pcpu;
 
-	/* Array of transmitted skb */
-	struct sk_buff **tx_skb;
-
 	u32 done_pkts_coal;
 
 	/* Virtual address of thex Tx DMA descriptors array */
-- 
2.7.4
