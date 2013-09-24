From: andreas.herrmann@calxeda.com (Andreas Herrmann)
Date: Tue, 24 Sep 2013 17:14:30 +0200
Subject: [PATCH 1/7] iommu/arm-smmu: Switch to arch_initcall for driver
 registration
In-Reply-To: <1380035221-11576-2-git-send-email-andreas.herrmann@calxeda.com>
References: <1380035221-11576-1-git-send-email-andreas.herrmann@calxeda.com>
 <1380035221-11576-2-git-send-email-andreas.herrmann@calxeda.com>
Message-ID: <20130924151430.GT4845@alberich>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

iommu/arm-smmu: Remove bogus semicolon from if conditions

Those prevented proper registration of arm_smmu_ops.

Signed-off-by: Andreas Herrmann <andreas.herrmann@calxeda.com>
---
 drivers/iommu/arm-smmu.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Will,

It seems that I've managed to exclude the very first patch of the
series. Here it is.


Regards,

Andreas

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index f417e89..be56846 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1966,10 +1966,10 @@ static int __init arm_smmu_init(void)
 		return ret;
 
 	/* Oh, for a proper bus abstraction */
-	if (!iommu_present(&platform_bus_type));
+	if (!iommu_present(&platform_bus_type))
 		bus_set_iommu(&platform_bus_type, &arm_smmu_ops);
 
-	if (!iommu_present(&amba_bustype));
+	if (!iommu_present(&amba_bustype))
 		bus_set_iommu(&amba_bustype, &arm_smmu_ops);
 
 	return 0;
-- 
1.7.9.5
