From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 23 May 2014 15:51:06 +0800
Subject: [PATCH 03/22] clk: sunxi: add "pll6" to sun6i protected clock list
In-Reply-To: <1400831485-28576-1-git-send-email-wens@csie.org>
References: <1400831485-28576-1-git-send-email-wens@csie.org>
Message-ID: <1400831485-28576-4-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PLL6 is used by some important but undocumented module, most likely
memory related, such as mbus or the actual memory controller. As we
do not have a driver for that, add pll6 to the list of protected
clocks, so that it won't be disabled and leave us with a non-responsive
system.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clk/sunxi/clk-sunxi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index e0e24d5..3e33bc1 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -1229,6 +1229,7 @@ CLK_OF_DECLARE(sun7i_a20_clk_init, "allwinner,sun7i-a20", sun5i_init_clocks);
 
 static const char *sun6i_critical_clocks[] __initdata = {
 	"cpu",
+	"pll6", /* something we don't know about uses pll6 */
 	"ahb1_sdram",
 };
 
-- 
2.0.0.rc2
