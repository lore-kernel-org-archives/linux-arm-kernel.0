From: kmpark@infradead.org (Kyungmin Park)
Date: Wed, 28 Jul 2010 19:12:28 +0900
Subject: [PATCH 6/6] S5PV310: Enable the OneNAND at Universal board
Message-ID: <20100728101228.GA21353@july>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kyungmin Park <kyungmin.park@samsung.com>

Use the OneNAND at universal board

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s5pv310/Kconfig          |    1 +
 arch/arm/mach-s5pv310/mach-universal.c |    8 ++++++++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5pv310/Kconfig b/arch/arm/mach-s5pv310/Kconfig
index 2fe8149..1bf780e 100644
--- a/arch/arm/mach-s5pv310/Kconfig
+++ b/arch/arm/mach-s5pv310/Kconfig
@@ -28,6 +28,7 @@ config MACH_UNIVERSAL
 	bool "Mobile Universal Board"
 	select CPU_S5PV310
 	select ARCH_SPARSEMEM_ENABLE
+	select S5PC110_DEV_ONENAND
 	help
 	  Machine support for Samsung Mobile Universal Reference Board.
 	  S5PC210(MCP) is one of package option of S5PV310
diff --git a/arch/arm/mach-s5pv310/mach-universal.c b/arch/arm/mach-s5pv310/mach-universal.c
index d22727f..371a95d 100644
--- a/arch/arm/mach-s5pv310/mach-universal.c
+++ b/arch/arm/mach-s5pv310/mach-universal.c
@@ -16,6 +16,7 @@
 #include <plat/regs-serial.h>
 #include <plat/s5pv310.h>
 #include <plat/cpu.h>
+#include <plat/devs.h>
 
 #include <mach/map.h>
 
@@ -60,6 +61,10 @@ static struct s3c2410_uartcfg universal_uartcfgs[] __initdata = {
 	},
 };
 
+static struct platform_device *universal_devices[] __initdata = {
+	&s5pc110_device_onenand,
+};
+
 static void __init universal_map_io(void)
 {
 	s5p_init_io(NULL, 0, S5P_VA_CHIPID);
@@ -72,6 +77,9 @@ static void __init universal_machine_init(void)
 #ifdef CONFIG_CACHE_L2X0
 	l2x0_init(S5P_VA_L2CC, 1 << 28, 0xffffffff);
 #endif
+
+	/* Last */
+	platform_add_devices(universal_devices, ARRAY_SIZE(universal_devices));
 }
 
 MACHINE_START(UNIVERSAL, "UNIVERSAL")
-- 
1.5.3.3
