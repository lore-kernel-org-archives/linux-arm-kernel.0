From: baruch@tkos.co.il (Baruch Siach)
Date: Wed, 14 Jan 2015 10:40:30 +0200
Subject: [PATCH v3 1/4] ARM: initial support for Conexant Digicolor CX92755 SoC
In-Reply-To: <cover.1421219953.git.baruch@tkos.co.il>
References: <cover.1421219953.git.baruch@tkos.co.il>
Message-ID: <b78eff5b92f808cb6748097b4f7867fb320e8d21.1421219953.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add initial support for the Conexant CX92755 SoC. The CX92755 is one of the
Digicolor series of SoCs, all sharing many of the same peripherals. The code
was tested on the CX92755 evaluation kit, AKA Equinox.

Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 arch/arm/Kconfig                    |  2 ++
 arch/arm/mach-digicolor/Kconfig     |  5 +++++
 arch/arm/mach-digicolor/Makefile    |  1 +
 arch/arm/mach-digicolor/digicolor.c | 18 ++++++++++++++++++
 4 files changed, 26 insertions(+)
 create mode 100644 arch/arm/mach-digicolor/Kconfig
 create mode 100644 arch/arm/mach-digicolor/Makefile
 create mode 100644 arch/arm/mach-digicolor/digicolor.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 97d07ed60a0b..86e2202565e6 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -858,6 +858,8 @@ source "arch/arm/mach-cns3xxx/Kconfig"
 
 source "arch/arm/mach-davinci/Kconfig"
 
+source "arch/arm/mach-digicolor/Kconfig"
+
 source "arch/arm/mach-dove/Kconfig"
 
 source "arch/arm/mach-ep93xx/Kconfig"
diff --git a/arch/arm/mach-digicolor/Kconfig b/arch/arm/mach-digicolor/Kconfig
new file mode 100644
index 000000000000..5a0669a2738e
--- /dev/null
+++ b/arch/arm/mach-digicolor/Kconfig
@@ -0,0 +1,5 @@
+config ARCH_DIGICOLOR
+	bool "Conexant Digicolor SoC Support"
+	depends on ARCH_MULTI_V7
+	select CLKSRC_MMIO
+	select GENERIC_IRQ_CHIP
diff --git a/arch/arm/mach-digicolor/Makefile b/arch/arm/mach-digicolor/Makefile
new file mode 100644
index 000000000000..3d8a1d228408
--- /dev/null
+++ b/arch/arm/mach-digicolor/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_ARCH_DIGICOLOR)	+= digicolor.o
diff --git a/arch/arm/mach-digicolor/digicolor.c b/arch/arm/mach-digicolor/digicolor.c
new file mode 100644
index 000000000000..cfc88d1caa47
--- /dev/null
+++ b/arch/arm/mach-digicolor/digicolor.c
@@ -0,0 +1,18 @@
+/*
+ * Support for Conexant Digicolor SoCs
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <asm/mach/arch.h>
+
+static const char *digicolor_dt_compat[] __initconst = {
+	"cnxt,cx92755",
+	NULL,
+};
+
+DT_MACHINE_START(DIGICOLOR, "Conexant Digicolor (Flattened Device Tree)")
+	.dt_compat	= digicolor_dt_compat,
+MACHINE_END
-- 
2.1.4
