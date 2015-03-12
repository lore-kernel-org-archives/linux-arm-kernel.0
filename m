From: eliad@wizery.com (Eliad Peller)
Date: Thu, 12 Mar 2015 14:09:11 +0200
Subject: [PATCH v6 3/6] dt: bindings: add TI's wilink wireless device
In-Reply-To: <1426162154-8716-1-git-send-email-eliad@wizery.com>
References: <1426162154-8716-1-git-send-email-eliad@wizery.com>
Message-ID: <1426162154-8716-4-git-send-email-eliad@wizery.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device tree binding documentation for TI's wilink
(wl12xx and wl18xx) wlan chip.

Signed-off-by: Eliad Peller <eliad@wizery.com>
---
v6: add wl12xx, use IRQ_TYPE_LEVEL_HIGH

 .../devicetree/bindings/net/wireless/ti,wlcore.txt | 47 ++++++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/wireless/ti,wlcore.txt

diff --git a/Documentation/devicetree/bindings/net/wireless/ti,wlcore.txt b/Documentation/devicetree/bindings/net/wireless/ti,wlcore.txt
new file mode 100644
index 0000000..2a3d90d
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/wireless/ti,wlcore.txt
@@ -0,0 +1,47 @@
+TI Wilink 6/7/8 (wl12xx/wl18xx) SDIO devices
+
+This node provides properties for controlling the wilink wireless device. The
+node is expected to be specified as a child node to the SDIO controller that
+connects the device to the system.
+
+Required properties:
+ - compatible: should be one of the following:
+    * "ti,wl1271"
+    * "ti,wl1273"
+    * "ti,wl1281"
+    * "ti,wl1283"
+    * "ti,wl1801"
+    * "ti,wl1805"
+    * "ti,wl1807"
+    * "ti,wl1831"
+    * "ti,wl1835"
+    * "ti,wl1837"
+ - interrupts : specifies attributes for the out-of-band interrupt.
+
+Optional properties:
+ - interrupt-parent : the phandle for the interrupt controller to which the
+	device interrupts are connected.
+ - ref-clock-frequency : ref clock frequency in Hz
+ - tcxo-clock-frequency : tcxo clock frequency in Hz
+
+Note: the *-clock-frequency properties assume internal clocks. In case of external
+clock, new bindings (for parsing the clock nodes) have to be added.
+
+Example:
+
+&mmc3 {
+	status = "okay";
+	vmmc-supply = <&wlan_en_reg>;
+	bus-width = <4>;
+	cap-power-off-card;
+	keep-power-in-suspend;
+
+	#address-cells = <1>;
+	#size-cells = <0>;
+	wlcore: wlcore at 2 {
+		compatible = "ti,wl1835";
+		reg = <2>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <19 IRQ_TYPE_LEVEL_HIGH>;
+	};
+};
-- 
1.8.5.2.229.g4448466.dirty
