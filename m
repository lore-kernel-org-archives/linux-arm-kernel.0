From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu,  1 Mar 2018 16:38:14 +0000
Subject: [PATCH v4 1/2] dt-bindings: i2c: add binding for Socionext SynQuacer
 I2C
In-Reply-To: <20180301163815.30595-1-ard.biesheuvel@linaro.org>
References: <20180301163815.30595-1-ard.biesheuvel@linaro.org>
Message-ID: <20180301163815.30595-2-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a binding for the I2C controller that can be found in the Socionext
SynQuacer SoC.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 Documentation/devicetree/bindings/i2c/i2c-synquacer.txt | 29 ++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-synquacer.txt b/Documentation/devicetree/bindings/i2c/i2c-synquacer.txt
new file mode 100644
index 000000000000..72f4a2f0fedc
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-synquacer.txt
@@ -0,0 +1,29 @@
+Socionext SynQuacer I2C
+
+Required properties:
+- compatible      : Must be "socionext,synquacer-i2c"
+- reg             : Offset and length of the register set for the device
+- interrupts      : A single interrupt specifier
+- #address-cells  : Must be <1>;
+- #size-cells     : Must be <0>;
+- clock-names     : Must contain "pclk".
+- clocks          : Must contain an entry for each name in clock-names.
+                    (See the common clock bindings.)
+
+Optional properties:
+- clock-frequency : Desired I2C bus clock frequency in Hz. As only Normal and
+                    Fast modes are supported, possible values are 100000 and
+                    400000.
+
+Example :
+
+    i2c at 51210000 {
+        compatible = "socionext,synquacer-i2c";
+        reg = <0x51210000 0x1000>;
+        interrupts = <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+        clock-names = "pclk";
+        clocks = <&clk_i2c>;
+        clock-frequency = <400000>;
+    };
-- 
2.11.0
