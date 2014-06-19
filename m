From: shc_work@mail.ru (Alexander Shiyan)
Date: Thu, 19 Jun 2014 19:26:36 +0400
Subject: [PATCH RESEND 4/5] ARM: clps711x: clep7312: Add common devices
 initialization
In-Reply-To: <1403191597-28460-1-git-send-email-shc_work@mail.ru>
References: <1403191597-28460-1-git-send-email-shc_work@mail.ru>
Message-ID: <1403191597-28460-4-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add initialization of commonly used devices to the CLEP7312 generic
board.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-clps711x/board-clep7312.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-clps711x/board-clep7312.c b/arch/arm/mach-clps711x/board-clep7312.c
index b33ba21..f9ca22b 100644
--- a/arch/arm/mach-clps711x/board-clep7312.c
+++ b/arch/arm/mach-clps711x/board-clep7312.c
@@ -25,6 +25,7 @@
 #include <asm/mach/arch.h>
 
 #include "common.h"
+#include "devices.h"
 
 static void __init
 fixup_clep7312(struct tag *tags, char **cmdline)
@@ -39,5 +40,6 @@ MACHINE_START(CLEP7212, "Cirrus Logic 7212/7312")
 	.map_io		= clps711x_map_io,
 	.init_irq	= clps711x_init_irq,
 	.init_time	= clps711x_timer_init,
+	.init_machine	= clps711x_devices_init,
 	.restart	= clps711x_restart,
 MACHINE_END
-- 
1.8.5.5
