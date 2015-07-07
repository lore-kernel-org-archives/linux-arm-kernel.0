From: thunder.leizhen@huawei.com (Zhen Lei)
Date: Tue, 7 Jul 2015 11:30:17 +0800
Subject: [PATCH v2 4/9] iommu/arm-smmu: enlarge STRTAB_L1_SZ_SHIFT to support
 larger sidsize
In-Reply-To: <1436239822-14132-1-git-send-email-thunder.leizhen@huawei.com>
References: <1436239822-14132-1-git-send-email-thunder.leizhen@huawei.com>
Message-ID: <1436239822-14132-5-git-send-email-thunder.leizhen@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Because we will choose the minimum value between STRTAB_L1_SZ_SHIFT and
IDR1.SIDSIZE, so enlarge STRTAB_L1_SZ_SHIFT will not impact the platforms
whose IDR1.SIDSIZE is smaller than old STRTAB_L1_SZ_SHIFT value.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/arm-smmu-v3.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 0723034..4e7fd4e 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -199,9 +199,10 @@
  * Stream table.
  *
  * Linear: Enough to cover 1 << IDR1.SIDSIZE entries
- * 2lvl: 8k L1 entries, 256 lazy entries per table (each table covers a PCI bus)
+ * 2lvl: 128k L1 entries,
+ *       256 lazy entries per table (each table covers a PCI bus)
  */
-#define STRTAB_L1_SZ_SHIFT		16
+#define STRTAB_L1_SZ_SHIFT		20
 #define STRTAB_SPLIT			8

 #define STRTAB_L1_DESC_DWORDS		1
--
1.8.0
