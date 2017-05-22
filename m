From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 22 May 2017 14:25:47 +0800
Subject: [PATCH 1/6] clk: sunxi-ng: a83t: Fix PLL lock status register offset
In-Reply-To: <20170522062552.19026-1-wens@csie.org>
References: <20170522062552.19026-1-wens@csie.org>
Message-ID: <20170522062552.19026-2-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The offset for the PLL lock status register was incorrectly set to
0x208, which actually points to an unused register. The correct
register offset is 0x20c.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clk/sunxi-ng/ccu-sun8i-a83t.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-a83t.c b/drivers/clk/sunxi-ng/ccu-sun8i-a83t.c
index 4a201a7e03b8..a9c5cc87d9d0 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-a83t.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-a83t.c
@@ -28,7 +28,7 @@
 
 #include "ccu-sun8i-a83t.h"
 
-#define CCU_SUN8I_A83T_LOCK_REG	0x208
+#define CCU_SUN8I_A83T_LOCK_REG	0x20c
 
 /*
  * The CPU PLLs are actually NP clocks, with P being /1 or /4. However
-- 
2.11.0
