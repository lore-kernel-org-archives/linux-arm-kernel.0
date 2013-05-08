From: lee.jones@linaro.org (Lee Jones)
Date: Wed,  8 May 2013 14:29:03 +0100
Subject: [PATCH 3/9] clk: ux500: Provide device enumeration number suffix for
 SMSC911x
In-Reply-To: <1368019749-19455-1-git-send-email-lee.jones@linaro.org>
References: <1368019749-19455-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1368019749-19455-4-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

First Ethernet device has a ".0" appended onto the device name. It
appears that we need this in order to obtain the correct clock.

Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Mike Turquette <mturquette@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/clk/ux500/u8500_clk.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/ux500/u8500_clk.c b/drivers/clk/ux500/u8500_clk.c
index 0b4f35a..80069c3 100644
--- a/drivers/clk/ux500/u8500_clk.c
+++ b/drivers/clk/ux500/u8500_clk.c
@@ -325,7 +325,7 @@ void u8500_clk_init(u32 clkrst1_base, u32 clkrst2_base, u32 clkrst3_base,
 	clk = clk_reg_prcc_pclk("p3_pclk0", "per3clk", clkrst3_base,
 				BIT(0), 0);
 	clk_register_clkdev(clk, "fsmc", NULL);
-	clk_register_clkdev(clk, NULL, "smsc911x");
+	clk_register_clkdev(clk, NULL, "smsc911x.0");
 
 	clk = clk_reg_prcc_pclk("p3_pclk1", "per3clk", clkrst3_base,
 				BIT(1), 0);
-- 
1.7.10.4
