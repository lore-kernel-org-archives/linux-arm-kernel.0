From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 24 Apr 2012 16:05:37 +0200
Subject: [PATCH 16/18][V3] ARM: OMAP3: set omap3_idle_data as static
In-Reply-To: <1335276339-11135-1-git-send-email-daniel.lezcano@linaro.org>
References: <1335276339-11135-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1335276339-11135-17-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reduce the scope of the omap3_idle_data to the file as it is only used
in cpuidle34xx.c.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index e7599e7..ee02a8c 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -44,7 +44,7 @@ struct omap3_idle_statedata {
 	u32 core_state;
 };
 
-struct omap3_idle_statedata omap3_idle_data[] = {
+static struct omap3_idle_statedata omap3_idle_data[] = {
 	{
 		.mpu_state = PWRDM_POWER_ON,
 		.core_state = PWRDM_POWER_ON,
-- 
1.7.5.4
