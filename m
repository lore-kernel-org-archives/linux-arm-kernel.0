From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Wed, 10 Aug 2016 20:59:16 +0800
Subject: [PATCH 2/2] arm: perf: Use the builtin_platform_driver
In-Reply-To: <1470833956-5619-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1470833956-5619-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <1470833956-5619-2-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the builtin_platform_driver() to simplify code.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/arm/kernel/perf_event_v6.c     | 6 +-----
 arch/arm/kernel/perf_event_v7.c     | 6 +-----
 arch/arm/kernel/perf_event_xscale.c | 6 +-----
 3 files changed, 3 insertions(+), 15 deletions(-)

diff --git a/arch/arm/kernel/perf_event_v6.c b/arch/arm/kernel/perf_event_v6.c
index 09413e7..96b7a47 100644
--- a/arch/arm/kernel/perf_event_v6.c
+++ b/arch/arm/kernel/perf_event_v6.c
@@ -581,9 +581,5 @@ static struct platform_driver armv6_pmu_driver = {
 	.probe		= armv6_pmu_device_probe,
 };
 
-static int __init register_armv6_pmu_driver(void)
-{
-	return platform_driver_register(&armv6_pmu_driver);
-}
-device_initcall(register_armv6_pmu_driver);
+builtin_platform_driver(armv6_pmu_driver);
 #endif	/* CONFIG_CPU_V6 || CONFIG_CPU_V6K */
diff --git a/arch/arm/kernel/perf_event_v7.c b/arch/arm/kernel/perf_event_v7.c
index 1506385..166e98d 100644
--- a/arch/arm/kernel/perf_event_v7.c
+++ b/arch/arm/kernel/perf_event_v7.c
@@ -2025,9 +2025,5 @@ static struct platform_driver armv7_pmu_driver = {
 	.probe		= armv7_pmu_device_probe,
 };
 
-static int __init register_armv7_pmu_driver(void)
-{
-	return platform_driver_register(&armv7_pmu_driver);
-}
-device_initcall(register_armv7_pmu_driver);
+builtin_platform_driver(armv7_pmu_driver);
 #endif	/* CONFIG_CPU_V7 */
diff --git a/arch/arm/kernel/perf_event_xscale.c b/arch/arm/kernel/perf_event_xscale.c
index aa0499e..0e51f5e 100644
--- a/arch/arm/kernel/perf_event_xscale.c
+++ b/arch/arm/kernel/perf_event_xscale.c
@@ -767,9 +767,5 @@ static struct platform_driver xscale_pmu_driver = {
 	.probe		= xscale_pmu_device_probe,
 };
 
-static int __init register_xscale_pmu_driver(void)
-{
-	return platform_driver_register(&xscale_pmu_driver);
-}
-device_initcall(register_xscale_pmu_driver);
+builtin_platform_driver(xscale_pmu_driver);
 #endif	/* CONFIG_CPU_XSCALE */
-- 
1.7.12.4
