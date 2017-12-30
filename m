From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Sat, 30 Dec 2017 22:01:54 +0100
Subject: [PATCH 02/11] clk: sunxi-ng: a83t: Add M divider to TCON1 clock
In-Reply-To: <20171230210203.24115-1-jernej.skrabec@siol.net>
References: <20171230210203.24115-1-jernej.skrabec@siol.net>
Message-ID: <20171230210203.24115-3-jernej.skrabec@siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

TCON1 also has M divider, contrary to TCON0.

Fixes: 05359be1176b ("clk: sunxi-ng: Add driver for A83T CCU")

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/clk/sunxi-ng/ccu-sun8i-a83t.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-a83t.c b/drivers/clk/sunxi-ng/ccu-sun8i-a83t.c
index 04a9c33f53f0..7d08015b980d 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-a83t.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-a83t.c
@@ -504,8 +504,8 @@ static SUNXI_CCU_MUX_WITH_GATE(tcon0_clk, "tcon0", tcon0_parents,
 				 0x118, 24, 3, BIT(31), CLK_SET_RATE_PARENT);
 
 static const char * const tcon1_parents[] = { "pll-video1" };
-static SUNXI_CCU_MUX_WITH_GATE(tcon1_clk, "tcon1", tcon1_parents,
-				 0x11c, 24, 3, BIT(31), CLK_SET_RATE_PARENT);
+static SUNXI_CCU_M_WITH_MUX_GATE(tcon1_clk, "tcon1", tcon1_parents,
+				 0x11c, 0, 4, 24, 2, BIT(31), CLK_SET_RATE_PARENT);
 
 static SUNXI_CCU_GATE(csi_misc_clk, "csi-misc", "osc24M", 0x130, BIT(16), 0);
 
-- 
2.15.1
