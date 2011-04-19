From: oskar.andero@sonyericsson.com (oskar.andero at sonyericsson.com)
Date: Tue, 19 Apr 2011 16:42:51 +0200
Subject: [PATCH v2] arm: omap2: enable smc instruction for sleep34xx
Message-ID: <1303224171-24984-1-git-send-email-oskar.andero@sonyericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes broken build when using binutils 2.21.

Signed-off-by: Oskar Andero <oskar.andero@sonyericsson.com>
---
 arch/arm/mach-omap2/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index a45cd64..512b152 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -68,7 +68,7 @@ obj-$(CONFIG_OMAP_SMARTREFLEX)          += sr_device.o smartreflex.o
 obj-$(CONFIG_OMAP_SMARTREFLEX_CLASS3)	+= smartreflex-class3.o
 
 AFLAGS_sleep24xx.o			:=-Wa,-march=armv6
-AFLAGS_sleep34xx.o			:=-Wa,-march=armv7-a
+AFLAGS_sleep34xx.o			:=-Wa,-march=armv7-a$(plus_sec)
 
 ifeq ($(CONFIG_PM_VERBOSE),y)
 CFLAGS_pm_bus.o				+= -DDEBUG
-- 
1.7.3.4
