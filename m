From: gerg@uclinux.org (Greg Ungerer)
Date: Wed, 30 Mar 2011 14:43:32 +1000
Subject: [PATCH] arm: at91: fix compiler warning for eb01 board build
Message-ID: <1301460212-6940-1-git-send-email-gerg@uclinux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix compiler warning when building for AT91EB01 board:

arch/arm/mach-at91/board-eb01.c:41: warning: initialisation from incompatible pointer type

Signed-off-by: Greg Ungerer <gerg@uclinux.org>
---
 arch/arm/mach-at91/board-eb01.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-at91/board-eb01.c b/arch/arm/mach-at91/board-eb01.c
index 1f9d3cb..d8df59a 100644
--- a/arch/arm/mach-at91/board-eb01.c
+++ b/arch/arm/mach-at91/board-eb01.c
@@ -30,6 +30,11 @@
 #include <mach/board.h>
 #include "generic.h"
 
+static void __init at91eb01_init_irq(void)
+{
+	at91x40_init_interrupts(NULL);
+}
+
 static void __init at91eb01_map_io(void)
 {
 	at91x40_initialize(40000000);
@@ -38,7 +43,7 @@ static void __init at91eb01_map_io(void)
 MACHINE_START(AT91EB01, "Atmel AT91 EB01")
 	/* Maintainer: Greg Ungerer <gerg@snapgear.com> */
 	.timer		= &at91x40_timer,
-	.init_irq	= at91x40_init_interrupts,
+	.init_irq	= at91eb01_init_irq,
 	.map_io		= at91eb01_map_io,
 MACHINE_END
 
-- 
1.7.0.4
