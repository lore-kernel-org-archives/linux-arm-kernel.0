From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 17 Jan 2014 09:44:58 +0200
Subject: [PATCH 1/2] ARM: OMAP2+: fix rate prints
In-Reply-To: <1389944699-27962-1-git-send-email-tomi.valkeinen@ti.com>
References: <1389944699-27962-1-git-send-email-tomi.valkeinen@ti.com>
Message-ID: <1389944699-27962-2-git-send-email-tomi.valkeinen@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Printing with unsigned long rates with %ld gives wrong result if the
rate is high enough. Fix this by using %lu.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/clkt_dpll.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/clkt_dpll.c b/arch/arm/mach-omap2/clkt_dpll.c
index 924c230f8948..1f1708ef77bb 100644
--- a/arch/arm/mach-omap2/clkt_dpll.c
+++ b/arch/arm/mach-omap2/clkt_dpll.c
@@ -306,7 +306,7 @@ long omap2_dpll_round_rate(struct clk_hw *hw, unsigned long target_rate,
 
 	ref_rate = __clk_get_rate(dd->clk_ref);
 	clk_name = __clk_get_name(hw->clk);
-	pr_debug("clock: %s: starting DPLL round_rate, target rate %ld\n",
+	pr_debug("clock: %s: starting DPLL round_rate, target rate %lu\n",
 		 clk_name, target_rate);
 
 	scaled_rt_rp = target_rate / (ref_rate / DPLL_SCALE_FACTOR);
@@ -342,7 +342,7 @@ long omap2_dpll_round_rate(struct clk_hw *hw, unsigned long target_rate,
 		if (r == DPLL_MULT_UNDERFLOW)
 			continue;
 
-		pr_debug("clock: %s: m = %d: n = %d: new_rate = %ld\n",
+		pr_debug("clock: %s: m = %d: n = %d: new_rate = %lu\n",
 			 clk_name, m, n, new_rate);
 
 		if (target_rate == new_rate) {
@@ -354,7 +354,7 @@ long omap2_dpll_round_rate(struct clk_hw *hw, unsigned long target_rate,
 	}
 
 	if (target_rate != new_rate) {
-		pr_debug("clock: %s: cannot round to rate %ld\n",
+		pr_debug("clock: %s: cannot round to rate %lu\n",
 			 clk_name, target_rate);
 		return ~0;
 	}
-- 
1.8.3.2
