From: jagan@amarulasolutions.com (Jagan Teki)
Date: Fri, 26 Oct 2018 20:13:20 +0530
Subject: [PATCH v3 01/25] clk: sunxi-ng: a64: Fix gate bit of DSI DPHY
In-Reply-To: <20181026144344.27778-1-jagan@amarulasolutions.com>
References: <20181026144344.27778-1-jagan@amarulasolutions.com>
Message-ID: <20181026144344.27778-2-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DSI DPHY gate bit on MIPI DSI clock register is bit 15
not bit 30.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Acked-by: Stephen Boyd <sboyd@kernel.org>
Tested-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v3:
- collect Stephen Ack
- add tested credit
Changes for v2:
- none

 drivers/clk/sunxi-ng/ccu-sun50i-a64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
index f7d297368eb2..019d67bf97c4 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
@@ -581,7 +581,7 @@ static const char * const dsi_dphy_parents[] = { "pll-video0", "pll-periph0" };
 static const u8 dsi_dphy_table[] = { 0, 2, };
 static SUNXI_CCU_M_WITH_MUX_TABLE_GATE(dsi_dphy_clk, "dsi-dphy",
 				       dsi_dphy_parents, dsi_dphy_table,
-				       0x168, 0, 4, 8, 2, BIT(31), CLK_SET_RATE_PARENT);
+				       0x168, 0, 4, 8, 2, BIT(15), CLK_SET_RATE_PARENT);
 
 static SUNXI_CCU_M_WITH_GATE(gpu_clk, "gpu", "pll-gpu",
 			     0x1a0, 0, 3, BIT(31), CLK_SET_RATE_PARENT);
-- 
2.18.0.321.gffc6fa0e3
