From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue,  3 Dec 2013 21:32:55 -0700
Subject: [PATCH 1/2] ARM: bcm2835: rebuild bcm2835_defconfig
Message-ID: <1386131576-21137-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is simply "make bcm2835_defconfig ; make savedefconfig". It
separates out the irrelevant changes from the later patches for
clarity.

Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>
---
 arch/arm/configs/bcm2835_defconfig |   13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/arm/configs/bcm2835_defconfig b/arch/arm/configs/bcm2835_defconfig
index 34e9780..c773ade 100644
--- a/arch/arm/configs/bcm2835_defconfig
+++ b/arch/arm/configs/bcm2835_defconfig
@@ -76,10 +76,7 @@ CONFIG_MMC=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_PLTFM=y
 CONFIG_MMC_SDHCI_BCM2835=y
-CONFIG_NEW_LEDS=y
-CONFIG_LEDS_CLASS=y
 CONFIG_LEDS_GPIO=y
-CONFIG_LEDS_TRIGGERS=y
 CONFIG_LEDS_TRIGGER_TIMER=y
 CONFIG_LEDS_TRIGGER_ONESHOT=y
 CONFIG_LEDS_TRIGGER_HEARTBEAT=y
@@ -109,20 +106,20 @@ CONFIG_NLS_ASCII=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_UTF8=y
 CONFIG_PRINTK_TIME=y
+CONFIG_BOOT_PRINTK_DELAY=y
+CONFIG_DYNAMIC_DEBUG=y
+CONFIG_DEBUG_INFO=y
 # CONFIG_ENABLE_WARN_DEPRECATED is not set
 # CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_UNUSED_SYMBOLS=y
-CONFIG_LOCKUP_DETECTOR=y
-CONFIG_DEBUG_INFO=y
 CONFIG_DEBUG_MEMORY_INIT=y
-CONFIG_BOOT_PRINTK_DELAY=y
+CONFIG_LOCKUP_DETECTOR=y
 CONFIG_SCHED_TRACER=y
 CONFIG_STACK_TRACER=y
 CONFIG_FUNCTION_PROFILER=y
-CONFIG_DYNAMIC_DEBUG=y
+CONFIG_TEST_KSTRTOX=y
 CONFIG_KGDB=y
 CONFIG_KGDB_KDB=y
-CONFIG_TEST_KSTRTOX=y
 CONFIG_STRICT_DEVMEM=y
 CONFIG_DEBUG_LL=y
 CONFIG_EARLY_PRINTK=y
-- 
1.7.10.4
