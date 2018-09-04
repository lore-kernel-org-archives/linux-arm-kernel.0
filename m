From: icenowy@aosc.io (Icenowy Zheng)
Date: Tue,  4 Sep 2018 12:40:49 +0800
Subject: [PATCH v4 07/11] dt-bindings: clock: sun50i-a64-ccu: Add PLL_VIDEO0
 macro
In-Reply-To: <20180904044053.15425-1-icenowy@aosc.io>
References: <20180904044053.15425-1-icenowy@aosc.io>
Message-ID: <20180904044053.15425-8-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jagan Teki <jagan@amarulasolutions.com>

Allwinner A64 HDMI PHY clock has PLL_VIDEO0 as a parent.

Include the macro on dt-bindings so-that the same can be used
while defining CCU clock phandles.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
Changes for v4:
- Dropped PLL_VIDEO1
Changes for v3.1:
- none
Changes for v3:
- collect Rob r-w-b tag
Changes for v2:
- new patch

 drivers/clk/sunxi-ng/ccu-sun50i-a64.h      | 4 +++-
 include/dt-bindings/clock/sun50i-a64-ccu.h | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a64.h b/drivers/clk/sunxi-ng/ccu-sun50i-a64.h
index 061b6fbb4f95..a83951cf0224 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-a64.h
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-a64.h
@@ -27,7 +27,9 @@
 #define CLK_PLL_AUDIO_2X		4
 #define CLK_PLL_AUDIO_4X		5
 #define CLK_PLL_AUDIO_8X		6
-#define CLK_PLL_VIDEO0			7
+
+/* PLL_VIDEO0 exported for HDMI PHY */
+
 #define CLK_PLL_VIDEO0_2X		8
 #define CLK_PLL_VE			9
 #define CLK_PLL_DDR0			10
diff --git a/include/dt-bindings/clock/sun50i-a64-ccu.h b/include/dt-bindings/clock/sun50i-a64-ccu.h
index d66432c6e675..a8ac4cfcdcbc 100644
--- a/include/dt-bindings/clock/sun50i-a64-ccu.h
+++ b/include/dt-bindings/clock/sun50i-a64-ccu.h
@@ -43,6 +43,7 @@
 #ifndef _DT_BINDINGS_CLK_SUN50I_A64_H_
 #define _DT_BINDINGS_CLK_SUN50I_A64_H_
 
+#define CLK_PLL_VIDEO0		7
 #define CLK_PLL_PERIPH0		11
 
 #define CLK_BUS_MIPI_DSI	28
-- 
2.18.0
