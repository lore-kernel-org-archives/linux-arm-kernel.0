From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 26 Sep 2017 14:59:08 +0800
Subject: [PATCH v2 02/13] clk: sunxi-ng: sun6i: Rename HDMI DDC clock to avoid
 name collision
In-Reply-To: <20170926065919.24446-1-wens@csie.org>
References: <20170926065919.24446-1-wens@csie.org>
Message-ID: <20170926065919.24446-3-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The HDMI DDC clock found in the CCU is the parent of the actual DDC
clock within the HDMI controller. That clock is also named "hdmi-ddc".

Rename the one in the CCU to "hdmi-ddc-parent". This makes more sense
than renaming the one in the HDMI controller to something else.

Fixes: c6e6c96d8fa6 ("clk: sunxi-ng: Add A31/A31s clocks")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clk/sunxi-ng/ccu-sun6i-a31.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun6i-a31.c b/drivers/clk/sunxi-ng/ccu-sun6i-a31.c
index 8af434815fba..14df7c9b07af 100644
--- a/drivers/clk/sunxi-ng/ccu-sun6i-a31.c
+++ b/drivers/clk/sunxi-ng/ccu-sun6i-a31.c
@@ -608,7 +608,8 @@ static SUNXI_CCU_M_WITH_MUX_GATE(hdmi_clk, "hdmi", lcd_ch1_parents,
 				 0x150, 0, 4, 24, 2, BIT(31),
 				 CLK_SET_RATE_PARENT);
 
-static SUNXI_CCU_GATE(hdmi_ddc_clk, "hdmi-ddc", "osc24M", 0x150, BIT(30), 0);
+static SUNXI_CCU_GATE(hdmi_ddc_clk, "hdmi-ddc-parent", "osc24M",
+		      0x150, BIT(30), 0);
 
 static SUNXI_CCU_GATE(ps_clk, "ps", "lcd1-ch1", 0x140, BIT(31), 0);
 
-- 
2.14.1
