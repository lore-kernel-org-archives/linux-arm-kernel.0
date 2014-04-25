From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 12:43:12 +0100
Subject: [PATCH 138/222] ARM: imx6q: clk: Parent DI clocks to video PLL via
 di_pre_sel
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1WdeXA-0007MT-DN@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sascha Hauer <s.hauer@pengutronix.de>
To: linux-arm-kernel at lists.infradead.org

Route the video PLL to the display interface clocks via the di_pre_sel
and di_sel muxes by default.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-imx/clk-imx6q.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
index f4d0b0e3e041..7d2b652497d2 100644
--- a/arch/arm/mach-imx/clk-imx6q.c
+++ b/arch/arm/mach-imx/clk-imx6q.c
@@ -449,6 +449,15 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 		clk_set_parent(clk[ipu1_sel], clk[pll3_pfd1_540m]);
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
1.8.3.1
