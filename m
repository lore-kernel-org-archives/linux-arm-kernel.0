From: yannick.fertre@st.com (Yannick Fertre)
Date: Wed, 15 Mar 2017 18:02:07 +0100
Subject: [PATCH v4 1/8] dt-bindings: display: add STM32 LTDC driver
In-Reply-To: <1489597334-16896-1-git-send-email-yannick.fertre@st.com>
References: <1489597334-16896-1-git-send-email-yannick.fertre@st.com>
Message-ID: <1489597334-16896-2-git-send-email-yannick.fertre@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Yannick Fertre <yannick.fertre@st.com>
---
 .../devicetree/bindings/display/st,stm32-ltdc.txt  | 36 ++++++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/st,stm32-ltdc.txt

diff --git a/Documentation/devicetree/bindings/display/st,stm32-ltdc.txt b/Documentation/devicetree/bindings/display/st,stm32-ltdc.txt
new file mode 100644
index 0000000..e8d39c5
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/st,stm32-ltdc.txt
@@ -0,0 +1,36 @@
+* STMicroelectronics STM32 lcd-tft display controller
+
+- ltdc: lcd-tft display controller host
+  must be a sub-node of st-display-subsystem
+  Required properties:
+  - compatible: "st,stm32-ltdc"
+  - reg: Physical base address of the IP registers and length of memory mapped region.
+  - clocks: A list of phandle + clock-specifier pairs, one for each
+    entry in 'clock-names'.
+  - clock-names: A list of clock names. For ltdc it should contain:
+      - "clk-lcd" for the clock feeding the output pixel clock & IP clock.
+  - resets: reset to be used by the device (defined by use of RCC macro).
+  Required nodes:
+    - Video port for RGB output.
+
+Example:
+
+/ {
+	...
+	soc {
+	...
+		ltdc: display-controller at 40016800 {
+			compatible = "st,stm32-ltdc";
+			reg = <0x40016800 0x200>;
+			interrupts = <88>, <89>;
+			resets = <&rcc STM32F4_APB2_RESET(LTDC)>;
+			clocks = <&rcc 1 CLK_LCD>;
+			clock-names = "lcd";
+
+			port {
+				ltdc_out_rgb: endpoint {
+				};
+			};
+		};
+	};
+};
-- 
1.9.1
