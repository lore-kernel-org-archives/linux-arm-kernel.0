From: l.stach@pengutronix.de (Lucas Stach)
Date: Fri, 28 Mar 2014 17:52:52 +0100
Subject: [PATCH 1/8] ARM: imx6q-clk: parent lvds_gate from lvds_sel
In-Reply-To: <1396025579-14344-1-git-send-email-l.stach@pengutronix.de>
References: <1396025579-14344-1-git-send-email-l.stach@pengutronix.de>
Message-ID: <1396025579-14344-2-git-send-email-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allows fror proper refcounting of the parent clocks
when enabling the clock output on CLK1/2 pads.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 arch/arm/mach-imx/clk-imx6q.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
index af2e582d2b74..f98a6bb98145 100644
--- a/arch/arm/mach-imx/clk-imx6q.c
+++ b/arch/arm/mach-imx/clk-imx6q.c
@@ -208,8 +208,8 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 	 * the "output_enable" bit as a gate, even though it's really just
 	 * enabling clock output.
 	 */
-	clk[lvds1_gate] = imx_clk_gate("lvds1_gate", "dummy", base + 0x160, 10);
-	clk[lvds2_gate] = imx_clk_gate("lvds2_gate", "dummy", base + 0x160, 11);
+	clk[lvds1_gate] = imx_clk_gate("lvds1_gate", "lvds1_sel", base + 0x160, 10);
+	clk[lvds2_gate] = imx_clk_gate("lvds2_gate", "lvds2_sel", base + 0x160, 11);
 
 	/*                                name              parent_name        reg       idx */
 	clk[pll2_pfd0_352m] = imx_clk_pfd("pll2_pfd0_352m", "pll2_bus",     base + 0x100, 0);
-- 
1.9.0
