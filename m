From: hoegeun.kwon@samsung.com (Hoegeun Kwon)
Date: Fri, 14 Apr 2017 14:19:37 +0900
Subject: [PATCH 1/3] dt-bindings: Add support for samsung s6e3ha2 edge panel
 binding
In-Reply-To: <1492147179-7824-1-git-send-email-hoegeun.kwon@samsung.com>
References: <1492147179-7824-1-git-send-email-hoegeun.kwon@samsung.com>
 <CGME20170414051959epcas5p3917fe7adbc17a42bf0450a46b2baf55d@epcas5p3.samsung.com>
Message-ID: <1492147179-7824-2-git-send-email-hoegeun.kwon@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Samsung s6e3ha2 edge is a 5.65" 1600x2560 AMOLED panel connected
using MIPI-DSI interfaces.

Signed-off-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
---
 .../bindings/display/panel/samsung,s6e3ha2-e.txt   | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/samsung,s6e3ha2-e.txt

diff --git a/Documentation/devicetree/bindings/display/panel/samsung,s6e3ha2-e.txt b/Documentation/devicetree/bindings/display/panel/samsung,s6e3ha2-e.txt
new file mode 100644
index 0000000..09c65f6
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/samsung,s6e3ha2-e.txt
@@ -0,0 +1,28 @@
+Samsung S6E3HA2 5.65" 1600x2560 AMOLED panel
+
+Required properties:
+  - compatible: "samsung,s6e3ha2-e"
+  - reg: the virtual channel number of a DSI peripheral
+  - vdd3-supply: I/O voltage supply
+  - vci-supply: voltage supply for analog circuits
+  - reset-gpios: a GPIO spec for the reset pin (active low)
+  - enable-gpios: a GPIO spec for the panel enable pin (active high)
+
+Optional properties:
+  - te-gpios: a GPIO spec for the tearing effect synchronization signal
+    gpio pin (active high)
+
+Example:
+&dsi {
+	...
+
+	panel at 0 {
+		compatible = "samsung,s6e3ha2-e";
+		reg = <0>;
+		vdd3-supply = <&ldo27_reg>;
+		vci-supply = <&ldo28_reg>;
+		reset-gpios = <&gpg0 0 GPIO_ACTIVE_LOW>;
+		enable-gpios = <&gpf1 5 GPIO_ACTIVE_HIGH>;
+		te-gpios = <&gpf1 3 GPIO_ACTIVE_HIGH>;
+	};
+};
-- 
1.9.1
