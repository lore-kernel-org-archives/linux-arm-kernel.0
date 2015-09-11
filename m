From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 11 Sep 2015 15:26:34 +0200
Subject: [PATCH 1/4] clk: sunxi: Add A33 gates support
In-Reply-To: <1441977997-29041-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1441977997-29041-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1441977997-29041-2-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A33 gates are different from the A23 ones, add a new hook to simple
gates to handle this clock

Reported-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/clk/sunxi/clk-simple-gates.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/sunxi/clk-simple-gates.c b/drivers/clk/sunxi/clk-simple-gates.c
index 6ce91180da1b..0214c6548afd 100644
--- a/drivers/clk/sunxi/clk-simple-gates.c
+++ b/drivers/clk/sunxi/clk-simple-gates.c
@@ -128,6 +128,8 @@ CLK_OF_DECLARE(sun8i_a23_apb1, "allwinner,sun8i-a23-apb1-gates-clk",
 	       sunxi_simple_gates_init);
 CLK_OF_DECLARE(sun8i_a23_apb2, "allwinner,sun8i-a23-apb2-gates-clk",
 	       sunxi_simple_gates_init);
+CLK_OF_DECLARE(sun8i_a33_ahb1, "allwinner,sun8i-a33-ahb1-gates-clk",
+	       sunxi_simple_gates_init);
 CLK_OF_DECLARE(sun9i_a80_ahb0, "allwinner,sun9i-a80-ahb0-gates-clk",
 	       sunxi_simple_gates_init);
 CLK_OF_DECLARE(sun9i_a80_ahb1, "allwinner,sun9i-a80-ahb1-gates-clk",
-- 
2.5.1
