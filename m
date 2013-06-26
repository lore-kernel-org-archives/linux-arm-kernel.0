From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Wed, 26 Jun 2013 12:28:23 +0300
Subject: [PATCH 20/23] iommu/tegra: smmu: Use dt-bindings MACRO
Message-ID: <1372238906-9346-21-git-send-email-hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use dt-bindings MACRO instead of SoC dependent MACROs.

Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
---
 drivers/iommu/tegra-smmu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index ae71721..50eb843 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -41,6 +41,8 @@
 #include <asm/cacheflush.h>
 #include <asm/dma-iommu.h>
 
+#include <dt-bindings/iommu/tegra-swgid.h>
+
 /* bitmap of the page sizes currently supported */
 #define SMMU_IOMMU_PGSIZES	(SZ_4K)
 
@@ -747,7 +749,7 @@ static int smmu_iommu_attach_dev(struct iommu_domain *domain,
 	 * Reserve "page zero" for AVP vectors using a common dummy
 	 * page.
 	 */
-	if (map & HWG_AVPC) {
+	if (map & SWGID(AVPC)) {
 		struct page *page;
 
 		page = as->smmu->avp_vector_page;
-- 
1.8.1.5
