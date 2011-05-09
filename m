From: avinashhm@ti.com (Avinash.H.M)
Date: Mon, 9 May 2011 17:59:40 +0530
Subject: [PATCH] OMAP3: set the core dpll clk rate in its set_rate function.
Message-ID: <1304944180-20443-1-git-send-email-avinashhm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The debug l3_ick/rate is not displaying the actual rate of the clock in
hardware. This is because, the core dpll set_rate function doesn't update the
clk.rate. After fixing, the l3_ick/rate is displaying proper values.

Signed-off-by: Shweta Gulati <shweta.gulati@ti.com>
Signed-off-by: Avinash.H.M <avinashhm@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Paul Wamsley <paul@pwsan.com>
---
* The patch is based on v2.6.39-rc6
* The patch is tested on zoom3.
* The patch is based on discussions from 
  http://www.mail-archive.com/linux-omap at vger.kernel.org/msg48518.html

 arch/arm/mach-omap2/clkt34xx_dpll3m2.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clkt34xx_dpll3m2.c b/arch/arm/mach-omap2/clkt34xx_dpll3m2.c
index b10d9ef..2a77faf 100644
--- a/arch/arm/mach-omap2/clkt34xx_dpll3m2.c
+++ b/arch/arm/mach-omap2/clkt34xx_dpll3m2.c
@@ -118,6 +118,7 @@ int omap3_core_dpll_m2_set_rate(struct clk *clk, unsigned long rate)
 				  sdrc_cs0->rfr_ctrl, sdrc_cs0->actim_ctrla,
 				  sdrc_cs0->actim_ctrlb, sdrc_cs0->mr,
 				  0, 0, 0, 0);
+	clk->rate = rate;
 
 	return 0;
 }
-- 
1.7.1
