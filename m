From: t-kristo@ti.com (Tero Kristo)
Date: Wed, 2 Jul 2014 11:47:37 +0300
Subject: [PATCH 03/13] ARM: OMAP4+: dpll: remove cpu_is_omap44xx checks
In-Reply-To: <1404290867-6768-1-git-send-email-t-kristo@ti.com>
References: <1404290867-6768-1-git-send-email-t-kristo@ti.com>
Message-ID: <1404290867-6768-4-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These are unnecessary, as the clock code is only used on OMAP4+ platforms
through clock registrations. This also allows to eventually migrate the
clock type implementation under clock driver.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/dpll44xx.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/dpll44xx.c b/arch/arm/mach-omap2/dpll44xx.c
index 52f9438..b071891 100644
--- a/arch/arm/mach-omap2/dpll44xx.c
+++ b/arch/arm/mach-omap2/dpll44xx.c
@@ -15,7 +15,6 @@
 #include <linux/io.h>
 #include <linux/bitops.h>
 
-#include "soc.h"
 #include "clock.h"
 #include "clock44xx.h"
 #include "cm-regbits-44xx.h"
@@ -35,7 +34,7 @@ int omap4_dpllmx_gatectrl_read(struct clk_hw_omap *clk)
 	u32 v;
 	u32 mask;
 
-	if (!clk || !clk->clksel_reg || !cpu_is_omap44xx())
+	if (!clk || !clk->clksel_reg)
 		return -EINVAL;
 
 	mask = clk->flags & CLOCK_CLKOUTX2 ?
@@ -54,7 +53,7 @@ void omap4_dpllmx_allow_gatectrl(struct clk_hw_omap *clk)
 	u32 v;
 	u32 mask;
 
-	if (!clk || !clk->clksel_reg || !cpu_is_omap44xx())
+	if (!clk || !clk->clksel_reg)
 		return;
 
 	mask = clk->flags & CLOCK_CLKOUTX2 ?
@@ -72,7 +71,7 @@ void omap4_dpllmx_deny_gatectrl(struct clk_hw_omap *clk)
 	u32 v;
 	u32 mask;
 
-	if (!clk || !clk->clksel_reg || !cpu_is_omap44xx())
+	if (!clk || !clk->clksel_reg)
 		return;
 
 	mask = clk->flags & CLOCK_CLKOUTX2 ?
-- 
1.7.9.5
