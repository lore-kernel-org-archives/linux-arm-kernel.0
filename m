From: shc_work@mail.ru (Alexander Shiyan)
Date: Tue, 13 May 2014 20:04:22 +0400
Subject: [PATCH v2 2/3] ARM: i.MX1 clk: Remove clk_register_clkdev() for
 unused clocks
In-Reply-To: <1399997062-4270-1-git-send-email-shc_work@mail.ru>
References: <1399997062-4270-1-git-send-email-shc_work@mail.ru>
Message-ID: <1399997062-4270-2-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes clk_register_clkdev() for the clocks that do not
have any users from boards and drivers.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-imx/clk-imx1.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm/mach-imx/clk-imx1.c b/arch/arm/mach-imx/clk-imx1.c
index 602b30a..7f739be 100644
--- a/arch/arm/mach-imx/clk-imx1.c
+++ b/arch/arm/mach-imx/clk-imx1.c
@@ -91,9 +91,6 @@ int __init mx1_clocks_init(unsigned long fref)
 
 	clk_register_clkdev(clk[dma_gate], "ahb", "imx1-dma");
 	clk_register_clkdev(clk[hclk], "ipg", "imx1-dma");
-	clk_register_clkdev(clk[csi_gate], NULL, "mx1-camera.0");
-	clk_register_clkdev(clk[mma_gate], "mma", NULL);
-	clk_register_clkdev(clk[usbd_gate], NULL, "imx_udc.0");
 	clk_register_clkdev(clk[per1], "per", "imx-gpt.0");
 	clk_register_clkdev(clk[hclk], "ipg", "imx-gpt.0");
 	clk_register_clkdev(clk[per1], "per", "imx1-uart.0");
@@ -107,14 +104,9 @@ int __init mx1_clocks_init(unsigned long fref)
 	clk_register_clkdev(clk[dummy], "ipg", "imx1-cspi.0");
 	clk_register_clkdev(clk[per2], "per", "imx1-cspi.1");
 	clk_register_clkdev(clk[dummy], "ipg", "imx1-cspi.1");
-	clk_register_clkdev(clk[per2], NULL, "imx-mmc.0");
 	clk_register_clkdev(clk[per2], "per", "imx1-fb.0");
 	clk_register_clkdev(clk[dummy], "ipg", "imx1-fb.0");
 	clk_register_clkdev(clk[dummy], "ahb", "imx1-fb.0");
-	clk_register_clkdev(clk[hclk], "mshc", NULL);
-	clk_register_clkdev(clk[per3], "ssi", NULL);
-	clk_register_clkdev(clk[clk32], NULL, "imx1-rtc.0");
-	clk_register_clkdev(clk[clko], "clko", NULL);
 
 	mxc_timer_init(MX1_IO_ADDRESS(MX1_TIM1_BASE_ADDR), MX1_TIM1_INT);
 
-- 
1.8.3.2
