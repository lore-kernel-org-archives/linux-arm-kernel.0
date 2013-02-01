From: anilkumar@ti.com (AnilKumar Ch)
Date: Fri, 1 Feb 2013 15:57:04 +0530
Subject: [PATCH] ARM: OMAP2+: dpll: Add missing soc_is_am33xx() check
Message-ID: <1359714424-21167-1-git-send-email-anilkumar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add missing soc_is_am33xx() check in noncore DPLL set rate function.
Without this, dpll set_rate function throughs warnings for am33xx
family of devices.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 arch/arm/mach-omap2/dpll3xxx.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/dpll3xxx.c b/arch/arm/mach-omap2/dpll3xxx.c
index 0a02aab5..4bb3f78 100644
--- a/arch/arm/mach-omap2/dpll3xxx.c
+++ b/arch/arm/mach-omap2/dpll3xxx.c
@@ -501,7 +501,8 @@ int omap3_noncore_dpll_set_rate(struct clk_hw *hw, unsigned long rate,
 			return -EINVAL;
 
 		/* No freqsel on OMAP4 and OMAP3630 */
-		if (!cpu_is_omap44xx() && !cpu_is_omap3630()) {
+		if (!cpu_is_omap44xx() && !cpu_is_omap3630() &&
+					!soc_is_am33xx()) {
 			freqsel = _omap3_dpll_compute_freqsel(clk,
 						dd->last_rounded_n);
 			WARN_ON(!freqsel);
-- 
1.7.9.5
