From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 12 Apr 2013 14:35:47 +0200
Subject: [V3 patch 01/19] ARM: shmobile: cpuidle: remove shmobile_enter_wfi
 function
In-Reply-To: <1365770165-27096-1-git-send-email-daniel.lezcano@linaro.org>
References: <1365770165-27096-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1365770165-27096-2-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the shmobile_enter_wfi function which is the same as the
common WFI enter function from the arm cpuidle driver defined
with the ARM_CPUIDLE_WFI_STATE macro.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-shmobile/pm-sh7372.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/pm-sh7372.c b/arch/arm/mach-shmobile/pm-sh7372.c
index f6b14ca..fbef7b9 100644
--- a/arch/arm/mach-shmobile/pm-sh7372.c
+++ b/arch/arm/mach-shmobile/pm-sh7372.c
@@ -414,7 +414,6 @@ static struct cpuidle_driver sh7372_cpuidle_driver = {
 	.state_count		= 5,
 	.safe_state_index	= 0, /* C1 */
 	.states[0] = ARM_CPUIDLE_WFI_STATE,
-	.states[0].enter = shmobile_enter_wfi,
 	.states[1] = {
 		.name = "C2",
 		.desc = "Core Standby Mode",
-- 
1.7.9.5
