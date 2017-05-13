From: shameerali.kolothum.thodi@huawei.com (shameer)
Date: Sat, 13 May 2017 10:47:25 +0100
Subject: [RFC v1 1/7] iommu/arm-smmu-v3: Add erratum framework structures
In-Reply-To: <20170513094731.3676-1-shameerali.kolothum.thodi@huawei.com>
References: <20170513094731.3676-1-shameerali.kolothum.thodi@huawei.com>
Message-ID: <20170513094731.3676-2-shameerali.kolothum.thodi@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is to introduce an erratum framework to smmu driver similar
to the one in arm_arch_timer code.

Signed-off-by: shameer <shameerali.kolothum.thodi@huawei.com>
---
 drivers/iommu/arm-smmu-v3.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index bbd46ef..a166590 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -660,6 +660,20 @@ static struct arm_smmu_option_prop arm_smmu_options[] = {
 	{ 0, NULL},
 };
 
+enum smmu_erratum_match_type {
+	se_match_dt,
+};
+
+struct smmu_erratum_workaround {
+	enum smmu_erratum_match_type match_type;
+	const void *id;	/* Indicate the Erratum ID */
+	const char *desc_str;
+};
+
+static const struct smmu_erratum_workaround smmu_workarounds[] = {
+
+};
+
 static struct arm_smmu_domain *to_smmu_domain(struct iommu_domain *dom)
 {
 	return container_of(dom, struct arm_smmu_domain, domain);
-- 
2.5.0
