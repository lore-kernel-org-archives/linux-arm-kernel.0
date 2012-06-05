From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue,  5 Jun 2012 15:16:42 +0800
Subject: [PATCH 1/2] ARM: imx6q: remove unneeded clkdev lookups
In-Reply-To: <1338880603-24333-1-git-send-email-shawn.guo@linaro.org>
References: <1338880603-24333-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1338880603-24333-2-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are a number of clkdev lookups left over from commit b0286f2
(ARM: imx6q: prepare and enable init on clks directly instead of
clk_get first), remove them since they are not needed now.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/clk-imx6q.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
index 17dc66a..34b89e9 100644
--- a/arch/arm/mach-imx/clk-imx6q.c
+++ b/arch/arm/mach-imx/clk-imx6q.c
@@ -386,12 +386,9 @@ int __init mx6q_clocks_init(void)
 			pr_err("i.MX6q clk %d: register failed with %ld\n",
 				i, PTR_ERR(clk[i]));
 
-	clk_register_clkdev(clk[mmdc_ch0_axi], NULL, "mmdc_ch0_axi");
-	clk_register_clkdev(clk[mmdc_ch1_axi], NULL, "mmdc_ch1_axi");
 	clk_register_clkdev(clk[gpt_ipg], "ipg", "imx-gpt.0");
 	clk_register_clkdev(clk[gpt_ipg_per], "per", "imx-gpt.0");
 	clk_register_clkdev(clk[twd], NULL, "smp_twd");
-	clk_register_clkdev(clk[usboh3], NULL, "usboh3");
 	clk_register_clkdev(clk[uart_serial], "per", "2020000.serial");
 	clk_register_clkdev(clk[uart_ipg], "ipg", "2020000.serial");
 	clk_register_clkdev(clk[uart_serial], "per", "21e8000.serial");
-- 
1.7.5.4
