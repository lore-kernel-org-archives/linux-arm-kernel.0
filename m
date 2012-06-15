From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Fri, 15 Jun 2012 14:23:07 -0300
Subject: [PATCH 4/4] ARM: clk-imx51-imx53: Remove unneeded '#ifdef CONFIG_OF'
In-Reply-To: <1339780987-11063-1-git-send-email-fabio.estevam@freescale.com>
References: <1339780987-11063-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1339780987-11063-4-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_OF is always selected for imx SoCs so it is safe
to drop the '#ifdef CONFIG_OF'.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/clk-imx51-imx53.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/clk-imx51-imx53.c b/arch/arm/mach-imx/clk-imx51-imx53.c
index 20964ce..59e3f9a 100644
--- a/arch/arm/mach-imx/clk-imx51-imx53.c
+++ b/arch/arm/mach-imx/clk-imx51-imx53.c
@@ -465,7 +465,6 @@ int __init mx53_clocks_init(unsigned long rate_ckil, unsigned long rate_osc,
 	return 0;
 }
 
-#ifdef CONFIG_OF
 static void __init clk_get_freq_dt(unsigned long *ckil, unsigned long *osc,
 				   unsigned long *ckih1, unsigned long *ckih2)
 {
@@ -503,4 +502,3 @@ int __init mx53_clocks_init_dt(void)
 	clk_get_freq_dt(&ckil, &osc, &ckih1, &ckih2);
 	return mx53_clocks_init(ckil, osc, ckih1, ckih2);
 }
-#endif
-- 
1.7.1
