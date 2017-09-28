From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 28 Sep 2017 16:14:55 -0700
Subject: [PATCH v2 03/10] ARM: bcm: Add support for Broadcom Hurricane 2 SoC
In-Reply-To: <20170928231502.27069-1-f.fainelli@gmail.com>
References: <20170928231502.27069-1-f.fainelli@gmail.com>
Message-ID: <20170928231502.27069-4-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a Kconfig entry point and basic machine board code for the Broadcom
Hurricane 2 SoCs used in switching products.

Acked-by: Jon Mason <jon.mason@broadcom.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/mach-bcm/Kconfig   |  9 +++++++++
 arch/arm/mach-bcm/Makefile  |  3 +++
 arch/arm/mach-bcm/bcm_hr2.c | 25 +++++++++++++++++++++++++
 3 files changed, 37 insertions(+)
 create mode 100644 arch/arm/mach-bcm/bcm_hr2.c

diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
index 73be3d578851..76807581f9f3 100644
--- a/arch/arm/mach-bcm/Kconfig
+++ b/arch/arm/mach-bcm/Kconfig
@@ -36,6 +36,15 @@ config ARCH_BCM_CYGNUS
 	  BCM11300, BCM11320, BCM11350, BCM11360,
 	  BCM58300, BCM58302, BCM58303, BCM58305.
 
+config ARCH_BCM_HR2
+	bool "Broadcom Hurricane 2 SoC support"
+	depends on ARCH_MULTI_V7
+	select ARCH_BCM_IPROC
+	help
+	  Enable support for the Hurricane 2 family,
+	  which includes the following variants:
+	  BCM53342, BCM53343, BCM53344, BCM53346.
+
 config ARCH_BCM_NSP
 	bool "Broadcom Northstar Plus SoC Support"
 	depends on ARCH_MULTI_V7
diff --git a/arch/arm/mach-bcm/Makefile b/arch/arm/mach-bcm/Makefile
index 980f5850097c..ec93c849a100 100644
--- a/arch/arm/mach-bcm/Makefile
+++ b/arch/arm/mach-bcm/Makefile
@@ -13,6 +13,9 @@
 # Cygnus
 obj-$(CONFIG_ARCH_BCM_CYGNUS) +=  bcm_cygnus.o
 
+# Hurricane 2
+obj-$(CONFIG_ARCH_BCM_HR2)	+= bcm_hr2.o
+
 # Northstar Plus
 obj-$(CONFIG_ARCH_BCM_NSP)	+= bcm_nsp.o
 
diff --git a/arch/arm/mach-bcm/bcm_hr2.c b/arch/arm/mach-bcm/bcm_hr2.c
new file mode 100644
index 000000000000..c104f28995d7
--- /dev/null
+++ b/arch/arm/mach-bcm/bcm_hr2.c
@@ -0,0 +1,25 @@
+/*
+ * Copyright (C) 2017 Broadcom
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <asm/mach/arch.h>
+
+static const char * const bcm_hr2_dt_compat[] __initconst = {
+	"brcm,hr2",
+	NULL,
+};
+
+DT_MACHINE_START(BCM_HR2_DT, "Broadcom Hurricane 2 SoC")
+	.l2c_aux_val	= 0,
+	.l2c_aux_mask	= ~0,
+	.dt_compat = bcm_hr2_dt_compat,
+MACHINE_END
-- 
2.14.1
