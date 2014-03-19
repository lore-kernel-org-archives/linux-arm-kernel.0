From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Mar 2014 20:29:22 +0100
Subject: [PATCH 25/62] ARM: mvebu: add missing header
In-Reply-To: <1395257399-359545-1-git-send-email-arnd@arndb.de>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
Message-ID: <1395257399-359545-26-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The definition for SIGBUS may not be visible without including
linux/signal.h, as I found during randconfig testing.

Adding an explicit include is certainly the right thing to do.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
 arch/arm/mach-mvebu/board-v7.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-mvebu/board-v7.c b/arch/arm/mach-mvebu/board-v7.c
index 746134e..333fca8 100644
--- a/arch/arm/mach-mvebu/board-v7.c
+++ b/arch/arm/mach-mvebu/board-v7.c
@@ -21,6 +21,7 @@
 #include <linux/clocksource.h>
 #include <linux/dma-mapping.h>
 #include <linux/mbus.h>
+#include <linux/signal.h>
 #include <linux/slab.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/mach/arch.h>
-- 
1.8.3.2
