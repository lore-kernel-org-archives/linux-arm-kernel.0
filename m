From: marc_gonzalez@sigmadesigns.com (Marc Gonzalez)
Date: Tue, 20 Jun 2017 10:14:33 +0200
Subject: [PATCH v9 1/3] PCI: Add DT binding for tango PCIe controller
In-Reply-To: <987fac41-80dc-f1d0-ec0b-91ae57b91bfd@sigmadesigns.com>
References: <987fac41-80dc-f1d0-ec0b-91ae57b91bfd@sigmadesigns.com>
Message-ID: <0e6ef385-7634-cde5-198f-ea16267bf5c2@sigmadesigns.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Binding for the Sigma Designs SMP8759 SoC.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
---
 .../devicetree/bindings/pci/tango-pcie.txt         | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/tango-pcie.txt

diff --git a/Documentation/devicetree/bindings/pci/tango-pcie.txt b/Documentation/devicetree/bindings/pci/tango-pcie.txt
new file mode 100644
index 000000000000..244683836a79
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/tango-pcie.txt
@@ -0,0 +1,29 @@
+Sigma Designs Tango PCIe controller
+
+Required properties:
+
+- compatible: "sigma,smp8759-pcie"
+- reg: address/size of PCI configuration space, address/size of register area
+- bus-range: defined by size of PCI configuration space
+- device_type: "pci"
+- #size-cells: <2>
+- #address-cells: <3>
+- msi-controller
+- ranges: translation from system to bus addresses
+- interrupts: spec for misc interrupts, spec for MSI
+
+Example:
+
+	pcie at 2e000 {
+		compatible = "sigma,smp8759-pcie";
+		reg = <0x50000000 0x400000>, <0x2e000 0x100>;
+		bus-range = <0 3>;
+		device_type = "pci";
+		#size-cells = <2>;
+		#address-cells = <3>;
+		msi-controller;
+		ranges = <0x02000000 0x0 0x00400000  0x50400000  0x0 0x3c00000>;
+		interrupts =
+			<54 IRQ_TYPE_LEVEL_HIGH>, /* misc interrupts */
+			<55 IRQ_TYPE_LEVEL_HIGH>; /* MSI */
+	};
-- 
2.11.0
