From: vishnupatekar0510@gmail.com (Vishnu Patekar)
Date: Sun, 25 Jan 2015 19:10:06 +0530
Subject: [PATCH v5 1/4] sunxi:dts-bindings:input: bindings for A10/A20 ps2
In-Reply-To: <1422193209-17787-1-git-send-email-vishnupatekar0510@gmail.com>
References: <1422193209-17787-1-git-send-email-vishnupatekar0510@gmail.com>
Message-ID: <1422193209-17787-2-git-send-email-vishnupatekar0510@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: VishnuPatekar <vishnupatekar0510@gmail.com>
---
 .../bindings/serio/allwinner,sun4i-ps2.txt         |   23 ++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serio/allwinner,sun4i-ps2.txt

diff --git a/Documentation/devicetree/bindings/serio/allwinner,sun4i-ps2.txt b/Documentation/devicetree/bindings/serio/allwinner,sun4i-ps2.txt
new file mode 100644
index 0000000..0c30440
--- /dev/null
+++ b/Documentation/devicetree/bindings/serio/allwinner,sun4i-ps2.txt
@@ -0,0 +1,23 @@
+* Device tree bindings for Allwinner A10, A20 PS2 host controller
+
+A20 PS2 is dual role controller(PS2 host and PS2 device). These bindings are
+for PS2 A10/A20 host controller. IBM compliant IBM PS2 and AT-compatible keyboard
+and mouse can be connected.
+
+Required properties:
+
+ - reg             : Offset and length of the register set for the device.
+ - compatible      : Should be as of the following:
+                     - "allwinner,sun4i-a10-ps2"
+ - interrupts      : The interrupt line connected to the PS2.
+ - clocks          : The gate clk connected to the PS2.
+
+
+Example:
+	ps20: ps2 at 0x01c2a000 {
+		compatible = "allwinner,sun4i-a10-ps2";
+		reg = <0x01c2a000 0x400>;
+		interrupts = <0 62 4>;
+		clocks = <&apb1_gates 6>;
+		status = "disabled";
+	};
-- 
1.7.9.5
