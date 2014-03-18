From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Tue, 18 Mar 2014 18:56:49 +0100
Subject: [PATCH v2 7/7] sched: powerpc: Add SD_SHARE_POWERDOMAIN for SMT level
In-Reply-To: <1395165409-18055-1-git-send-email-vincent.guittot@linaro.org>
References: <1395165409-18055-1-git-send-email-vincent.guittot@linaro.org>
Message-ID: <1395165409-18055-8-git-send-email-vincent.guittot@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Set the power domain dependency at SMT level of Power8 but keep the flag
clear at CPU level. The goal is to consolidate tasks on the threads of a
core up to a level as decribed in the link below:
https://lkml.org/lkml/2014/3/12/16

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 arch/powerpc/kernel/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index c9cade5..fbbac3c 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -759,7 +759,7 @@ int setup_profiling_timer(unsigned int multiplier)
 /* cpumask of CPUs with asymetric SMT dependancy */
 static const int powerpc_smt_flags(void)
 {
-	int flags = SD_SHARE_CPUPOWER | SD_SHARE_PKG_RESOURCES;
+	int flags = SD_SHARE_CPUPOWER | SD_SHARE_PKG_RESOURCES | SD_SHARE_POWERDOMAIN;
 
 	if (cpu_has_feature(CPU_FTR_ASYM_SMT)) {
 		printk_once(KERN_INFO "Enabling Asymmetric SMT scheduling\n");
-- 
1.9.0
