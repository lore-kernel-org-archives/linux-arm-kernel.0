From: robin.murphy@arm.com (Robin Murphy)
Date: Fri,  9 Sep 2016 19:17:48 +0100
Subject: [PATCH 4.5/20] Docs: dt: document ARM SMMUv3 generic binding usage
In-Reply-To: <cover.1473173789.git.robin.murphy@arm.com>
References: <cover.1473173789.git.robin.murphy@arm.com>
Message-ID: <6067fc2b12b3bc681687753eedd941c8244c22fa.1473443407.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we've ratified SMMUv3's use of the generic binding, document it.

CC: Rob Herring <robh+dt@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
index 7b94c88cf2ee..69a694f70bea 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
@@ -27,6 +27,12 @@ the PCIe specification.
                       * "cmdq-sync" - CMD_SYNC complete
                       * "gerror"    - Global Error activated
 
+- #iommu-cells      : See the generic IOMMU binding described in
+                        devicetree/bindings/iommu/iommu.txt
+                      for details. For SMMUv3, must be 1, with each cell
+                      describing a single stream ID. All possible stream
+                      ID which a device may emit must be described.
+
 ** SMMUv3 optional properties:
 
 - dma-coherent      : Present if DMA operations made by the SMMU (page
@@ -54,6 +60,6 @@ the PCIe specification.
                              <GIC_SPI 79 IRQ_TYPE_EDGE_RISING>;
                 interrupt-names = "eventq", "priq", "cmdq-sync", "gerror";
                 dma-coherent;
-                #iommu-cells = <0>;
+                #iommu-cells = <1>;
                 msi-parent = <&its 0xff0000>;
         };
-- 
2.8.1.dirty
