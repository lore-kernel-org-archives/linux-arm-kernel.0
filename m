From: will.deacon@arm.com (Will Deacon)
Date: Wed, 27 May 2015 17:25:58 +0100
Subject: [PATCH v2 1/3] Documentation: dt-bindings: Add device-tree binding
 for ARM SMMUv3 IOMMU
In-Reply-To: <1432743960-25205-1-git-send-email-will.deacon@arm.com>
References: <1432743960-25205-1-git-send-email-will.deacon@arm.com>
Message-ID: <1432743960-25205-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds device-tree bindings for ARM SMMUv3 IOMMU devices.

Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 .../devicetree/bindings/iommu/arm,smmu-v3.txt      | 37 ++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
new file mode 100644
index 000000000000..c03eec116872
--- /dev/null
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
@@ -0,0 +1,37 @@
+* ARM SMMUv3 Architecture Implementation
+
+The SMMUv3 architecture is a significant deparature from previous
+revisions, replacing the MMIO register interface with in-memory command
+and event queues and adding support for the ATS and PRI components of
+the PCIe specification.
+
+** SMMUv3 required properties:
+
+- compatible        : Should include:
+
+                      * "arm,smmu-v3" for any SMMUv3 compliant
+                        implementation. This entry should be last in the
+                        compatible list.
+
+- reg               : Base address and size of the SMMU.
+
+- interrupts        : Non-secure interrupt list describing the wired
+                      interrupt sources corresponding to entries in
+                      interrupt-names. If no wired interrupts are
+                      present then this property may be omitted.
+
+- interrupt-names   : When the interrupts property is present, should
+                      include the following:
+                      * "eventq"    - Event Queue not empty
+                      * "priq"      - PRI Queue not empty
+                      * "cmdq-sync" - CMD_SYNC complete
+                      * "gerror"    - Global Error activated
+
+** SMMUv3 optional properties:
+
+- dma-coherent      : Present if DMA operations made by the SMMU (page
+                      table walks, stream table accesses etc) are cache
+                      coherent with the CPU.
+
+                      NOTE: this only applies to the SMMU itself, not
+                      masters connected upstream of the SMMU.
-- 
2.1.4
