From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat, 31 May 2014 16:10:12 +0400
Subject: [PATCH 4/5] ARM: clps711x: clep7312: Add common devices initialization
In-Reply-To: <1401538213-16106-1-git-send-email-shc_work@mail.ru>
References: <1401538213-16106-1-git-send-email-shc_work@mail.ru>
Message-ID: <1401538213-16106-4-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add initialization of commonly used devices to the CLEP7312 generic board.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-clps711x/board-clep7312.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-clps711x/board-clep7312.c b/arch/arm/mach-clps711x/board-clep7312.c
index 1f3b403..dbff8c6 100644
--- a/arch/arm/mach-clps711x/board-clep7312.c
+++ b/arch/arm/mach-clps711x/board-clep7312.c
@@ -24,6 +24,7 @@
 #include <asm/mach/arch.h>
 
 #include "common.h"
+#include "devices.h"
 
 static void __init
 fixup_clep7312(struct tag *tags, char **cmdline, struct meminfo *mi)
@@ -40,5 +41,6 @@ MACHINE_START(CLEP7212, "Cirrus Logic 7212/7312")
 	.map_io		= clps711x_map_io,
 	.init_irq	= clps711x_init_irq,
 	.init_time	= clps711x_timer_init,
+	.init_machine	= clps711x_devices_init,
 	.restart	= clps711x_restart,
 MACHINE_END
-- 
1.8.5.5
