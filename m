From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 9 Sep 2013 12:31:04 -0400 (EDT)
Subject: [PATCH] ARM: vexpress: allow dcscb and tc2_pm in a combined ARMv6+v7
 build
Message-ID: <alpine.LFD.2.03.1309091224010.20709@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This fixes the following build error:

/tmp/cce439dZ.s: Assembler messages:
/tmp/cce439dZ.s:506: Error: selected processor does not support ARM mode `isb '
/tmp/cce439dZ.s:512: Error: selected processor does not support ARM mode `isb '
/tmp/cce439dZ.s:513: Error: selected processor does not support ARM mode `dsb '
/tmp/cce439dZ.s:583: Error: selected processor does not support ARM mode `isb '
/tmp/cce439dZ.s:589: Error: selected processor does not support ARM mode `isb '
/tmp/cce439dZ.s:590: Error: selected processor does not support ARM mode `dsb '

Tested-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Nicolas Pitre <nico@linaro.org>

diff --git a/arch/arm/mach-vexpress/Makefile b/arch/arm/mach-vexpress/Makefile
index 36ea824712..505e64ab3e 100644
--- a/arch/arm/mach-vexpress/Makefile
+++ b/arch/arm/mach-vexpress/Makefile
@@ -7,6 +7,8 @@ ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include \
 obj-y					:= v2m.o
 obj-$(CONFIG_ARCH_VEXPRESS_CA9X4)	+= ct-ca9x4.o
 obj-$(CONFIG_ARCH_VEXPRESS_DCSCB)	+= dcscb.o	dcscb_setup.o
+CFLAGS_dcscb.o				+= -march=armv7-a
 obj-$(CONFIG_ARCH_VEXPRESS_TC2_PM)	+= tc2_pm.o spc.o
+CFLAGS_tc2_pm.o				+= -march=armv7-a
 obj-$(CONFIG_SMP)			+= platsmp.o
 obj-$(CONFIG_HOTPLUG_CPU)		+= hotplug.o
