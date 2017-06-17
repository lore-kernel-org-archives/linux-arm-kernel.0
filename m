From: shawnguo@kernel.org (Shawn Guo)
Date: Sat, 17 Jun 2017 22:09:33 +0800
Subject: [PATCH 1/2] ASoC: add bindings for ZTE zx-aud96p22 audio codec
In-Reply-To: <1497708574-22380-1-git-send-email-shawnguo@kernel.org>
References: <1497708574-22380-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1497708574-22380-2-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Baoyou Xie <baoyou.xie@linaro.org>

It adds dt-bindings document for ZTE zx-aud96p22 audio codec.

Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 .../devicetree/bindings/sound/zte,zx-aud96p22.txt  | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/zte,zx-aud96p22.txt

diff --git a/Documentation/devicetree/bindings/sound/zte,zx-aud96p22.txt b/Documentation/devicetree/bindings/sound/zte,zx-aud96p22.txt
new file mode 100644
index 000000000000..cb211a295cad
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/zte,zx-aud96p22.txt
@@ -0,0 +1,28 @@
+ZTE ZX AUD96P22 Audio Codec
+
+Required properties:
+ - compatible: Must be "zte,zx-aud96p22"
+ - #sound-dai-cells: Should be 0
+ - reg: I2C bus slave address of AUD96P22
+
+Optional properties:
+ - zte,pa-gpios: The GPIO to enable external power amplifier
+
+Example:
+
+	i2c0: i2c at 1486000 {
+		compatible = "zte,zx296718-i2c";
+		reg = <0x01486000 0x1000>;
+		interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&audiocrm AUDIO_I2C0_WCLK>;
+		clock-frequency = <1600000>;
+
+		aud96p22: codec at 22 {
+			compatible = "zte,zx-aud96p22";
+			#sound-dai-cells = <0>;
+			reg = <0x22>;
+			zte,pa-gpios = <&bgpio4 0 GPIO_ACTIVE_HIGH>;
+		};
+	};
-- 
1.9.1
