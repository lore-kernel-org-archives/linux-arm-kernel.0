From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Mon, 15 May 2017 19:17:00 +0200
Subject: [PATCH] drivers/perf/arm_pmu: Delete an error message for a failed
 memory allocation in armpmu_alloc()
Message-ID: <24951908-0642-33e8-877b-06988f433a67@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 15 May 2017 19:09:03 +0200

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Link: http://events.linuxfoundation.org/sites/events/files/slides/LCJ16-Refactor_Strings-WSang_0.pdf
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/perf/arm_pmu.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index dc459eb1246b..30f24bb0a1d1 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -787,10 +787,8 @@ struct arm_pmu *armpmu_alloc(void)
 	int cpu;
 
 	pmu = kzalloc(sizeof(*pmu), GFP_KERNEL);
-	if (!pmu) {
-		pr_info("failed to allocate PMU device!\n");
+	if (!pmu)
 		goto out;
-	}
 
 	pmu->hw_events = alloc_percpu(struct pmu_hw_events);
 	if (!pmu->hw_events) {
-- 
2.13.0
