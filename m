From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 16 Nov 2009 06:36:54 -0700
Subject: [PATCH 2/3] OMAP3: Clock: Fixed dpll3_m2x2 rate calculation
In-Reply-To: <20091116133237.14128.39687.stgit@localhost.localdomain>
References: <20091116133237.14128.39687.stgit@localhost.localdomain>
Message-ID: <20091116133653.14128.48304.stgit@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tero Kristo <tero.kristo@nokia.com>

Current calculation does not take into account any changes to M2 divisor, and
thus when we change VDD2 OPP, dpll3_m2x2 rate does not change. Fixed by
re-routing dpll3_m2x2 parent to dpll3_m2.

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock34xx.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
index a1b3de7..8fe1bcb 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -489,9 +489,9 @@ static struct clk core_ck = {
 static struct clk dpll3_m2x2_ck = {
 	.name		= "dpll3_m2x2_ck",
 	.ops		= &clkops_null,
-	.parent		= &dpll3_x2_ck,
+	.parent		= &dpll3_m2_ck,
 	.clkdm_name	= "dpll3_clkdm",
-	.recalc		= &followparent_recalc,
+	.recalc		= &omap3_clkoutx2_recalc,
 };
 
 /* The PWRDN bit is apparently only available on 3430ES2 and above */
