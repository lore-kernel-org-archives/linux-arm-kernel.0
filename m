From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 12 Dec 2016 09:00:53 +0100
Subject: [PATCH] clk: bcm: Fix 'maybe-uninitialized' warning in
 bcm2835_clock_choose_div_and_prate()
Message-ID: <1481529653-28133-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

best_rate is reported as potentially uninitialized by gcc.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Fixes: 155e8b3b0ee3 ("clk: bcm: Support rate change propagation on bcm2835 clocks")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/clk/bcm/clk-bcm2835.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
index eaf82f49dede..0d14409097e7 100644
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -1029,7 +1029,7 @@ static unsigned long bcm2835_clock_choose_div_and_prate(struct clk_hw *hw,
 	struct bcm2835_clock *clock = bcm2835_clock_from_hw(hw);
 	struct bcm2835_cprman *cprman = clock->cprman;
 	const struct bcm2835_clock_data *data = clock->data;
-	unsigned long best_rate;
+	unsigned long best_rate = 0;
 	u32 curdiv, mindiv, maxdiv;
 	struct clk_hw *parent;
 
-- 
2.7.4
