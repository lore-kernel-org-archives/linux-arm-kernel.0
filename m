From: baoyou.xie@linaro.org (Baoyou Xie)
Date: Wed, 15 Feb 2017 18:55:08 +0800
Subject: [PATCH v1 1/3] ASoC: zx-96p22: add documentation for zte's aud96p22
 controller
Message-ID: <1487156110-12840-1-git-send-email-baoyou.xie@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds dt-binding documentation for zte's aud96p22 controller.

Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
---
 .../devicetree/bindings/sound/zte,zx-96p22.txt     | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/zte,zx-96p22.txt

diff --git a/Documentation/devicetree/bindings/sound/zte,zx-96p22.txt b/Documentation/devicetree/bindings/sound/zte,zx-96p22.txt
new file mode 100644
index 0000000..4184566
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/zte,zx-96p22.txt
@@ -0,0 +1,24 @@
+ZTE zx96p22 controller
+
+Required properties:
+ - compatible : Must be "zte,zx-aud96p22"
+ - #sound-dai-cells: Should be 0
+ - reg : Offset of I2C register for zx96p22
+
+Example:
+
+	audio_i2c0: audio_i2c0 at 1486000 {
+		compatible = "zte,zx296718-i2c";
+		reg = <0x01486000 0x1000>;
+		interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&audiocrm AUDIO_I2C0_WCLK>;
+		clock-frequency = <1600000>;
+		status = "ok";
+		inner_codec: aud96p22 at 22 {
+			compatible = "zte,zx-aud96p22";
+			#sound-dai-cells = <0>;
+			reg = <0x22>;
+		};
+	};
-- 
2.7.4
