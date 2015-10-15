From: thunder.leizhen@huawei.com (Zhen Lei)
Date: Thu, 15 Oct 2015 16:30:47 +0800
Subject: [PATCH v4 5/5] iommu/arm-smmu: describe the limitation of #iommu-cells
In-Reply-To: <1444897847-18040-1-git-send-email-thunder.leizhen@huawei.com>
References: <1444897847-18040-1-git-send-email-thunder.leizhen@huawei.com>
Message-ID: <1444897847-18040-6-git-send-email-thunder.leizhen@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Only support #iommu-cells = <1>.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
index 947863a..4845d44 100644
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
2.5.0
