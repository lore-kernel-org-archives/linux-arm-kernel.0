From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 5 Apr 2013 16:22:56 +0200
Subject: [PATCH 14/14] ARM: ux500: build hotplug.o for ARMv7-a
In-Reply-To: <1365171776-8463-1-git-send-email-linus.walleij@stericsson.com>
References: <1365171776-8463-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <1365171776-8463-15-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>

If we try to build this file in a multiplatform configuration with
ARMv6 enabled, gas complains about the dsb operation being undefined.
Adding -march=armv7-a is safe because that code is only ever run
on ux500, which is Cortex-A9.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-ux500/Makefile b/arch/arm/mach-ux500/Makefile
index 580a4db..bf9b6be 100644
--- a/arch/arm/mach-ux500/Makefile
+++ b/arch/arm/mach-ux500/Makefile
@@ -15,3 +15,5 @@ obj-$(CONFIG_MACH_MOP500)	+= board-mop500.o board-mop500-sdi.o \
 				board-mop500-audio.o
 obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o
 obj-$(CONFIG_HOTPLUG_CPU)	+= hotplug.o
+
+CFLAGS_hotplug.o		+= -march=armv7-a
-- 
1.7.11.3
