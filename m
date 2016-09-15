From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 15 Sep 2016 14:57:40 +0800
Subject: [PATCH 3/3] clk: sunxi-ng: sun6i-a31: Fix register offset for
 mipi-csi clk
In-Reply-To: <20160915065740.13664-1-wens@csie.org>
References: <20160915065740.13664-1-wens@csie.org>
Message-ID: <20160915065740.13664-4-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The register offset for the mipi-csi clk is off by 4, a copy paste
error from the mipi-dsi clk.

Fixes: c6e6c96d8fa6 ("clk: sunxi-ng: Add A31/A31s clocks")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clk/sunxi-ng/ccu-sun6i-a31.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun6i-a31.c b/drivers/clk/sunxi-ng/ccu-sun6i-a31.c
index ff0d621495fd..79596463e0d9 100644
--- a/drivers/clk/sunxi-ng/ccu-sun6i-a31.c
+++ b/drivers/clk/sunxi-ng/ccu-sun6i-a31.c
@@ -633,7 +633,7 @@ static SUNXI_CCU_M_WITH_MUX_GATE(mipi_dsi_dphy_clk, "mipi-dsi-dphy",
 				 lcd_ch1_parents, 0x168, 0, 3, 8, 2,
 				 BIT(15), CLK_SET_RATE_PARENT);
 static SUNXI_CCU_M_WITH_MUX_GATE(mipi_csi_dphy_clk, "mipi-csi-dphy",
-				 lcd_ch1_parents, 0x168, 0, 3, 8, 2,
+				 lcd_ch1_parents, 0x16c, 0, 3, 8, 2,
 				 BIT(15), 0);
 
 static SUNXI_CCU_M_WITH_MUX_GATE(iep_drc0_clk, "iep-drc0", de_parents,
-- 
2.9.3
