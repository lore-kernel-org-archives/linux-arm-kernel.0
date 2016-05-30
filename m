From: pramod.kumar@broadcom.com (Pramod Kumar)
Date: Mon, 30 May 2016 12:40:50 +0530
Subject: [PATCH 6/7] Binding:PHY: Binding doc for NS2 PCIe PHYs.
In-Reply-To: <1464592251-2688-1-git-send-email-pramod.kumar@broadcom.com>
References: <1464592251-2688-1-git-send-email-pramod.kumar@broadcom.com>
Message-ID: <1464592251-2688-7-git-send-email-pramod.kumar@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Binding doc for NS2 PCIe PHYs.

Signed-off-by: Jon Mason <jonmason@broadcom.com>
Signed-off-by: Pramod Kumar <pramod.kumar@broadcom.com>
---
 .../bindings/phy/brcm,mdio-mux-bus-pci.txt         | 27 ++++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/brcm,mdio-mux-bus-pci.txt

diff --git a/Documentation/devicetree/bindings/phy/brcm,mdio-mux-bus-pci.txt b/Documentation/devicetree/bindings/phy/brcm,mdio-mux-bus-pci.txt
new file mode 100644
index 0000000..5b51007
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/brcm,mdio-mux-bus-pci.txt
@@ -0,0 +1,27 @@
+* Broadcom NS2 PCIe PHY binding document
+
+Required bus properties:
+- reg: MDIO Bus number for the MDIO interface
+- #address-cells: must be 1
+- #size-cells: must be 0
+
+Required PHY properties:
+- compatible: should be "brcm,ns2-pcie-phy"
+- reg: MDIO Phy ID for the MDIO interface
+- #phy-cells: must be 0
+
+This is a child bus node of "brcm,mdio-mux-iproc" node.
+
+Example:
+
+mdio at 0 {
+	reg = <0x0>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	pci_phy0: pci-phy at 0 {
+		compatible = "brcm,ns2-pcie-phy";
+		reg = <0x0>;
+		#phy-cells = <0>;
+	};
+};
-- 
1.9.1
