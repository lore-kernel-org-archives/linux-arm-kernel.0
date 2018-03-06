From: amit.kucheria@linaro.org (Amit Kucheria)
Date: Tue,  6 Mar 2018 18:35:03 +0530
Subject: [PATCH 3/3] arm64: defconfig: enable more cpufreq governors
In-Reply-To: <cover.1520340931.git.amit.kucheria@linaro.org>
References: <cover.1520340931.git.amit.kucheria@linaro.org>
Message-ID: <7a5ecbaf8e5defbf47dc1f0b312a372a4654a18e.1520340931.git.amit.kucheria@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the various CPUFREQ governors and statistics to ease development.
Don't change the default governor - performance governor.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 arch/arm64/configs/defconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 80530cb..1f542fd 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -99,6 +99,14 @@ CONFIG_HIBERNATION=y
 CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
 CONFIG_ARM_CPUIDLE=y
 CONFIG_CPU_FREQ=y
+CONFIG_CPU_FREQ_GOV_ATTR_SET=y
+CONFIG_CPU_FREQ_GOV_COMMON=y
+CONFIG_CPU_FREQ_STAT=y
+CONFIG_CPU_FREQ_GOV_POWERSAVE=m
+CONFIG_CPU_FREQ_GOV_USERSPACE=y
+CONFIG_CPU_FREQ_GOV_ONDEMAND=y
+CONFIG_CPU_FREQ_GOV_CONSERVATIVE=m
+CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y
 CONFIG_CPUFREQ_DT=y
 CONFIG_ARM_ARMADA_37XX_CPUFREQ=y
 CONFIG_ARM_BIG_LITTLE_CPUFREQ=y
-- 
2.7.4
