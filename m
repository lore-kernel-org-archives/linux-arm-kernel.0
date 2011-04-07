From: kostap@marvell.com (Konstantin Porotchkin)
Date: Thu,  7 Apr 2011 13:49:41 +0300
Subject: [PATCH 1/2] Moving Marvell Dove platform defaults to ARMv7
Message-ID: <1302173382-25577-1-git-send-email-kostap@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Disabled legacy support for ARMv6 archtecture on Dove platform.
Latest Dove HW uses only ARMv7 model.

Signed-off-by: Konstantin Porotchkin <kostap@marvell.com>
---
 arch/arm/Kconfig                |    2 +-
 arch/arm/configs/dove_defconfig |    2 --
 2 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 599e163..e9d9a4f 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -463,7 +463,7 @@ config ARCH_IXP4XX
 
 config ARCH_DOVE
 	bool "Marvell Dove"
-	select CPU_V6K
+	select CPU_V7
 	select PCI
 	select ARCH_REQUIRE_GPIOLIB
 	select GENERIC_CLOCKEVENTS
diff --git a/arch/arm/configs/dove_defconfig b/arch/arm/configs/dove_defconfig
index 54bf5ee..d7c3cfa 100644
--- a/arch/arm/configs/dove_defconfig
+++ b/arch/arm/configs/dove_defconfig
@@ -8,8 +8,6 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 CONFIG_ARCH_DOVE=y
 CONFIG_MACH_DOVE_DB=y
-CONFIG_CPU_V6=y
-CONFIG_CPU_32v6K=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_AEABI=y
-- 
1.7.4.1
