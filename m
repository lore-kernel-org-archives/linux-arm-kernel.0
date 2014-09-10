From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 10 Sep 2014 10:26:19 +0200
Subject: [PATCH 3/3] ARM64: make of_device_ids const
In-Reply-To: <1410337579-23466-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1410337579-23466-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1410337579-23466-4-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

of_device_ids (i.e. compatible strings and the respective data) are not
supposed to change at runtime. All functions working with of_device_ids
provided by <linux/of.h> work with const of_device_ids. So mark the
only non-const struct in arch/arm64 as const, too.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm64/kernel/perf_event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index baf5afb7e6a0..aa29ecb4f800 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -1276,7 +1276,7 @@ arch_initcall(cpu_pmu_reset);
 /*
  * PMU platform driver and devicetree bindings.
  */
-static struct of_device_id armpmu_of_device_ids[] = {
+static const struct of_device_id armpmu_of_device_ids[] = {
 	{.compatible = "arm,armv8-pmuv3"},
 	{},
 };
-- 
2.1.0
