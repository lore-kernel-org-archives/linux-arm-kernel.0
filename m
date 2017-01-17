From: cedric.madianga@gmail.com (M'boumba Cedric Madianga)
Date: Tue, 17 Jan 2017 16:26:57 +0100
Subject: [PATCH v9 1/5] dt-bindings: Document the STM32 I2C bindings
In-Reply-To: <1484666821-20551-1-git-send-email-cedric.madianga@gmail.com>
References: <1484666821-20551-1-git-send-email-cedric.madianga@gmail.com>
Message-ID: <1484666821-20551-2-git-send-email-cedric.madianga@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds documentation of device tree bindings for the STM32 I2C
controller.

Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/i2c/i2c-stm32.txt          | 33 ++++++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-stm32.txt

diff --git a/Documentation/devicetree/bindings/i2c/i2c-stm32.txt b/Documentation/devicetree/bindings/i2c/i2c-stm32.txt
new file mode 100644
index 0000000..78eaf7b
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-stm32.txt
@@ -0,0 +1,33 @@
+* I2C controller embedded in STMicroelectronics STM32 I2C platform
+
+Required properties :
+- compatible : Must be "st,stm32f4-i2c"
+- reg : Offset and length of the register set for the device
+- interrupts : Must contain the interrupt id for I2C event and then the
+  interrupt id for I2C error.
+- resets: Must contain the phandle to the reset controller.
+- clocks: Must contain the input clock of the I2C instance.
+- A pinctrl state named "default" must be defined to set pins in mode of
+  operation for I2C transfer
+- #address-cells = <1>;
+- #size-cells = <0>;
+
+Optional properties :
+- clock-frequency : Desired I2C bus clock frequency in Hz. If not specified,
+  the default 100 kHz frequency will be used. As only Normal and Fast modes
+  are supported, possible values are 100000 and 400000.
+
+Example :
+
+	i2c at 40005400 {
+		compatible = "st,stm32f4-i2c";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x40005400 0x400>;
+		interrupts = <31>,
+			     <32>;
+		resets = <&rcc 277>;
+		clocks = <&rcc 0 149>;
+		pinctrl-0 = <&i2c1_sda_pin>, <&i2c1_scl_pin>;
+		pinctrl-names = "default";
+	};
-- 
1.9.1
