From: philippe.cornu@st.com (Philippe Cornu)
Date: Thu, 26 Oct 2017 18:12:36 +0200
Subject: [PATCH] dt-bindings: display: stm32: add pixel clock mandatory
 property
Message-ID: <1509034356-23885-1-git-send-email-philippe.cornu@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the DPI/RGB input pixel clock in mandatory properties
because it really offers a better preciseness for timing
computations.
Note: Fix also the DSI panel example where "ref" & "pclk"
clocks were swapped.

Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
---
 Documentation/devicetree/bindings/display/st,stm32-ltdc.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/st,stm32-ltdc.txt b/Documentation/devicetree/bindings/display/st,stm32-ltdc.txt
index 0292522..99823fb 100644
--- a/Documentation/devicetree/bindings/display/st,stm32-ltdc.txt
+++ b/Documentation/devicetree/bindings/display/st,stm32-ltdc.txt
@@ -28,6 +28,7 @@ Mandatory properties specific to STM32 DSI:
 - #size-cells: Should be <0>.
 - compatible: "st,stm32-dsi".
 - clock-names:
+  - DPI/RGB input pixel clock string name, must be "px_clk".
   - phy pll reference clock string name, must be "ref".
 - resets: see [5].
 - reset-names: see [5].
@@ -97,8 +98,9 @@ Example 2: DSI panel
 			#size-cells = <0>;
 			compatible = "st,stm32-dsi";
 			reg = <0x40016c00 0x800>;
-			clocks = <&rcc 1 CLK_F469_DSI>, <&clk_hse>;
-			clock-names = "ref", "pclk";
+			clocks = <&rcc 1 CLK_F469_DSI>, <&rcc 1 CLK_LCD>,
+				 <&clk_hse>;
+			clock-names = "pclk", "px_clk", "ref";
 			resets = <&rcc STM32F4_APB2_RESET(DSI)>;
 			reset-names = "apb";
 
-- 
1.9.1
