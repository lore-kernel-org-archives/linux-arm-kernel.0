From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 31 Oct 2012 17:04:54 +0100
Subject: [PATCH v4 05/10] net/macb: tx status is more than 8 bits now
In-Reply-To: <cover.1351690694.git.nicolas.ferre@atmel.com>
References: <cover.1351690694.git.nicolas.ferre@atmel.com>
Message-ID: <76a3a1fb6ad2fbf5e4d8d447afe7cd5c0eb24b8b.1351690694.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On some revision of GEM, TSR status register has more information.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Tested-by: Joachim Eastwood <manabian@gmail.com>
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
