From: voice.shen@atmel.com (Bo Shen)
Date: Thu, 5 Jun 2014 18:19:30 +0800
Subject: [PATCH 3/5] dt: wm8904: add device tree binding document
In-Reply-To: <1401963572-10953-1-git-send-email-voice.shen@atmel.com>
References: <1401963572-10953-1-git-send-email-voice.shen@atmel.com>
Message-ID: <1401963572-10953-4-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---
 Documentation/devicetree/bindings/sound/wm8904.txt | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/wm8904.txt

diff --git a/Documentation/devicetree/bindings/sound/wm8904.txt b/Documentation/devicetree/bindings/sound/wm8904.txt
new file mode 100644
index 0000000..ef3d23da
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/wm8904.txt
@@ -0,0 +1,32 @@
+WM8904 audio CODEC
+
+This device supports I2C only.
+
+Required properties:
+  - compatible: "wlf,wm8904"
+  - reg: the I2C address of the device.
+  - clocks and clock-names: reference to
+    <Documentation/devicetree/bindings/clock/clock-bindings.txt>
+
+Pins on the device (for linking into audio routes):
+
+  * IN1L
+  * IN1R
+  * IN2L
+  * IN2R
+  * IN3L
+  * IN3R
+  * HPOUTL
+  * HPOUTR
+  * LINEOUTL
+  * LINEOUTR
+  * MICBIAS
+
+Examples:
+
+codec: wm8904 at 1a {
+	compatible = "wlf,wm8904";
+	reg = <0x1a>;
+	clocks = <&pck0>;
+	clock-names = "mclk";
+};
-- 
1.8.5.2
