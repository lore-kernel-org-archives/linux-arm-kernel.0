From: srk@ti.com (Sriram)
Date: Thu, 11 Mar 2010 15:13:41 +0000
Subject: [PATCH] OMAP3 : clock data: Update name string for EMAC clocks
Message-ID: <mailman.403.1273523875.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The emac driver currently uses Davinci clock names for the module and phy
clocks. Updated the omap3xxx_clks table to match the names
used by the Davinci emac driver.

Note that eventually the EMAC clocks should be renamed to be generic.

Signed-off-by: Sriramakrishnan <srk@ti.com>
Acked-by: Paul Walmsley <paul@pwsan.com>
[tony at atomide.com: updated patch description to match the patch]
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index 9cba556..6905eb7 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -3472,8 +3472,8 @@ static struct omap_clk omap3xxx_clks[] = {
 	CLK(NULL,	"ipss_ick",	&ipss_ick,	CK_AM35XX),
 	CLK(NULL,	"rmii_ck",	&rmii_ck,	CK_AM35XX),
 	CLK(NULL,	"pclk_ck",	&pclk_ck,	CK_AM35XX),
-	CLK("davinci_emac",	"ick",		&emac_ick,	CK_AM35XX),
-	CLK("davinci_emac",	"fck",		&emac_fck,	CK_AM35XX),
+	CLK("davinci_emac",	"emac_clk",	&emac_ick,	CK_AM35XX),
+	CLK("davinci_emac",	"phy_clk",	&emac_fck,	CK_AM35XX),
 	CLK("vpfe-capture",	"master",	&vpfe_ick,	CK_AM35XX),
 	CLK("vpfe-capture",	"slave",	&vpfe_fck,	CK_AM35XX),
 	CLK("musb_hdrc",	"ick",		&hsotgusb_ick_am35xx,	CK_AM35XX),

--vkogqOf2sHV7VnPd--
