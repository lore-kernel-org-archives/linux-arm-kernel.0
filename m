From: chaiw.fnst@cn.fujitsu.com (chai wen)
Date: Wed, 22 Oct 2014 16:21:47 +0800
Subject: [PATCH 2/2] ARM: perf: armv7: wrap unsupported arch init functions
 via micro
In-Reply-To: <1413966107-11881-1-git-send-email-chaiw.fnst@cn.fujitsu.com>
References: <1413966107-11881-1-git-send-email-chaiw.fnst@cn.fujitsu.com>
Message-ID: <1413966107-11881-2-git-send-email-chaiw.fnst@cn.fujitsu.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: chai wen <chaiw.fnst@cn.fujitsu.com>
---
 arch/arm/kernel/perf_event_v7.c |   52 +++++++++-----------------------------
 1 files changed, 13 insertions(+), 39 deletions(-)

diff --git a/arch/arm/kernel/perf_event_v7.c b/arch/arm/kernel/perf_event_v7.c
index f66a9b8..6c088e8 100644
--- a/arch/arm/kernel/perf_event_v7.c
+++ b/arch/arm/kernel/perf_event_v7.c
@@ -1459,43 +1459,17 @@ static int krait_pmu_init(struct arm_pmu *cpu_pmu)
 	return 0;
 }
 #else
-static inline int armv7_a8_pmu_init(struct arm_pmu *cpu_pmu)
-{
-	return -ENODEV;
-}
-
-static inline int armv7_a9_pmu_init(struct arm_pmu *cpu_pmu)
-{
-	return -ENODEV;
-}
-
-static inline int armv7_a5_pmu_init(struct arm_pmu *cpu_pmu)
-{
-	return -ENODEV;
-}
-
-static inline int armv7_a15_pmu_init(struct arm_pmu *cpu_pmu)
-{
-	return -ENODEV;
-}
-
-static inline int armv7_a7_pmu_init(struct arm_pmu *cpu_pmu)
-{
-	return -ENODEV;
-}
-
-static inline int armv7_a12_pmu_init(struct arm_pmu *cpu_pmu)
-{
-	return -ENODEV;
-}
-
-static inline int armv7_a17_pmu_init(struct arm_pmu *cpu_pmu)
-{
-	return -ENODEV;
-}
-
-static inline int krait_pmu_init(struct arm_pmu *cpu_pmu)
-{
-	return -ENODEV;
-}
+#define WRAP_UNSUPPORTED_INIT(__FUNC)                           \
+static inline int __FUNC(struct arm_pmu *cpu_pmu)               \
+{                                                               \
+        return -ENODEV;                                         \
+}
+WRAP_UNSUPPORTED_INIT(armv7_a8_pmu_init);
+WRAP_UNSUPPORTED_INIT(armv7_a9_pmu_init);
+WRAP_UNSUPPORTED_INIT(armv7_a5_pmu_init);
+WRAP_UNSUPPORTED_INIT(armv7_a15_pmu_init);
+WRAP_UNSUPPORTED_INIT(armv7_a7_pmu_init);
+WRAP_UNSUPPORTED_INIT(armv7_a12_pmu_init);
+WRAP_UNSUPPORTED_INIT(armv7_a17_pmu_init);
+WRAP_UNSUPPORTED_INIT(krait_pmu_init);
 #endif	/* CONFIG_CPU_V7 */
-- 
1.7.1
