From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  9 Oct 2013 15:49:50 +0900
Subject: [PATCH 09/14] ARM: shmobile: r8a7791 Arch timer workaround
In-Reply-To: <cover.1381293239.git.horms+renesas@verge.net.au>
References: <cover.1381293239.git.horms+renesas@verge.net.au>
Message-ID: <cd8344f4ddfe58ef9ca1743eff3a121f00b75302.1381293239.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Make use of the R-Car Gen2 arch timer workaround on r8a7791.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/Makefile        | 2 +-
 arch/arm/mach-shmobile/setup-r8a7791.c | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index 6b7a02e..3c37e82 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -16,7 +16,7 @@ obj-$(CONFIG_ARCH_R8A7778)	+= setup-r8a7778.o
 obj-$(CONFIG_ARCH_R8A7779)	+= setup-r8a7779.o
 obj-$(CONFIG_ARCH_R8A7790)	+= setup-r8a7790.o
 obj-$(CONFIG_ARCH_R8A7790)	+= setup-r8a7790.o setup-rcar-gen2.o
-obj-$(CONFIG_ARCH_R8A7791)	+= setup-r8a7791.o
+obj-$(CONFIG_ARCH_R8A7791)	+= setup-r8a7791.o setup-rcar-gen2.o
 obj-$(CONFIG_ARCH_EMEV2)	+= setup-emev2.o
 
 # Clock objects
diff --git a/arch/arm/mach-shmobile/setup-r8a7791.c b/arch/arm/mach-shmobile/setup-r8a7791.c
index ba4fa3e..cb3859b 100644
--- a/arch/arm/mach-shmobile/setup-r8a7791.c
+++ b/arch/arm/mach-shmobile/setup-r8a7791.c
@@ -28,6 +28,7 @@
 #include <mach/common.h>
 #include <mach/irqs.h>
 #include <mach/r8a7791.h>
+#include <mach/rcar-gen2.h>
 #include <asm/mach/arch.h>
 
 #define SCIF_COMMON(scif_type, baseaddr, irq)			\
@@ -176,6 +177,7 @@ static const char *r8a7791_boards_compat_dt[] __initdata = {
 
 DT_MACHINE_START(R8A7791_DT, "Generic R8A7791 (Flattened Device Tree)")
 	.init_early	= r8a7791_init_early,
+	.init_time	= rcar_gen2_timer_init,
 	.dt_compat	= r8a7791_boards_compat_dt,
 MACHINE_END
 #endif /* CONFIG_USE_OF */
-- 
1.8.4
