From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Fri, 23 Nov 2018 15:18:27 +0100
Subject: [PATCH 08/12] dt-bindings: PCI: aardvark: describe the PHY property
In-Reply-To: <20181123141831.8214-1-miquel.raynal@bootlin.com>
References: <20181123141831.8214-1-miquel.raynal@bootlin.com>
Message-ID: <20181123141831.8214-9-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document the possibility to reference a PHY.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 Documentation/devicetree/bindings/pci/aardvark-pci.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/aardvark-pci.txt b/Documentation/devicetree/bindings/pci/aardvark-pci.txt
index c275c3e39cde..b41c69968e38 100644
--- a/Documentation/devicetree/bindings/pci/aardvark-pci.txt
+++ b/Documentation/devicetree/bindings/pci/aardvark-pci.txt
@@ -24,6 +24,7 @@ contain the following properties:
 The following are optional properties:
 
  - reset-gpios: GPIO to reset the device
+ - phys: the PCIe PHY handle
 
 In addition, the Device Tree describing an Aardvark PCIe controller
 must include a sub-node that describes the legacy interrupt controller
@@ -55,6 +56,7 @@ Example:
 				<0 0 0 3 &pcie_intc 2>,
 				<0 0 0 4 &pcie_intc 3>;
 		reset-gpios = <&gpiosb 3 GPIO_ACTIVE_HIGH>;
+		phys = <&comphy1 0>;
 		pcie_intc: interrupt-controller {
 			interrupt-controller;
 			#interrupt-cells = <1>;
-- 
2.19.1
