From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri,  9 May 2014 22:33:41 -0500
Subject: [PATCH 6/6] clk: sun6i: Protect SDRAM gating bit
In-Reply-To: <1399692821-20988-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1399692821-20988-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1399692821-20988-7-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Prevent the SDRAM controller from being gated by force-enabling it in the
machine code.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/clk/sunxi/clk-sunxi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index fdb9cea60011..548f7113efa6 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -1185,6 +1185,7 @@ CLK_OF_DECLARE(sun7i_a20_clk_init, "allwinner,sun7i-a20", sun5i_init_clocks);
 
 static const char *sun6i_critical_clocks[] __initdata = {
 	"cpu",
+	"ahb1_sdram",
 };
 
 static void __init sun6i_init_clocks(void)
-- 
1.9.1
