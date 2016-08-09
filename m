From: bharat.kumar.gogada@xilinx.com (Bharat Kumar Gogada)
Date: Tue, 9 Aug 2016 19:30:09 +0530
Subject: [PATCH] PCI: Xilinx NWL PCIe: Updating device tree documentation with
 prefetchable memory space
Message-ID: <1470751209-31203-1-git-send-email-bharatku@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Updating device tree documentation with prefetchable memory
sapce.
Configuration space shifted to 64-bit address space.

Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
---
 Documentation/devicetree/bindings/pci/xilinx-nwl-pcie.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/xilinx-nwl-pcie.txt b/Documentation/devicetree/bindings/pci/xilinx-nwl-pcie.txt
index 337fc97..3259798 100644
--- a/Documentation/devicetree/bindings/pci/xilinx-nwl-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/xilinx-nwl-pcie.txt
@@ -55,9 +55,10 @@ nwl_pcie: pcie at fd0e0000 {
 	msi-parent = <&nwl_pcie>;
 	reg = <0x0 0xfd0e0000 0x0 0x1000>,
 	      <0x0 0xfd480000 0x0 0x1000>,
-	      <0x0 0xe0000000 0x0 0x1000000>;
+	      <0x80 0x00000000 0x0 0x1000000>;
 	reg-names = "breg", "pcireg", "cfg";
-	ranges = <0x02000000 0x00000000 0xe1000000 0x00000000 0xe1000000 0 0x0f000000>;
+	ranges = <0x02000000 0x00000000 0xe0000000 0x00000000 0xe0000000 0x00000000 0x10000000  /* non-prefetchable memory */
+		  0x43000000 0x00000006 0x00000000 0x00000006 0x00000000 0x00000002 0x00000000>;/* prefetchable memory */
 
 	pcie_intc: legacy-interrupt-controller {
 		interrupt-controller;
-- 
2.1.1
