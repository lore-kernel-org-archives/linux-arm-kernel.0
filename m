From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 11 May 2015 12:06:38 +0200
Subject: [PATCH] ARM: multi_v7_defconfig: enable asm and NEON accelerated
 crypto modules
Message-ID: <1431338798-26909-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable all drivers under CONFIG_ARM_CRYPTO as modules. Enable
CONFIG_KERNEL_MODE_NEON as well so that the modules that either
contain a NEON alternative or consist solely of a NEON (or ARMv8
crypto extensions) accelerated implementation are enabled fully as
well.

Note that the ARMv8 modules will only be built if the detected
toolchain version is recent enough (binutils 2.23 or higher).

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm/configs/multi_v7_defconfig | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 0ca4a3eaf65d..d7d3bf35f9f0 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -116,6 +116,7 @@ CONFIG_CPU_FREQ_STAT_DETAILS=y
 CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
 CONFIG_CPU_IDLE=y
 CONFIG_NEON=y
+CONFIG_KERNEL_MODE_NEON=y
 CONFIG_ARM_ZYNQ_CPUIDLE=y
 CONFIG_NET=y
 CONFIG_PACKET=y
@@ -590,3 +591,14 @@ CONFIG_LOCKUP_DETECTOR=y
 CONFIG_CRYPTO_DEV_TEGRA_AES=y
 CONFIG_CPUFREQ_DT=y
 CONFIG_KEYSTONE_IRQ=y
+CONFIG_ARM_CRYPTO=y
+CONFIG_CRYPTO_SHA1_ARM=m
+CONFIG_CRYPTO_SHA1_ARM_NEON=m
+CONFIG_CRYPTO_SHA1_ARM_CE=m
+CONFIG_CRYPTO_SHA2_ARM_CE=m
+CONFIG_CRYPTO_SHA256_ARM=m
+CONFIG_CRYPTO_SHA512_ARM=m
+CONFIG_CRYPTO_AES_ARM=m
+CONFIG_CRYPTO_AES_ARM_BS=m
+CONFIG_CRYPTO_AES_ARM_CE=m
+CONFIG_CRYPTO_GHASH_ARM_CE=m
-- 
1.9.1
