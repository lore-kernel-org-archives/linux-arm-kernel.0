From: antoine.tenart@free-electrons.com (=?UTF-8?q?Antoine=20T=C3=A9nart?=)
Date: Mon,  7 Jul 2014 12:16:08 +0200
Subject: [PATCH v9 2/7] Documentation: bindings: add the Berlin SATA PHY
In-Reply-To: <1404728173-20263-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1404728173-20263-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1404728173-20263-3-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Berlin SATA PHY drives the PHY related to the SATA interface. Add
the corresponding documentation.

Signed-off-by: Antoine T?nart <antoine.tenart@free-electrons.com>
---
 .../devicetree/bindings/phy/berlin-sata-phy.txt    | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/berlin-sata-phy.txt

diff --git a/Documentation/devicetree/bindings/phy/berlin-sata-phy.txt b/Documentation/devicetree/bindings/phy/berlin-sata-phy.txt
new file mode 100644
index 000000000000..88f8c23384c0
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/berlin-sata-phy.txt
@@ -0,0 +1,34 @@
+Berlin SATA PHY
+---------------
+
+Required properties:
+- compatible: should be "marvell,berlin2q-sata-phy"
+- address-cells: should be 1
+- size-cells: should be 0
+- phy-cells: from the generic PHY bindings, must be 1
+- reg: address and length of the register
+- clocks: reference to the clock entry
+
+Sub-nodes:
+Each PHY should be represented as a sub-node.
+
+Sub-nodes required properties:
+- reg: the PHY number
+
+Example:
+	sata_phy: phy at f7e900a0 {
+		compatible = "marvell,berlin2q-sata-phy";
+		reg = <0xf7e900a0 0x200>;
+		clocks = <&chip CLKID_SATA>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		#phy-cells = <1>;
+
+		sata-phy at 0 {
+			reg = <0>;
+		};
+
+		sata-phy at 1 {
+			reg = <1>;
+		};
+	};
-- 
1.9.1
