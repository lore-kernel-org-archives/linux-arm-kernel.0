From: baruch@tkos.co.il (Baruch Siach)
Date: Tue, 23 Dec 2014 09:58:38 +0200
Subject: [PATCH 1/8] ARM: initial support for Conexant Digicolor CX92755 SoC
In-Reply-To: <cover.1419318109.git.baruch@tkos.co.il>
References: <cover.1419318109.git.baruch@tkos.co.il>
Message-ID: <e705e6c9d491431ab42dbfaedef881602a87619a.1419318109.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 arch/arm/Kconfig                    |  2 ++
 arch/arm/mach-digicolor/Kconfig     |  3 +++
 arch/arm/mach-digicolor/Makefile    |  1 +
 arch/arm/mach-digicolor/digicolor.c | 18 ++++++++++++++++++
 4 files changed, 24 insertions(+)
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
index 000000000000..4830122a9dd0
--- /dev/null
+++ b/arch/arm/mach-digicolor/Kconfig
@@ -0,0 +1,3 @@
+config ARCH_DIGICOLOR
+	bool "Conexant Digicolor SoC Support"
+	depends on ARCH_MULTI_V7
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
2.1.3
