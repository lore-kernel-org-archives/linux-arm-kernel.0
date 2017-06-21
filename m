From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed, 21 Jun 2017 21:16:59 +0200
Subject: [PATCH 4/4] ARM: exynos_defconfig: Enable locking test options
In-Reply-To: <20170621191659.10929-1-krzk@kernel.org>
References: <20170621191659.10929-1-krzk@kernel.org>
Message-ID: <20170621191659.10929-4-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

exynos_defconfig, beside serving as a reference config for Exynos-based
devices, is used by developers during regular development work.
Enabling options responsible for locking tests allows to discover bugs
in drivers and mach code earlier.

This enables:
1. Detection of sleeping in atomic sections (DEBUG_ATOMIC_SLEEP),
2. Full lockdep (DEBUG_LOCK_ALLOC and PROVE_LOCKING which makes other
   lock debug entries unneeded),
3. Detection of soft, kernel lockups (SOFTLOCKUP_DETECTOR).

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/configs/exynos_defconfig | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index 71b8dbcc1d65..fbd64fc0e692 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -3,7 +3,6 @@ CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_CGROUPS=y
 CONFIG_BLK_DEV_INITRD=y
-CONFIG_KALLSYMS_ALL=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_PARTITION_ADVANCED=y
@@ -316,10 +315,10 @@ CONFIG_DEBUG_INFO=y
 CONFIG_DEBUG_FS=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
-CONFIG_LOCKUP_DETECTOR=y
-CONFIG_DEBUG_RT_MUTEXES=y
-CONFIG_DEBUG_SPINLOCK=y
-CONFIG_DEBUG_MUTEXES=y
+CONFIG_SOFTLOCKUP_DETECTOR=y
+# CONFIG_DETECT_HUNG_TASK is not set
+CONFIG_PROVE_LOCKING=y
+CONFIG_DEBUG_ATOMIC_SLEEP=y
 CONFIG_DEBUG_USER=y
 CONFIG_CRYPTO_RSA=m
 CONFIG_CRYPTO_DH=m
-- 
2.9.3
