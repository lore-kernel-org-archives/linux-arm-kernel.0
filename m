From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 21 Jun 2013 22:28:29 +0200
Subject: [PATCH] ARM: keystone: remove hand-coded smc instruction
Message-ID: <201306212228.29717.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This lets us build keystone with CONFIG_THUMB2_KERNEL enabled,
without the patch we get this error:

Error: cannot determine Thumb instruction size. Use .inst.n/.inst.w instead

This follows the same change for all other platforms done
earlier.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>

diff --git a/arch/arm/mach-keystone/platsmp.c b/arch/arm/mach-keystone/platsmp.c
index 630ab3bd..1800c33 100644
--- a/arch/arm/mach-keystone/platsmp.c
+++ b/arch/arm/mach-keystone/platsmp.c
@@ -34,7 +34,7 @@ static int __cpuinit keystone_smp_boot_secondary(unsigned int cpu,
 		"mov    r0, #0\n"	/* power on cmd	*/
 		"mov    r1, %1\n"	/* cpu		*/
 		"mov    r2, %2\n"	/* start	*/
-		".inst  0xe1600070\n"	/* smc #0	*/
+		"smc	#0\n"		/* smc #0	*/
 		"mov    %0, r0\n"
 		: "=r" (error)
 		: "r"(cpu), "r"(start)
