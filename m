From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Thu, 12 Mar 2015 22:55:55 +0100
Subject: [PATCH v3  09/15] dt-bindings: Document the STM32 USART bindings
In-Reply-To: <1426197361-19290-1-git-send-email-maxime.coquelin@st.com>
References: <1426197361-19290-1-git-send-email-maxime.coquelin@st.com>
Message-ID: <1426197361-19290-10-git-send-email-maxime.coquelin@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Maxime Coquelin <mcoquelin.stm32@gmail.com>

This adds documentation of device tree bindings for the
STM32 USART

Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
---
 .../devicetree/bindings/serial/st,stm32-usart.txt  | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/st,stm32-usart.txt

diff --git a/Documentation/devicetree/bindings/serial/st,stm32-usart.txt b/Documentation/devicetree/bindings/serial/st,stm32-usart.txt
new file mode 100644
index 0000000..090a3a4
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/st,stm32-usart.txt
@@ -0,0 +1,32 @@
+* STMicroelectronics STM32 USART
+
+Required properties:
+- compatible: Can be either "st,stm32-usart" or "st,stm32-uart" depending on
+whether the device supports synchronous mode.
+- reg: The address and length of the peripheral registers space
+- interrupts: The interrupt line of the USART instance
+- clocks: The input clock of the USART instance
+
+Optional properties:
+- pinctrl: The reference on the pins configuration
+- st,hw-flow-ctrl: bool flag to enable hardware flow control.
+
+Examples:
+usart4: serial at 40004c00 {
+	compatible = "st,stm32-uart";
+	reg = <0x40004c00 0x400>;
+	interrupts = <52>;
+	clocks = <&clk_pclk1>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usart4>;
+};
+
+usart2: serial at 40004400 {
+	compatible = "st,stm32-usart", "st,stm32-uart";
+	reg = <0x40004400 0x400>;
+	interrupts = <38>;
+	clocks = <&clk_pclk1>;
+	st,hw-flow-ctrl;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usart2 &pinctrl_usart2_rtscts>;
+};
-- 
1.9.1
