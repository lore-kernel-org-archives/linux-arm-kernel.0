From: t-kristo@ti.com (Tero Kristo)
Date: Thu, 24 Sep 2015 17:26:56 +0300
Subject: [PATCH 15/17] ARM: OMAP24xx: hwmod: remove reset data from hwmod
 database
In-Reply-To: <1443104818-993-1-git-send-email-t-kristo@ti.com>
References: <1443104818-993-1-git-send-email-t-kristo@ti.com>
Message-ID: <1443104818-993-16-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These are now parsed from DT, so not needed under the hwmod database
anymore.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |   13 -------------
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |    7 -------
 2 files changed, 20 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
index 65b1647..5db681d 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -49,16 +49,10 @@ static struct omap_hwmod_class iva1_hwmod_class = {
 	.name		= "iva1",
 };
 
-static struct omap_hwmod_rst_info omap2420_iva_resets[] = {
-	{ .name = "iva", .rst_shift = 8 },
-};
-
 static struct omap_hwmod omap2420_iva_hwmod = {
 	.name		= "iva",
 	.class		= &iva1_hwmod_class,
 	.clkdm_name	= "iva1_clkdm",
-	.rst_lines	= omap2420_iva_resets,
-	.rst_lines_cnt	= ARRAY_SIZE(omap2420_iva_resets),
 	.main_clk	= "iva1_ifck",
 };
 
@@ -67,17 +61,10 @@ static struct omap_hwmod_class dsp_hwmod_class = {
 	.name		= "dsp",
 };
 
-static struct omap_hwmod_rst_info omap2420_dsp_resets[] = {
-	{ .name = "logic", .rst_shift = 0 },
-	{ .name = "mmu", .rst_shift = 1 },
-};
-
 static struct omap_hwmod omap2420_dsp_hwmod = {
 	.name		= "dsp",
 	.class		= &dsp_hwmod_class,
 	.clkdm_name	= "dsp_clkdm",
-	.rst_lines	= omap2420_dsp_resets,
-	.rst_lines_cnt	= ARRAY_SIZE(omap2420_dsp_resets),
 	.main_clk	= "dsp_fck",
 };
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index 79127b3..cc0cfaf 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -44,17 +44,10 @@
  */
 
 /* IVA2 (IVA2) */
-static struct omap_hwmod_rst_info omap2430_iva_resets[] = {
-	{ .name = "logic", .rst_shift = 0 },
-	{ .name = "mmu", .rst_shift = 1 },
-};
-
 static struct omap_hwmod omap2430_iva_hwmod = {
 	.name		= "iva",
 	.class		= &iva_hwmod_class,
 	.clkdm_name	= "dsp_clkdm",
-	.rst_lines	= omap2430_iva_resets,
-	.rst_lines_cnt	= ARRAY_SIZE(omap2430_iva_resets),
 	.main_clk	= "dsp_fck",
 };
 
-- 
1.7.9.5
