From: icenowy@aosc.io (Icenowy Zheng)
Date: Tue,  1 Aug 2017 21:12:57 +0800
Subject: [PATCH 06/13] clk: sunxi-ng: export CLK_PLL_DE for H3
In-Reply-To: <20170801131304.7741-1-icenowy@aosc.io>
References: <20170801131304.7741-1-icenowy@aosc.io>
Message-ID: <20170801131304.7741-7-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CLK_PLL_DE is needed to be referenced in device tree for H3, for
both forcing the parent of PLL_DE.

So export it to the device tree binding header.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 drivers/clk/sunxi-ng/ccu-sun8i-h3.h      | 3 +--
 include/dt-bindings/clock/sun8i-h3-ccu.h | 2 ++
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-h3.h b/drivers/clk/sunxi-ng/ccu-sun8i-h3.h
index 1b4baea37d81..add3a7c18212 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-h3.h
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-h3.h
@@ -35,9 +35,8 @@
 #define CLK_PLL_PERIPH0_2X	10
 #define CLK_PLL_GPU		11
 #define CLK_PLL_PERIPH1		12
-#define CLK_PLL_DE		13
 
-/* The CPUX clock is exported */
+/* The PLL_DE and CPUX clocks is exported */
 
 #define CLK_AXI			15
 #define CLK_AHB1		16
diff --git a/include/dt-bindings/clock/sun8i-h3-ccu.h b/include/dt-bindings/clock/sun8i-h3-ccu.h
index e139fe5c62ec..5345957a8c2e 100644
--- a/include/dt-bindings/clock/sun8i-h3-ccu.h
+++ b/include/dt-bindings/clock/sun8i-h3-ccu.h
@@ -45,6 +45,8 @@
 
 #define CLK_PLL_PERIPH0		9
 
+#define CLK_PLL_DE		13
+
 #define CLK_CPUX		14
 
 #define CLK_BUS_CE		20
-- 
2.13.0
