From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 27 Jun 2013 17:10:00 +0200
Subject: [PATCH V2] ARM: cpuidle: davinci: Fix target residency
Message-ID: <1372345800-26792-1-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The commit 19976c2a88d125aec16b9255c7197c297bbdd637 changed the target
residency to 100000, assuming this is a careless mistake.

commit 19976c2a88d125aec16b9255c7197c297bbdd637
Author: Robert Lee <rob.lee@linaro.org>
Date:   Tue Mar 20 15:22:45 2012 -0500

    ARM: davinci: Consolidate time keeping and irq enable

    Enable core cpuidle timekeeping and irq enabling and remove that
    handling from this code.

    Signed-off-by: Robert Lee <rob.lee@linaro.org>
    Reviewed-by: Kevin Hilman <khilman@ti.com>
    Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
    Acked-by: Jean Pihet <j-pihet@ti.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

The same happened to the at91's cpuidle driver.

Fix it by putting the initial value to 10000.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-davinci/cpuidle.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-davinci/cpuidle.c b/arch/arm/mach-davinci/cpuidle.c
index 36aef3a..f1ac1c9 100644
--- a/arch/arm/mach-davinci/cpuidle.c
+++ b/arch/arm/mach-davinci/cpuidle.c
@@ -65,7 +65,7 @@ static struct cpuidle_driver davinci_idle_driver = {
 	.states[1]		= {
 		.enter			= davinci_enter_idle,
 		.exit_latency		= 10,
-		.target_residency	= 100000,
+		.target_residency	= 10000,
 		.flags			= CPUIDLE_FLAG_TIME_VALID,
 		.name			= "DDR SR",
 		.desc			= "WFI and DDR Self Refresh",
-- 
1.7.9.5
