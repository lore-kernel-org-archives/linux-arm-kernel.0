From: jeremy.linton@arm.com (Jeremy Linton)
Date: Tue, 23 Aug 2016 15:47:54 -0500
Subject: [PATCH v7 3/9] arm64: pmu: Hoist pmu platform device name
In-Reply-To: <1471985280-2243-1-git-send-email-jeremy.linton@arm.com>
References: <1471985280-2243-1-git-send-email-jeremy.linton@arm.com>
Message-ID: <1471985280-2243-4-git-send-email-jeremy.linton@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the PMU name into a common header file so it may
be referenced by other users.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 arch/arm64/kernel/perf_event.c | 2 +-
 include/linux/perf/arm_pmu.h   | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index f650548..356fa6c 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -1099,7 +1099,7 @@ static int armv8_pmu_device_probe(struct platform_device *pdev)
 
 static struct platform_driver armv8_pmu_driver = {
 	.driver		= {
-		.name	= "armv8-pmu",
+		.name	= ARMV8_PMU_PDEV_NAME,
 		.of_match_table = armv8_pmu_of_device_ids,
 	},
 	.probe		= armv8_pmu_device_probe,
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index 65d8e27..ef4b760 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -154,6 +154,8 @@ int arm_pmu_device_probe(struct platform_device *pdev,
 			 const struct of_device_id *of_table,
 			 const struct pmu_probe_info *probe_table);
 
+#define ARMV8_PMU_PDEV_NAME "armv8-pmu"
+
 #endif /* CONFIG_ARM_PMU */
 
 #endif /* __ARM_PMU_H__ */
-- 
2.5.5
