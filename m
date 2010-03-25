From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 25 Mar 2010 12:15:12 +0100
Subject: [PATCH 1/8] ARM: S5PV210: fix formating of the debug messages on boot
In-Reply-To: <1269515719-18519-1-git-send-email-m.szyprowski@samsung.com>
References: <1269515719-18519-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1269515719-18519-2-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix broken boot messages about all base clocks.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s5pv210/clock.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-s5pv210/clock.c b/arch/arm/mach-s5pv210/clock.c
index ccccae2..b9749f1 100644
--- a/arch/arm/mach-s5pv210/clock.c
+++ b/arch/arm/mach-s5pv210/clock.c
@@ -369,7 +369,7 @@ void __init_or_cpufreq s5pv210_setup_clocks(void)
 	mpll = s5p_get_pll45xx(xtal, __raw_readl(S5P_MPLL_CON), pll_4502);
 	epll = s5p_get_pll45xx(xtal, __raw_readl(S5P_EPLL_CON), pll_4500);
 
-	printk(KERN_INFO "S5PV210: PLL settings, A=%ld, M=%ld, E=%ld",
+	printk(KERN_INFO "S5PV210: PLL settings, A=%ld, M=%ld, E=%ld\n",
 			apll, mpll, epll);
 
 	armclk = apll / GET_DIV(clkdiv0, S5P_CLKDIV0_APLL);
@@ -394,8 +394,8 @@ void __init_or_cpufreq s5pv210_setup_clocks(void)
 	pclk83 = hclk166 / GET_DIV(clkdiv0, S5P_CLKDIV0_PCLK83);
 	pclk66 = hclk133 / GET_DIV(clkdiv0, S5P_CLKDIV0_PCLK66);
 
-	printk(KERN_INFO "S5PV210: ARMCLK=%ld, HCLKM=%ld, HCLKD=%ld, \
-			HCLKP=%ld, PCLKM=%ld, PCLKD=%ld, PCLKP=%ld\n",
+	printk(KERN_INFO "S5PV210: ARMCLK=%ld, HCLKM=%ld, HCLKD=%ld, "
+			"HCLKP=%ld, PCLKM=%ld, PCLKD=%ld, PCLKP=%ld\n",
 	       armclk, hclk200, hclk166, hclk133, pclk100, pclk83, pclk66);
 
 	clk_fout_apll.rate = apll;
-- 
1.6.4
