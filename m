From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue,  6 Jan 2015 20:16:44 +0800
Subject: [PATCH] ARM: imx: drop CPUIDLE_FLAG_TIME_VALID from cpuidle-imx6sx
Message-ID: <1420546604-14709-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the result of commit b82b6cca4880 ("cpuidle: Invert
CPUIDLE_FLAG_TIME_VALID logic"), the flag gets removed and hence we see
the compile error below.

  CC      arch/arm/mach-imx/cpuidle-imx6sx.o
arch/arm/mach-imx/cpuidle-imx6sx.c:69:13: error: ?CPUIDLE_FLAG_TIME_VALID? undeclared here (not in a function)

Since the behavior of the original flag has been the default, we can
simply drop the flag now.

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/cpuidle-imx6sx.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/mach-imx/cpuidle-imx6sx.c b/arch/arm/mach-imx/cpuidle-imx6sx.c
index d8a9f219e028..5a36722b089d 100644
--- a/arch/arm/mach-imx/cpuidle-imx6sx.c
+++ b/arch/arm/mach-imx/cpuidle-imx6sx.c
@@ -66,8 +66,7 @@ static struct cpuidle_driver imx6sx_cpuidle_driver = {
 		{
 			.exit_latency = 50,
 			.target_residency = 75,
-			.flags = CPUIDLE_FLAG_TIME_VALID |
-				CPUIDLE_FLAG_TIMER_STOP,
+			.flags = CPUIDLE_FLAG_TIMER_STOP,
 			.enter = imx6sx_enter_wait,
 			.name = "WAIT",
 			.desc = "Clock off",
@@ -81,7 +80,6 @@ static struct cpuidle_driver imx6sx_cpuidle_driver = {
 			 */
 			.exit_latency = 300,
 			.target_residency = 500,
-			.flags = CPUIDLE_FLAG_TIME_VALID,
 			.enter = imx6sx_enter_wait,
 			.name = "LOW-POWER-IDLE",
 			.desc = "ARM power off",
-- 
1.9.1
