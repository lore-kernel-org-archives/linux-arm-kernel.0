From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 30 Apr 2013 14:38:07 +0200
Subject: [PATCH] ARM: add the "bool" type definition to asm/mach/arch.h
In-Reply-To: <517F8FF4.3050901@atmel.com>
References: <517F8FF4.3050901@atmel.com>
Message-ID: <1367325487-8366-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Addition of boolean field to machine_desc structure in commit
4dbfa9a25367cfa91aec0e56d75a6905d3242cd3 (ARM: Enable selection of
SMP operations at boot time) was triggering compilation errors like:

  CC      arch/arm/mach-at91/at91sam9260_devices.o
In file included from arch/arm/mach-at91/at91sam9260_devices.c:12:0:
arch/arm/include/asm/mach/arch.h:46:2: error: expected specifier-qualifier-list before "bool"

So, we add the definition of "bool" by including the linux/types.h
file to asm/mach/arch.h and make it self-contained.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/include/asm/mach/arch.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/include/asm/mach/arch.h b/arch/arm/include/asm/mach/arch.h
index af8c54c..75bf079 100644
--- a/arch/arm/include/asm/mach/arch.h
+++ b/arch/arm/include/asm/mach/arch.h
@@ -8,6 +8,8 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/types.h>
+
 #ifndef __ASSEMBLY__
 
 struct tag;
-- 
1.8.0
