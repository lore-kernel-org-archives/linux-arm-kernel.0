From: thunder.leizhen@huawei.com (Zhen Lei)
Date: Tue, 21 Jul 2015 15:30:33 +0800
Subject: [PATCH v3 5/5] iommu/arm-smmu: describe the limitation of #iommu-cells
In-Reply-To: <1437463833-16112-1-git-send-email-thunder.leizhen@huawei.com>
References: <1437463833-16112-1-git-send-email-thunder.leizhen@huawei.com>
Message-ID: <1437463833-16112-6-git-send-email-thunder.leizhen@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Only support #iommu-cells = <1>.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
index 3443e0f..7d110a1 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
@@ -5,6 +5,12 @@ revisions, replacing the MMIO register interface with in-memory command
 and event queues and adding support for the ATS and PRI components of
 the PCIe specification.

+Please read ./iommu.txt first, here list something special as below:
+
+** SMMUv3 limited properties:
+- #iommu-cells      : fixed to <1>. The pci root device is a special case,
+                      its IDs can be omitted in dts, seems #iommu-cells = <0>.
+
 ** SMMUv3 required properties:

 - compatible        : Should include:
--
1.8.0
