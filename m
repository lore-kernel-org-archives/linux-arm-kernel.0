From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat, 29 Jun 2013 12:40:44 +0400
Subject: [PATCH v3 5/5] ARM: imx: move i.MX1/21/27 RTC clk lookup into DT
In-Reply-To: <1372495244-21215-1-git-send-email-shc_work@mail.ru>
References: <1372495244-21215-1-git-send-email-shc_work@mail.ru>
Message-ID: <1372495244-21215-5-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-imx/clk-imx1.c  | 1 -
 arch/arm/mach-imx/clk-imx21.c | 1 -
 arch/arm/mach-imx/clk-imx27.c | 1 -
 3 files changed, 3 deletions(-)

diff --git a/arch/arm/mach-imx/clk-imx1.c b/arch/arm/mach-imx/clk-imx1.c
index 15f9d22..210f33e 100644
--- a/arch/arm/mach-imx/clk-imx1.c
+++ b/arch/arm/mach-imx/clk-imx1.c
@@ -106,7 +106,6 @@ int __init mx1_clocks_init(unsigned long fref)
 	clk_register_clkdev(clk[dummy], "ahb", "imx1-fb.0");
 	clk_register_clkdev(clk[hclk], "mshc", NULL);
 	clk_register_clkdev(clk[per3], "ssi", NULL);
-	clk_register_clkdev(clk[clk32], NULL, "imx1-rtc.0");
 	clk_register_clkdev(clk[clko], "clko", NULL);
 
 	mxc_timer_init(MX1_IO_ADDRESS(MX1_TIM1_BASE_ADDR), MX1_TIM1_INT);
diff --git a/arch/arm/mach-imx/clk-imx21.c b/arch/arm/mach-imx/clk-imx21.c
index d7ed660..a30537f 100644
--- a/arch/arm/mach-imx/clk-imx21.c
+++ b/arch/arm/mach-imx/clk-imx21.c
@@ -172,7 +172,6 @@ int __init mx21_clocks_init(unsigned long lref, unsigned long href)
 	clk_register_clkdev(clk[emma_gate], "emma", NULL);
 	clk_register_clkdev(clk[slcdc_gate], "slcdc", NULL);
 	clk_register_clkdev(clk[gpio_gate], "gpio", NULL);
-	clk_register_clkdev(clk[rtc_gate], "rtc", NULL);
 	clk_register_clkdev(clk[csi_hclk_gate], "csi", NULL);
 	clk_register_clkdev(clk[ssi1_gate], "ssi1", NULL);
 	clk_register_clkdev(clk[ssi2_gate], "ssi2", NULL);
diff --git a/arch/arm/mach-imx/clk-imx27.c b/arch/arm/mach-imx/clk-imx27.c
index c3cfa41..0aca839 100644
--- a/arch/arm/mach-imx/clk-imx27.c
+++ b/arch/arm/mach-imx/clk-imx27.c
@@ -283,7 +283,6 @@ int __init mx27_clocks_init(unsigned long fref)
 	clk_register_clkdev(clk[gpio_ipg_gate], "gpio", NULL);
 	clk_register_clkdev(clk[brom_ahb_gate], "brom", NULL);
 	clk_register_clkdev(clk[ata_ahb_gate], "ata", NULL);
-	clk_register_clkdev(clk[rtc_ipg_gate], NULL, "imx21-rtc");
 	clk_register_clkdev(clk[scc_ipg_gate], "scc", NULL);
 	clk_register_clkdev(clk[cpu_div], NULL, "cpufreq-cpu0.0");
 	clk_register_clkdev(clk[emi_ahb_gate], "emi_ahb" , NULL);
-- 
1.8.1.5
