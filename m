From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 22 Dec 2009 09:03:05 -0700 (MST)
Subject: [PATCH] OMAP1 clock: Add missing clocks for OMAP 7xx
Message-ID: <alpine.DEB.2.00.0912220901360.5563@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


From: Cory Maccarrone <darkstar6262@gmail.com>

This change adds in some missing clocks that were needed as a result
of 526505... (OMAP1 clock: convert mach-omap1/clock.h to
mach-omap1/clock_data.c).  Prior to this, it was just assumed that
these clocks existed for all devices, and it was used directly instead
of calling it out with a clock_get call or similar.  So, not having
the CK_7XX meant these clocks weren't being used anymore for omap 7xx
devices, which broke things badly.

Signed-off-by: Cory Maccarrone <darkstar6262@gmail.com>
[paul at pwsan.com: commit message edited]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap1/clock_data.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap1/clock_data.c b/arch/arm/mach-omap1/clock_data.c
index ab995a9..31fba07 100644
--- a/arch/arm/mach-omap1/clock_data.c
+++ b/arch/arm/mach-omap1/clock_data.c
@@ -599,7 +599,7 @@ static struct clk i2c_ick = {
 static struct omap_clk omap_clks[] = {
 	/* non-ULPD clocks */
 	CLK(NULL,	"ck_ref",	&ck_ref,	CK_16XX | CK_1510 | CK_310 | CK_7XX),
-	CLK(NULL,	"ck_dpll1",	&ck_dpll1,	CK_16XX | CK_1510 | CK_310),
+	CLK(NULL,	"ck_dpll1",	&ck_dpll1,	CK_16XX | CK_1510 | CK_310 | CK_7XX),
 	/* CK_GEN1 clocks */
 	CLK(NULL,	"ck_dpll1out",	&ck_dpll1out.clk, CK_16XX),
 	CLK(NULL,	"ck_sossi",	&sossi_ck,	CK_16XX),
@@ -627,7 +627,7 @@ static struct omap_clk omap_clks[] = {
 	CLK(NULL,	"tc2_ck",	&tc2_ck,	CK_16XX),
 	CLK(NULL,	"dma_ck",	&dma_ck,	CK_16XX | CK_1510 | CK_310),
 	CLK(NULL,	"dma_lcdfree_ck", &dma_lcdfree_ck, CK_16XX),
-	CLK(NULL,	"api_ck",	&api_ck.clk,	CK_16XX | CK_1510 | CK_310),
+	CLK(NULL,	"api_ck",	&api_ck.clk,	CK_16XX | CK_1510 | CK_310 | CK_7XX),
 	CLK(NULL,	"lb_ck",	&lb_ck.clk,	CK_1510 | CK_310),
 	CLK(NULL,	"rhea1_ck",	&rhea1_ck,	CK_16XX),
 	CLK(NULL,	"rhea2_ck",	&rhea2_ck,	CK_16XX),
-- 
1.6.6.rc2.5.g49666
