From: wens@csie.org (Chen-Yu Tsai)
Date: Fri,  2 Jun 2017 18:10:20 +0800
Subject: [PATCH 15/19] clk: sunxi-ng: sun6i: Export video PLLs
In-Reply-To: <20170602101024.18940-1-wens@csie.org>
References: <20170602101024.18940-1-wens@csie.org>
Message-ID: <20170602101024.18940-16-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 2x outputs of the 2 video PLL clocks are directly used by the
HDMI controller block.

Export them so they can be referenced in the device tree.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clk/sunxi-ng/ccu-sun6i-a31.h      | 8 ++++++--
 include/dt-bindings/clock/sun6i-a31-ccu.h | 4 ++++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun6i-a31.h b/drivers/clk/sunxi-ng/ccu-sun6i-a31.h
index 4e434011e9e7..27e6ad4133ab 100644
--- a/drivers/clk/sunxi-ng/ccu-sun6i-a31.h
+++ b/drivers/clk/sunxi-ng/ccu-sun6i-a31.h
@@ -27,7 +27,9 @@
 #define CLK_PLL_AUDIO_4X	4
 #define CLK_PLL_AUDIO_8X	5
 #define CLK_PLL_VIDEO0		6
-#define CLK_PLL_VIDEO0_2X	7
+
+/* The PLL_VIDEO0_2X clock is exported */
+
 #define CLK_PLL_VE		8
 #define CLK_PLL_DDR		9
 
@@ -35,7 +37,9 @@
 
 #define CLK_PLL_PERIPH_2X	11
 #define CLK_PLL_VIDEO1		12
-#define CLK_PLL_VIDEO1_2X	13
+
+/* The PLL_VIDEO1_2X clock is exported */
+
 #define CLK_PLL_GPU		14
 #define CLK_PLL_MIPI		15
 #define CLK_PLL9		16
diff --git a/include/dt-bindings/clock/sun6i-a31-ccu.h b/include/dt-bindings/clock/sun6i-a31-ccu.h
index 4482530fb6f5..c5d13340184a 100644
--- a/include/dt-bindings/clock/sun6i-a31-ccu.h
+++ b/include/dt-bindings/clock/sun6i-a31-ccu.h
@@ -43,8 +43,12 @@
 #ifndef _DT_BINDINGS_CLK_SUN6I_A31_H_
 #define _DT_BINDINGS_CLK_SUN6I_A31_H_
 
+#define CLK_PLL_VIDEO0_2X	7
+
 #define CLK_PLL_PERIPH		10
 
+#define CLK_PLL_VIDEO1_2X	13
+
 #define CLK_CPU			18
 
 #define CLK_AHB1_MIPIDSI	23
-- 
2.11.0
