From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 18 Dec 2015 14:32:16 +0100
Subject: [PATCH] ARM: realview: select apropriate targets
Message-ID: <1450445536-28912-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have multiplatform support, let the RealView
defconfigs select all the RealView boards so we boot out of
the box like before. This updates both defconfigs.

Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/configs/realview-smp_defconfig | 9 +++++++++
 arch/arm/configs/realview_defconfig     | 8 ++++++++
 2 files changed, 17 insertions(+)

diff --git a/arch/arm/configs/realview-smp_defconfig b/arch/arm/configs/realview-smp_defconfig
index 1da5d9e48224..bff0754bf2c1 100644
--- a/arch/arm/configs/realview-smp_defconfig
+++ b/arch/arm/configs/realview-smp_defconfig
@@ -8,10 +8,19 @@ CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_CFQ is not set
+CONFIG_ARCH_MULTI_V6=y
 CONFIG_ARCH_REALVIEW=y
+CONFIG_REALVIEW_DT=y
 CONFIG_MACH_REALVIEW_EB=y
+CONFIG_REALVIEW_EB_ARM1136=y
+CONFIG_REALVIEW_EB_ARM1176=y
+CONFIG_REALVIEW_EB_A9MP=y
 CONFIG_REALVIEW_EB_ARM11MP=y
+CONFIG_REALVIEW_EB_ARM11MP_REVB=y
 CONFIG_MACH_REALVIEW_PB11MP=y
+CONFIG_MACH_REALVIEW_PB1176=y
+CONFIG_MACH_REALVIEW_PBA8=y
+CONFIG_MACH_REALVIEW_PBX=y
 CONFIG_SMP=y
 CONFIG_HOTPLUG_CPU=y
 CONFIG_AEABI=y
diff --git a/arch/arm/configs/realview_defconfig b/arch/arm/configs/realview_defconfig
index d02e9d911bb7..bc6bef864b36 100644
--- a/arch/arm/configs/realview_defconfig
+++ b/arch/arm/configs/realview_defconfig
@@ -8,11 +8,19 @@ CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_CFQ is not set
+CONFIG_ARCH_MULTI_V6=y
 CONFIG_ARCH_REALVIEW=y
+CONFIG_REALVIEW_DT=y
 CONFIG_MACH_REALVIEW_EB=y
+CONFIG_REALVIEW_EB_ARM1136=y
+CONFIG_REALVIEW_EB_ARM1176=y
+CONFIG_REALVIEW_EB_A9MP=y
 CONFIG_REALVIEW_EB_ARM11MP=y
+CONFIG_REALVIEW_EB_ARM11MP_REVB=y
 CONFIG_MACH_REALVIEW_PB11MP=y
 CONFIG_MACH_REALVIEW_PB1176=y
+CONFIG_MACH_REALVIEW_PBA8=y
+CONFIG_MACH_REALVIEW_PBX=y
 CONFIG_AEABI=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
-- 
2.4.3
