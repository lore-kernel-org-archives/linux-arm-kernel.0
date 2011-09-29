From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 29 Sep 2011 17:12:54 +0900
Subject: [PATCH 2/5] ARM: EXYNOS4: Add support clock for EXYNOS4412
Message-ID: <009501cc7e7f$96eb6f60$c4c24e20$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Changhwan Youn <chaos.youn@samsung.com>

This patch makes EXYNOS4412 use same clock code for
EXYNOS4212 because the clock hierarchy of both SoCs
are same.

Signed-off-by: Changhwan Youn <chaos.youn@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-exynos4/clock.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-exynos4/clock.c b/arch/arm/mach-exynos4/clock.c
index a25c818..db61691 100644
--- a/arch/arm/mach-exynos4/clock.c
+++ b/arch/arm/mach-exynos4/clock.c
@@ -1283,7 +1283,7 @@ static unsigned long exynos4_fout_apll_get_rate(struct clk *clk)
 	if (soc_is_exynos4210())
 		return s5p_get_pll45xx(xtal_rate, __raw_readl(S5P_APLL_CON0),
 					pll_4508);
-	else if (soc_is_exynos4212())
+	else if (soc_is_exynos4212() || soc_is_exynos4412())
 		return s5p_get_pll35xx(xtal_rate, __raw_readl(S5P_APLL_CON0));
 	else
 		return 0;
@@ -1399,7 +1399,7 @@ void __init_or_cpufreq exynos4_setup_clocks(void)
 		vpllsrc = clk_get_rate(&clk_vpllsrc.clk);
 		vpll = s5p_get_pll46xx(vpllsrc, __raw_readl(S5P_VPLL_CON0),
 					__raw_readl(S5P_VPLL_CON1), pll_4650c);
-	} else if (soc_is_exynos4212()) {
+	} else if (soc_is_exynos4212() || soc_is_exynos4412()) {
 		apll = s5p_get_pll35xx(xtal, __raw_readl(S5P_APLL_CON0));
 		mpll = s5p_get_pll35xx(xtal, __raw_readl(S5P_MPLL_CON0));
 		epll = s5p_get_pll36xx(xtal, __raw_readl(S5P_EPLL_CON0),
-- 
1.7.1
