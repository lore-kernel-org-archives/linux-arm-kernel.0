From: jszhang@marvell.com (Jisheng Zhang)
Date: Thu, 7 Nov 2013 11:16:41 +0800
Subject: [PATCH V2 1/4] arm: highbank: make use of common scu_a9_get_base()
 interface
In-Reply-To: <1383794204-4714-1-git-send-email-jszhang@marvell.com>
References: <1383794204-4714-1-git-send-email-jszhang@marvell.com>
Message-ID: <1383794204-4714-2-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make use of common scu_a9_get_base() and delete the comment since the
interface is self commented.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 arch/arm/mach-highbank/highbank.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-highbank/highbank.c b/arch/arm/mach-highbank/highbank.c
index 8e63ccd..7df007b 100644
--- a/arch/arm/mach-highbank/highbank.c
+++ b/arch/arm/mach-highbank/highbank.c
@@ -29,6 +29,7 @@
 #include <asm/cacheflush.h>
 #include <asm/cputype.h>
 #include <asm/smp_plat.h>
+#include <asm/smp_scu.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -43,8 +44,7 @@ static void __init highbank_scu_map_io(void)
 {
 	unsigned long base;
 
-	/* Get SCU base */
-	asm("mrc p15, 4, %0, c15, c0, 0" : "=r" (base));
+	base = scu_a9_get_base();
 
 	scu_base_addr = ioremap(base, SZ_4K);
 }
-- 
1.8.4.2
