From: thunder.leizhen@huawei.com (Zhen Lei)
Date: Thu, 10 Jul 2014 14:53:06 +0800
Subject: [PATCH v3 13/13] documentation/iommu: Add description of Hisilicon
 SMMU private binding
In-Reply-To: <1404975186-12032-1-git-send-email-thunder.leizhen@huawei.com>
References: <1404975186-12032-1-git-send-email-thunder.leizhen@huawei.com>
Message-ID: <1404975186-12032-14-git-send-email-thunder.leizhen@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a description of private properties for the Hisilicon
System MMU architecture.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.txt | 2 ++
 drivers/iommu/arm-smmu-base.c                        | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
index f284b99..23035ce 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
@@ -1,4 +1,5 @@
 * ARM System MMU Architecture Implementation
+* Hisilicon System MMU Architecture Implementation

 ARM SoCs may contain an implementation of the ARM System Memory
 Management Unit Architecture, which can be used to provide 1 or 2 stages
@@ -15,6 +16,7 @@ conditions.
                         "arm,smmu-v2"
                         "arm,mmu-400"
                         "arm,mmu-500"
+                        "hisilicon,smmu-v1"

                   depending on the particular implementation and/or the
                   version of the architecture implemented.
diff --git a/drivers/iommu/arm-smmu-base.c b/drivers/iommu/arm-smmu-base.c
index d71af43..a0d7c6f 100644
--- a/drivers/iommu/arm-smmu-base.c
+++ b/drivers/iommu/arm-smmu-base.c
@@ -22,6 +22,9 @@
  *	- 4k and 64k pages, with contiguous pte hints.
  *	- Up to 42-bit addressing (dependent on VA_BITS)
  *	- Context fault reporting
+ *
+ * Additional supports:
+ *	- Hisilicon smmu-v1 implementation
  */

 #define pr_fmt(fmt) "arm-smmu: " fmt
--
1.8.0
