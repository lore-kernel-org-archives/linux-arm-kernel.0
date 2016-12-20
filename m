From: codekipper@gmail.com (codekipper at gmail.com)
Date: Tue, 20 Dec 2016 11:44:46 +0100
Subject: [linux-sunxi][PATCH] clk: sunxi-ng: A31: Fix spdif clock register
Message-ID: <20161220104446.22638-1-codekipper@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcus Cooper <codekipper@gmail.com>

As the SPDIF was rarely documented on the earlier Allwinner SoCs
it was assumed that it had a similar clock register to the one
described in the H3 User Manual.

However this is not the case and it looks to shares the same setup
as the I2S clock registers.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 drivers/clk/sunxi-ng/ccu-sun6i-a31.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun6i-a31.c b/drivers/clk/sunxi-ng/ccu-sun6i-a31.c
index fc75a335a7ce..4c9a920ff4ab 100644
--- a/drivers/clk/sunxi-ng/ccu-sun6i-a31.c
+++ b/drivers/clk/sunxi-ng/ccu-sun6i-a31.c
@@ -468,8 +468,8 @@ static SUNXI_CCU_MUX_WITH_GATE(daudio0_clk, "daudio0", daudio_parents,
 static SUNXI_CCU_MUX_WITH_GATE(daudio1_clk, "daudio1", daudio_parents,
 			       0x0b4, 16, 2, BIT(31), CLK_SET_RATE_PARENT);
 
-static SUNXI_CCU_M_WITH_GATE(spdif_clk, "spdif", "pll-audio",
-			     0x0c0, 0, 4, BIT(31), CLK_SET_RATE_PARENT);
+static SUNXI_CCU_MUX_WITH_GATE(spdif_clk, "spdif", daudio_parents,
+			       0x0c0, 16, 2, BIT(31), CLK_SET_RATE_PARENT);
 
 static SUNXI_CCU_GATE(usb_phy0_clk,	"usb-phy0",	"osc24M",
 		      0x0cc, BIT(8), 0);
-- 
2.11.0
