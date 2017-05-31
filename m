From: marc_gonzalez@sigmadesigns.com (Marc Gonzalez)
Date: Wed, 31 May 2017 15:30:26 +0200
Subject: [PATCH v5 1/3] PCI: Add DT binding for tango PCIe controller
In-Reply-To: <741766e5-cff2-db5f-d40b-6866e08fd966@sigmadesigns.com>
References: <741766e5-cff2-db5f-d40b-6866e08fd966@sigmadesigns.com>
Message-ID: <69f3ffe7-3c39-fa94-71f8-91744a869cc9@sigmadesigns.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Binding for the Sigma Designs SMP8759 SoC.

Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
---
 Documentation/devicetree/bindings/pci/tango-pcie.txt | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/tango-pcie.txt b/Documentation/devicetree/bindings/pci/tango-pcie.txt
new file mode 100644
index 000000000000..35ef2c811a27
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/tango-pcie.txt
@@ -0,0 +1,30 @@
+Sigma Designs Tango PCIe controller
+
+Required properties:
+
+- compatible: "sigma,smp8759-pcie"
+- reg: address/size of PCI configuration space, address/size of register area
+- device_type: "pci"
+- #size-cells: <2>
+- #address-cells: <3>
+- msi-controller
+- ranges: translation from system to bus addresses
+- interrupts: spec for misc interrupts, spec for MSI
+
+http://elinux.org/Device_Tree_Usage#PCI_Address_Translation
+http://elinux.org/Device_Tree_Usage#Advanced_Interrupt_Mapping
+
+Example:
+
+	pcie at 2e000 {
+		compatible = "sigma,smp8759-pcie";
+		reg = <0x50000000 SZ_4M>, <0x2e000 0x100>;
+		device_type = "pci";
+		#size-cells = <2>;
+		#address-cells = <3>;
+		msi-controller;
+		ranges = <0x02000000 0x0 0x00400000  0x50400000  0x0 SZ_60M>;
+		interrupts =
+			<54 IRQ_TYPE_LEVEL_HIGH>, /* misc interrupts */
+			<55 IRQ_TYPE_LEVEL_HIGH>; /* MSI */
+	};
-- 
2.11.0
