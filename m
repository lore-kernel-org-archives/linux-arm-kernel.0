From: ttynkkynen@nvidia.com (Tuomas Tynkkynen)
Date: Thu, 21 Aug 2014 00:04:44 +0300
Subject: [PATCH v4 16/16] ARM: tegra: enable Tegra124 cpufreq driver by default
In-Reply-To: <1408568684-11016-1-git-send-email-ttynkkynen@nvidia.com>
References: <1408568684-11016-1-git-send-email-ttynkkynen@nvidia.com>
Message-ID: <1408568684-11016-17-git-send-email-ttynkkynen@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Tegra124 cpufreq driver depends on CONFIG_GENERIC_CPUFREQ_CPU0, so
enable it to get the Tegra driver to build by default.

Signed-off-by: Tuomas Tynkkynen <ttynkkynen@nvidia.com>
---
v4: New patch
---
 arch/arm/configs/tegra_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index 285c433..afaa97c 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -43,6 +43,7 @@ CONFIG_KEXEC=y
 CONFIG_CPU_FREQ=y
 CONFIG_CPU_FREQ_STAT_DETAILS=y
 CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
+CONFIG_GENERIC_CPUFREQ_CPU0=y
 CONFIG_CPU_IDLE=y
 CONFIG_VFP=y
 CONFIG_NEON=y
-- 
1.8.1.5
