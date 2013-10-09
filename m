From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Wed, 9 Oct 2013 16:12:37 +0300
Subject: [PATCH 1/3] ARM: OMAP4: use CLK_SET_RATE_PARENT for dss_dss_clk
Message-ID: <1381324359-28825-1-git-send-email-tomi.valkeinen@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Set CLK_SET_RATE_PARENT flag for dss_dss_clk so that the DSS's fclk can
be configured without the need to get the parent of the fclk.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/cclock44xx_data.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/cclock44xx_data.c b/arch/arm/mach-omap2/cclock44xx_data.c
index b237950..ec0dc0b 100644
--- a/arch/arm/mach-omap2/cclock44xx_data.c
+++ b/arch/arm/mach-omap2/cclock44xx_data.c
@@ -830,7 +830,8 @@ DEFINE_CLK_GATE(dss_tv_clk, "extalt_clkin_ck", &extalt_clkin_ck, 0x0,
 		OMAP4430_CM_DSS_DSS_CLKCTRL,
 		OMAP4430_OPTFCLKEN_TV_CLK_SHIFT, 0x0, NULL);
 
-DEFINE_CLK_GATE(dss_dss_clk, "dpll_per_m5x2_ck", &dpll_per_m5x2_ck, 0x0,
+DEFINE_CLK_GATE(dss_dss_clk, "dpll_per_m5x2_ck", &dpll_per_m5x2_ck,
+		CLK_SET_RATE_PARENT,
 		OMAP4430_CM_DSS_DSS_CLKCTRL, OMAP4430_OPTFCLKEN_DSSCLK_SHIFT,
 		0x0, NULL);
 
-- 
1.8.1.2
