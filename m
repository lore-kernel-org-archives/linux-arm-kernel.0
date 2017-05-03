From: wens@csie.org (Chen-Yu Tsai)
Date: Wed,  3 May 2017 11:13:46 +0800
Subject: [PATCH] clk: sunxi-ng: a31: Correct lcd1-ch1 clock register offset
Message-ID: <20170503031346.29174-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The register offset for the lcd1-ch1 clock was incorrectly pointing to
the lcd0-ch1 clock. This resulted in the lcd0-ch1 clock being disabled
when the clk core disables unused clocks. This then stops the simplefb
HDMI output path.

Reported-by: Bob Ham <rah@settrans.net>
Fixes: c6e6c96d8fa6 ("clk: sunxi-ng: Add A31/A31s clocks")
Cc: stable at vger.kernel.org # 4.9.x-
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clk/sunxi-ng/ccu-sun6i-a31.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun6i-a31.c b/drivers/clk/sunxi-ng/ccu-sun6i-a31.c
index 89e68d29bf45..df97e25aec76 100644
--- a/drivers/clk/sunxi-ng/ccu-sun6i-a31.c
+++ b/drivers/clk/sunxi-ng/ccu-sun6i-a31.c
@@ -556,7 +556,7 @@ static SUNXI_CCU_M_WITH_MUX_GATE(lcd0_ch1_clk, "lcd0-ch1", lcd_ch1_parents,
 				 0x12c, 0, 4, 24, 3, BIT(31),
 				 CLK_SET_RATE_PARENT);
 static SUNXI_CCU_M_WITH_MUX_GATE(lcd1_ch1_clk, "lcd1-ch1", lcd_ch1_parents,
-				 0x12c, 0, 4, 24, 3, BIT(31),
+				 0x130, 0, 4, 24, 3, BIT(31),
 				 CLK_SET_RATE_PARENT);
 
 static const char * const csi_sclk_parents[] = { "pll-video0", "pll-video1",
-- 
2.11.0
