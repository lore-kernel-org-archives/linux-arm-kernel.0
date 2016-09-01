From: leo.yan@linaro.org (Leo Yan)
Date: Thu,  1 Sep 2016 12:51:09 +0800
Subject: [PATCH v2] arm64: defconfig: enable common modules for power
 management
Message-ID: <1472705469-25599-1-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable common modules for power management; one is to enable
CPUFREQ_DT driver; the driver is used by many platforms by passing OPP
table from device tree.

Also enables thermal related drivers. Firstly we need enable
configuration CPU_THERMAL for CPU cooling device driver, this will bind
thermal zone with CPU cooling device; and enable 'power allocator'
thermal governor.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 arch/arm64/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index eadf485..c4f5948 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -82,6 +82,7 @@ CONFIG_COMPAT=y
 CONFIG_CPU_IDLE=y
 CONFIG_ARM_CPUIDLE=y
 CONFIG_CPU_FREQ=y
+CONFIG_CPUFREQ_DT=y
 CONFIG_ARM_BIG_LITTLE_CPUFREQ=y
 CONFIG_ARM_SCPI_CPUFREQ=y
 CONFIG_NET=y
@@ -252,6 +253,8 @@ CONFIG_SENSORS_INA2XX=m
 CONFIG_SENSORS_ARM_SCPI=y
 CONFIG_THERMAL=y
 CONFIG_THERMAL_EMULATION=y
+CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
+CONFIG_CPU_THERMAL=y
 CONFIG_EXYNOS_THERMAL=y
 CONFIG_WATCHDOG=y
 CONFIG_RENESAS_WDT=y
-- 
1.9.1
