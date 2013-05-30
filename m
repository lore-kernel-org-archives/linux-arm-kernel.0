From: pebolle@tiscali.nl (Paul Bolle)
Date: Thu, 30 May 2013 13:20:23 +0200
Subject: [PATCH] ARM: OMAP2+: Remove obsolete Makefile line
Message-ID: <1369912823.23034.46.camel@x61.thuisdomein>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The OMAP runtime PM implementation was removed in v3.0. But one Makefile
line, which was used to tweak CFLAGS, was overlooked. Remove it too.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Untested. This cleans up after commit 638080c37a ("OMAP2+ / PM: move
runtime PM implementation to use device power domains").

 arch/arm/mach-omap2/Makefile | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 55a9d67..7279fa8 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -93,10 +93,6 @@ obj-$(CONFIG_POWER_AVS_OMAP_CLASS3)    += smartreflex-class3.o
 AFLAGS_sleep24xx.o			:=-Wa,-march=armv6
 AFLAGS_sleep34xx.o			:=-Wa,-march=armv7-a$(plus_sec)
 
-ifeq ($(CONFIG_PM_VERBOSE),y)
-CFLAGS_pm_bus.o				+= -DDEBUG
-endif
-
 endif
 
 ifeq ($(CONFIG_CPU_IDLE),y)
-- 
1.7.11.7
