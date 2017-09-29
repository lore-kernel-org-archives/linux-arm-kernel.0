From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 29 Sep 2017 16:22:54 +0800
Subject: [PATCH v3 02/14] clk: sunxi-ng: sun6i: Rename HDMI DDC clock to avoid
 name collision
In-Reply-To: <20170929082306.16193-1-wens@csie.org>
References: <20170929082306.16193-1-wens@csie.org>
Message-ID: <20170929082306.16193-3-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The HDMI DDC clock found in the CCU is the parent of the actual DDC
clock within the HDMI controller. That clock is also named "hdmi-ddc".

Rename the one in the CCU to "ddc". This makes more sense than renaming
the one in the HDMI controller to something else.

Fixes: c6e6c96d8fa6 ("clk: sunxi-ng: Add A31/A31s clocks")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clk/sunxi-ng/ccu-sun6i-a31.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun6i-a31.c b/drivers/clk/sunxi-ng/ccu-sun6i-a31.c
index 8af434815fba..241fb13f1c06 100644
--- a/drivers/clk/sunxi-ng/ccu-sun6i-a31.c
+++ b/drivers/clk/sunxi-ng/ccu-sun6i-a31.c
@@ -608,7 +608,7 @@ static SUNXI_CCU_M_WITH_MUX_GATE(hdmi_clk, "hdmi", lcd_ch1_parents,
 				 0x150, 0, 4, 24, 2, BIT(31),
 				 CLK_SET_RATE_PARENT);
 
-static SUNXI_CCU_GATE(hdmi_ddc_clk, "hdmi-ddc", "osc24M", 0x150, BIT(30), 0);
+static SUNXI_CCU_GATE(hdmi_ddc_clk, "ddc", "osc24M", 0x150, BIT(30), 0);
 
 static SUNXI_CCU_GATE(ps_clk, "ps", "lcd1-ch1", 0x140, BIT(31), 0);
 
-- 
2.14.2
