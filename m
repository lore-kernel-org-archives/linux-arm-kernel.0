From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 21 Mar 2012 10:27:48 +0100
Subject: [RFC][PATCH 5/7] ARM: OMAP4: cpuidle - Initialize omap4_idle_data at
 compile time
In-Reply-To: <1332322070-24577-1-git-send-email-daniel.lezcano@linaro.org>
References: <1332322070-24577-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1332322070-24577-6-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-omap2/cpuidle44xx.c |   19 ++++++++++++++++++-
 1 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/cpuidle44xx.c
index 254f97b..e14cd56 100644
--- a/arch/arm/mach-omap2/cpuidle44xx.c
+++ b/arch/arm/mach-omap2/cpuidle44xx.c
@@ -33,7 +33,24 @@ struct omap4_idle_statedata {
 
 #define OMAP4_NUM_STATES 3
 
-static struct omap4_idle_statedata omap4_idle_data[OMAP4_NUM_STATES];
+static struct omap4_idle_statedata omap4_idle_data[] = {
+	{
+		.cpu_state = PWRDM_POWER_ON,
+		.mpu_state = PWRDM_POWER_ON,
+		.mpu_logic_state = PWRDM_POWER_RET,
+	},
+	{
+		.cpu_state = PWRDM_POWER_OFF,
+		.mpu_state = PWRDM_POWER_RET,
+		.mpu_logic_state = PWRDM_POWER_RET,
+	},
+	{
+		.cpu_state = PWRDM_POWER_OFF,
+		.mpu_state = PWRDM_POWER_RET,
+		.mpu_logic_state = PWRDM_POWER_OFF,
+	},
+};
+
 static struct powerdomain *mpu_pd, *cpu0_pd, *cpu1_pd;
 
 /**
-- 
1.7.5.4
