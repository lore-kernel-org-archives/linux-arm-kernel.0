From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 30 Mar 2010 01:56:54 -0600
Subject: [PATCH 4/4] OMAP3: clock: fix enable bit used for dpll4_m4x2 clock
In-Reply-To: <20100330074801.11629.61888.stgit@localhost.localdomain>
References: <20100330074801.11629.61888.stgit@localhost.localdomain>
Message-ID: <20100330075651.11629.4018.stgit@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ranjith Lohithakshan <ranjithl@ti.com>

The enable bit for dpll4_m4x2 clock should be OMAP3430_PWRDN_DSS1_SHIFT.
The code erroneously uses OMAP3430_PWRDN_CAM_SHIFT which is meant for
dpll4_m5x2 clock.

This came into notice during a recent review of the clock tree.

Signed-off-by: Ranjith Lohithakshan <ranjithl@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock3xxx_data.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index d5153b6..9cba556 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -895,7 +895,7 @@ static struct clk dpll4_m4x2_ck = {
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &dpll4_m4_ck,
 	.enable_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
-	.enable_bit	= OMAP3430_PWRDN_CAM_SHIFT,
+	.enable_bit	= OMAP3430_PWRDN_DSS1_SHIFT,
 	.flags		= INVERT_ENABLE,
 	.clkdm_name	= "dpll4_clkdm",
 	.recalc		= &omap3_clkoutx2_recalc,
