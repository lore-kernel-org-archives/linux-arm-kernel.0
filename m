From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 19 Dec 2012 17:19:46 +0000
Subject: [PATCH 3/4] clk: ux500: Provide an alias for the SMSC911x Ethernet
 chip
In-Reply-To: <1355937587-31730-1-git-send-email-lee.jones@linaro.org>
References: <1355937587-31730-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1355937587-31730-3-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the case of some of the ux500 platforms, an Ethernet chip is
placed on an extended bus which is traditionally used as a NAND
flash chip placeholder. The p3_pclk0 clock is used to control it,
so we are required to provide and easy way to access it from the
SMSC911x driver. We do this using an alias provided by this patch.

Cc: Mike Turquette <mturquette@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/clk/ux500/u8500_clk.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/ux500/u8500_clk.c b/drivers/clk/ux500/u8500_clk.c
index a601802..9d9add1 100644
--- a/drivers/clk/ux500/u8500_clk.c
+++ b/drivers/clk/ux500/u8500_clk.c
@@ -325,6 +325,7 @@ void u8500_clk_init(void)
 	clk = clk_reg_prcc_pclk("p3_pclk0", "per3clk", U8500_CLKRST3_BASE,
 				BIT(0), 0);
 	clk_register_clkdev(clk, "fsmc", NULL);
+	clk_register_clkdev(clk, NULL, "smsc911x");
 
 	clk = clk_reg_prcc_pclk("p3_pclk1", "per3clk", U8500_CLKRST3_BASE,
 				BIT(1), 0);
-- 
1.7.9.5
