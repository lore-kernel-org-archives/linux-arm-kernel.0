From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 19 Dec 2012 17:19:45 +0000
Subject: [PATCH 2/4] clk: ux500: Ensure the FMSC clock is obtainable
In-Reply-To: <1355937587-31730-1-git-send-email-lee.jones@linaro.org>
References: <1355937587-31730-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1355937587-31730-2-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The FMSC clock is traditionally used for NAND flash devices when
used on the ux500 series platforms. This patch makes it searchable
during a clock-name search.

Cc: Mike Turquette <mturquette@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/clk/ux500/u8500_clk.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/ux500/u8500_clk.c b/drivers/clk/ux500/u8500_clk.c
index 6b889a0..a601802 100644
--- a/drivers/clk/ux500/u8500_clk.c
+++ b/drivers/clk/ux500/u8500_clk.c
@@ -324,7 +324,7 @@ void u8500_clk_init(void)
 
 	clk = clk_reg_prcc_pclk("p3_pclk0", "per3clk", U8500_CLKRST3_BASE,
 				BIT(0), 0);
-	clk_register_clkdev(clk, NULL, "fsmc");
+	clk_register_clkdev(clk, "fsmc", NULL);
 
 	clk = clk_reg_prcc_pclk("p3_pclk1", "per3clk", U8500_CLKRST3_BASE,
 				BIT(1), 0);
-- 
1.7.9.5
