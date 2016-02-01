From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon,  1 Feb 2016 09:55:45 +0100
Subject: [PATCH 1/3] ARM: realview: activate SMP on the default defconfig
Message-ID: <1454316945-4426-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The realview has two defconfigs: realview_defconfig and
realview-smp_defconfig. We now have working SMP_ON_UP so
make them equal so we can delete the -smp variant. For
some reason NO_HZ_FULL was missing from the plain
realview_defconfig.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/configs/realview_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/realview_defconfig b/arch/arm/configs/realview_defconfig
index 8f56fb3ff51d..9f84c508a5f4 100644
--- a/arch/arm/configs/realview_defconfig
+++ b/arch/arm/configs/realview_defconfig
@@ -1,5 +1,6 @@
 # CONFIG_SWAP is not set
 CONFIG_SYSVIPC=y
+CONFIG_NO_HZ_FULL=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_PERF_EVENTS=y
@@ -21,6 +22,7 @@ CONFIG_MACH_REALVIEW_PB11MP=y
 CONFIG_MACH_REALVIEW_PB1176=y
 CONFIG_MACH_REALVIEW_PBA8=y
 CONFIG_MACH_REALVIEW_PBX=y
+CONFIG_SMP=y
 CONFIG_AEABI=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
-- 
2.4.3
