From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 28 Mar 2014 14:07:00 +0100
Subject: [PATCH 04/10] ARM: mvebu: add Armada 375/38x support in cpu-reset
In-Reply-To: <1396012026-5997-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1396012026-5997-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1396012026-5997-5-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds new compatible strings for the Armada 375 and Armada
38x SOCs to the cpu-reset code of mach-mvebu. It will allow the
upcoming SMP support for these SOCs to start the secondary CPUs.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 .../devicetree/bindings/arm/armada-cpu-reset.txt       |  2 ++
 arch/arm/mach-mvebu/armada-375.h                       | 18 ++++++++++++++++++
 arch/arm/mach-mvebu/armada-380.h                       | 18 ++++++++++++++++++
 arch/arm/mach-mvebu/cpu-reset.c                        |  4 ++++
 4 files changed, 42 insertions(+)
 create mode 100644 arch/arm/mach-mvebu/armada-375.h
 create mode 100644 arch/arm/mach-mvebu/armada-380.h

diff --git a/Documentation/devicetree/bindings/arm/armada-cpu-reset.txt b/Documentation/devicetree/bindings/arm/armada-cpu-reset.txt
index 384cbf8..27e70df 100644
--- a/Documentation/devicetree/bindings/arm/armada-cpu-reset.txt
+++ b/Documentation/devicetree/bindings/arm/armada-cpu-reset.txt
@@ -7,6 +7,8 @@ Required properties:
   values are:
     marvell,armada-370-cpu-reset
     marvell,armada-xp-cpu-reset
+    marvell,armada-375-cpu-reset
+    marvell,armada-380-cpu-reset
 
 - reg: should be register base and length as documented in the
   datasheet for the CPU reset registers
diff --git a/arch/arm/mach-mvebu/armada-375.h b/arch/arm/mach-mvebu/armada-375.h
new file mode 100644
index 0000000..3da7575
--- /dev/null
+++ b/arch/arm/mach-mvebu/armada-375.h
@@ -0,0 +1,18 @@
+/*
+ * Generic definitions for Marvell Armada 375 SoCs
+ *
+ * Copyright (C) 2014 Marvell
+ *
+ * Gregory CLEMENT <gregory.clement@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __MACH_ARMADA_375_H
+#define __MACH_ARMADA_375_H
+
+#define ARMADA_375_MAX_CPUS 2
+
+#endif /* __MACH_ARMADA_375_H */
diff --git a/arch/arm/mach-mvebu/armada-380.h b/arch/arm/mach-mvebu/armada-380.h
new file mode 100644
index 0000000..fdfc34f
--- /dev/null
+++ b/arch/arm/mach-mvebu/armada-380.h
@@ -0,0 +1,18 @@
+/*
+ * Generic definitions for Marvell Armada 38x SoCs
+ *
+ * Copyright (C) 2014 Marvell
+ *
+ * Gregory CLEMENT <gregory.clement@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __MACH_ARMADA_38X_H
+#define __MACH_ARMADA_38X_H
+
+#define ARMADA_380_MAX_CPUS 2
+
+#endif /* __MACH_ARMADA_38X_H */
diff --git a/arch/arm/mach-mvebu/cpu-reset.c b/arch/arm/mach-mvebu/cpu-reset.c
index e3821b1..8b84c94 100644
--- a/arch/arm/mach-mvebu/cpu-reset.c
+++ b/arch/arm/mach-mvebu/cpu-reset.c
@@ -16,10 +16,14 @@
 #include <linux/io.h>
 #include <linux/resource.h>
 #include "armada-370-xp.h"
+#include "armada-375.h"
+#include "armada-380.h"
 
 static struct of_device_id of_cpu_reset_table[] = {
 	{.compatible = "marvell,armada-370-cpu-reset", .data = (void*) ARMADA_370_MAX_CPUS },
 	{.compatible = "marvell,armada-xp-cpu-reset",  .data = (void*) ARMADA_XP_MAX_CPUS },
+	{.compatible = "marvell,armada-375-cpu-reset", .data = (void*) ARMADA_375_MAX_CPUS },
+	{.compatible = "marvell,armada-380-cpu-reset", .data = (void*) ARMADA_380_MAX_CPUS },
 	{ /* end of list */ },
 };
 
-- 
1.8.3.2
