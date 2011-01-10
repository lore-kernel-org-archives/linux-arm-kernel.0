From: jj@chaosbits.net (Jesper Juhl)
Date: Mon, 10 Jan 2011 22:29:32 +0100 (CET)
Subject: [PATCH] ARM AT91SAM9M10G45: Remove duplicate inclusion of
	mach/hardware.h
Message-ID: <alpine.LNX.2.00.1101102225550.32164@swampdragon.chaosbits.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove duplicate inclusion of mach/hardware.h

Signed-off-by: Jesper Juhl <jj@chaosbits.net>
---
 board-sam9m10g45ek.c |    1 -
 1 file changed, 1 deletion(-)

  Completely untested. I don't have any way of even compiling this, but I 
  think it's fairly obviously correct.

diff --git a/arch/arm/mach-at91/board-sam9m10g45ek.c b/arch/arm/mach-at91/board-sam9m10g45ek.c
index 86ff4b5..6c999db 100644
--- a/arch/arm/mach-at91/board-sam9m10g45ek.c
+++ b/arch/arm/mach-at91/board-sam9m10g45ek.c
@@ -29,23 +29,22 @@
 #include <mach/hardware.h>
 #include <video/atmel_lcdc.h>
 
 #include <asm/setup.h>
 #include <asm/mach-types.h>
 #include <asm/irq.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
 
-#include <mach/hardware.h>
 #include <mach/board.h>
 #include <mach/gpio.h>
 #include <mach/at91sam9_smc.h>
 #include <mach/at91_shdwc.h>
 
 #include "sam9_smc.h"
 #include "generic.h"
 
 
 static void __init ek_map_io(void)
 {


-- 
Jesper Juhl <jj@chaosbits.net>            http://www.chaosbits.net/
Don't top-post http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please.
