From: axel.lin@gmail.com (Axel Lin)
Date: Sun, 02 Sep 2012 20:25:47 +0800
Subject: [PATCH] ARM: ux500: Fix build error due to missing include of
 asm/pmu.h in cpu-db8500.c
Message-ID: <1346588747.7909.2.camel@phoenix>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Include asm/pmu.h to fix below build error:

  CC      arch/arm/mach-ux500/cpu-db8500.o
arch/arm/mach-ux500/cpu-db8500.c:118:8: error: variable 'db8500_pmu_platdata' has initializer but incomplete type
arch/arm/mach-ux500/cpu-db8500.c:119:2: error: unknown field 'handle_irq' specified in initializer
arch/arm/mach-ux500/cpu-db8500.c:119:2: warning: excess elements in struct initializer [enabled by default]
arch/arm/mach-ux500/cpu-db8500.c:119:2: warning: (near initialization for 'db8500_pmu_platdata') [enabled by default]
make[1]: *** [arch/arm/mach-ux500/cpu-db8500.o] Error 1
make: *** [arch/arm/mach-ux500] Error 2

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 arch/arm/mach-ux500/cpu-db8500.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index 8169f2c..3ce7d94 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -18,6 +18,7 @@
 #include <linux/io.h>
 #include <linux/mfd/abx500/ab8500.h>
 
+#include <asm/pmu.h>
 #include <asm/mach/map.h>
 #include <plat/gpio-nomadik.h>
 #include <mach/hardware.h>
-- 
1.7.9.5
