From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 28 Jun 2013 14:24:15 +0200
Subject: [PATCH 1/2] ARM i.MX6DL: parent LDB DI clocks to PLL5 on i.MX6S/DL
Message-ID: <1372422256-22037-1-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i.MX6S/DL have the Video PLL post dividers fixed already in revision 1.0

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 arch/arm/mach-imx/clk-imx6q.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
index 4282e99f..eb02b49 100644
--- a/arch/arm/mach-imx/clk-imx6q.c
+++ b/arch/arm/mach-imx/clk-imx6q.c
@@ -553,7 +553,7 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 	clk_register_clkdev(clk[pll4_post_div], "pll4_post_div", NULL);
 	clk_register_clkdev(clk[pll4_audio], "pll4_audio", NULL);
 
-	if (imx6q_revision() != IMX_CHIP_REVISION_1_0) {
+	if ((imx6q_revision() != IMX_CHIP_REVISION_1_0) || cpu_is_imx6dl()) {
 		clk_set_parent(clk[ldb_di0_sel], clk[pll5_video_div]);
 		clk_set_parent(clk[ldb_di1_sel], clk[pll5_video_div]);
 	}
-- 
1.8.3.1
