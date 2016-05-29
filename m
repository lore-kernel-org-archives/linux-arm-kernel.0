From: carlo@caione.org (Carlo Caione)
Date: Sun, 29 May 2016 13:12:02 +0200
Subject: [PATCH v5 2/3] documentation: Add secure monitor binding documentation
In-Reply-To: <1464520323-19531-1-git-send-email-carlo@caione.org>
References: <1464520323-19531-1-git-send-email-carlo@caione.org>
Message-ID: <1464520323-19531-3-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Carlo Caione <carlo@endlessm.com>

Add the binding documentation for the Amlogic secure monitor driver.

Signed-off-by: Carlo Caione <carlo@endlessm.com>
---
 .../bindings/firmware/meson/meson_sm.txt           | 33 ++++++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/meson/meson_sm.txt

diff --git a/Documentation/devicetree/bindings/firmware/meson/meson_sm.txt b/Documentation/devicetree/bindings/firmware/meson/meson_sm.txt
new file mode 100644
index 0000000..6f0b5bc
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/meson/meson_sm.txt
@@ -0,0 +1,33 @@
+* Amlogic Secure Monitor
+
+In the Amlogic SoCs the Secure Monitor code is used to provide access to the
+NVMEM, enable JTAG, set USB boot, etc...
+
+Required properties for the secure monitor node:
+- compatible: Should be "amlogic,meson-gxbb-sm"
+
+Example:
+
+	firmware {
+		compatible = "simple-bus";
+
+		sm: secure-monitor {
+			compatible = "amlogic,meson-gxbb-sm";
+		};
+	};
+
+Example of the node using the secure monitor:
+
+	#include <dt-bindings/firmware/meson-sm.h>
+
+	...
+
+	efuse: efuse {
+		compatible = "amlogic,meson-gxbb-efuse";
+		secure-monitor = <&sm>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		...
+	};
+
-- 
2.7.4
