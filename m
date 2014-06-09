From: voice.shen@atmel.com (Bo Shen)
Date: Mon, 9 Jun 2014 11:31:45 +0800
Subject: [PATCH v2 3/5] dt: wm8904: add device tree binding document
In-Reply-To: <1402284707-23354-1-git-send-email-voice.shen@atmel.com>
References: <1402284707-23354-1-git-send-email-voice.shen@atmel.com>
Message-ID: <1402284707-23354-4-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---
Changes in v2:
  - List the clock-names, which need by driver.

 Documentation/devicetree/bindings/sound/wm8904.txt | 33 ++++++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/wm8904.txt

diff --git a/Documentation/devicetree/bindings/sound/wm8904.txt b/Documentation/devicetree/bindings/sound/wm8904.txt
new file mode 100644
index 0000000..e99f409
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/wm8904.txt
@@ -0,0 +1,33 @@
+WM8904 audio CODEC
+
+This device supports I2C only.
+
+Required properties:
+  - compatible: "wlf,wm8904"
+  - reg: the I2C address of the device.
+  - clock-names: "mclk"
+  - clocks: reference to
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
