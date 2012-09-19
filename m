From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 19 Sep 2012 13:55:18 +0200
Subject: [PATCH v2 5/9] net/macb: tx status is more than 8 bits now
In-Reply-To: <cover.1348055112.git.nicolas.ferre@atmel.com>
References: <cover.1348055112.git.nicolas.ferre@atmel.com>
Message-ID: <bfe08a1f18b7f4bb248517e319b6c42f041f7351.1348055112.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On some revision of GEM, TSR status register has more information.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/net/ethernet/cadence/macb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cadence/macb.c b/drivers/net/ethernet/cadence/macb.c
index 31f945c..e98f6fc 100644
--- a/drivers/net/ethernet/cadence/macb.c
+++ b/drivers/net/ethernet/cadence/macb.c
@@ -310,7 +310,7 @@ static void macb_tx(struct macb *bp)
 	status = macb_readl(bp, TSR);
 	macb_writel(bp, TSR, status);
 
-	netdev_vdbg(bp->dev, "macb_tx status = %02lx\n", (unsigned long)status);
+	netdev_vdbg(bp->dev, "macb_tx status = 0x%03lx\n", (unsigned long)status);
 
 	if (status & (MACB_BIT(UND) | MACB_BIT(TSR_RLE))) {
 		int i;
-- 
1.7.11.3
