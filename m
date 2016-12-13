From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Tue, 13 Dec 2016 23:22:48 +0800
Subject: [PATCH 2/6] clk: sunxi-ng: set the parent rate when adjustin CPUX
 clock on A33
In-Reply-To: <20161213152252.53749-1-icenowy@aosc.xyz>
References: <20161213152252.53749-1-icenowy@aosc.xyz>
Message-ID: <20161213152252.53749-3-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CPUX clock on A33, which is for the Cortex-A7 cores, is designed to
be changeable by changing the rate of PLL_CPUX.

Add CLK_SET_RATE_PARENT flag to this clock.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
 drivers/clk/sunxi-ng/ccu-sun8i-a33.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-a33.c b/drivers/clk/sunxi-ng/ccu-sun8i-a33.c
index 0f3e7d2dc19a..0d513d2674cb 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-a33.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-a33.c
@@ -170,7 +170,7 @@ static SUNXI_CCU_N_WITH_GATE_LOCK(pll_ddr1_clk, "pll-ddr1",
 static const char * const cpux_parents[] = { "osc32k", "osc24M",
 					     "pll-cpux" , "pll-cpux" };
 static SUNXI_CCU_MUX(cpux_clk, "cpux", cpux_parents,
-		     0x050, 16, 2, CLK_IS_CRITICAL);
+		     0x050, 16, 2, CLK_IS_CRITICAL | CLK_SET_RATE_PARENT);
 
 static SUNXI_CCU_M(axi_clk, "axi", "cpux", 0x050, 0, 2, 0);
 
-- 
2.11.0
