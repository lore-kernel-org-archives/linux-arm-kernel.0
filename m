From: broonie@kernel.org (Mark Brown)
Date: Tue, 16 Sep 2014 11:26:56 -0700
Subject: [PATCH] ARM: configs: Remove duplicate CPU_FREQ assignment from
 multi_v7_defconfig
Message-ID: <1410892016-32025-1-git-send-email-broonie@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The addition of cpufreq-cpu0 added the core CPU_FREQ config option but
this was already enabled further up the config, causing build warnings
from Kconfig.  Remove the duplicate.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm/configs/multi_v7_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 9799e9d..c1cc616 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -414,5 +414,4 @@ CONFIG_DEBUG_FS=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_LOCKUP_DETECTOR=y
 CONFIG_CRYPTO_DEV_TEGRA_AES=y
-CONFIG_CPU_FREQ=y
 CONFIG_GENERIC_CPUFREQ_CPU0=y
-- 
2.1.0
