From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 25 Mar 2015 01:22:08 +0800
Subject: [PATCH v2 2/3] clk: sunxi: Add pll6 / 4 clock output to sun4i-a10-pll6
In-Reply-To: <1427217729-10017-1-git-send-email-wens@csie.org>
References: <1427217729-10017-1-git-send-email-wens@csie.org>
Message-ID: <1427217729-10017-3-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pll6 has a /4 output that is used as an input to the ahb mux clock.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clk/sunxi/clk-sunxi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index 9f31314a9cd7..7e1e2bd189b6 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -1088,11 +1088,12 @@ static const struct divs_data pll5_divs_data __initconst = {
 
 static const struct divs_data pll6_divs_data __initconst = {
 	.factors = &sun4i_pll6_data,
-	.ndivs = 3,
+	.ndivs = 4,
 	.div = {
 		{ .shift = 0, .table = pll6_sata_tbl, .gate = 14 }, /* M, SATA */
 		{ .fixed = 2 }, /* P, other */
 		{ .self = 1 }, /* base factor clock, 2x */
+		{ .fixed = 4 }, /* pll6 / 4, used as ahb input */
 	}
 };
 
-- 
2.1.4
