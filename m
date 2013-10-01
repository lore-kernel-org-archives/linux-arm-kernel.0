From: magnus.damm@gmail.com (Magnus Damm)
Date: Tue, 01 Oct 2013 17:12:48 +0900
Subject: [PATCH 06/10] ARM: shmobile: r8a7791 Arch timer workaround
In-Reply-To: <20131001081143.4136.46925.sendpatchset@w520>
References: <20131001081143.4136.46925.sendpatchset@w520>
Message-ID: <20131001081248.4136.41380.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Make use of the R-Car Gen2 arch timer workaround on r8a7791.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/Makefile        |    2 +-
 arch/arm/mach-shmobile/setup-r8a7791.c |    2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

--- 0001/arch/arm/mach-shmobile/Makefile
+++ work/arch/arm/mach-shmobile/Makefile	2013-10-01 16:32:25.000000000 +0900
@@ -16,7 +16,7 @@ obj-$(CONFIG_ARCH_R8A7778)	+= setup-r8a7
 obj-$(CONFIG_ARCH_R8A7779)	+= setup-r8a7779.o
 obj-$(CONFIG_ARCH_R8A7790)	+= setup-r8a7790.o
 obj-$(CONFIG_ARCH_R8A7790)	+= setup-r8a7790.o setup-rcar-gen2.o
-obj-$(CONFIG_ARCH_R8A7791)	+= setup-r8a7791.o
+obj-$(CONFIG_ARCH_R8A7791)	+= setup-r8a7791.o setup-rcar-gen2.o
 obj-$(CONFIG_ARCH_EMEV2)	+= setup-emev2.o
 
 # Clock objects
--- 0004/arch/arm/mach-shmobile/setup-r8a7791.c
+++ work/arch/arm/mach-shmobile/setup-r8a7791.c	2013-10-01 16:34:15.000000000 +0900
@@ -27,6 +27,7 @@
 #include <mach/common.h>
 #include <mach/irqs.h>
 #include <mach/r8a7791.h>
+#include <mach/rcar-gen2.h>
 #include <asm/mach/arch.h>
 
 #define SCIF_COMMON(scif_type, baseaddr, irq)			\
@@ -175,6 +176,7 @@ static const char *r8a7791_boards_compat
 
 DT_MACHINE_START(R8A7791_DT, "Generic R8A7791 (Flattened Device Tree)")
 	.init_early	= r8a7791_init_early,
+	.init_time	= rcar_gen2_timer_init,
 	.dt_compat	= r8a7791_boards_compat_dt,
 MACHINE_END
 #endif /* CONFIG_USE_OF */
