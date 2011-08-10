From: dave.martin@linaro.org (Dave Martin)
Date: Wed, 10 Aug 2011 11:13:40 +0100
Subject: [RFC PATCH 2/5] ARM: s3c24xx: Reference cpu_architecture as a global
	variable
In-Reply-To: <1312971223-28165-1-git-send-email-dave.martin@linaro.org>
References: <1312971223-28165-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1312971223-28165-3-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is needed for compatibility with the change of
cpu_architecture from a function to a global variable.

Since cpu_architecture is ARM-specific, also add an explicit
include for <asm/system.h> rather than relying on this being
included as a side-effect.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/plat-s3c24xx/cpu.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-s3c24xx/cpu.c b/arch/arm/plat-s3c24xx/cpu.c
index c1fc6c6..bc118dc 100644
--- a/arch/arm/plat-s3c24xx/cpu.c
+++ b/arch/arm/plat-s3c24xx/cpu.c
@@ -34,6 +34,7 @@
 #include <mach/hardware.h>
 #include <asm/irq.h>
 #include <asm/cacheflush.h>
+#include <asm/system.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -221,7 +222,7 @@ void __init s3c24xx_init_io(struct map_desc *mach_desc, int size)
 	iotable_init(mach_desc, size);
 	iotable_init(s3c_iodesc, ARRAY_SIZE(s3c_iodesc));
 
-	if (cpu_architecture() >= CPU_ARCH_ARMv5) {
+	if (cpu_architecture >= CPU_ARCH_ARMv5) {
 		idcode = s3c24xx_read_idcode_v5();
 	} else {
 		idcode = s3c24xx_read_idcode_v4();
-- 
1.7.4.1
