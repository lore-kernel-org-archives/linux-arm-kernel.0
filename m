From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 30 Jul 2015 17:12:22 +0900
Subject: [PATCH 3/3] i2c: uniphier: add bindings for UniPhier I2C controllers
In-Reply-To: <1438243942-26401-1-git-send-email-yamada.masahiro@socionext.com>
References: <1438243942-26401-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1438243942-26401-4-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Device Tree bindings for two I2C controllers embedded in
UniPhier SoCs.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 .../devicetree/bindings/i2c/i2c-uniphier.txt       | 46 ++++++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-uniphier.txt

diff --git a/Documentation/devicetree/bindings/i2c/i2c-uniphier.txt b/Documentation/devicetree/bindings/i2c/i2c-uniphier.txt
new file mode 100644
index 0000000..e4ddb50
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-uniphier.txt
@@ -0,0 +1,46 @@
+UniPhier I2C controller
+
+Two different types of I2C controller IPs are used on UniPhier SoC platform:
+- FIFO-less I2C controller on PH-LD4, PH1-sLD8 or older SoCs
+- FIFO-builtin I2C controller on PH1-Pro4 or newer SoCs
+
+Required properties:
+- compatible: should be one of the followings:
+	"socionext,uniphier-i2c"  (FIFO-less)
+	"socionext,uniphier-fi2c" (FIFO-builtin)
+- #address-cells: should be 1.
+- #size-cells: should be 0.
+- reg: offset and length of the register set for the device.
+- interrupts: a single interrupt specifier.
+- clocks: phandle to the input clock.
+
+Optional properties:
+- clock-frequency: desired I2C bus frequency in Hz.  The maximum supported
+  value is 400000.  Defaults to 100000 if not specified.
+
+Examples:
+
+- FIFO-less
+
+	i2c0: i2c at 58400000 {
+		compatible = "socionext,uniphier-i2c";
+		reg = <0x58400000 0x40>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		interrupts = <0 41 1>;
+		clocks = <&i2c_clk>;
+		clock-frequency = <100000>;
+	};
+
+
+- FIFO-builtin
+
+	i2c0: i2c at 58780000 {
+		compatible = "socionext,uniphier-fi2c";
+		reg = <0x58780000 0x80>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		interrupts = <0 41 4>;
+		clocks = <&i2c_clk>;
+		clock-frequency = <100000>;
+	};
-- 
1.9.1
