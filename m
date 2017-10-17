From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 17 Oct 2017 20:18:03 +0800
Subject: [PATCH 06/10] clk: sunxi-ng: sun4i: Export video PLLs
In-Reply-To: <20171017121807.2994-1-wens@csie.org>
References: <20171017121807.2994-1-wens@csie.org>
Message-ID: <20171017121807.2994-7-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jonathan Liu <net147@gmail.com>

The video PLLs are used directly by the HDMI controller. Export them so
that we can use them in our DT node.

Signed-off-by: Jonathan Liu <net147@gmail.com>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clk/sunxi-ng/ccu-sun4i-a10.h      | 4 ++--
 include/dt-bindings/clock/sun4i-a10-ccu.h | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun4i-a10.h b/drivers/clk/sunxi-ng/ccu-sun4i-a10.h
index c5947c7c050e..23c908ad509f 100644
--- a/drivers/clk/sunxi-ng/ccu-sun4i-a10.h
+++ b/drivers/clk/sunxi-ng/ccu-sun4i-a10.h
@@ -29,7 +29,7 @@
 #define CLK_PLL_AUDIO_4X	6
 #define CLK_PLL_AUDIO_8X	7
 #define CLK_PLL_VIDEO0		8
-#define CLK_PLL_VIDEO0_2X	9
+/* The PLL_VIDEO0_2X clock is exported */
 #define CLK_PLL_VE		10
 #define CLK_PLL_DDR_BASE	11
 #define CLK_PLL_DDR		12
@@ -38,7 +38,7 @@
 #define CLK_PLL_PERIPH		15
 #define CLK_PLL_PERIPH_SATA	16
 #define CLK_PLL_VIDEO1		17
-#define CLK_PLL_VIDEO1_2X	18
+/* The PLL_VIDEO1_2X clock is exported */
 #define CLK_PLL_GPU		19
 
 /* The CPU clock is exported */
diff --git a/include/dt-bindings/clock/sun4i-a10-ccu.h b/include/dt-bindings/clock/sun4i-a10-ccu.h
index c5a53f38d654..e4fa61be5c75 100644
--- a/include/dt-bindings/clock/sun4i-a10-ccu.h
+++ b/include/dt-bindings/clock/sun4i-a10-ccu.h
@@ -43,6 +43,8 @@
 #define _DT_BINDINGS_CLK_SUN4I_A10_H_
 
 #define CLK_HOSC		1
+#define CLK_PLL_VIDEO0_2X	9
+#define CLK_PLL_VIDEO1_2X	18
 #define CLK_CPU			20
 
 /* AHB Gates */
-- 
2.14.2
