From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Wed, 10 Aug 2016 20:59:15 +0800
Subject: [PATCH 1/2] arm64: perf: Use the builtin_platform_driver
Message-ID: <1470833956-5619-1-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the builtin_platform_driver() to simplify code.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/arm64/kernel/perf_event.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 838ccf1..ea64f01 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -1057,8 +1057,4 @@ static struct platform_driver armv8_pmu_driver = {
 	.probe		= armv8_pmu_device_probe,
 };
 
-static int __init register_armv8_pmu_driver(void)
-{
-	return platform_driver_register(&armv8_pmu_driver);
-}
-device_initcall(register_armv8_pmu_driver);
+builtin_platform_driver(armv8_pmu_driver);
-- 
1.7.12.4
