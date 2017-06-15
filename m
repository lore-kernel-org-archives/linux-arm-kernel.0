From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Thu, 15 Jun 2017 14:55:37 +0530
Subject: [PATCH] arm: perf: make of_device_ids const
Message-ID: <7b4609967722cb047484394b91ebbc307b8a3d40.1497518589.git.arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

of_device_ids are not supposed to change at runtime. All functions
working with of_device_ids provided by <linux/of.h> work with const
of_device_ids. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 arch/arm/kernel/perf_event_v6.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/perf_event_v6.c b/arch/arm/kernel/perf_event_v6.c
index 96b7a47..8226d0b 100644
--- a/arch/arm/kernel/perf_event_v6.c
+++ b/arch/arm/kernel/perf_event_v6.c
@@ -552,7 +552,7 @@ static int armv6mpcore_pmu_init(struct arm_pmu *cpu_pmu)
 	return 0;
 }
 
-static struct of_device_id armv6_pmu_of_device_ids[] = {
+static const struct of_device_id armv6_pmu_of_device_ids[] = {
 	{.compatible = "arm,arm11mpcore-pmu",	.data = armv6mpcore_pmu_init},
 	{.compatible = "arm,arm1176-pmu",	.data = armv6_1176_pmu_init},
 	{.compatible = "arm,arm1136-pmu",	.data = armv6_1136_pmu_init},
-- 
1.9.1
