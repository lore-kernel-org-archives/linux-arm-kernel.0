From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Wed, 25 Nov 2015 10:33:37 +0000
Subject: [RFC PATCH 06/10] ARM: mps2: introduce MPS2 platform
In-Reply-To: <1448447621-17900-1-git-send-email-vladimir.murzin@arm.com>
References: <1448447621-17900-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1448447621-17900-7-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Cortex-M Prototyping System (or V2M-MPS2) is designed for
prototyping and evaluation Cortex-M family of processors including the
latest Cortex-M7.

It comes with a range of useful peripherals including 8MB single cycle
SRAM, 16MB PSRAM, Ethernet, QSVGA touch screen panel, 4bit RGB VGA
connector, Audio, SPI and GPIO.

Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/arm/Kconfig                 |    8 ++++++++
 arch/arm/Makefile                |    1 +
 arch/arm/mach-mps2/Makefile      |    1 +
 arch/arm/mach-mps2/Makefile.boot |    3 +++
 arch/arm/mach-mps2/dtmachine.c   |   21 +++++++++++++++++++++
 5 files changed, 34 insertions(+)
 create mode 100644 arch/arm/mach-mps2/Makefile
 create mode 100644 arch/arm/mach-mps2/Makefile.boot
 create mode 100644 arch/arm/mach-mps2/dtmachine.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 0365cbb..28db2b2 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -967,6 +967,14 @@ config ARCH_STM32
 	help
 	  Support for STMicroelectronics STM32 processors.
 
+config ARCH_MPS2
+	bool "ARM MPS2 paltform"
+	depends on ARM_SINGLE_ARMV7M
+	select ARM_AMBA
+	select CLKSRC_MPS2
+	help
+	  Support for ARM MPS2 Cortex-M platform.
+
 # Definitions to make life easier
 config ARCH_ACORN
 	bool
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 2c2b28e..dbe06fd 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -183,6 +183,7 @@ machine-$(CONFIG_ARCH_LPC18XX)		+= lpc18xx
 machine-$(CONFIG_ARCH_LPC32XX)		+= lpc32xx
 machine-$(CONFIG_ARCH_MESON)		+= meson
 machine-$(CONFIG_ARCH_MMP)		+= mmp
+machine-$(CONFIG_ARCH_MPS2)		+= mps2
 machine-$(CONFIG_ARCH_MOXART)		+= moxart
 machine-$(CONFIG_ARCH_MV78XX0)		+= mv78xx0
 machine-$(CONFIG_ARCH_MVEBU)		+= mvebu
diff --git a/arch/arm/mach-mps2/Makefile b/arch/arm/mach-mps2/Makefile
new file mode 100644
index 0000000..3a74af7
--- /dev/null
+++ b/arch/arm/mach-mps2/Makefile
@@ -0,0 +1 @@
+obj-y += dtmachine.o
diff --git a/arch/arm/mach-mps2/Makefile.boot b/arch/arm/mach-mps2/Makefile.boot
new file mode 100644
index 0000000..eacfc3f
--- /dev/null
+++ b/arch/arm/mach-mps2/Makefile.boot
@@ -0,0 +1,3 @@
+# Empty file waiting for deletion once Makefile.boot isn't needed any more.
+# Patch waits for application at
+# http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=7889/1 .
diff --git a/arch/arm/mach-mps2/dtmachine.c b/arch/arm/mach-mps2/dtmachine.c
new file mode 100644
index 0000000..e7ad9c2
--- /dev/null
+++ b/arch/arm/mach-mps2/dtmachine.c
@@ -0,0 +1,21 @@
+/*
+ * Copyright (C) 2015 ARM Limited
+ *
+ * Author: Vladimir Murzin <vladimir.murzin@arm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <asm/mach/arch.h>
+
+static const char *const mps2_compat[] __initconst = {
+	"arm,mps2",
+	NULL
+};
+
+DT_MACHINE_START(MPS2DT, "MPS2 (Device Tree Support)")
+	.dt_compat = mps2_compat,
+MACHINE_END
-- 
1.7.9.5
