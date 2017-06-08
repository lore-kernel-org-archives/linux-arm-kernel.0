From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Thu,  8 Jun 2017 18:10:40 +0200
Subject: [PATCH 29/35] ARM: s5pv210_defconfig: Bring back lost (but wanted)
 options
In-Reply-To: <20170608160836.12196-1-krzk@kernel.org>
References: <20170608160836.12196-1-krzk@kernel.org>
Message-ID: <20170608161049.12421-29-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The config was not updated for some time so it needs updates to get the
same options as wanted initially:
 - SYSFS_DEPRECATED is now needed for SYSFS_DEPRECATED_V2;
 - DEBUG_SPINLOCK_SLEEP was replaced by DEBUG_ATOMIC_SLEEP;
 - Use proper DEBUG_S3C_UART1 for UART1;

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/configs/s5pv210_defconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/s5pv210_defconfig b/arch/arm/configs/s5pv210_defconfig
index 4e0138993626..ddf7f75ba8d9 100644
--- a/arch/arm/configs/s5pv210_defconfig
+++ b/arch/arm/configs/s5pv210_defconfig
@@ -1,5 +1,6 @@
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
+CONFIG_SYSFS_DEPRECATED=y
 CONFIG_SYSFS_DEPRECATED_V2=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_KALLSYMS_ALL=y
@@ -54,9 +55,9 @@ CONFIG_DEBUG_KERNEL=y
 CONFIG_DEBUG_RT_MUTEXES=y
 CONFIG_DEBUG_SPINLOCK=y
 CONFIG_DEBUG_MUTEXES=y
-CONFIG_DEBUG_SPINLOCK_SLEEP=y
+CONFIG_DEBUG_ATOMIC_SLEEP=y
 CONFIG_DEBUG_USER=y
 CONFIG_DEBUG_LL=y
+CONFIG_DEBUG_S3C_UART1=y
 CONFIG_EARLY_PRINTK=y
-CONFIG_DEBUG_S3C_UART=1
 CONFIG_CRC_CCITT=y
-- 
2.9.3
