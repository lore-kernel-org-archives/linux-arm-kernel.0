From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 11 Aug 2013 23:49:16 +0200
Subject: [PATCH] clk: ux500: Remove BML8580 clock
Message-ID: <1376257756-23575-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lee Jones <lee.jones@linaro.org>

There is no mention of the PRCMU_BML8580CLK in any of the Design
Specifications for the chips supported in Mainline. In fact, where it
is incorrectly used in the u8540 clock definition driver it would
have the side effect of using the incorrect clock management address
([PRCM_BML8580CLK_MGT] 0x108 instead of the correct value 0x04C).

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/clk/ux500/u8540_clk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/ux500/u8540_clk.c b/drivers/clk/ux500/u8540_clk.c
index f262588..20c8add 100644
--- a/drivers/clk/ux500/u8540_clk.c
+++ b/drivers/clk/ux500/u8540_clk.c
@@ -83,7 +83,7 @@ void u8540_clk_init(u32 clkrst1_base, u32 clkrst2_base, u32 clkrst3_base,
 	clk_register_clkdev(clk, NULL, "lcd");
 	clk_register_clkdev(clk, "lcd", "mcde");
 
-	clk = clk_reg_prcmu_opp_gate("bmlclk", NULL, PRCMU_BML8580CLK,
+	clk = clk_reg_prcmu_opp_gate("bmlclk", NULL, PRCMU_BMLCLK,
 				CLK_IS_ROOT);
 	clk_register_clkdev(clk, NULL, "bml");
 
-- 
1.8.1.4
