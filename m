From: suzuki.katsuhiro@socionext.com (Katsuhiro Suzuki)
Date: Wed, 21 Feb 2018 13:33:10 +0900
Subject: [PATCH 1/2] ASoC: add DT bindings documentation for ROHM BD28623 codec
In-Reply-To: <20180221043311.25840-1-suzuki.katsuhiro@socionext.com>
References: <20180221043311.25840-1-suzuki.katsuhiro@socionext.com>
Message-ID: <20180221043311.25840-2-suzuki.katsuhiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds DT bindings documentation for ROHM BD28623MUV
class D speaker amplifier.

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
---
 .../devicetree/bindings/sound/rohm,bd28623.txt     | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/rohm,bd28623.txt

diff --git a/Documentation/devicetree/bindings/sound/rohm,bd28623.txt b/Documentation/devicetree/bindings/sound/rohm,bd28623.txt
new file mode 100644
index 000000000000..954c689b5b08
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/rohm,bd28623.txt
@@ -0,0 +1,26 @@
+ROHM BD28623MUV Class D speaker amplifier for digital input
+
+This codec does not have any control buses such as I2C, it detect format and
+rate of I2S signal automatically. It has two signals that can be connected
+to GPIOs: reset and mute.
+
+Required properties:
+- compatible      : should be "rohm,bd28623"
+- #sound-dai-cells: should be 0.
+- reset-gpios     : GPIO specifier for the active low reset line
+- mute-gpios      : GPIO specifier for the active low mute line
+
+Optional properties:
+- VCCA-supply : regulator phandle for the VCCA supply
+- VCCP1-supply: regulator phandle for the VCCP1 supply
+- VCCP2-supply: regulator phandle for the VCCP2 supply
+
+Example:
+
+	codec {
+		compatible = "rohm,bd28623";
+		#sound-dai-cells = <0>;
+
+		reset-gpios = <&gpio 0 GPIO_ACTIVE_LOW>;
+		mute-gpios = <&gpio 1 GPIO_ACTIVE_LOW>;
+	};
-- 
2.16.1
