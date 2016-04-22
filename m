From: pchiu@nvidia.com (Penny Chiu)
Date: Fri, 22 Apr 2016 18:31:11 +0800
Subject: [PATCH 11/11] arm64: config: Enable CPUFreq-DT, Tegra DFLL PWM,
 and PWM regulator
In-Reply-To: <1461321071-6431-1-git-send-email-pchiu@nvidia.com>
References: <1461321071-6431-1-git-send-email-pchiu@nvidia.com>
Message-ID: <1461321071-6431-12-git-send-email-pchiu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable CPUFreq-DT, PWM regulator for CPU rail, and related PWM
controller driver.

Signed-off-by: Penny Chiu <pchiu@nvidia.com>
---
 arch/arm64/configs/defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 5091d35..865daca 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -75,6 +75,7 @@ CONFIG_COMPAT=y
 CONFIG_CPU_IDLE=y
 CONFIG_ARM_CPUIDLE=y
 CONFIG_CPU_FREQ=y
+CONFIG_CPUFREQ_DT=y
 CONFIG_ARM_BIG_LITTLE_CPUFREQ=y
 CONFIG_ARM_SCPI_CPUFREQ=y
 CONFIG_NET=y
@@ -177,11 +178,14 @@ CONFIG_THERMAL_EMULATION=y
 CONFIG_EXYNOS_THERMAL=y
 CONFIG_MFD_SPMI_PMIC=y
 CONFIG_MFD_SEC_CORE=y
+CONFIG_PWM=y
+CONFIG_PWM_TEGRA_DFLL=y
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_REGULATOR_QCOM_SMD_RPM=y
 CONFIG_REGULATOR_QCOM_SPMI=y
 CONFIG_REGULATOR_S2MPS11=y
+CONFIG_REGULATOR_PWM=y
 CONFIG_FB=y
 CONFIG_FB_ARMCLCD=y
 CONFIG_FRAMEBUFFER_CONSOLE=y
-- 
2.8.1
