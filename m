From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 05 Nov 2011 22:29:54 +0000
Subject: [PATCH 2/2] ARM: PXA: fix includes in pxa2xx_cm_x2xx PCMCIA driver
In-Reply-To: <20111105222832.GH12913@n2100.arm.linux.org.uk>
References: <20111105222832.GH12913@n2100.arm.linux.org.uk>
Message-ID: <E1RMokM-0000KU-Hr@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The includes in the pxa2xx_cm_x2xx PCMCIA driver are rather random;
the driver doesn't require anything from these headers except the
cpu_is_xxx() macros which come from another include.

The concern is that it's getting these definitions via mach/system.h,
which is supposed to only be included by arch/arm/kernel/process.c.
As this header is scheduled for cleanup (and elimination) keeping
the status quo will cause build errors.  So lets fix properly and
independent of the future work.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/pcmcia/pxa2xx_cm_x2xx.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/pcmcia/pxa2xx_cm_x2xx.c b/drivers/pcmcia/pxa2xx_cm_x2xx.c
index 4f09506..6e7dcfd 100644
--- a/drivers/pcmcia/pxa2xx_cm_x2xx.c
+++ b/drivers/pcmcia/pxa2xx_cm_x2xx.c
@@ -12,9 +12,8 @@
 
 #include <linux/module.h>
 
-#include <asm/system.h>
 #include <asm/mach-types.h>
-#include <mach/system.h>
+#include <mach/hardware.h>
 
 int cmx255_pcmcia_init(void);
 int cmx270_pcmcia_init(void);
-- 
1.7.4.4
