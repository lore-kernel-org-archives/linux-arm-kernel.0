From: plaes@plaes.org (Priit Laes)
Date: Thu,  2 Mar 2017 22:55:27 +0200
Subject: [PATCH] clk: sunxi-ng: sun5i: Fix mux width for csi clock
Message-ID: <20170302205527.23007-1-plaes@plaes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mux for CSI clock is 3 bits, not 2.

Signed-off-by: Priit Laes <plaes@plaes.org>
---
 drivers/clk/sunxi-ng/ccu-sun5i.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun5i.c b/drivers/clk/sunxi-ng/ccu-sun5i.c
index 06edaa5..5c476f9 100644
--- a/drivers/clk/sunxi-ng/ccu-sun5i.c
+++ b/drivers/clk/sunxi-ng/ccu-sun5i.c
@@ -469,7 +469,7 @@ static const char * const csi_parents[] = { "hosc", "pll-video0", "pll-video1",
 static const u8 csi_table[] = { 0, 1, 2, 5, 6 };
 static SUNXI_CCU_M_WITH_MUX_TABLE_GATE(csi_clk, "csi",
 				       csi_parents, csi_table,
-				       0x134, 0, 5, 24, 2, BIT(31), 0);
+				       0x134, 0, 5, 24, 3, BIT(31), 0);
 
 static SUNXI_CCU_GATE(ve_clk,		"ve",		"pll-ve",
 		      0x13c, BIT(31), CLK_SET_RATE_PARENT);
-- 
2.9.3
