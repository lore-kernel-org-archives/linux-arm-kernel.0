From: jszhang@marvell.com (Jisheng Zhang)
Date: Thu, 7 Nov 2013 11:16:44 +0800
Subject: [PATCH V2 4/4] arm: socfgpa: make use of common scu_a9_get_base()
 interface
In-Reply-To: <1383794204-4714-1-git-send-email-jszhang@marvell.com>
References: <1383794204-4714-1-git-send-email-jszhang@marvell.com>
Message-ID: <1383794204-4714-5-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make use of common scu_a9_get_base() and delete the comment since the
interface is self commented.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 arch/arm/mach-socfpga/socfpga.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-socfpga/socfpga.c b/arch/arm/mach-socfpga/socfpga.c
index bfce964..b695887 100644
--- a/arch/arm/mach-socfpga/socfpga.c
+++ b/arch/arm/mach-socfpga/socfpga.c
@@ -24,6 +24,7 @@
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
+#include <asm/smp_scu.h>
 
 #include "core.h"
 
@@ -51,8 +52,7 @@ static void __init socfpga_scu_map_io(void)
 {
 	unsigned long base;
 
-	/* Get SCU base */
-	asm("mrc p15, 4, %0, c15, c0, 0" : "=r" (base));
+	base = scu_a9_get_base();
 
 	scu_io_desc.pfn = __phys_to_pfn(base);
 	iotable_init(&scu_io_desc, 1);
-- 
1.8.4.2
