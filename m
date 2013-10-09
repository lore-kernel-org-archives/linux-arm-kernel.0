From: badarkhe.manish@gmail.com (Manish Badarkhe)
Date: Wed,  9 Oct 2013 20:43:37 +0530
Subject: [PATCH] cpufreq: fix false return check from "regulator_set_voltage"
Message-ID: <1381331617-14703-1-git-send-email-badarkhe.manish@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, code checks false return value from "regulator_set_voltage"
to show failure message. Modify the code to check proper return
value from "regulator_set_voltage".

Signed-off-by: Manish Badarkhe <badarkhe.manish@gmail.com>
---
Based on master branch of linux-mainline.

:100644 100644 0fac344... 1537f32... M	drivers/cpufreq/exynos-cpufreq.c
 drivers/cpufreq/exynos-cpufreq.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/exynos-cpufreq.c b/drivers/cpufreq/exynos-cpufreq.c
index 0fac344..1537f32 100644
--- a/drivers/cpufreq/exynos-cpufreq.c
+++ b/drivers/cpufreq/exynos-cpufreq.c
@@ -141,7 +141,7 @@ post_notify:
 	if ((freqs.new < freqs.old) ||
 	   ((freqs.new > freqs.old) && safe_arm_volt)) {
 		/* down the voltage after frequency change */
-		regulator_set_voltage(arm_regulator, arm_volt,
+		ret = regulator_set_voltage(arm_regulator, arm_volt,
 				arm_volt);
 		if (ret) {
 			pr_err("%s: failed to set cpu voltage to %d\n",
-- 
1.7.10.4
