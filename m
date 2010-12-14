From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 13 Dec 2010 23:34:47 -0700
Subject: [PATCH 04/12] OMAP4: clock data: Add missing fields in
	iva_hsd_byp_clk_mux_ck
In-Reply-To: <20101214063308.21555.76050.stgit@twilight.localdomain>
References: <20101214063308.21555.76050.stgit@twilight.localdomain>
Message-ID: <20101214063446.21555.74809.stgit@twilight.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jonathan Bergsagel <jbergsagel@ti.com>

Add register address, mask and link to the clksel structure that
were missing in the IVA DPLL mux clock node.

Signed-off-by: Jonathan Bergsagel <jbergsagel@ti.com>
Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/clock44xx_data.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index aa503cb..421103c 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -636,8 +636,12 @@ static const struct clksel iva_hsd_byp_clk_mux_sel[] = {
 static struct clk iva_hsd_byp_clk_mux_ck = {
 	.name		= "iva_hsd_byp_clk_mux_ck",
 	.parent		= &sys_clkin_ck,
+	.clksel		= iva_hsd_byp_clk_mux_sel,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP4430_CM_CLKSEL_DPLL_IVA,
+	.clksel_mask	= OMAP4430_DPLL_BYP_CLKSEL_MASK,
 	.ops		= &clkops_null,
-	.recalc		= &followparent_recalc,
+	.recalc		= &omap2_clksel_recalc,
 };
 
 /* DPLL_IVA */
