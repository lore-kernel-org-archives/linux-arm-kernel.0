From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Mon, 25 Mar 2013 09:20:33 -0300
Subject: [PATCH 6/17] ARM: mach-imx: clk-pllv1: Staticize clk_pllv1_ops
In-Reply-To: <1364214044-13950-1-git-send-email-fabio.estevam@freescale.com>
References: <1364214044-13950-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1364214044-13950-6-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the following sparse warning:

arch/arm/mach-imx/clk-pllv1.c:81:16: warning: symbol 'clk_pllv1_ops' was not declared. Should it be static?

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/clk-pllv1.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/clk-pllv1.c b/arch/arm/mach-imx/clk-pllv1.c
index abff350..c1eaee3 100644
--- a/arch/arm/mach-imx/clk-pllv1.c
+++ b/arch/arm/mach-imx/clk-pllv1.c
@@ -78,7 +78,7 @@ static unsigned long clk_pllv1_recalc_rate(struct clk_hw *hw,
 	return ll;
 }
 
-struct clk_ops clk_pllv1_ops = {
+static struct clk_ops clk_pllv1_ops = {
 	.recalc_rate = clk_pllv1_recalc_rate,
 };
 
-- 
1.7.9.5
