From: ttnguyen@apm.com (Tai Nguyen)
Date: Wed, 12 Oct 2016 09:39:27 -0700
Subject: [PATCH] perf: xgene: Remove bogus IS_ERR() check
Message-ID: <1476290367-8092-1-git-send-email-ttnguyen@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the warning issue with static checker.
The bug is reported in [1]

[1] https://www.spinics.net/lists/arm-kernel/msg535957.html

Signed-off-by: Tai Nguyen <ttnguyen@apm.com>
---
 drivers/perf/xgene_pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/perf/xgene_pmu.c b/drivers/perf/xgene_pmu.c
index c2ac764..a8ac4bc 100644
--- a/drivers/perf/xgene_pmu.c
+++ b/drivers/perf/xgene_pmu.c
@@ -1011,7 +1011,7 @@ xgene_pmu_dev_ctx *acpi_get_pmu_hw_inf(struct xgene_pmu *xgene_pmu,
 	rc = acpi_dev_get_resources(adev, &resource_list,
 				    acpi_pmu_dev_add_resource, &res);
 	acpi_dev_free_resource_list(&resource_list);
-	if (rc < 0 || IS_ERR(&res)) {
+	if (rc < 0) {
 		dev_err(dev, "PMU type %d: No resource address found\n", type);
 		goto err;
 	}
-- 
1.9.1
