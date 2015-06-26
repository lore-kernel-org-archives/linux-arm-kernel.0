From: thunder.leizhen@huawei.com (Zhen Lei)
Date: Fri, 26 Jun 2015 16:33:03 +0800
Subject: [PATCH 7/8] iommu/arm-smmu: enlarge STRTAB_L1_SZ_SHIFT to support
 larger sidsize
In-Reply-To: <1435307584-9812-1-git-send-email-thunder.leizhen@huawei.com>
References: <1435307584-9812-1-git-send-email-thunder.leizhen@huawei.com>
Message-ID: <1435307584-9812-8-git-send-email-thunder.leizhen@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Because we will choose the minimum value between STRTAB_L1_SZ_SHIFT and
IDR1.SIDSIZE, so enlarge STRTAB_L1_SZ_SHIFT will not impact the platforms
whose IDR1.SIDSIZE is smaller than old STRTAB_L1_SZ_SHIFT value.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/arm-smmu-v3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 87c3d9b..d799feb 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -206,7 +206,7 @@
  * Linear: Enough to cover 1 << IDR1.SIDSIZE entries
  * 2lvl: 8k L1 entries, 256 lazy entries per table (each table covers a PCI bus)
  */
-#define STRTAB_L1_SZ_SHIFT		16
+#define STRTAB_L1_SZ_SHIFT		20
 #define STRTAB_SPLIT			8

 #define STRTAB_L1_DESC_DWORDS		1
--
1.8.0
