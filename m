From: marex@denx.de (Marek Vasut)
Date: Thu, 24 Dec 2015 10:45:30 +0100
Subject: [PATCH] doc: PCI: altera: Fix the 'ranges' property in example
Message-ID: <1450950330-28393-1-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The example does not work on real hardware with the PCIe HIP [1].
The problem is with incorrect "ranges" property in the example, so
one cannot just copy-paste the example into his DT and expect this
to work. This patches aligns the "ranges" in the example with the
reference FPGA design.

[1] http://rocketboards.org/foswiki/view/Projects/PCIeRootPortWithMSI

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Ley Foon Tan <lftan@altera.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/pci/altera-pcie.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/altera-pcie.txt b/Documentation/devicetree/bindings/pci/altera-pcie.txt
index 2951a6a..d2427c1 100644
--- a/Documentation/devicetree/bindings/pci/altera-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/altera-pcie.txt
@@ -44,6 +44,6 @@ Example
 			            <0 0 0 2 &pcie_0 2>,
 			            <0 0 0 3 &pcie_0 3>,
 			            <0 0 0 4 &pcie_0 4>;
-		ranges = <0x82000000 0x00000000 0x00000000 0xc0000000 0x00000000 0x10000000
-			    0x82000000 0x00000000 0x10000000 0xd0000000 0x00000000 0x10000000>;
+		ranges = <0x82000000 0x00000000 0xc0000000 0xc0000000 0x00000000 0x10000000
+			  0x82000000 0x00000000 0xd0000000 0xd0000000 0x00000000 0x10000000>;
 	};
-- 
2.1.4
