From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 15 Mar 2013 15:27:06 +0100
Subject: [RFC patch 07/11] cpuidle / shmobile : use common ARM cpuidle driver
In-Reply-To: <1363357630-22214-1-git-send-email-daniel.lezcano@linaro.org>
References: <1363357630-22214-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1363357630-22214-8-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-shmobile/cpuidle.c |   10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/arm/mach-shmobile/cpuidle.c b/arch/arm/mach-shmobile/cpuidle.c
index 9e05026..11a0542 100644
--- a/arch/arm/mach-shmobile/cpuidle.c
+++ b/arch/arm/mach-shmobile/cpuidle.c
@@ -23,7 +23,6 @@ int shmobile_enter_wfi(struct cpuidle_device *dev, struct cpuidle_driver *drv,
 	return 0;
 }
 
-static struct cpuidle_device shmobile_cpuidle_dev;
 static struct cpuidle_driver shmobile_cpuidle_default_driver = {
 	.name			= "shmobile_cpuidle",
 	.owner			= THIS_MODULE,
@@ -43,12 +42,5 @@ void shmobile_cpuidle_set_driver(struct cpuidle_driver *drv)
 
 int shmobile_cpuidle_init(void)
 {
-	struct cpuidle_device *dev = &shmobile_cpuidle_dev;
-
-	cpuidle_register_driver(cpuidle_drv);
-
-	dev->state_count = cpuidle_drv->state_count;
-	cpuidle_register_device(dev);
-
-	return 0;
+	return arm_idle_init(cpuidle_drv);
 }
-- 
1.7.9.5
