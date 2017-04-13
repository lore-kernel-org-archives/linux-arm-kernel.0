From: robh@kernel.org (Rob Herring)
Date: Thu, 13 Apr 2017 10:03:50 -0500
Subject: [PATCH v3 1/4] dt-bindings: net: Add TI WiLink shared transport
 binding
In-Reply-To: <20170413150353.7389-1-robh@kernel.org>
References: <20170413150353.7389-1-robh@kernel.org>
Message-ID: <20170413150353.7389-2-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add serial slave device binding for the TI WiLink series of Bluetooth/FM/GPS
devices.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: netdev at vger.kernel.org
Cc: devicetree at vger.kernel.org
---
v3:
- rebase on bluetooth-next

 .../devicetree/bindings/net/ti,wilink-st.txt       | 35 ++++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/ti,wilink-st.txt

diff --git a/Documentation/devicetree/bindings/net/ti,wilink-st.txt b/Documentation/devicetree/bindings/net/ti,wilink-st.txt
new file mode 100644
index 000000000000..cbad73a84ac4
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/ti,wilink-st.txt
@@ -0,0 +1,35 @@
+TI WiLink 7/8 (wl12xx/wl18xx) Shared Transport BT/FM/GPS devices
+
+TI WiLink devices have a UART interface for providing Bluetooth, FM radio,
+and GPS over what's called "shared transport". The shared transport is
+standard BT HCI protocol with additional channels for the other functions.
+
+These devices also have a separate WiFi interface as described in
+wireless/ti,wlcore.txt.
+
+This bindings follows the UART slave device binding in
+../serial/slave-device.txt.
+
+Required properties:
+ - compatible: should be one of the following:
+    "ti,wl1271-st"
+    "ti,wl1273-st"
+    "ti,wl1831-st"
+    "ti,wl1835-st"
+    "ti,wl1837-st"
+
+Optional properties:
+ - enable-gpios : GPIO signal controlling enabling of BT. Active high.
+ - vio-supply : Vio input supply (1.8V)
+ - vbat-supply : Vbat input supply (2.9-4.8V)
+
+Example:
+
+&serial0 {
+	compatible = "ns16550a";
+	...
+	bluetooth {
+		compatible = "ti,wl1835-st";
+		enable-gpios = <&gpio1 7 GPIO_ACTIVE_HIGH>;
+	};
+};
-- 
2.11.0
