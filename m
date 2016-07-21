From: isubramanian@apm.com (Iyappan Subramanian)
Date: Wed, 20 Jul 2016 23:59:29 -0700
Subject: [PATCH v6 11/12] Documentation: dtb: xgene: Add MDIO node
In-Reply-To: <1469084370-16781-1-git-send-email-isubramanian@apm.com>
References: <1469084370-16781-1-git-send-email-isubramanian@apm.com>
Message-ID: <1469084370-16781-12-git-send-email-isubramanian@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Iyappan Subramanian <isubramanian@apm.com>
Tested-by: Fushen Chen <fchen@apm.com>
Tested-by: Toan Le <toanle@apm.com>
---
 .../devicetree/bindings/net/apm-xgene-mdio.txt     | 37 ++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/apm-xgene-mdio.txt

diff --git a/Documentation/devicetree/bindings/net/apm-xgene-mdio.txt b/Documentation/devicetree/bindings/net/apm-xgene-mdio.txt
new file mode 100644
index 0000000..78722d7
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/apm-xgene-mdio.txt
@@ -0,0 +1,37 @@
+APM X-Gene SoC MDIO node
+
+MDIO node is defined to describe on-chip MDIO controller.
+
+Required properties:
+	- compatible: Must be "apm,xgene-mdio-rgmii" or "apm,xgene-mdio-xfi"
+	- #address-cells: Must be <1>.
+	- #size-cells: Must be <0>.
+	- reg: Address and length of the register set
+	- clocks: Reference to the clock entry
+
+For the phys on the mdio bus, there must be a node with the following fields:
+	- compatible: PHY identifier.  Please refer ./phy.txt for the format.
+	- reg: The ID number for the phy.
+
+Example:
+
+	mdio: mdio at 17020000 {
+		compatible = "apm,xgene-mdio-rgmii";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x0 0x17020000 0x0 0xd100>;
+		clocks = <&menetclk 0>;
+	};
+
+	/* Board-specific peripheral configurations */
+	&mdio {
+		menetphy: phy at 3 {
+			reg = <0x3>;
+		};
+		sgenet0phy: phy at 4 {
+			reg = <0x4>;
+		};
+		sgenet1phy: phy at 5 {
+			reg = <0x5>;
+		};
+	};
-- 
1.9.1
