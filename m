From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Mon, 25 Mar 2013 09:20:34 -0300
Subject: [PATCH 7/17] ARM: mach-imx: clk-pllv2: Staticize clk_pllv2_ops
In-Reply-To: <1364214044-13950-1-git-send-email-fabio.estevam@freescale.com>
References: <1364214044-13950-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1364214044-13950-7-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the following sparse warning:

rch/arm/mach-imx/clk-pllv2.c:232:16: warning: symbol 'clk_pllv2_ops' was not declared. Should it be static?

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/clk-pllv2.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/clk-pllv2.c b/arch/arm/mach-imx/clk-pllv2.c
index 0440379..20889d5 100644
--- a/arch/arm/mach-imx/clk-pllv2.c
+++ b/arch/arm/mach-imx/clk-pllv2.c
@@ -229,7 +229,7 @@ static void clk_pllv2_unprepare(struct clk_hw *hw)
 	__raw_writel(reg, pllbase + MXC_PLL_DP_CTL);
 }
 
-struct clk_ops clk_pllv2_ops = {
+static struct clk_ops clk_pllv2_ops = {
 	.prepare = clk_pllv2_prepare,
 	.unprepare = clk_pllv2_unprepare,
 	.recalc_rate = clk_pllv2_recalc_rate,
-- 
1.7.9.5
