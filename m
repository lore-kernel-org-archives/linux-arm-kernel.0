From: b20788@freescale.com (Anson Huang)
Date: Fri, 31 May 2013 17:01:55 -0400
Subject: [PATCH 4/4] ARM: imx: clk-imx6q: correct some clocks' initial
 enable_count
In-Reply-To: <1370034115-24006-1-git-send-email-b20788@freescale.com>
References: <1370034115-24006-1-git-send-email-b20788@freescale.com>
Message-ID: <1370034115-24006-4-git-send-email-b20788@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Those always-on clocks need to be added into init_on array, this
is to avoid confusion when we dump the clock tree, the result
shows that some clocks are on but their enabled_count is 0.

Signed-off-by: Anson Huang <b20788@freescale.com>
---
 arch/arm/mach-imx/clk-imx6q.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
index 390950e..66831a6 100644
--- a/arch/arm/mach-imx/clk-imx6q.c
+++ b/arch/arm/mach-imx/clk-imx6q.c
@@ -247,7 +247,7 @@ static struct clk *clk[clk_max];
 static struct clk_onecell_data clk_data;
 
 static enum mx6q_clks const clks_init_on[] __initconst = {
-	mmdc_ch0_axi, rom, pll1_sys,
+	mmdc_ch0_axi, rom, pll1_sys, ckil, ocram, axi, ipg_per, mx6fast1, per2_main, aips_tz1, aips_tz2, mmdc_ch0_ipg, mmdc_ch1_ipg,
 };
 
 static struct clk_div_table clk_enet_ref_table[] = {
-- 
1.7.9.5
