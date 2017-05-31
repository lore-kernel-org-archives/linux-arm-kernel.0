From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 31 May 2017 15:58:23 +0800
Subject: [PATCH v2 5/6] clk: sunxi-ng: a64: Export PLL_PERIPH0 clock for the
 PRCM
In-Reply-To: <20170531075824.657-1-wens@csie.org>
References: <20170531075824.657-1-wens@csie.org>
Message-ID: <20170531075824.657-6-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PRCM takes PLL_PERIPH0 as one of its parents for the AR100 clock.
As such we need to be able to describe this relationship in the device
tree.

Export the PLL_PERIPH0 clock so we can reference it in the PRCM node.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clk/sunxi-ng/ccu-sun50i-a64.h      | 4 +++-
 include/dt-bindings/clock/sun50i-a64-ccu.h | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a64.h b/drivers/clk/sunxi-ng/ccu-sun50i-a64.h
index 9b3cd24b78d2..061b6fbb4f95 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-a64.h
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-a64.h
@@ -31,7 +31,9 @@
 #define CLK_PLL_VIDEO0_2X		8
 #define CLK_PLL_VE			9
 #define CLK_PLL_DDR0			10
-#define CLK_PLL_PERIPH0			11
+
+/* PLL_PERIPH0 exported for PRCM */
+
 #define CLK_PLL_PERIPH0_2X		12
 #define CLK_PLL_PERIPH1			13
 #define CLK_PLL_PERIPH1_2X		14
diff --git a/include/dt-bindings/clock/sun50i-a64-ccu.h b/include/dt-bindings/clock/sun50i-a64-ccu.h
index 370c0a0473fc..d66432c6e675 100644
--- a/include/dt-bindings/clock/sun50i-a64-ccu.h
+++ b/include/dt-bindings/clock/sun50i-a64-ccu.h
@@ -43,6 +43,8 @@
 #ifndef _DT_BINDINGS_CLK_SUN50I_A64_H_
 #define _DT_BINDINGS_CLK_SUN50I_A64_H_
 
+#define CLK_PLL_PERIPH0		11
+
 #define CLK_BUS_MIPI_DSI	28
 #define CLK_BUS_CE		29
 #define CLK_BUS_DMA		30
-- 
2.11.0
