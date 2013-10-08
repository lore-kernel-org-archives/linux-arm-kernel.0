From: andreas.herrmann@calxeda.com (Andreas Herrmann)
Date: Tue,  8 Oct 2013 12:31:05 +0200
Subject: [PATCH] documentation/iommu: Update description of ARM System MMU
 binding
In-Reply-To: <1381224444-27303-1-git-send-email-andreas.herrmann@calxeda.com>
References: <1381224444-27303-1-git-send-email-andreas.herrmann@calxeda.com>
Message-ID: <1381228265-29313-1-git-send-email-andreas.herrmann@calxeda.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds descriptions fore new properties of device tree
binding for the ARM SMMU architecture. These properties control
arm-smmu driver options.

Cc: Rob Herring <robherring2@gmail.com>
Cc: Grant Likely <grant.likely@linaro.org>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Andreas Herrmann <andreas.herrmann@calxeda.com>
---
 .../devicetree/bindings/iommu/arm,smmu.txt         |   23 ++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
index e34c6cd..6415a88 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
@@ -48,6 +48,28 @@ conditions.
                   from the mmu-masters towards memory) node for this
                   SMMU.
 
+- arm,smmu-isolate-devices : Enable device isolation for all masters
+                             of this SMMU. Ie. each master will be
+                             attached to its own iommu domain.
+
+- arm,smmu-mask-stream-ids : Enable mapping of all StreamIDs to one
+                             context for this SMMU. It is only allowed
+                             if there is one single master. It saves
+                             the need to know and specify all
+                             StreamIDs in cases where just one master
+                             is attached to an SMMU. If StreamIDs are
+                             specified in the mmu-masters property
+                             those are ignored. (The referred device
+                             node must still have a "#stream-id-cells"
+                             property. But it can be set to 0.)
+
+- arm,smmu-secure-config-access : Enable proper handling of buggy
+                                  implementations that always use
+                                  secure access to SMMU configuration
+                                  registers. In this case non-secure
+                                  aliases of secure registers have to
+                                  be used during SMMU configuration.
+
 Example:
 
         smmu {
@@ -67,4 +89,5 @@ Example:
                  */
                 mmu-masters = <&dma0 0xd01d 0xd01e>,
                               <&dma1 0xd11c>;
+                arm,smmu-isolate-devices;
         };
-- 
1.7.9.5
