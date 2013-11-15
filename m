From: axel.lin@ingics.com (Axel Lin)
Date: Fri, 15 Nov 2013 11:38:00 +0800
Subject: [PATCH] ARM: nommu: Include asm/procinfo.h to fix build warning
Message-ID: <1384486680.11140.1.camel@phoenix>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Include asm/procinfo.h to fix below build warning:
  CC      arch/arm/mm/nommu.o
arch/arm/mm/nommu.c:303:17: warning: 'struct proc_info_list' declared inside parameter list [enabled by default]
arch/arm/mm/nommu.c:303:17: warning: its scope is only this definition or declaration, which is probably not what you want [enabled by default]

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 arch/arm/mm/nommu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mm/nommu.c b/arch/arm/mm/nommu.c
index 5c668b7..55764a7 100644
--- a/arch/arm/mm/nommu.c
+++ b/arch/arm/mm/nommu.c
@@ -18,6 +18,7 @@
 #include <asm/mach/arch.h>
 #include <asm/cputype.h>
 #include <asm/mpu.h>
+#include <asm/procinfo.h>
 
 #include "mm.h"
 
-- 
1.8.1.2
