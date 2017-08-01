From: icenowy@aosc.io (Icenowy Zheng)
Date: Tue,  1 Aug 2017 21:13:01 +0800
Subject: [PATCH 10/13] [NOT FOR REVIEW NOW] clk: sunxi: Add
 CLK_SET_RATE_PARENT flag for H3 HDMI clock
In-Reply-To: <20170801131304.7741-1-icenowy@aosc.io>
References: <20170801131304.7741-1-icenowy@aosc.io>
Message-ID: <20170801131304.7741-11-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jernej Skrabec <jernej.skrabec@siol.net>

When setting the HDMI clock of H3, the PLL_VIDEO clock needs to be set.

Add CLK_SET_RATE_PARENT flag for H3 HDMI clock.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 drivers/clk/sunxi-ng/ccu-sun8i-h3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-h3.c b/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
index b1127e8629d9..2ebb3d865b01 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
@@ -474,7 +474,7 @@ static SUNXI_CCU_GATE(avs_clk,		"avs",		"osc24M",
 
 static const char * const hdmi_parents[] = { "pll-video" };
 static SUNXI_CCU_M_WITH_MUX_GATE(hdmi_clk, "hdmi", hdmi_parents,
-				 0x150, 0, 4, 24, 2, BIT(31), 0);
+				 0x150, 0, 4, 24, 2, BIT(31), CLK_SET_RATE_PARENT);
 
 static SUNXI_CCU_GATE(hdmi_ddc_clk,	"hdmi-ddc",	"osc24M",
 		      0x154, BIT(31), 0);
-- 
2.13.0
