From: geliangtang@gmail.com (Geliang Tang)
Date: Wed, 23 Nov 2016 22:39:52 +0800
Subject: [PATCH] arm: perf: use builtin_platform_driver
Message-ID: <5fa901e2e1441ba60df316dfd3e14c87bd7bdfd1.1479911941.git.geliangtang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use builtin_platform_driver() helper to simplify the code.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
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
index b942349..ab6522b 100644
--- a/arch/arm/kernel/perf_event_v7.c
+++ b/arch/arm/kernel/perf_event_v7.c
@@ -2034,9 +2034,5 @@ static struct platform_driver armv7_pmu_driver = {
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
2.9.3
