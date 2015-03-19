From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 20 Mar 2015 01:19:07 +0800
Subject: [PATCH 5/6] clk: sunxi: Add pll6 / 4 clock output to sun4i-a10-pll6
In-Reply-To: <1426785548-5932-1-git-send-email-wens@csie.org>
References: <1426785548-5932-1-git-send-email-wens@csie.org>
Message-ID: <1426785548-5932-6-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pll6 has a /4 output that is used as an input to the ahb mux clock.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clk/sunxi/clk-sunxi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index d28acdde364e..6e0908e3fd33 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -1082,11 +1082,12 @@ static const struct divs_data pll5_divs_data __initconst = {
 
 static const struct divs_data pll6_divs_data __initconst = {
 	.factors = &sun4i_pll6_data,
-	.ndivs = 3,
+	.ndivs = 4,
 	.div = {
 		{ .shift = 0, .table = pll6_sata_tbl, .gate = 14 }, /* M, SATA */
 		{ .fixed = 2 }, /* P, other */
 		{ .parent = 1 }, /* parent, 2x */
+		{ .fixed = 4 }, /* pll6 / 4, used as ahb input */
 	}
 };
 
-- 
2.1.4
