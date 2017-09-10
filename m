From: icenowy@aosc.io (Icenowy Zheng)
Date: Sun, 10 Sep 2017 20:40:06 +0800
Subject: [PATCH 2/2] clk: sunxi-ng: add CLK_SET_RATE_PARENT flag to H3 GPU
 clock
In-Reply-To: <20170910124006.60250-1-icenowy@aosc.io>
References: <20170910124006.60250-1-icenowy@aosc.io>
Message-ID: <20170910124006.60250-3-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GPU clock on H3 has only one parent, PLL-GPU, and the PLL is only
the parent of the GPU clock. The GPU clock can be tweaked by tweaking
the PLL-GPU clock.

Add CLK_SET_RATE_PARENT flag to allow tweaking the GPU clock via
tweaking PLL-CPU.

Fixes: 0577e4853bfb ("clk: sunxi-ng: Add H3 clocks")
Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 drivers/clk/sunxi-ng/ccu-sun8i-h3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-h3.c b/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
index 7a81c4885836..543c46d0e045 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
@@ -484,7 +484,7 @@ static SUNXI_CCU_M_WITH_MUX_GATE(mbus_clk, "mbus", mbus_parents,
 				 0x15c, 0, 3, 24, 2, BIT(31), CLK_IS_CRITICAL);
 
 static SUNXI_CCU_M_WITH_GATE(gpu_clk, "gpu", "pll-gpu",
-			     0x1a0, 0, 3, BIT(31), 0);
+			     0x1a0, 0, 3, BIT(31), CLK_SET_RATE_PARENT);
 
 static struct ccu_common *sun8i_h3_ccu_clks[] = {
 	&pll_cpux_clk.common,
-- 
2.13.5
