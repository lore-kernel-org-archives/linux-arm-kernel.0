From: t-kristo@ti.com (Tero Kristo)
Date: Wed, 2 Jul 2014 11:47:35 +0300
Subject: [PATCH 01/13] ARM: OMAP2+: clock/dpll: fix _dpll_test_fint
 arithmetics overflow
In-Reply-To: <1404290867-6768-1-git-send-email-t-kristo@ti.com>
References: <1404290867-6768-1-git-send-email-t-kristo@ti.com>
Message-ID: <1404290867-6768-2-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The divider value provided to the _dpll_test_fint can reach value of
256 with J type DPLLs (USB etc.), which causes an overflow with the u8
datatype. Fix this by changing the parameter to be an int instead.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/clkt_dpll.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/clkt_dpll.c b/arch/arm/mach-omap2/clkt_dpll.c
index 332af92..5aa734a 100644
--- a/arch/arm/mach-omap2/clkt_dpll.c
+++ b/arch/arm/mach-omap2/clkt_dpll.c
@@ -76,7 +76,7 @@
  * (assuming that it is counting N upwards), or -2 if the enclosing loop
  * should skip to the next iteration (again assuming N is increasing).
  */
-static int _dpll_test_fint(struct clk_hw_omap *clk, u8 n)
+static int _dpll_test_fint(struct clk_hw_omap *clk, int n)
 {
 	struct dpll_data *dd;
 	long fint, fint_min, fint_max;
-- 
1.7.9.5
