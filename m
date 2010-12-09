From: b-cousson@ti.com (Benoit Cousson)
Date: Thu, 9 Dec 2010 23:13:34 +0100
Subject: [PATCH v2 2/8] OMAP3: clock data: Add "wkup_clkdm" in sr1_fck and
	sr2_fck
In-Reply-To: <1291932820-11163-1-git-send-email-b-cousson@ti.com>
References: <1291932820-11163-1-git-send-email-b-cousson@ti.com>
Message-ID: <1291932820-11163-3-git-send-email-b-cousson@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The smartreflex modules belong to an ALWON_FCLK clock domain that
does not have any SW control. The gating of that interface clock
is triggered by a transition of the WKUP clock domain to idle.

Attach both smartreflex instances on OMAP3 to the WKUP clock domain.

The missing clock domain field in srX_fck clock nodes was reported by
Kevin during the discussion about smartreflex on OMAP3:
https://patchwork.kernel.org/patch/199342/

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/clock3xxx_data.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index d85ecd5..741f6a0 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -3044,6 +3044,7 @@ static struct clk sr1_fck = {
 	.parent		= &sys_ck,
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_SR1_SHIFT,
+	.clkdm_name	= "wkup_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -3054,6 +3055,7 @@ static struct clk sr2_fck = {
 	.parent		= &sys_ck,
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_SR2_SHIFT,
+	.clkdm_name	= "wkup_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
-- 
1.7.0.4
