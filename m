From: Dinh.Nguyen@freescale.com (Dinh Nguyen)
Date: Tue, 13 Apr 2010 14:05:08 -0500
Subject: [2.6.34-fixes 1/1] mx5: Fix build error for mx51_defconfig
Message-ID: <3a30bc0788e02ba069c003d194680a2d39ef1c1a.1271883980.git.amit.kucheria@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Need to include <asm/div64.h> for do_div calls. Fixes the following error:

arch/arm/mach-mx5/clock-mx51.c: In function 'clk_pll_get_rate':
arch/arm/mach-mx5/clock-mx51.c:149: error: implicit declaration of function
'do_div'
make[1]: *** [arch/arm/mach-mx5/clock-mx51.o] Error 1

Signed-off-by: Dinh Nguyen <Dinh.Nguyen@freescale.com>
Signed-off-by: Amit Kucheria <amit.kucheria@canonical.com>
---
 arch/arm/mach-mx5/clock-mx51.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx5/clock-mx51.c b/arch/arm/mach-mx5/clock-mx51.c
index 8f85f73..1ee6ce4 100644
--- a/arch/arm/mach-mx5/clock-mx51.c
+++ b/arch/arm/mach-mx5/clock-mx51.c
@@ -16,6 +16,7 @@
 #include <linux/io.h>
 
 #include <asm/clkdev.h>
+#include <asm/div64.h>
 
 #include <mach/hardware.h>
 #include <mach/common.h>
-- 
1.7.0.4


-- 
-------------------------------------------------------------------------
Amit Kucheria,				 Kernel Developer, Verdurent
-------------------------------------------------------------------------
