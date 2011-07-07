From: LW@KARO-electronics.de (=?utf-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Thu,  7 Jul 2011 09:43:12 +0200
Subject: [BUGFIX][PATCH] plat-mxc: [cpufreq] Fix section mismatch due to
	incorrect __init attributes
Message-ID: <1310024592-31272-1-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mxc_cpufreq_init() function is incorrectly labeled __init while
the real __init function mxc_cpufreq_driver_init() is labeled __devinit.

Signed-off-by: Lothar Wa??mann <LW@KARO-electronics.de>
---
 arch/arm/plat-mxc/cpufreq.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-mxc/cpufreq.c b/arch/arm/plat-mxc/cpufreq.c
index 74aac96..e0107e9 100644
--- a/arch/arm/plat-mxc/cpufreq.c
+++ b/arch/arm/plat-mxc/cpufreq.c
@@ -97,7 +97,7 @@ static int mxc_set_target(struct cpufreq_policy *policy,
 	return ret;
 }
 
-static int __init mxc_cpufreq_init(struct cpufreq_policy *policy)
+static int __devinit mxc_cpufreq_init(struct cpufreq_policy *policy)
 {
 	int ret;
 	int i;
@@ -187,7 +187,7 @@ static struct cpufreq_driver mxc_driver = {
 	.name = "imx",
 };
 
-static int __devinit mxc_cpufreq_driver_init(void)
+static int __init mxc_cpufreq_driver_init(void)
 {
 	return cpufreq_register_driver(&mxc_driver);
 }
-- 
1.5.6.5
