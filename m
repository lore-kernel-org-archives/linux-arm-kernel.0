From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed,  3 Apr 2013 14:15:15 +0200
Subject: [PATCH 2/9] ARM: shmobile: pm: fix init sections
In-Reply-To: <1364991322-20585-1-git-send-email-daniel.lezcano@linaro.org>
References: <1364991322-20585-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1364991322-20585-2-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the __init section for the functions which are called
at init time.

Signed-off-by: Daniel Lezcano <daniel.linaro.org>
Acked-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/cpuidle.c   |    4 ++--
 arch/arm/mach-shmobile/pm-sh7372.c |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-shmobile/cpuidle.c b/arch/arm/mach-shmobile/cpuidle.c
index 9e05026..068f9ca 100644
--- a/arch/arm/mach-shmobile/cpuidle.c
+++ b/arch/arm/mach-shmobile/cpuidle.c
@@ -36,12 +36,12 @@ static struct cpuidle_driver shmobile_cpuidle_default_driver = {
 
 static struct cpuidle_driver *cpuidle_drv = &shmobile_cpuidle_default_driver;
 
-void shmobile_cpuidle_set_driver(struct cpuidle_driver *drv)
+void __init shmobile_cpuidle_set_driver(struct cpuidle_driver *drv)
 {
 	cpuidle_drv = drv;
 }
 
-int shmobile_cpuidle_init(void)
+int __init shmobile_cpuidle_init(void)
 {
 	struct cpuidle_device *dev = &shmobile_cpuidle_dev;
 
diff --git a/arch/arm/mach-shmobile/pm-sh7372.c b/arch/arm/mach-shmobile/pm-sh7372.c
index a0826a4..f6b14ca 100644
--- a/arch/arm/mach-shmobile/pm-sh7372.c
+++ b/arch/arm/mach-shmobile/pm-sh7372.c
@@ -450,12 +450,12 @@ static struct cpuidle_driver sh7372_cpuidle_driver = {
 	},
 };
 
-static void sh7372_cpuidle_init(void)
+static void __init sh7372_cpuidle_init(void)
 {
 	shmobile_cpuidle_set_driver(&sh7372_cpuidle_driver);
 }
 #else
-static void sh7372_cpuidle_init(void) {}
+static void __init sh7372_cpuidle_init(void) {}
 #endif
 
 #ifdef CONFIG_SUSPEND
-- 
1.7.9.5
