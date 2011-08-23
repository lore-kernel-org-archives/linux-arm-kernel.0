From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 22 Aug 2011 23:18:25 -0600 (MDT)
Subject: [PATCH] OMAP3: clock: indicate that gpt12_fck and wdt1_fck are in
	the WKUP clockdomain
Message-ID: <alpine.DEB.2.00.1108222317510.28226@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The oscillator that supplies GPT12_FCLK and WDT1_FCLK exists in the
WKUP powerdomain[1].  This resolves at least one boot-time warning:

omap_hwmod: gpt12_fck: missing clockdomain for gpt12_fck.

1. _OMAP34xx Multimedia High Security (HS) Device Silicon Revision 3.1.x
   Security Addendum Version K (SWPU119K)_  Figure 3-29.  August 2010.
---
 arch/arm/mach-omap2/clock3xxx_data.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index ffd55b1..b9b8446 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -3078,6 +3078,7 @@ static struct clk gpt12_fck = {
 	.name		= "gpt12_fck",
 	.ops		= &clkops_null,
 	.parent		= &secure_32k_fck,
+	.clkdm_name	= "wkup_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -3085,6 +3086,7 @@ static struct clk wdt1_fck = {
 	.name		= "wdt1_fck",
 	.ops		= &clkops_null,
 	.parent		= &secure_32k_fck,
+	.clkdm_name	= "wkup_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
-- 
1.7.5.4
