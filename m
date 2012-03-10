From: paul@pwsan.com (Paul Walmsley)
Date: Sat, 10 Mar 2012 00:08:40 -0700 (MST)
Subject: [PATCH] ARM: OMAP4: clock: Add aliases for McBSP fclk clocks
In-Reply-To: <alpine.DEB.2.00.1203091103450.7039@utopia.booyaka.com>
References: <1331024133-18201-1-git-send-email-peter.ujfalusi@ti.com>
 <4F5A258F.8050704@ti.com> <20120309180027.GF12083@atomide.com>
 <alpine.DEB.2.00.1203091101400.7039@utopia.booyaka.com>
 <alpine.DEB.2.00.1203091103450.7039@utopia.booyaka.com>
Message-ID: <alpine.DEB.2.00.1203092355280.27395@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hello P?ter

could you please try this patch instead of the clkdev change?

It is based on my 'hwmod_enable_remaining_hwmods_devel_3.4' branch, but 
the basic idea should work on v3.3-rc6 as well.

If it works for you, please let us know and we can queue this up along 
with the hwmod data changes.  Probably we should replace the changelog 
also with the one from your patch, it might be a little more useful?  
Suggestions welcome.


- Paul

From: Paul Walmsley <paul@pwsan.com>
Date: Fri, 9 Mar 2012 23:28:28 -0700
Subject: [PATCH] ARM: OMAP4: hwmod data: add McBSP parent clock aliases

Add optional parent clocks for the OMAP4 McBSP modules so the driver
can switch between parent clocks.

Based on a patch from P?ter Ujfalusi <peter.ujfalusi@ti.com>.
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index e029992..b4a061d 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -1921,6 +1921,11 @@ static struct omap_hwmod_dma_info omap44xx_mcbsp1_sdma_reqs[] = {
 	{ .dma_req = -1 }
 };
 
+static struct omap_hwmod_opt_clk mcbsp1_opt_clks[] = {
+	{ .role = "pad_fck", .clk = "pad_clks_ck" },
+	{ .role = "prcm_clk", .clk = "mcbsp1_sync_mux_ck" },
+};
+
 static struct omap_hwmod omap44xx_mcbsp1_hwmod = {
 	.name		= "mcbsp1",
 	.class		= &omap44xx_mcbsp_hwmod_class,
@@ -1935,6 +1940,8 @@ static struct omap_hwmod omap44xx_mcbsp1_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
+	.opt_clks	= mcbsp1_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(mcbsp1_opt_clks),
 };
 
 /* mcbsp2 */
@@ -1949,6 +1956,11 @@ static struct omap_hwmod_dma_info omap44xx_mcbsp2_sdma_reqs[] = {
 	{ .dma_req = -1 }
 };
 
+static struct omap_hwmod_opt_clk mcbsp2_opt_clks[] = {
+	{ .role = "pad_fck", .clk = "pad_clks_ck" },
+	{ .role = "prcm_clk", .clk = "mcbsp2_sync_mux_ck" },
+};
+
 static struct omap_hwmod omap44xx_mcbsp2_hwmod = {
 	.name		= "mcbsp2",
 	.class		= &omap44xx_mcbsp_hwmod_class,
@@ -1963,6 +1975,8 @@ static struct omap_hwmod omap44xx_mcbsp2_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
+	.opt_clks	= mcbsp2_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(mcbsp2_opt_clks),
 };
 
 /* mcbsp3 */
@@ -1977,6 +1991,11 @@ static struct omap_hwmod_dma_info omap44xx_mcbsp3_sdma_reqs[] = {
 	{ .dma_req = -1 }
 };
 
+static struct omap_hwmod_opt_clk mcbsp3_opt_clks[] = {
+	{ .role = "pad_fck", .clk = "pad_clks_ck" },
+	{ .role = "prcm_clk", .clk = "mcbsp3_sync_mux_ck" },
+};
+
 static struct omap_hwmod omap44xx_mcbsp3_hwmod = {
 	.name		= "mcbsp3",
 	.class		= &omap44xx_mcbsp_hwmod_class,
@@ -1991,6 +2010,8 @@ static struct omap_hwmod omap44xx_mcbsp3_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
+	.opt_clks	= mcbsp3_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(mcbsp3_opt_clks),
 };
 
 /* mcbsp4 */
@@ -2005,6 +2026,11 @@ static struct omap_hwmod_dma_info omap44xx_mcbsp4_sdma_reqs[] = {
 	{ .dma_req = -1 }
 };
 
+static struct omap_hwmod_opt_clk mcbsp4_opt_clks[] = {
+	{ .role = "pad_fck", .clk = "pad_clks_ck" },
+	{ .role = "prcm_clk", .clk = "mcbsp4_sync_mux_ck" },
+};
+
 static struct omap_hwmod omap44xx_mcbsp4_hwmod = {
 	.name		= "mcbsp4",
 	.class		= &omap44xx_mcbsp_hwmod_class,
@@ -2019,6 +2045,8 @@ static struct omap_hwmod omap44xx_mcbsp4_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
+	.opt_clks	= mcbsp4_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(mcbsp4_opt_clks),
 };
 
 /*
-- 
1.7.9.1
