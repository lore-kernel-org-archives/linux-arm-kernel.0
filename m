From: festevam@gmail.com (Fabio Estevam)
Date: Sat,  7 Jul 2012 17:47:19 -0300
Subject: [PATCH 1/3] ARM: clk-imx27: Fix rtc clock id
Message-ID: <1341694041-7839-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Fix rtc clock id.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/clk-imx27.c |    2 +-
 arch/arm/mach-imx/clk-imx31.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/clk-imx27.c b/arch/arm/mach-imx/clk-imx27.c
index 295cbd7..167a3f1 100644
--- a/arch/arm/mach-imx/clk-imx27.c
+++ b/arch/arm/mach-imx/clk-imx27.c
@@ -256,7 +256,7 @@ int __init mx27_clocks_init(unsigned long fref)
 	clk_register_clkdev(clk[gpio_ipg_gate], "gpio", NULL);
 	clk_register_clkdev(clk[brom_ahb_gate], "brom", NULL);
 	clk_register_clkdev(clk[ata_ahb_gate], "ata", NULL);
-	clk_register_clkdev(clk[rtc_ipg_gate], "rtc", NULL);
+	clk_register_clkdev(clk[rtc_ipg_gate], NULL, "mxc_rtc");
 	clk_register_clkdev(clk[scc_ipg_gate], "scc", NULL);
 	clk_register_clkdev(clk[cpu_div], "cpu", NULL);
 	clk_register_clkdev(clk[emi_ahb_gate], "emi_ahb" , NULL);
diff --git a/arch/arm/mach-imx/clk-imx31.c b/arch/arm/mach-imx/clk-imx31.c
index c9a06d8..8711090 100644
--- a/arch/arm/mach-imx/clk-imx31.c
+++ b/arch/arm/mach-imx/clk-imx31.c
@@ -123,7 +123,7 @@ int __init mx31_clocks_init(unsigned long fref)
 	clk_register_clkdev(clk[cspi3_gate], NULL, "imx31-cspi.2");
 	clk_register_clkdev(clk[pwm_gate], "pwm", NULL);
 	clk_register_clkdev(clk[wdog_gate], NULL, "imx2-wdt.0");
-	clk_register_clkdev(clk[rtc_gate], "rtc", NULL);
+	clk_register_clkdev(clk[rtc_gate], NULL, "mxc_rtc");
 	clk_register_clkdev(clk[epit1_gate], "epit", NULL);
 	clk_register_clkdev(clk[epit2_gate], "epit", NULL);
 	clk_register_clkdev(clk[nfc], NULL, "mxc_nand.0");
-- 
1.7.1
