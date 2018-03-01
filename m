From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Thu,  1 Mar 2018 22:34:30 +0100
Subject: [PATCH v3 04/16] clk: sunxi-ng: h3: h5: export CLK_PLL_VIDEO
In-Reply-To: <20180301213442.16677-1-jernej.skrabec@siol.net>
References: <20180301213442.16677-1-jernej.skrabec@siol.net>
Message-ID: <20180301213442.16677-5-jernej.skrabec@siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CLK_PLL_VIDEO needs to be referenced in HDMI DT entry as a possible
PHY clock parent.

Export it so it can be used later in DT.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/clk/sunxi-ng/ccu-sun8i-h3.h      | 4 +++-
 include/dt-bindings/clock/sun8i-h3-ccu.h | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-h3.h b/drivers/clk/sunxi-ng/ccu-sun8i-h3.h
index 1b4baea37d81..73d7392c968c 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-h3.h
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-h3.h
@@ -26,7 +26,9 @@
 #define CLK_PLL_AUDIO_2X	3
 #define CLK_PLL_AUDIO_4X	4
 #define CLK_PLL_AUDIO_8X	5
-#define CLK_PLL_VIDEO		6
+
+/* PLL_VIDEO is exported */
+
 #define CLK_PLL_VE		7
 #define CLK_PLL_DDR		8
 
diff --git a/include/dt-bindings/clock/sun8i-h3-ccu.h b/include/dt-bindings/clock/sun8i-h3-ccu.h
index e139fe5c62ec..c5f7e9a70968 100644
--- a/include/dt-bindings/clock/sun8i-h3-ccu.h
+++ b/include/dt-bindings/clock/sun8i-h3-ccu.h
@@ -43,6 +43,8 @@
 #ifndef _DT_BINDINGS_CLK_SUN8I_H3_H_
 #define _DT_BINDINGS_CLK_SUN8I_H3_H_
 
+#define CLK_PLL_VIDEO		6
+
 #define CLK_PLL_PERIPH0		9
 
 #define CLK_CPUX		14
-- 
2.16.2
