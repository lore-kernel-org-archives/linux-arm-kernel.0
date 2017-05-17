From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 17 May 2017 09:40:37 +0200
Subject: [PATCH v3 08/21] clk: sunxi-ng: sun5i: Export video PLLs
In-Reply-To: <cover.463df61c38224ecbfb5bf1cf192deeb63718b693.1495006350.git-series.maxime.ripard@free-electrons.com>
References: <cover.463df61c38224ecbfb5bf1cf192deeb63718b693.1495006350.git-series.maxime.ripard@free-electrons.com>
Message-ID: <5f07c9602419aba17ad6e25e3edb2d7a643f9bdc.1495006350.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The video PLLs are used directly by the HDMI controller. Export them so
that we can use them in our DT node.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Acked-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clk/sunxi-ng/ccu-sun5i.h      | 6 ++++--
 include/dt-bindings/clock/sun5i-ccu.h | 3 +++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun5i.h b/drivers/clk/sunxi-ng/ccu-sun5i.h
index 8144487eb7ca..93a275fbd9a9 100644
--- a/drivers/clk/sunxi-ng/ccu-sun5i.h
+++ b/drivers/clk/sunxi-ng/ccu-sun5i.h
@@ -28,15 +28,17 @@
 #define CLK_PLL_AUDIO_4X	6
 #define CLK_PLL_AUDIO_8X	7
 #define CLK_PLL_VIDEO0		8
-#define CLK_PLL_VIDEO0_2X	9
+
+/* The PLL_VIDEO0_2X is exported for HDMI */
+
 #define CLK_PLL_VE		10
 #define CLK_PLL_DDR_BASE	11
 #define CLK_PLL_DDR		12
 #define CLK_PLL_DDR_OTHER	13
 #define CLK_PLL_PERIPH		14
 #define CLK_PLL_VIDEO1		15
-#define CLK_PLL_VIDEO1_2X	16
 
+/* The PLL_VIDEO1_2X is exported for HDMI */
 /* The CPU clock is exported */
 
 #define CLK_AXI			18
diff --git a/include/dt-bindings/clock/sun5i-ccu.h b/include/dt-bindings/clock/sun5i-ccu.h
index aeb2e2f781fb..81f34d477aeb 100644
--- a/include/dt-bindings/clock/sun5i-ccu.h
+++ b/include/dt-bindings/clock/sun5i-ccu.h
@@ -19,6 +19,9 @@
 
 #define CLK_HOSC		1
 
+#define CLK_PLL_VIDEO0_2X	9
+
+#define CLK_PLL_VIDEO1_2X	16
 #define CLK_CPU			17
 
 #define CLK_AHB_OTG		23
-- 
git-series 0.9.1
