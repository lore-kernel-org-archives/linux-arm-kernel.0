From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 29 Mar 2013 11:31:29 +0100
Subject: [PATCH 3/9] ARM: shmobile: cpuidle: remove useless WFI function
In-Reply-To: <1364553095-25110-1-git-send-email-daniel.lezcano@linaro.org>
References: <1364553095-25110-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1364553095-25110-3-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the shmobile_enter_wfi function which is the same as the
common WFI enter function from the arm cpuidle driver defined
with the ARM_CPUIDLE_WFI_STATE macro.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/cpuidle.c |    8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm/mach-shmobile/cpuidle.c b/arch/arm/mach-shmobile/cpuidle.c
index 068f9ca..c872ae8 100644
--- a/arch/arm/mach-shmobile/cpuidle.c
+++ b/arch/arm/mach-shmobile/cpuidle.c
@@ -16,20 +16,12 @@
 #include <asm/cpuidle.h>
 #include <asm/io.h>
 
-int shmobile_enter_wfi(struct cpuidle_device *dev, struct cpuidle_driver *drv,
-		       int index)
-{
-	cpu_do_idle();
-	return 0;
-}
-
 static struct cpuidle_device shmobile_cpuidle_dev;
 static struct cpuidle_driver shmobile_cpuidle_default_driver = {
 	.name			= "shmobile_cpuidle",
 	.owner			= THIS_MODULE,
 	.en_core_tk_irqen	= 1,
 	.states[0]		= ARM_CPUIDLE_WFI_STATE,
-	.states[0].enter	= shmobile_enter_wfi,
 	.safe_state_index	= 0, /* C1 */
 	.state_count		= 1,
 };
-- 
1.7.9.5
