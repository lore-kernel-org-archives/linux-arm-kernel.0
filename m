From: philippe.cornu@st.com (Philippe CORNU)
Date: Tue, 4 Jul 2017 18:30:04 +0200
Subject: [PATCH v1 2/3] dt-bindings: display: panel: Add support for Orise
 Tech otm8009a dsi panel
In-Reply-To: <1499185805-23354-1-git-send-email-philippe.cornu@st.com>
References: <1499185805-23354-1-git-send-email-philippe.cornu@st.com>
Message-ID: <1499185805-23354-3-git-send-email-philippe.cornu@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Orise Tech OTM8009A is a 3.97" 480x800 TFT LCD panel connected using
a MIPI-DSI video interface. Its backlight is managed through the DSI link.

Signed-off-by: Philippe CORNU <philippe.cornu@st.com>
---
 .../bindings/display/panel/orisetech,otm8009a.txt    | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/orisetech,otm8009a.txt

diff --git a/Documentation/devicetree/bindings/display/panel/orisetech,otm8009a.txt b/Documentation/devicetree/bindings/display/panel/orisetech,otm8009a.txt
new file mode 100644
index 0000000..0bb8237
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/orisetech,otm8009a.txt
@@ -0,0 +1,20 @@
+Orise Tech OTM8009A 3.97" 480x800 TFT LCD panel (MIPI-DSI video mode)
+
+The Orise Tech OTM8009A is a 3.97" 480x800 TFT LCD panel connected using
+a MIPI-DSI video interface. Its backlight is managed through the DSI link.
+
+Required properties:
+  - compatible: "orisetech,otm8009a"
+  - reg: the virtual channel number of a DSI peripheral
+  - reset-gpios: a GPIO spec for the reset pin (active low). (Optional)
+
+Example:
+&dsi {
+	...
+
+	panel at 0 {
+		compatible = "orisetech,otm8009a";
+		reg = <0>;
+		reset-gpios = <&gpioh 7 0>;
+	};
+};
-- 
1.9.1
