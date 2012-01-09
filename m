From: robherring2@gmail.com (Rob Herring)
Date: Mon,  9 Jan 2012 16:45:42 -0600
Subject: [PATCH 2/6] ARM: realview: remove incorrect BSYM usage
In-Reply-To: <1326149146-19756-1-git-send-email-robherring2@gmail.com>
References: <1326149146-19756-1-git-send-email-robherring2@gmail.com>
Message-ID: <1326149146-19756-3-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

BSYM macro is only needed for assembly files and its usage in c files is
wrong, so remove it. The linker will correctly set bit 0 for Thumb2
kernels.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Dave Martin <dave.martin@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>
---
 arch/arm/mach-realview/platsmp.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-realview/platsmp.c b/arch/arm/mach-realview/platsmp.c
index e83c654..17c878d 100644
--- a/arch/arm/mach-realview/platsmp.c
+++ b/arch/arm/mach-realview/platsmp.c
@@ -17,7 +17,6 @@
 #include <asm/hardware/gic.h>
 #include <asm/mach-types.h>
 #include <asm/smp_scu.h>
-#include <asm/unified.h>
 
 #include <mach/board-eb.h>
 #include <mach/board-pb11mp.h>
@@ -75,6 +74,6 @@ void __init platform_smp_prepare_cpus(unsigned int max_cpus)
 	 * until it receives a soft interrupt, and then the
 	 * secondary CPU branches to this address.
 	 */
-	__raw_writel(BSYM(virt_to_phys(versatile_secondary_startup)),
+	__raw_writel(virt_to_phys(versatile_secondary_startup),
 		     __io_address(REALVIEW_SYS_FLAGSSET));
 }
-- 
1.7.5.4
