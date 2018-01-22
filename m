From: philippe.cornu@st.com (Philippe Cornu)
Date: Mon, 22 Jan 2018 16:38:05 +0100
Subject: [PATCH] dt-bindings: display: stm32: add pixel clock mandatory
 property
Message-ID: <20180122153805.23720-1-philippe.cornu@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the DPI/RGB input pixel clock in mandatory properties
because it really offers a better preciseness for timing
computations.

Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
---
Please apply "dt-bindings: display: stm32: correct clock-names
in dsi panel example" before this patch.

Changes in v3: remove the note regarding swapped clock names
  (now in a separate patch).
Changes in v2: put new clock in last position (Rob Herring)

 Documentation/devicetree/bindings/display/st,stm32-ltdc.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/st,stm32-ltdc.txt b/Documentation/devicetree/bindings/display/st,stm32-ltdc.txt
index 3eb1b48b47dd..942b7237ae87 100644
--- a/Documentation/devicetree/bindings/display/st,stm32-ltdc.txt
+++ b/Documentation/devicetree/bindings/display/st,stm32-ltdc.txt
@@ -29,6 +29,7 @@ Mandatory properties specific to STM32 DSI:
 - compatible: "st,stm32-dsi".
 - clock-names:
   - phy pll reference clock string name, must be "ref".
+  - DPI/RGB input pixel clock string name, must be "px_clk".
 - resets: see [5].
 - reset-names: see [5].
 
@@ -97,8 +98,9 @@ Example 2: DSI panel
 			#size-cells = <0>;
 			compatible = "st,stm32-dsi";
 			reg = <0x40016c00 0x800>;
-			clocks = <&rcc 1 CLK_F469_DSI>, <&clk_hse>;
-			clock-names = "pclk", "ref";
+			clocks = <&rcc 1 CLK_F469_DSI>, <&clk_hse>,
+				 <&rcc 1 CLK_LCD>;
+			clock-names = "pclk", "ref", "px_clk";
 			resets = <&rcc STM32F4_APB2_RESET(DSI)>;
 			reset-names = "apb";
 
-- 
2.15.1
