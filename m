From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 20 Mar 2015 01:19:04 +0800
Subject: [PATCH 2/6] clk: sunxi: Add "cpu" to list of protected clocks for
 sun5i
In-Reply-To: <1426785548-5932-1-git-send-email-wens@csie.org>
References: <1426785548-5932-1-git-send-email-wens@csie.org>
Message-ID: <1426785548-5932-3-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the ahb clock on sun5i/sun7i is muxable, ahb is no longer
guaranteed to be a child of the cpu clock. Add the cpu clock to
the list of protected clocks so it doesn't get disabled.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clk/sunxi/clk-sunxi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index ae7b1c4d6aae..7580a1bc88fd 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -1349,6 +1349,7 @@ static void __init sun4i_a10_init_clocks(struct device_node *node)
 CLK_OF_DECLARE(sun4i_a10_clk_init, "allwinner,sun4i-a10", sun4i_a10_init_clocks);
 
 static const char *sun5i_critical_clocks[] __initdata = {
+	"cpu",
 	"pll5_ddr",
 	"ahb_sdram",
 };
-- 
2.1.4
