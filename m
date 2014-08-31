From: broonie@kernel.org (Mark Brown)
Date: Sun, 31 Aug 2014 13:09:39 +0100
Subject: [PATCH] ARM: configs: Enable cpufreq-cpu0 for multi_v7_defconfig
Message-ID: <1409486979-26869-1-git-send-email-broonie@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Many boards share the cpufreq-cpu0 driver meaning that if we enable it in
multi_v7_defconfig we can get a reasonable amount of functional utility for
systems and test coverage for a fairly small increase in kernel size.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm/configs/multi_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 05c0e7c789df..9799e9d2e222 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -414,3 +414,5 @@ CONFIG_DEBUG_FS=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_LOCKUP_DETECTOR=y
 CONFIG_CRYPTO_DEV_TEGRA_AES=y
+CONFIG_CPU_FREQ=y
+CONFIG_GENERIC_CPUFREQ_CPU0=y
-- 
2.1.0
