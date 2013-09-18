From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 18 Sep 2013 13:14:18 +0100
Subject: [PATCH 21/41] clk: ux500: Remove BML8580 clock
In-Reply-To: <1379506478-16625-1-git-send-email-lee.jones@linaro.org>
References: <1379506478-16625-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1379506478-16625-22-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no mention of the PRCMU_BML8580CLK in any of the Design
Specifications for the chips supported in Mainline. In fact, where it
is incorrectly used in the u8540 clock definition driver it would
have the side effect of using the incorrect clock management address
([PRCM_BML8580CLK_MGT] 0x108 instead of the correct value 0x04C).

Acked-by: Mike Turquette <mturquette@linaro.org>
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
1.8.1.2
