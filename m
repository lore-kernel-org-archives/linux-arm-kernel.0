From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Mon, 30 Jun 2014 09:56:35 -0700
Subject: [PATCH 3/4] net: macb: Use clk_find_nearest_rate() API
In-Reply-To: <1404147396-8041-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1404147396-8041-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <1404147396-8041-4-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Ethernet clock has to match the specified frequencies as accurately
as possible. clk_round_rate() does not specify how rounding is
implemented. Hence use clk_find_nearest_rate().

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---

 drivers/net/ethernet/cadence/macb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cadence/macb.c b/drivers/net/ethernet/cadence/macb.c
index e9daa072ebb4..7b7f5eb1b341 100644
--- a/drivers/net/ethernet/cadence/macb.c
+++ b/drivers/net/ethernet/cadence/macb.c
@@ -223,7 +223,7 @@ static void macb_set_tx_clk(struct clk *clk, int speed, struct net_device *dev)
 		return;
 	}
 
-	rate_rounded = clk_round_rate(clk, rate);
+	rate_rounded = clk_find_nearest_rate(clk, rate);
 	if (rate_rounded < 0)
 		return;
 
-- 
2.0.1.1.gfbfc394
