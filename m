From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 14 Feb 2017 10:23:32 +0800
Subject: [PATCH] clk: sunxi-ng: sun6i: Fix enable bit offset for hdmi-ddc
 module clock
Message-ID: <20170214022332.13326-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The enable bit offset for the hdmi-ddc module clock is wrong. It is
pointing to the main hdmi module clock enable bit.

Reported-by: Bob Ham <rah@settrans.net>
Fixes: c6e6c96d8fa6 ("clk: sunxi-ng: Add A31/A31s clocks")
Cc: stable at vger.kernel.org # 4.9.x-
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

Hi Bob,

Can you try this patch and see if it fixes your HDMI issue?
With the kernel running without "clk_ignore_unused" that is.

---
 drivers/clk/sunxi-ng/ccu-sun6i-a31.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun6i-a31.c b/drivers/clk/sunxi-ng/ccu-sun6i-a31.c
index 4c9a920ff4ab..89e68d29bf45 100644
--- a/drivers/clk/sunxi-ng/ccu-sun6i-a31.c
+++ b/drivers/clk/sunxi-ng/ccu-sun6i-a31.c
@@ -608,7 +608,7 @@ static SUNXI_CCU_M_WITH_MUX_GATE(hdmi_clk, "hdmi", lcd_ch1_parents,
 				 0x150, 0, 4, 24, 2, BIT(31),
 				 CLK_SET_RATE_PARENT);
 
-static SUNXI_CCU_GATE(hdmi_ddc_clk, "hdmi-ddc", "osc24M", 0x150, BIT(31), 0);
+static SUNXI_CCU_GATE(hdmi_ddc_clk, "hdmi-ddc", "osc24M", 0x150, BIT(30), 0);
 
 static SUNXI_CCU_GATE(ps_clk, "ps", "lcd1-ch1", 0x140, BIT(31), 0);
 
-- 
2.11.0
