From: honghui.zhang@mediatek.com (honghui.zhang at mediatek.com)
Date: Fri, 21 Jul 2017 10:32:45 +0800
Subject: [PATCH 3/5] dt-bindings: PCI: rename and cleanup MediaTek binding text
In-Reply-To: <cover.1500601172.git.honghui.zhang@mediatek.com>
References: <cover.1500601172.git.honghui.zhang@mediatek.com>
Message-ID: <c49a1c3ecda24bfb95fe108ff3fd76c04a905676.1500601172.git.honghui.zhang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ryder Lee <ryder.lee@mediatek.com>

In order to accommodate other SoC generations, this patch updates filename
to make it more generic, regroups specific properties by SoCs, and removes
redundant descriptions.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 ...{mediatek,mt7623-pcie.txt => mediatek-pcie.txt} | 29 +++++++++++-----------
 1 file changed, 14 insertions(+), 15 deletions(-)
 rename Documentation/devicetree/bindings/pci/{mediatek,mt7623-pcie.txt => mediatek-pcie.txt} (91%)

diff --git a/Documentation/devicetree/bindings/pci/mediatek,mt7623-pcie.txt b/Documentation/devicetree/bindings/pci/mediatek-pcie.txt
similarity index 91%
rename from Documentation/devicetree/bindings/pci/mediatek,mt7623-pcie.txt
rename to Documentation/devicetree/bindings/pci/mediatek-pcie.txt
index fe80dda..294f4a3 100644
--- a/Documentation/devicetree/bindings/pci/mediatek,mt7623-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/mediatek-pcie.txt
@@ -1,18 +1,13 @@
-MediaTek Gen2 PCIe controller which is available on MT7623 series SoCs
-
-PCIe subsys supports single root complex (RC) with 3 Root Ports. Each root
-ports supports a Gen2 1-lane Link and has PIPE interface to PHY.
+MediaTek Gen2 PCIe controller
 
 Required properties:
-- compatible: Should contain "mediatek,mt7623-pcie".
+- compatible: Should contain one of the following string:
+	"mediatek,mt7623-pcie"
+	"mediatek,mt2701-pcie"
 - device_type: Must be "pci"
 - reg: Base addresses and lengths of the PCIe controller.
 - #address-cells: Address representation for root ports (must be 3)
 - #size-cells: Size representation for root ports (must be 2)
-- #interrupt-cells: Size representation for interrupts (must be 1)
-- interrupt-map-mask and interrupt-map: Standard PCI IRQ mapping properties
-  Please refer to the standard PCI bus binding document for a more detailed
-  explanation.
 - clocks: Must contain an entry for each entry in clock-names.
   See ../clocks/clock-bindings.txt for details.
 - clock-names: Must include the following entries:
@@ -20,12 +15,6 @@ Required properties:
   - sys_ck0 :for clock of Port0
   - sys_ck1 :for clock of Port1
   - sys_ck2 :for clock of Port2
-- resets: Must contain an entry for each entry in reset-names.
-  See ../reset/reset.txt for details.
-- reset-names: Must include the following entries:
-  - pcie-rst0 :port0 reset
-  - pcie-rst1 :port1 reset
-  - pcie-rst2 :port2 reset
 - phys: List of PHY specifiers (used by generic PHY framework).
 - phy-names : Must be "pcie-phy0", "pcie-phy1", "pcie-phyN".. based on the
   number of PHYs as specified in *phys* property.
@@ -34,6 +23,16 @@ Required properties:
 - bus-range: Range of bus numbers associated with this controller.
 - ranges: Ranges for the PCI memory and I/O regions.
 
+Required properties for MT7623/MT2701:
+- #interrupt-cells: Size representation for interrupts (must be 1)
+- interrupt-map-mask and interrupt-map: Standard PCI IRQ mapping properties
+  Please refer to the standard PCI bus binding document for a more detailed
+  explanation.
+- resets: Must contain an entry for each entry in reset-names.
+  See ../reset/reset.txt for details.
+- reset-names: Must be "pcie-rst0", "pcie-rst1", "pcie-rstN".. based on the
+  number of root ports.
+
 In addition, the device tree node must have sub-nodes describing each
 PCIe port interface, having the following mandatory properties:
 
-- 
2.6.4
