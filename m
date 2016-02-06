From: swarren@wwwdotorg.org (Stephen Warren)
Date: Sat,  6 Feb 2016 11:03:45 -0700
Subject: [PATCH 2/3] ARM: bcm2835_defconfig: disable DEBUG_LL
In-Reply-To: <1454781826-10571-1-git-send-email-swarren@wwwdotorg.org>
References: <1454781826-10571-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1454781826-10571-2-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This way the kernel works on both RPi0/1 and RPi2 even with earlyprintk
in the kernel cmdline; the two hardware platforms use different physical
addresses for peripherals, so the same DEBUG_LL configuration won't work
on both. If someone needs DEBUG_LL support, they can enable it locally.

Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>
---
 arch/arm/configs/bcm2835_defconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/configs/bcm2835_defconfig b/arch/arm/configs/bcm2835_defconfig
index e95dcb16d65d..4a1fb17eebf6 100644
--- a/arch/arm/configs/bcm2835_defconfig
+++ b/arch/arm/configs/bcm2835_defconfig
@@ -142,7 +142,5 @@ CONFIG_TEST_KSTRTOX=y
 CONFIG_KGDB=y
 CONFIG_KGDB_KDB=y
 CONFIG_STRICT_DEVMEM=y
-CONFIG_DEBUG_LL=y
-CONFIG_EARLY_PRINTK=y
 # CONFIG_XZ_DEC_ARM is not set
 # CONFIG_XZ_DEC_ARMTHUMB is not set
-- 
1.9.1
