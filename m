From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Mon, 24 Sep 2012 16:43:19 +0200
Subject: [PATCH 3/3] clk: ux500: Update sdmmc clock to 100MHz for u8500
In-Reply-To: <1348497799-32143-1-git-send-email-ulf.hansson@stericsson.com>
References: <1348497799-32143-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <1348497799-32143-4-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulf Hansson <ulf.hansson@linaro.org>

For u8500 and using 100MHz as the frequency also requires the ape opp 100
voltage, thus use the prcmu_opp_volt_scalable clock type.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/clk/ux500/u8500_clk.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/ux500/u8500_clk.c b/drivers/clk/ux500/u8500_clk.c
index ca4a25e..7bebf1f 100644
--- a/drivers/clk/ux500/u8500_clk.c
+++ b/drivers/clk/ux500/u8500_clk.c
@@ -170,10 +170,11 @@ void u8500_clk_init(void)
 	clk_register_clkdev(clk, NULL, "mtu0");
 	clk_register_clkdev(clk, NULL, "mtu1");
 
-	clk = clk_reg_prcmu_gate("sdmmcclk", NULL, PRCMU_SDMMCCLK, CLK_IS_ROOT);
+	clk = clk_reg_prcmu_opp_volt_scalable("sdmmcclk", NULL, PRCMU_SDMMCCLK,
+					100000000,
+					CLK_IS_ROOT|CLK_SET_RATE_GATE);
 	clk_register_clkdev(clk, NULL, "sdmmc");
 
-
 	clk = clk_reg_prcmu_scalable("dsi_pll", "hdmiclk",
 				PRCMU_PLLDSI, 0, CLK_SET_RATE_GATE);
 	clk_register_clkdev(clk, "dsihs2", "mcde");
-- 
1.7.10
