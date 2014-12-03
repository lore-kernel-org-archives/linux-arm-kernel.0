From: vishnupatekar0510@gmail.com (vishnupatekar)
Date: Thu,  4 Dec 2014 04:10:41 +0530
Subject: [PATCH 1/3] dts-binding: input: sun7ips2: Device tree bindings for
 Allwinner sun7i A20 PS2 host controller
Message-ID: <1417646441-27649-1-git-send-email-VishnuPatekar0510@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

---
 .../bindings/input/allwinner,sun7i-a20-ps2.txt     |   22 ++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/allwinner,sun7i-a20-ps2.txt

diff --git a/Documentation/devicetree/bindings/input/allwinner,sun7i-a20-ps2.txt b/Documentation/devicetree/bindings/input/allwinner,sun7i-a20-ps2.txt
new file mode 100644
index 0000000..63b6214
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/allwinner,sun7i-a20-ps2.txt
@@ -0,0 +1,22 @@
+* Device tree bindings for Allwinner A20 PS2 host controller
+
+A20 PS2 is dual role controller(PS2 host and PS2 device). These bindings are for PS2 host controller.
+IBM compliant IBM PS2 and AT-compatible keyboard and mouse can be connected.
+
+Required properties:
+
+ - reg             : Offset and length of the register set for the device.
+ - compatible      : Should one of the following:
+                     - "allwinner,sun7i-a20-ps2"
+ - interrupts      : The interrupt line connected to the P2WI peripheral.
+ - clocks          : The gate clk connected to the P2WI peripheral.
+
+
+Example:
+	ps20: ps2 at 0x01c2a000 {
+		compatible = "allwinner,sun7i-a20-ps2";
+		reg = <0x01c2a000 0x400>;
+		interrupts = <0 62 4>;
+		clocks = <&apb1_gates 6>;
+		status = "disabled";
+	};
-- 
1.7.9.5
