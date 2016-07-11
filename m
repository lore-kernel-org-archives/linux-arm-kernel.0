From: tuomas@tuxera.com (Tuomas Tynkkynen)
Date: Mon, 11 Jul 2016 21:08:12 +0300
Subject: [PATCH RESEND 2/2] ARM: multi_v7_defconfig: Enable ARM_IMX6Q_CPUFREQ
In-Reply-To: <20160711180812.10610-1-tuomas@tuxera.com>
References: <20160711180812.10610-1-tuomas@tuxera.com>
Message-ID: <20160711180812.10610-2-tuomas@tuxera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Wandboard Quad can make use of the cpufreq support provided by the
driver. Enable it and its dependency, REGULATOR_ANATOP, by default.

Signed-off-by: Tuomas Tynkkynen <tuomas@tuxera.com>
---
Resent for the i.MX maintainers to apply.

 arch/arm/configs/multi_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 0b20712..92befd2 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -136,6 +136,7 @@ CONFIG_CPU_FREQ_GOV_POWERSAVE=m
 CONFIG_CPU_FREQ_GOV_USERSPACE=m
 CONFIG_CPU_FREQ_GOV_CONSERVATIVE=m
 CONFIG_CPU_FREQ_GOV_SCHEDUTIL=m
+CONFIG_ARM_IMX6Q_CPUFREQ=y
 CONFIG_QORIQ_CPUFREQ=y
 CONFIG_CPU_IDLE=y
 CONFIG_ARM_CPUIDLE=y
@@ -500,6 +501,7 @@ CONFIG_MFD_TPS65910=y
 CONFIG_REGULATOR_ACT8945A=y
 CONFIG_REGULATOR_AB8500=y
 CONFIG_REGULATOR_ACT8865=y
+CONFIG_REGULATOR_ANATOP=y
 CONFIG_REGULATOR_AS3711=y
 CONFIG_REGULATOR_AS3722=y
 CONFIG_REGULATOR_AXP20X=m
-- 
2.9.0
