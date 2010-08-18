From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 18 Aug 2010 23:01:14 +0900
Subject: [PATCH 04/14] ARM: S5PV310: Fix on PLL setting for S5PV310
In-Reply-To: <1282140084-10265-1-git-send-email-kgene.kim@samsung.com>
References: <1282140084-10265-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1282140084-10265-5-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jongpill Lee <boyko.lee@samsung.com>

This patch fixes on PLL setting for S5PV310/S5PC210.

Signed-off-by: Jongpill Lee <boyko.lee@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5pv310/clock.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-s5pv310/clock.c b/arch/arm/mach-s5pv310/clock.c
index d909515..c60d3b0 100644
--- a/arch/arm/mach-s5pv310/clock.c
+++ b/arch/arm/mach-s5pv310/clock.c
@@ -347,11 +347,11 @@ void __init_or_cpufreq s5pv310_setup_clocks(void)
 	apll = s5p_get_pll45xx(xtal, __raw_readl(S5P_APLL_CON0), pll_4508);
 	mpll = s5p_get_pll45xx(xtal, __raw_readl(S5P_MPLL_CON0), pll_4508);
 	epll = s5p_get_pll46xx(xtal, __raw_readl(S5P_EPLL_CON0),
-				__raw_readl(S5P_EPLL_CON1), pll_4500);
+				__raw_readl(S5P_EPLL_CON1), pll_4600);
 
 	vpllsrc = clk_get_rate(&clk_vpllsrc.clk);
 	vpll = s5p_get_pll46xx(vpllsrc, __raw_readl(S5P_VPLL_CON0),
-				__raw_readl(S5P_VPLL_CON1), pll_4502);
+				__raw_readl(S5P_VPLL_CON1), pll_4650);
 
 	clk_fout_apll.rate = apll;
 	clk_fout_mpll.rate = mpll;
-- 
1.6.2.5
