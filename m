From: carlo@caione.org (Carlo Caione)
Date: Fri, 10 Jun 2016 21:44:10 +0200
Subject: [PATCH v7 2/3] documentation: Add secure monitor binding documentation
In-Reply-To: <1465587851-24184-1-git-send-email-carlo@caione.org>
References: <1465587851-24184-1-git-send-email-carlo@caione.org>
Message-ID: <1465587851-24184-3-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Carlo Caione <carlo@endlessm.com>

Add the binding documentation for the Amlogic secure monitor driver.

Signed-off-by: Carlo Caione <carlo@endlessm.com>
---
 .../bindings/firmware/meson/meson_sm.txt           | 27 ++++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/meson/meson_sm.txt

diff --git a/Documentation/devicetree/bindings/firmware/meson/meson_sm.txt b/Documentation/devicetree/bindings/firmware/meson/meson_sm.txt
new file mode 100644
index 0000000..d017675
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/meson/meson_sm.txt
@@ -0,0 +1,27 @@
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
+		sm: secure-monitor {
+			compatible = "amlogic,meson-gxbb-sm";
+		};
+	};
+
+Example of the node using the secure monitor:
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
