From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Thu, 11 Dec 2014 11:15:54 +0100
Subject: [PATCH 1/1] net/macb: fix compilation warning for print_hex_dump()
 called with skb->mac_header
Message-ID: <efa28485b430e77f5254248cb396da431d03fc5b.1418292741.git.cyrille.pitchen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
---
 drivers/net/ethernet/cadence/macb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cadence/macb.c b/drivers/net/ethernet/cadence/macb.c
index 41113e5..9ddc9bf 100644
--- a/drivers/net/ethernet/cadence/macb.c
+++ b/drivers/net/ethernet/cadence/macb.c
@@ -776,7 +776,7 @@ static int gem_rx(struct macb *bp, int budget)
 		netdev_vdbg(bp->dev, "received skb of length %u, csum: %08x\n",
 			    skb->len, skb->csum);
 		print_hex_dump(KERN_DEBUG, " mac: ", DUMP_PREFIX_ADDRESS, 16, 1,
-			       skb->mac_header, 16, true);
+			       skb_mac_header(skb), 16, true);
 		print_hex_dump(KERN_DEBUG, "data: ", DUMP_PREFIX_ADDRESS, 16, 1,
 			       skb->data, 32, true);
 #endif
-- 
1.8.2.2
