From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 22 Jun 2010 10:05:59 +0900
Subject: [PATCH] ARM: S5P6442: Fix PLL setting announce message.
Message-ID: <1277168759-4599-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Abraham <thomas@localhost.localdomain>

The S5P6442 PLL setting announce message incorrectly displays S5P6440
as the SoC. Change it to S5P6442.

Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5p6442/clock.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-s5p6442/clock.c b/arch/arm/mach-s5p6442/clock.c
index 3aadbf4..087e57f 100644
--- a/arch/arm/mach-s5p6442/clock.c
+++ b/arch/arm/mach-s5p6442/clock.c
@@ -294,7 +294,7 @@ void __init_or_cpufreq s5p6442_setup_clocks(void)
 	mpll = s5p_get_pll45xx(xtal, __raw_readl(S5P_MPLL_CON), pll_4502);
 	epll = s5p_get_pll45xx(xtal, __raw_readl(S5P_EPLL_CON), pll_4500);
 
-	printk(KERN_INFO "S5P6440: PLL settings, A=%ld, M=%ld, E=%ld",
+	printk(KERN_INFO "S5P6442: PLL settings, A=%ld, M=%ld, E=%ld",
 			apll, mpll, epll);
 
 	clk_fout_apll.rate = apll;
-- 
1.6.6.rc2
