From: zhiqiang.hou@nxp.com (Z.q. Hou)
Date: Wed, 7 Nov 2018 05:35:22 +0000
Subject: [PATCHv3 2/4] dt-bindings: pci: layerscape-pci: removed compatible
 string "snps,dw-pcie"
In-Reply-To: <20181107053500.13575-1-Zhiqiang.Hou@nxp.com>
References: <20181107053500.13575-1-Zhiqiang.Hou@nxp.com>
Message-ID: <20181107053500.13575-3-Zhiqiang.Hou@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Removed the compatible string "snps,dw-pcie", it is for the reference
platform driver for PCI RC IP Protoyping Kits based on the ARC SDP,
so it is not suitable for all platform with designware PCIe controller,
and platform vendors have themselves' drivers.

The compatible string "snsp,dw-pcie" was added by mistake and it's not
matched that time, but it is matched because PCIe drivers has been
collected recently.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
V3:
 - no change

 Documentation/devicetree/bindings/pci/layerscape-pci.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/layerscape-pci.txt b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
index 5eb1c202932f..9b2b8d66d1f4 100644
--- a/Documentation/devicetree/bindings/pci/layerscape-pci.txt
+++ b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
@@ -13,8 +13,8 @@ information.
 
 Required properties:
 - compatible: should contain the platform identifier such as:
-        "fsl,ls1021a-pcie", "snps,dw-pcie"
-        "fsl,ls2080a-pcie", "fsl,ls2085a-pcie", "snps,dw-pcie"
+        "fsl,ls1021a-pcie"
+        "fsl,ls2080a-pcie", "fsl,ls2085a-pcie"
         "fsl,ls2088a-pcie"
         "fsl,ls1088a-pcie"
         "fsl,ls1046a-pcie"
@@ -36,7 +36,7 @@ Required properties:
 Example:
 
 	pcie at 3400000 {
-		compatible = "fsl,ls1021a-pcie", "snps,dw-pcie";
+		compatible = "fsl,ls1021a-pcie";
 		reg = <0x00 0x03400000 0x0 0x00010000   /* controller registers */
 		       0x40 0x00000000 0x0 0x00002000>; /* configuration space */
 		reg-names = "regs", "config";
-- 
2.17.1
