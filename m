From: icenowy@aosc.io (Icenowy Zheng)
Date: Thu, 18 May 2017 00:43:52 +0800
Subject: [RFC PATCH 09/11] clk: sunxi-ng: export CLK_PLL_DE for H3
In-Reply-To: <20170517164354.16399-1-icenowy@aosc.io>
References: <20170517164354.16399-1-icenowy@aosc.io>
Message-ID: <20170517164354.16399-10-icenowy@aosc.io>
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
index 85973d1e8165..7029091a6c9f 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-h3.h
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-h3.h
@@ -33,9 +33,8 @@
 #define CLK_PLL_PERIPH0_2X	10
 #define CLK_PLL_GPU		11
 #define CLK_PLL_PERIPH1		12
-#define CLK_PLL_DE		13
 
-/* The CPUX clock is exported */
+/* The PLL_DE and CPUX clocks is exported */
 
 #define CLK_AXI			15
 #define CLK_AHB1		16
diff --git a/include/dt-bindings/clock/sun8i-h3-ccu.h b/include/dt-bindings/clock/sun8i-h3-ccu.h
index c2afc41d6964..82496a57efd4 100644
--- a/include/dt-bindings/clock/sun8i-h3-ccu.h
+++ b/include/dt-bindings/clock/sun8i-h3-ccu.h
@@ -43,6 +43,8 @@
 #ifndef _DT_BINDINGS_CLK_SUN8I_H3_H_
 #define _DT_BINDINGS_CLK_SUN8I_H3_H_
 
+#define CLK_PLL_DE		13
+
 #define CLK_CPUX		14
 
 #define CLK_BUS_CE		20
-- 
2.12.2
