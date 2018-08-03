From: stelford@cadence.com (Scott Telford)
Date: Fri, 3 Aug 2018 16:08:30 +0100
Subject: [PATCH v3 1/2] dt-bindings: phy: Document Cadence MHDP DisplayPort
 PHY bindings
In-Reply-To: <1533308911-17286-1-git-send-email-stelford@cadence.com>
References: <f4b7167e-a210-2196-07ba-0c22fd88fa64@ti.com>
 <1533308911-17286-1-git-send-email-stelford@cadence.com>
Message-ID: <1533308911-17286-2-git-send-email-stelford@cadence.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Scott Telford <stelford@cadence.com>
---
 .../devicetree/bindings/phy/phy-cadence-dp.txt     | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-cadence-dp.txt

diff --git a/Documentation/devicetree/bindings/phy/phy-cadence-dp.txt b/Documentation/devicetree/bindings/phy/phy-cadence-dp.txt
new file mode 100644
index 0000000..8de0526
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/phy-cadence-dp.txt
@@ -0,0 +1,28 @@
+Cadence MHDP DisplayPort SD0801 PHY binding
+===========================================
+
+This binding describes the Cadence SD0801 PHY hardware included with
+the Cadence MHDP DisplayPort controller.
+
+-------------------------------------------------------------------------------
+Required properties (controller (parent) node):
+- compatible	: Should be "cdns,dp-phy"
+- reg		: Defines the following sets of registers in the parent
+		  mhdp device:
+			- Offset of the DPTX PHY configuration registers
+			- Offset of the SD0801 PHY configuration registers
+- num_lanes	: Number of DisplayPort lanes to use (1, 2 or 4)
+- max_bit_rate	: Maximum DisplayPort link bit rate to use, in Mbps (2160,
+		  2430, 2700, 3240, 4320, 5400 or 8100)
+- #phy-cells	: from the generic PHY bindings, must be 0.
+-------------------------------------------------------------------------------
+
+Example:
+	dp_phy: phy at f0fb030a00 {
+		compatible = "cdns,dp-phy";
+		reg = <0xf0 0xfb030a00 0x0 0x00000040>,
+		      <0xf0 0xfb500000 0x0 0x00100000>;
+		num_lanes = <4>;
+		max_bit_rate = <8100>;
+		#phy-cells = <0>;
+	};
-- 
2.2.2
