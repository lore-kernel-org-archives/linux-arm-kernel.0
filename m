From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 13 Dec 2010 23:34:45 -0700
Subject: [PATCH 02/12] OMAP3: clock data: Add "wkup_clkdm" in sr1_fck and
	sr2_fck
In-Reply-To: <20101214063308.21555.76050.stgit@twilight.localdomain>
References: <20101214063308.21555.76050.stgit@twilight.localdomain>
Message-ID: <20101214063444.21555.65240.stgit@twilight.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Benoit Cousson <b-cousson@ti.com>

The smartreflex modules belong to an ALWON_FCLK clock domain that
does not have any SW control. The gating of that interface clock
is triggered by a transition of the WKUP clock domain to idle.

Attach both smartreflex instances on OMAP3 to the WKUP clock domain.

The missing clock domain field in srX_fck clock nodes was reported by
Kevin during the discussion about smartreflex on OMAP3:
https://patchwork.kernel.org/patch/199342/

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/clock3xxx_data.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index 0579604..94cbae3 100644
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
 
