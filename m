From: antoine.tenart@free-electrons.com (=?UTF-8?q?Antoine=20T=C3=A9nart?=)
Date: Wed, 14 May 2014 11:48:58 +0200
Subject: [PATCH v3 2/6] Documentation: bindings: add the Berlin SATA PHY
In-Reply-To: <1400060942-10588-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1400060942-10588-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1400060942-10588-3-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Berlin SATA PHY drives the PHY related to the SATA interface and
allows to power up/down each PHY independently. Add the corresponding
documentation.

Signed-off-by: Antoine T?nart <antoine.tenart@free-electrons.com>
---
 .../devicetree/bindings/phy/berlin-sata-phy.txt    | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/berlin-sata-phy.txt

diff --git a/Documentation/devicetree/bindings/phy/berlin-sata-phy.txt b/Documentation/devicetree/bindings/phy/berlin-sata-phy.txt
new file mode 100644
index 000000000000..b1e11a25775a
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/berlin-sata-phy.txt
@@ -0,0 +1,34 @@
+Berlin SATA PHY
+---------------
+
+Required properties:
+- compatible: "marvell,berlin-sata-phy"
+- #address-cells: number of cells to encode an address, must be 1
+- #size-cells: number of cells representing the size of an address, must be 0
+- reg: address and length of the register
+
+The SATA PHY node is a provider and should contain sub-nodes representing the
+PHYs it handles, one per PHY.
+
+Required sub-node properties:
+- reg: the PHY described. 0 or 1.
+- #phy-cells: from the generic PHY bindings, must be 0
+
+Example:
+	sata_phy: phy at f7e900a0 {
+		compatible = "marvell,berlin-sata-phy";
+		reg = <0xf7e900a0 0x10>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "okay";
+
+		sata_phy0: phy at 0 {
+			reg = <0>;
+			#phy-cells = <0>;
+		};
+
+		sata_phy1: phy at 1 {
+			reg = <1>;
+			#phy-cells = <0>;
+		};
+	};
-- 
1.9.1
