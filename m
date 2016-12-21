From: alexander.stein@systec-electronic.com (Alexander Stein)
Date: Wed, 21 Dec 2016 16:03:40 +0100
Subject: [PATCH v2 2/2] arm: perf: Mark as non-removable
In-Reply-To: <20161221150340.25657-1-alexander.stein@systec-electronic.com>
References: <20161221150340.25657-1-alexander.stein@systec-electronic.com>
Message-ID: <20161221150340.25657-3-alexander.stein@systec-electronic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver can only built into the kernel. So disallow driver bind/unbind
and also prevent a kernel error in case DEBUG_TEST_DRIVER_REMOVE is
enabled.

Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
---
 arch/arm/kernel/perf_event_v7.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/kernel/perf_event_v7.c b/arch/arm/kernel/perf_event_v7.c
index b942349..795e373 100644
--- a/arch/arm/kernel/perf_event_v7.c
+++ b/arch/arm/kernel/perf_event_v7.c
@@ -2029,6 +2029,7 @@ static int armv7_pmu_device_probe(struct platform_device *pdev)
 static struct platform_driver armv7_pmu_driver = {
 	.driver		= {
 		.name	= "armv7-pmu",
+		.suppress_bind_attrs = true,
 		.of_match_table = armv7_pmu_of_device_ids,
 	},
 	.probe		= armv7_pmu_device_probe,
-- 
2.10.2
