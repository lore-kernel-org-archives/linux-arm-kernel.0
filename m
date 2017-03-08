From: hoegeun.kwon@samsung.com (Hoegeun Kwon)
Date: Wed, 08 Mar 2017 10:42:35 +0900
Subject: [PATCH v11 1/3] dt-bindings: Add support for samsung s6e3ha2 panel
 binding
In-Reply-To: <1488937357-5623-1-git-send-email-hoegeun.kwon@samsung.com>
References: <1488937357-5623-1-git-send-email-hoegeun.kwon@samsung.com>
 <CGME20170308014258epcas5p3f1ae559dedf1d7561d2690d7777437db@epcas5p3.samsung.com>
Message-ID: <1488937357-5623-2-git-send-email-hoegeun.kwon@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Samsung s6e3ha2 is a 5.7" 1440x2560 AMOLED panel connected
using MIPI-DSI interfaces.

Signed-off-by: Donghwa Lee <dh09.lee@samsung.com>
Signed-off-by: Hyungwon Hwang <human.hwang@samsung.com>
Signed-off-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../bindings/display/panel/samsung,s6e3ha2.txt     | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/samsung,s6e3ha2.txt

diff --git a/Documentation/devicetree/bindings/display/panel/samsung,s6e3ha2.txt b/Documentation/devicetree/bindings/display/panel/samsung,s6e3ha2.txt
new file mode 100644
index 0000000..18854f4
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/samsung,s6e3ha2.txt
@@ -0,0 +1,28 @@
+Samsung S6E3HA2 5.7" 1440x2560 AMOLED panel
+
+Required properties:
+  - compatible: "samsung,s6e3ha2"
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
+		compatible = "samsung,s6e3ha2";
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
