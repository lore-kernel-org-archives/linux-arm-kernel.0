From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 16 Dec 2014 22:59:56 +0100
Subject: [PATCH 3/6] ARM: sunxi: DT: Convert the DTs to use a header for the
 DMA arguments
In-Reply-To: <1418767199-20957-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1418767199-20957-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1418767199-20957-3-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DMA engine for the A10/A20 and derivatives require an opaque extra
argument.

Add a dt-bindings header, and convert the device trees to it.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun4i-a10.dtsi    | 14 +++++++---
 arch/arm/boot/dts/sun5i-a10s.dtsi   | 11 ++++++--
 arch/arm/boot/dts/sun5i-a13.dtsi    | 11 ++++++--
 arch/arm/boot/dts/sun7i-a20.dtsi    | 14 +++++++---
 include/dt-bindings/dma/sun4i-a10.h | 56 +++++++++++++++++++++++++++++++++++++
 5 files changed, 92 insertions(+), 14 deletions(-)
 create mode 100644 include/dt-bindings/dma/sun4i-a10.h

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index 69d12ed92406..e78f00d77c00 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -12,6 +12,8 @@
 
 #include "skeleton.dtsi"
 
+#include <dt-bindings/dma/sun4i-a10.h>
+
 / {
 	interrupt-parent = <&intc>;
 
@@ -359,7 +361,8 @@
 			interrupts = <10>;
 			clocks = <&ahb_gates 20>, <&spi0_clk>;
 			clock-names = "ahb", "mod";
-			dmas = <&dma 1 27>, <&dma 1 26>;
+			dmas = <&dma SUN4I_DMA_DEDICATED 27>,
+			       <&dma SUN4I_DMA_DEDICATED 26>;
 			dma-names = "rx", "tx";
 			status = "disabled";
 			#address-cells = <1>;
@@ -372,7 +375,8 @@
 			interrupts = <11>;
 			clocks = <&ahb_gates 21>, <&spi1_clk>;
 			clock-names = "ahb", "mod";
-			dmas = <&dma 1 9>, <&dma 1 8>;
+			dmas = <&dma SUN4I_DMA_DEDICATED 9>,
+			       <&dma SUN4I_DMA_DEDICATED 8>;
 			dma-names = "rx", "tx";
 			status = "disabled";
 			#address-cells = <1>;
@@ -469,7 +473,8 @@
 			interrupts = <12>;
 			clocks = <&ahb_gates 22>, <&spi2_clk>;
 			clock-names = "ahb", "mod";
-			dmas = <&dma 1 29>, <&dma 1 28>;
+			dmas = <&dma SUN4I_DMA_DEDICATED 29>,
+			       <&dma SUN4I_DMA_DEDICATED 28>;
 			dma-names = "rx", "tx";
 			status = "disabled";
 			#address-cells = <1>;
@@ -510,7 +515,8 @@
 			interrupts = <50>;
 			clocks = <&ahb_gates 23>, <&spi3_clk>;
 			clock-names = "ahb", "mod";
-			dmas = <&dma 1 31>, <&dma 1 30>;
+			dmas = <&dma SUN4I_DMA_DEDICATED 31>,
+			       <&dma SUN4I_DMA_DEDICATED 30>;
 			dma-names = "rx", "tx";
 			status = "disabled";
 			#address-cells = <1>;
diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
index 98dbf4dd2db8..1bda98868a3c 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -13,6 +13,8 @@
 
 #include "skeleton.dtsi"
 
+#include <dt-bindings/dma/sun4i-a10.h>
+
 / {
 	interrupt-parent = <&intc>;
 
@@ -320,7 +322,8 @@
 			interrupts = <10>;
 			clocks = <&ahb_gates 20>, <&spi0_clk>;
 			clock-names = "ahb", "mod";
-			dmas = <&dma 1 27>, <&dma 1 26>;
+			dmas = <&dma SUN4I_DMA_DEDICATED 27>,
+			       <&dma SUN4I_DMA_DEDICATED 26>;
 			dma-names = "rx", "tx";
 			status = "disabled";
 			#address-cells = <1>;
@@ -333,7 +336,8 @@
 			interrupts = <11>;
 			clocks = <&ahb_gates 21>, <&spi1_clk>;
 			clock-names = "ahb", "mod";
-			dmas = <&dma 1 9>, <&dma 1 8>;
+			dmas = <&dma SUN4I_DMA_DEDICATED 9>,
+			       <&dma SUN4I_DMA_DEDICATED 8>;
 			dma-names = "rx", "tx";
 			status = "disabled";
 			#address-cells = <1>;
@@ -421,7 +425,8 @@
 			interrupts = <12>;
 			clocks = <&ahb_gates 22>, <&spi2_clk>;
 			clock-names = "ahb", "mod";
-			dmas = <&dma 1 29>, <&dma 1 28>;
+			dmas = <&dma SUN4I_DMA_DEDICATED 29>,
+			       <&dma SUN4I_DMA_DEDICATED 28>;
 			dma-names = "rx", "tx";
 			status = "disabled";
 			#address-cells = <1>;
diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
index c46549244786..9a9241e9f3dd 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -13,6 +13,8 @@
 
 #include "skeleton.dtsi"
 
+#include <dt-bindings/dma/sun4i-a10.h>
+
 / {
 	interrupt-parent = <&intc>;
 
@@ -304,7 +306,8 @@
 			interrupts = <10>;
 			clocks = <&ahb_gates 20>, <&spi0_clk>;
 			clock-names = "ahb", "mod";
-			dmas = <&dma 1 27>, <&dma 1 26>;
+			dmas = <&dma SUN4I_DMA_DEDICATED 27>,
+			       <&dma SUN4I_DMA_DEDICATED 26>;
 			dma-names = "rx", "tx";
 			status = "disabled";
 			#address-cells = <1>;
@@ -317,7 +320,8 @@
 			interrupts = <11>;
 			clocks = <&ahb_gates 21>, <&spi1_clk>;
 			clock-names = "ahb", "mod";
-			dmas = <&dma 1 9>, <&dma 1 8>;
+			dmas = <&dma SUN4I_DMA_DEDICATED 9>,
+			       <&dma SUN4I_DMA_DEDICATED 8>;
 			dma-names = "rx", "tx";
 			status = "disabled";
 			#address-cells = <1>;
@@ -380,7 +384,8 @@
 			interrupts = <12>;
 			clocks = <&ahb_gates 22>, <&spi2_clk>;
 			clock-names = "ahb", "mod";
-			dmas = <&dma 1 29>, <&dma 1 28>;
+			dmas = <&dma SUN4I_DMA_DEDICATED 29>,
+			       <&dma SUN4I_DMA_DEDICATED 28>;
 			dma-names = "rx", "tx";
 			status = "disabled";
 			#address-cells = <1>;
diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index db45d85640ca..4ec6dfc87a02 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -49,6 +49,8 @@
 
 #include "skeleton.dtsi"
 
+#include <dt-bindings/dma/sun4i-a10.h>
+
 / {
 	interrupt-parent = <&gic>;
 
@@ -479,7 +481,8 @@
 			interrupts = <0 10 4>;
 			clocks = <&ahb_gates 20>, <&spi0_clk>;
 			clock-names = "ahb", "mod";
-			dmas = <&dma 1 27>, <&dma 1 26>;
+			dmas = <&dma SUN4I_DMA_DEDICATED 27>,
+			       <&dma SUN4I_DMA_DEDICATED 26>;
 			dma-names = "rx", "tx";
 			status = "disabled";
 			#address-cells = <1>;
@@ -492,7 +495,8 @@
 			interrupts = <0 11 4>;
 			clocks = <&ahb_gates 21>, <&spi1_clk>;
 			clock-names = "ahb", "mod";
-			dmas = <&dma 1 9>, <&dma 1 8>;
+			dmas = <&dma SUN4I_DMA_DEDICATED 9>,
+			       <&dma SUN4I_DMA_DEDICATED 8>;
 			dma-names = "rx", "tx";
 			status = "disabled";
 			#address-cells = <1>;
@@ -589,7 +593,8 @@
 			interrupts = <0 12 4>;
 			clocks = <&ahb_gates 22>, <&spi2_clk>;
 			clock-names = "ahb", "mod";
-			dmas = <&dma 1 29>, <&dma 1 28>;
+			dmas = <&dma SUN4I_DMA_DEDICATED 29>,
+			       <&dma SUN4I_DMA_DEDICATED 28>;
 			dma-names = "rx", "tx";
 			status = "disabled";
 			#address-cells = <1>;
@@ -630,7 +635,8 @@
 			interrupts = <0 50 4>;
 			clocks = <&ahb_gates 23>, <&spi3_clk>;
 			clock-names = "ahb", "mod";
-			dmas = <&dma 1 31>, <&dma 1 30>;
+			dmas = <&dma SUN4I_DMA_DEDICATED 31>,
+			       <&dma SUN4I_DMA_DEDICATED 30>;
 			dma-names = "rx", "tx";
 			status = "disabled";
 			#address-cells = <1>;
diff --git a/include/dt-bindings/dma/sun4i-a10.h b/include/dt-bindings/dma/sun4i-a10.h
new file mode 100644
index 000000000000..8caba9ef7e9d
--- /dev/null
+++ b/include/dt-bindings/dma/sun4i-a10.h
@@ -0,0 +1,56 @@
+/*
+ * Copyright 2014 Maxime Ripard
+ *
+ * Maxime Ripard <maxime.ripard@free-electrons.com>
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of the
+ *     License, or (at your option) any later version.
+ *
+ *     This file is distributed in the hope that it will be useful,
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ *     You should have received a copy of the GNU General Public
+ *     License along with this file; if not, write to the Free
+ *     Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
+ *     MA 02110-1301 USA
+ *
+ * Or, alternatively,
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use,
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#ifndef __DT_BINDINGS_DMA_SUN4I_A10_H_
+#define __DT_BINDINGS_DMA_SUN4I_A10_H_
+
+#define SUN4I_DMA_NORMAL	0
+#define SUN4I_DMA_DEDICATED	1
+
+#endif /* __DT_BINDINGS_DMA_SUN4I_A10_H_ */
-- 
2.2.0
