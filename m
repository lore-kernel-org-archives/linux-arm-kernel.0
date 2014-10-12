From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sun, 12 Oct 2014 17:28:50 +0200
Subject: [PATCH v2 3/4] arm: pxa: remove unecessary includes from pxa-dt
In-Reply-To: <1413127731-1187-1-git-send-email-robert.jarzmik@free.fr>
References: <1413127731-1187-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <1413127731-1187-4-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the init functions necessary for machine init have moved to
generic.h, remove the unecessary includes and prototypes definitions
from pxa-dt.c.

This removes the include of mach/pxaXXX-regs.h, and make pxa-dt generic
enough to accept other pxa variants.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 arch/arm/mach-pxa/pxa-dt.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/mach-pxa/pxa-dt.c b/arch/arm/mach-pxa/pxa-dt.c
index f6a2c4b..b070196 100644
--- a/arch/arm/mach-pxa/pxa-dt.c
+++ b/arch/arm/mach-pxa/pxa-dt.c
@@ -15,13 +15,10 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
 #include <mach/irqs.h>
-#include <mach/pxa3xx.h>
 
 #include "generic.h"
 
 #ifdef CONFIG_PXA3xx
-extern void __init pxa3xx_dt_init_irq(void);
-
 static const struct of_dev_auxdata pxa3xx_auxdata_lookup[] __initconst = {
 	OF_DEV_AUXDATA("mrvl,pxa-uart",		0x40100000, "pxa2xx-uart.0", NULL),
 	OF_DEV_AUXDATA("mrvl,pxa-uart",		0x40200000, "pxa2xx-uart.1", NULL),
-- 
2.1.0
