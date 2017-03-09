From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Thu, 9 Mar 2017 13:27:21 +0530
Subject: [PATCH v3 10/23] dt-bindings: PCI: Add dt bindings for pci designware
 EP mode
In-Reply-To: <1489046254-19919-1-git-send-email-kishon@ti.com>
References: <1489046254-19919-1-git-send-email-kishon@ti.com>
Message-ID: <1489046254-19919-11-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device tree binding documentation for pci designware EP mode.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 .../devicetree/bindings/pci/designware-pcie.txt    |   26 ++++++++++++++------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/designware-pcie.txt b/Documentation/devicetree/bindings/pci/designware-pcie.txt
index 1392c70..b2480dd 100644
--- a/Documentation/devicetree/bindings/pci/designware-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/designware-pcie.txt
@@ -6,30 +6,40 @@ Required properties:
 - reg-names: Must be "config" for the PCIe configuration space.
     (The old way of getting the configuration address space from "ranges"
     is deprecated and should be avoided.)
+- num-lanes: number of lanes to use
+RC mode:
 - #address-cells: set to <3>
 - #size-cells: set to <2>
 - device_type: set to "pci"
 - ranges: ranges for the PCI memory and I/O regions
 - #interrupt-cells: set to <1>
-- interrupt-map-mask and interrupt-map: standard PCI properties
-	to define the mapping of the PCIe interface to interrupt
+- interrupt-map-mask and interrupt-map: standard PCI
+	properties to define the mapping of the PCIe interface to interrupt
 	numbers.
-- num-lanes: number of lanes to use
+EP mode:
+- num-ib-windows: number of inbound address translation
+        windows
+- num-ob-windows: number of outbound address translation
+        windows
 
 Optional properties:
-- num-viewport: number of view ports configured in hardware.  If a platform
-  does not specify it, the driver assumes 2.
 - num-lanes: number of lanes to use (this property should be specified unless
   the link is brought already up in BIOS)
 - reset-gpio: gpio pin number of power good signal
-- bus-range: PCI bus numbers covered (it is recommended for new devicetrees to
-  specify this property, to keep backwards compatibility a range of 0x00-0xff
-  is assumed if not present)
 - clocks: Must contain an entry for each entry in clock-names.
 	See ../clocks/clock-bindings.txt for details.
 - clock-names: Must include the following entries:
 	- "pcie"
 	- "pcie_bus"
+RC mode:
+- num-viewport: number of view ports configured in
+  hardware. If a platform does not specify it, the driver assumes 2.
+- bus-range: PCI bus numbers covered (it is recommended
+  for new devicetrees to specify this property, to keep backwards
+  compatibility a range of 0x00-0xff is assumed if not present)
+EP mode:
+- max-functions: maximum number of functions that can be
+  configured
 
 Example configuration:
 
-- 
1.7.9.5
