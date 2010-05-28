From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 28 May 2010 19:35:02 +0200
Subject: [PATCH 2/2] ARM: ux500 make it possible to disable localtimers
Message-ID: <1275068102-18321-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently compilation of ux500 fails if you deselect the kernel
feature for localtimers.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 arch/arm/mach-ux500/Makefile |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-ux500/Makefile b/arch/arm/mach-ux500/Makefile
index c7bc419..4556aea 100644
--- a/arch/arm/mach-ux500/Makefile
+++ b/arch/arm/mach-ux500/Makefile
@@ -7,4 +7,5 @@ obj-$(CONFIG_UX500_SOC_DB5500)	+= cpu-db5500.o devices-db5500.o
 obj-$(CONFIG_UX500_SOC_DB8500)	+= cpu-db8500.o devices-db8500.o
 obj-$(CONFIG_MACH_U8500_MOP)	+= board-mop500.o
 obj-$(CONFIG_MACH_U5500)	+= board-u5500.o
-obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o localtimer.o
+obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o
+obj-$(CONFIG_LOCAL_TIMERS)	+= localtimer.o
-- 
1.6.3.3
