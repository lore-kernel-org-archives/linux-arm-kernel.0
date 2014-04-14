From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 14 Apr 2014 16:20:39 +0200
Subject: [PATCH 1/2] ARM: imx6q: clk: Parent DI clocks to video PLL via
 di_pre_sel
Message-ID: <1397485240-29163-1-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sascha Hauer <s.hauer@pengutronix.de>

Route the video PLL to the display interface clocks via the di_pre_sel
and di_sel muxes by default.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 arch/arm/mach-imx/clk-imx6q.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
index a3a69ab..ba17299 100644
--- a/arch/arm/mach-imx/clk-imx6q.c
+++ b/arch/arm/mach-imx/clk-imx6q.c
@@ -445,6 +445,15 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 		clk_set_parent(clk[ldb_di1_sel], clk[pll5_video_div]);
 	}
 
+	clk_set_parent(clk[ipu1_di0_pre_sel], clk[pll5_video_div]);
+	clk_set_parent(clk[ipu1_di1_pre_sel], clk[pll5_video_div]);
+	clk_set_parent(clk[ipu2_di0_pre_sel], clk[pll5_video_div]);
+	clk_set_parent(clk[ipu2_di1_pre_sel], clk[pll5_video_div]);
+	clk_set_parent(clk[ipu1_di0_sel], clk[ipu1_di0_pre]);
+	clk_set_parent(clk[ipu1_di1_sel], clk[ipu1_di1_pre]);
+	clk_set_parent(clk[ipu2_di0_sel], clk[ipu2_di0_pre]);
+	clk_set_parent(clk[ipu2_di1_sel], clk[ipu2_di1_pre]);
+
 	/*
 	 * The gpmi needs 100MHz frequency in the EDO/Sync mode,
 	 * We can not get the 100MHz from the pll2_pfd0_352m.
-- 
1.9.1
