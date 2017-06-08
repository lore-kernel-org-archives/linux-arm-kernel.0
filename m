From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Thu,  8 Jun 2017 18:10:39 +0200
Subject: [PATCH 28/35] ARM: s3c6400_defconfig: Bring back lost (but wanted)
 options
In-Reply-To: <20170608160836.12196-1-krzk@kernel.org>
References: <20170608160836.12196-1-krzk@kernel.org>
Message-ID: <20170608161049.12421-28-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The config was not updated for some time so it needs updates to get the
same options as wanted initially:
 - SYSFS_DEPRECATED is now needed for SYSFS_DEPRECATED_V2;
 - PWM is now needed for BACKLIGHT_PWM;
 - DEBUG_SPINLOCK_SLEEP was replaced by DEBUG_ATOMIC_SLEEP;

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/configs/s3c6400_defconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/configs/s3c6400_defconfig b/arch/arm/configs/s3c6400_defconfig
index 97e377a4c118..8979e343d255 100644
--- a/arch/arm/configs/s3c6400_defconfig
+++ b/arch/arm/configs/s3c6400_defconfig
@@ -1,3 +1,4 @@
+CONFIG_SYSFS_DEPRECATED=y
 CONFIG_SYSFS_DEPRECATED_V2=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_KALLSYMS_ALL=y
@@ -72,6 +73,7 @@ CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_S3C=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_S3C=y
+CONFIG_PWM=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
 CONFIG_EXT3_FS_POSIX_ACL=y
@@ -86,6 +88,6 @@ CONFIG_DEBUG_KERNEL=y
 CONFIG_DEBUG_RT_MUTEXES=y
 CONFIG_DEBUG_SPINLOCK=y
 CONFIG_DEBUG_MUTEXES=y
-CONFIG_DEBUG_SPINLOCK_SLEEP=y
+CONFIG_DEBUG_ATOMIC_SLEEP=y
 CONFIG_DEBUG_USER=y
 CONFIG_DEBUG_LL=y
-- 
2.9.3
