From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Fri, 26 Sep 2014 16:33:49 +0200
Subject: [PATCH v5 03/10] Documentation: bindings: net: add the Marvell PXA168
 Ethernet controller
In-Reply-To: <1411742036-23520-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1411742036-23520-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1411742036-23520-4-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the binding documentation for the Marvell PXA168 Ethernet
controller, following its DT support.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 .../devicetree/bindings/net/marvell-pxa168.txt     | 36 ++++++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/marvell-pxa168.txt

diff --git a/Documentation/devicetree/bindings/net/marvell-pxa168.txt b/Documentation/devicetree/bindings/net/marvell-pxa168.txt
new file mode 100644
index 000000000000..845a148a346e
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/marvell-pxa168.txt
@@ -0,0 +1,36 @@
+* Marvell PXA168 Ethernet Controller
+
+Required properties:
+- compatible: should be "marvell,pxa168-eth".
+- reg: address and length of the register set for the device.
+- interrupts: interrupt for the device.
+- clocks: pointer to the clock for the device.
+
+Optional properties:
+- port-id: Ethernet port number. Should be '0','1' or '2'.
+- #address-cells: must be 1 when using sub-nodes.
+- #size-cells: must be 0 when using sub-nodes.
+- phy-handle: see ethernet.txt file in the same directory.
+- local-mac-address: see ethernet.txt file in the same directory.
+
+Sub-nodes:
+Each PHY can be represented as a sub-node. This is not mandatory.
+
+Sub-nodes required properties:
+- reg: the MDIO address of the PHY.
+
+Example:
+
+	eth0: ethernet at f7b90000 {
+		compatible = "marvell,pxa168-eth";
+		reg = <0xf7b90000 0x10000>;
+		clocks = <&chip CLKID_GETH0>;
+		interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		phy-handle = <&ethphy0>;
+
+		ethphy0: ethernet-phy at 0 {
+			reg = <0>;
+		};
+	};
-- 
1.9.1
