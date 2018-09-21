From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 21 Sep 2018 15:51:45 +0530
Subject: [RFC PATCH 30/40] dt-bindings: PCI: Add PCI RC dt binding
 documentation for AM654
In-Reply-To: <20180921102155.22839-1-kishon@ti.com>
References: <20180921102155.22839-1-kishon@ti.com>
Message-ID: <20180921102155.22839-31-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add devicetree binding documentation for PCIe in RC mode present in
AM654 SoC.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 Documentation/devicetree/bindings/pci/pci-keystone.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/pci-keystone.txt b/Documentation/devicetree/bindings/pci/pci-keystone.txt
index 8ee07197a063..5c60e911b8b1 100644
--- a/Documentation/devicetree/bindings/pci/pci-keystone.txt
+++ b/Documentation/devicetree/bindings/pci/pci-keystone.txt
@@ -11,7 +11,8 @@ described here as well as properties that are not applicable.
 
 Required Properties:-
 
-compatibility: "ti,keystone-pcie"
+compatibility: Should be "ti,keystone-pcie" for RC on Keystone2 SoC
+	       Should be "ti,am654-pcie-rc" for RC on AM654x SoC
 reg: Three register ranges as listed in the reg-names property
 reg-names: "dbics" for the DesignWare PCIe registers, "app" for the
 	   TI specific application registers, "config" for the
@@ -20,6 +21,9 @@ reg-names: "dbics" for the DesignWare PCIe registers, "app" for the
 pcie_msi_intc : Interrupt controller device node for MSI IRQ chip
 	interrupt-cells: should be set to 1
 	interrupts: GIC interrupt lines connected to PCI MSI interrupt lines
+	(required if the compatible is "ti,keystone-pcie")
+msi-map: As specified in Documentation/devicetree/bindings/pci/pci-msi.txt
+	 (required if the compatible is "ti,am654-pcie-rc".
 
 ti,syscon-pcie-id : phandle to the device control module required to set device
 		    id and vendor id.
-- 
2.17.1
