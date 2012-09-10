From: jm@lentin.co.uk (Jamie Lentin)
Date: Mon, 10 Sep 2012 15:35:53 +0100
Subject: [PATCH] ARM: kirkwood: Trim excess #includes in board-dnskw.c
Message-ID: <1347287753-2805-1-git-send-email-jm@lentin.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lots of code has now moved into the devicetree, leaving a collection of
useless header files. Tidy them up.

This applies cleanly atop of my previous patch, "[PATCH V2 2/2] ARM:
kirkwood: Use devicetree to define DNS-32[05] fan", which also removes
gpio-fan.h

Signed-off-by: Jamie Lentin <jm@lentin.co.uk>
---
 arch/arm/mach-kirkwood/board-dnskw.c |    9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/arm/mach-kirkwood/board-dnskw.c b/arch/arm/mach-kirkwood/board-dnskw.c
index 6ac7a8d..43d16d6 100644
--- a/arch/arm/mach-kirkwood/board-dnskw.c
+++ b/arch/arm/mach-kirkwood/board-dnskw.c
@@ -14,17 +14,8 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
-#include <linux/ata_platform.h>
 #include <linux/mv643xx_eth.h>
-#include <linux/of.h>
 #include <linux/gpio.h>
-#include <linux/input.h>
-#include <linux/leds.h>
-#include <asm/mach-types.h>
-#include <asm/mach/arch.h>
-#include <asm/mach/map.h>
-#include <mach/kirkwood.h>
-#include <mach/bridge-regs.h>
 #include "common.h"
 #include "mpp.h"
 
-- 
1.7.10.4
