From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 30 Oct 2012 11:17:57 +0100
Subject: [PATCH v3 05/10] net/macb: tx status is more than 8 bits now
In-Reply-To: <cover.1351591858.git.nicolas.ferre@atmel.com>
References: <cover.1351591858.git.nicolas.ferre@atmel.com>
Message-ID: <8c3727fd87fe9bd595d9e44a89982d5761166922.1351591858.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On some revision of GEM, TSR status register has more information.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/net/ethernet/cadence/macb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cadence/macb.c b/drivers/net/ethernet/cadence/macb.c
index 4db52f3..cd6d431 100644
--- a/drivers/net/ethernet/cadence/macb.c
+++ b/drivers/net/ethernet/cadence/macb.c
@@ -314,7 +314,7 @@ static void macb_tx(struct macb *bp)
 	status = macb_readl(bp, TSR);
 	macb_writel(bp, TSR, status);
 
-	netdev_vdbg(bp->dev, "macb_tx status = %02lx\n", (unsigned long)status);
+	netdev_vdbg(bp->dev, "macb_tx status = 0x%03lx\n", (unsigned long)status);
 
 	if (status & (MACB_BIT(UND) | MACB_BIT(TSR_RLE))) {
 		int i;
-- 
1.8.0
