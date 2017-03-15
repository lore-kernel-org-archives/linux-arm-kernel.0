From: yannick.fertre@st.com (Yannick Fertre)
Date: Wed, 15 Mar 2017 18:02:09 +0100
Subject: [PATCH v4 3/8] dt-bindings: Add Ampire AM-480272H3TMQW-T01H panel
In-Reply-To: <1489597334-16896-1-git-send-email-yannick.fertre@st.com>
References: <1489597334-16896-1-git-send-email-yannick.fertre@st.com>
Message-ID: <1489597334-16896-4-git-send-email-yannick.fertre@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Yannick Fertre <yannick.fertre@st.com>
---
 .../display/panel/ampire,am-480272h3tmqw-t01h.txt  | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/ampire,am-480272h3tmqw-t01h.txt

diff --git a/Documentation/devicetree/bindings/display/panel/ampire,am-480272h3tmqw-t01h.txt b/Documentation/devicetree/bindings/display/panel/ampire,am-480272h3tmqw-t01h.txt
new file mode 100644
index 0000000..e70111f
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/ampire,am-480272h3tmqw-t01h.txt
@@ -0,0 +1,26 @@
+Ampire AM-480272H3TMQW-T01H 4.3" WQVGA TFT LCD panel
+
+This binding is compatible with the simple-panel binding, which is specified
+in simple-panel.txt in this directory.
+
+Required properties:
+- compatible: should be "ampire,am-480272h3tmqw-t01h"
+
+Optional properties:
+- power-supply: regulator to provide the supply voltage
+- enable-gpios: GPIO pin to enable or disable the panel
+- backlight: phandle of the backlight device attached to the panel
+
+Optional nodes:
+- Video port for RGB input.
+
+Example:
+	panel_rgb: panel-rgb {
+		compatible = "ampire,am-480272h3tmqw-t01h";
+		enable-gpios = <&gpioa 8 1>;
+		port {
+			panel_in_rgb: endpoint {
+				remote-endpoint = <&controler_out_rgb>;
+			};
+		};
+	};
-- 
1.9.1
