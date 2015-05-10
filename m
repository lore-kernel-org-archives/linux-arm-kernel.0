From: vishnupatekar0510@gmail.com (Vishnu Patekar)
Date: Sun, 10 May 2015 12:16:20 +0530
Subject: [PATCH 3/6] clk: sunxi: Add A33 clock for compilation
In-Reply-To: <1431240383-12763-1-git-send-email-vishnupatekar0510@gmail.com>
References: <1431240383-12763-1-git-send-email-vishnupatekar0510@gmail.com>
Message-ID: <1431240383-12763-4-git-send-email-vishnupatekar0510@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A33 clock control unit is similar to A23.

A33 specific clocks are not yet implemented, added CLK_OF_DECLARE
to get it compiled for A33.

Signed-off-by: VishnuPatekar <vishnupatekar0510@gmail.com>
---
 drivers/clk/sunxi/clk-sunxi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index 7e1e2bd..6d25e4e 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -1389,6 +1389,7 @@ static void __init sun6i_init_clocks(struct device_node *node)
 CLK_OF_DECLARE(sun6i_a31_clk_init, "allwinner,sun6i-a31", sun6i_init_clocks);
 CLK_OF_DECLARE(sun6i_a31s_clk_init, "allwinner,sun6i-a31s", sun6i_init_clocks);
 CLK_OF_DECLARE(sun8i_a23_clk_init, "allwinner,sun8i-a23", sun6i_init_clocks);
+CLK_OF_DECLARE(sun8i_a33_clk_init, "allwinner,sun8i-a33", sun6i_init_clocks);
 
 static void __init sun9i_init_clocks(struct device_node *node)
 {
-- 
1.9.1
