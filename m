From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Sat, 19 May 2018 20:31:15 +0200
Subject: [PATCH 03/15] clk: sunxi-ng: r40: Export video PLLs
In-Reply-To: <20180519183127.2718-1-jernej.skrabec@siol.net>
References: <20180519183127.2718-1-jernej.skrabec@siol.net>
Message-ID: <20180519183127.2718-4-jernej.skrabec@siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Video PLLs need to be referenced in R40 DT as possible HDMI PHY parent.

Export them.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/clk/sunxi-ng/ccu-sun8i-r40.h      | 8 ++++++--
 include/dt-bindings/clock/sun8i-r40-ccu.h | 4 ++++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-r40.h b/drivers/clk/sunxi-ng/ccu-sun8i-r40.h
index 0db8e1e97af8..db2a1243f9ff 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-r40.h
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-r40.h
@@ -25,7 +25,9 @@
 #define CLK_PLL_AUDIO_2X	4
 #define CLK_PLL_AUDIO_4X	5
 #define CLK_PLL_AUDIO_8X	6
-#define CLK_PLL_VIDEO0		7
+
+/* PLL_VIDEO0 is exported */
+
 #define CLK_PLL_VIDEO0_2X	8
 #define CLK_PLL_VE		9
 #define CLK_PLL_DDR0		10
@@ -34,7 +36,9 @@
 #define CLK_PLL_PERIPH0_2X	13
 #define CLK_PLL_PERIPH1		14
 #define CLK_PLL_PERIPH1_2X	15
-#define CLK_PLL_VIDEO1		16
+
+/* PLL_VIDEO1 is exported */
+
 #define CLK_PLL_VIDEO1_2X	17
 #define CLK_PLL_SATA		18
 #define CLK_PLL_SATA_OUT	19
diff --git a/include/dt-bindings/clock/sun8i-r40-ccu.h b/include/dt-bindings/clock/sun8i-r40-ccu.h
index 4fa5f69fc297..f9e15a235626 100644
--- a/include/dt-bindings/clock/sun8i-r40-ccu.h
+++ b/include/dt-bindings/clock/sun8i-r40-ccu.h
@@ -43,6 +43,10 @@
 #ifndef _DT_BINDINGS_CLK_SUN8I_R40_H_
 #define _DT_BINDINGS_CLK_SUN8I_R40_H_
 
+#define CLK_PLL_VIDEO0		7
+
+#define CLK_PLL_VIDEO1		16
+
 #define CLK_CPU			24
 
 #define CLK_BUS_MIPI_DSI	29
-- 
2.17.0
