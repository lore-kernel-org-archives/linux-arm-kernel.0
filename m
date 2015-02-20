From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Fri, 20 Feb 2015 19:01:11 +0100
Subject: [PATCH v2 12/18] dt-bindings: Document the STM32 USART bindings
In-Reply-To: <1424455277-29983-1-git-send-email-mcoquelin.stm32@gmail.com>
References: <1424455277-29983-1-git-send-email-mcoquelin.stm32@gmail.com>
Message-ID: <1424455277-29983-13-git-send-email-mcoquelin.stm32@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds documentation of device tree bindings for the
STM32 USART

Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
---
 .../devicetree/bindings/serial/st,stm32-usart.txt      | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/st,stm32-usart.txt

diff --git a/Documentation/devicetree/bindings/serial/st,stm32-usart.txt b/Documentation/devicetree/bindings/serial/st,stm32-usart.txt
new file mode 100644
index 0000000..e49b75ad
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/st,stm32-usart.txt
@@ -0,0 +1,18 @@
+* STMicroelectronics STM32 USART
+
+Required properties:
+- compatible: Should be "st,stm32-usart"
+- reg: The address and length of the peripheral registers space
+- interrupts: The interrupt line of the USART instance
+- clocks: The input clock of the USART instance
+- pinctrl: The reference on the pins configuration
+
+Example:
+usart1: usart at 40011000 {
+	compatible = "st,stm32-usart";
+	reg = <0x40011000 0x400>;
+	interrupts = <37>;
+	clocks = <&clk_pclk2>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usart1>;
+};
-- 
1.9.1
