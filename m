From: axel.lin@gmail.com (Axel Lin)
Date: Fri, 12 Aug 2011 16:25:56 +0800
Subject: [PATCH] [ARM] Orion: gpio: add missing include of linux/types.h
Message-ID: <1313137556.24918.2.camel@phoenix>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds missing include of linux/types.h to fix below build error.

  CC      arch/arm/mach-mv78xx0/mpp.o
In file included from arch/arm/mach-mv78xx0/include/mach/gpio.h:9,
                 from /home/axel/repos/git/linux-2.6/arch/arm/include/asm/gpio.h:5,
                 from include/linux/gpio.h:18,
                 from arch/arm/mach-mv78xx0/mpp.c:10:
arch/arm/plat-orion/include/plat/gpio.h:28: error: expected declaration specifiers or '...' before 'u32'
make[1]: *** [arch/arm/mach-mv78xx0/mpp.o] Error 1
make: *** [arch/arm/mach-mv78xx0] Error 2

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
This patch is against linux-next tree ( next-20110811 ).

 arch/arm/plat-orion/include/plat/gpio.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-orion/include/plat/gpio.h b/arch/arm/plat-orion/include/plat/gpio.h
index f7d76308..3abf304 100644
--- a/arch/arm/plat-orion/include/plat/gpio.h
+++ b/arch/arm/plat-orion/include/plat/gpio.h
@@ -12,6 +12,7 @@
 #define __PLAT_GPIO_H
 
 #include <linux/init.h>
+#include <linux/types.h>
 
 /*
  * Orion-specific GPIO API extensions.
-- 
1.7.4.1
