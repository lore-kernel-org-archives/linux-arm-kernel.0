From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 31 May 2017 15:58:21 +0800
Subject: [PATCH v2 3/6] clk: sunxi-ng: h3: Export PLL_PERIPH0 clock for the
 PRCM
In-Reply-To: <20170531075824.657-1-wens@csie.org>
References: <20170531075824.657-1-wens@csie.org>
Message-ID: <20170531075824.657-4-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PRCM takes PLL_PERIPH0 as one of its parents for the AR100 clock.
As such we need to be able to describe this relationship in the device
tree.

Export the PLL_PERIPH0 clock so we can reference it in the PRCM node.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clk/sunxi-ng/ccu-sun8i-h3.h      | 4 +++-
 include/dt-bindings/clock/sun8i-h3-ccu.h | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-h3.h b/drivers/clk/sunxi-ng/ccu-sun8i-h3.h
index 85973d1e8165..1b4baea37d81 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-h3.h
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-h3.h
@@ -29,7 +29,9 @@
 #define CLK_PLL_VIDEO		6
 #define CLK_PLL_VE		7
 #define CLK_PLL_DDR		8
-#define CLK_PLL_PERIPH0		9
+
+/* PLL_PERIPH0 exported for PRCM */
+
 #define CLK_PLL_PERIPH0_2X	10
 #define CLK_PLL_GPU		11
 #define CLK_PLL_PERIPH1		12
diff --git a/include/dt-bindings/clock/sun8i-h3-ccu.h b/include/dt-bindings/clock/sun8i-h3-ccu.h
index c2afc41d6964..e139fe5c62ec 100644
--- a/include/dt-bindings/clock/sun8i-h3-ccu.h
+++ b/include/dt-bindings/clock/sun8i-h3-ccu.h
@@ -43,6 +43,8 @@
 #ifndef _DT_BINDINGS_CLK_SUN8I_H3_H_
 #define _DT_BINDINGS_CLK_SUN8I_H3_H_
 
+#define CLK_PLL_PERIPH0		9
+
 #define CLK_CPUX		14
 
 #define CLK_BUS_CE		20
-- 
2.11.0
