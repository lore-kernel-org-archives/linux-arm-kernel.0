From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 21 Mar 2013 22:51:14 +0100
Subject: [PATCH 9/9] ARM: ux500: build hotplug.o for ARMv7-a
In-Reply-To: <1363902674-6456-1-git-send-email-arnd@arndb.de>
References: <1363866553-15054-1-git-send-email-linus.walleij@stericsson.com>
 <1363902674-6456-1-git-send-email-arnd@arndb.de>
Message-ID: <1363902674-6456-10-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If we try to build this file in a multiplatform configuration with
ARMv6 enabled, gas complains about the dsb operation being undefined.
Adding -march=armv7-a is safe because that code is only ever run
on ux500, which is Cortex-A9.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-ux500/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-ux500/Makefile b/arch/arm/mach-ux500/Makefile
index f24710d..4d91505 100644
--- a/arch/arm/mach-ux500/Makefile
+++ b/arch/arm/mach-ux500/Makefile
@@ -15,3 +15,5 @@ obj-$(CONFIG_MACH_MOP500)	+= board-mop500.o board-mop500-sdi.o \
 				board-mop500-audio.o
 obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o
 obj-$(CONFIG_HOTPLUG_CPU)	+= hotplug.o
+
+CFLAGS_hotplug.o		+= -march=armv7-a
-- 
1.8.1.2
