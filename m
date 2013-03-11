From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 11 Mar 2013 10:51:50 +0800
Subject: [PATCH] ARM: imx: pll1_sys should be an initial on clk
Message-ID: <1362970310-10617-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We always boot from PLL1, so let's have pll1_sys in the clks_init_on
list to have clk prepare/enable use count match the hardware status,
so that drivers managing pll1_sys like cpufreq can get the use count
right from the start.

Reported-by: Dirk Behme <dirk.behme@de.bosch.com>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/clk-imx6q.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
index 7b025ee..2f9ff93 100644
--- a/arch/arm/mach-imx/clk-imx6q.c
+++ b/arch/arm/mach-imx/clk-imx6q.c
@@ -172,7 +172,7 @@ static struct clk *clk[clk_max];
 static struct clk_onecell_data clk_data;
 
 static enum mx6q_clks const clks_init_on[] __initconst = {
-	mmdc_ch0_axi, rom,
+	mmdc_ch0_axi, rom, pll1_sys,
 };
 
 static struct clk_div_table clk_enet_ref_table[] = {
-- 
1.7.9.5
