From: viresh.kumar@st.com (Viresh KUMAR)
Date: Thu, 25 Mar 2010 14:10:50 +0530
Subject: [PATCH V2 Resend 07/12] ST SPEAr: Added source files for SPEAr3xx
	machine family
In-Reply-To: <1269506455-15173-7-git-send-email-viresh.kumar@st.com>
References: <1269506455-15173-1-git-send-email-viresh.kumar@st.com>
	<1269506455-15173-2-git-send-email-viresh.kumar@st.com>
	<1269506455-15173-3-git-send-email-viresh.kumar@st.com>
	<1269506455-15173-4-git-send-email-viresh.kumar@st.com>
	<1269506455-15173-5-git-send-email-viresh.kumar@st.com>
	<1269506455-15173-6-git-send-email-viresh.kumar@st.com>
	<1269506455-15173-7-git-send-email-viresh.kumar@st.com>
Message-ID: <1269506455-15173-8-git-send-email-viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/mach-spear3xx/Kconfig        |   33 +++++++++++
 arch/arm/mach-spear3xx/Kconfig300     |   17 ++++++
 arch/arm/mach-spear3xx/Kconfig310     |   17 ++++++
 arch/arm/mach-spear3xx/Kconfig320     |   17 ++++++
 arch/arm/mach-spear3xx/Makefile       |   26 +++++++++
 arch/arm/mach-spear3xx/Makefile.boot  |    3 +
 arch/arm/mach-spear3xx/spear300.c     |   45 +++++++++++++++
 arch/arm/mach-spear3xx/spear300_evb.c |   55 ++++++++++++++++++
 arch/arm/mach-spear3xx/spear310.c     |   25 ++++++++
 arch/arm/mach-spear3xx/spear310_evb.c |   54 +++++++++++++++++
 arch/arm/mach-spear3xx/spear320.c     |   25 ++++++++
 arch/arm/mach-spear3xx/spear320_evb.c |   54 +++++++++++++++++
 arch/arm/mach-spear3xx/spear3xx.c     |  101 +++++++++++++++++++++++++++++++++
 13 files changed, 472 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-spear3xx/Kconfig
 create mode 100644 arch/arm/mach-spear3xx/Kconfig300
 create mode 100644 arch/arm/mach-spear3xx/Kconfig310
 create mode 100644 arch/arm/mach-spear3xx/Kconfig320
 create mode 100644 arch/arm/mach-spear3xx/Makefile
 create mode 100644 arch/arm/mach-spear3xx/Makefile.boot
 create mode 100644 arch/arm/mach-spear3xx/spear300.c
 create mode 100644 arch/arm/mach-spear3xx/spear300_evb.c
 create mode 100644 arch/arm/mach-spear3xx/spear310.c
 create mode 100644 arch/arm/mach-spear3xx/spear310_evb.c
 create mode 100644 arch/arm/mach-spear3xx/spear320.c
 create mode 100644 arch/arm/mach-spear3xx/spear320_evb.c
 create mode 100644 arch/arm/mach-spear3xx/spear3xx.c

diff --git a/arch/arm/mach-spear3xx/Kconfig b/arch/arm/mach-spear3xx/Kconfig
new file mode 100644
index 0000000..20d1317
--- /dev/null
+++ b/arch/arm/mach-spear3xx/Kconfig
@@ -0,0 +1,33 @@
+#
+# SPEAr3XX Machine configuration file
+#
+
+if ARCH_SPEAR3XX
+
+choice
+	prompt "SPEAr3XX Family"
+	default MACH_SPEAR300
+
+config MACH_SPEAR300
+	bool "SPEAr300"
+	help
+	  Supports ST SPEAr300 Machine
+
+config MACH_SPEAR310
+	bool "SPEAr310"
+	help
+	  Supports ST SPEAr310 Machine
+
+config MACH_SPEAR320
+	bool "SPEAr320"
+	help
+	  Supports ST SPEAr320 Machine
+
+endchoice
+
+# Adding SPEAr3XX machine specific configuration files
+source "arch/arm/mach-spear3xx/Kconfig300"
+source "arch/arm/mach-spear3xx/Kconfig310"
+source "arch/arm/mach-spear3xx/Kconfig320"
+
+endif #ARCH_SPEAR3XX
diff --git a/arch/arm/mach-spear3xx/Kconfig300 b/arch/arm/mach-spear3xx/Kconfig300
new file mode 100644
index 0000000..c519a05
--- /dev/null
+++ b/arch/arm/mach-spear3xx/Kconfig300
@@ -0,0 +1,17 @@
+#
+# SPEAr300 machine configuration file
+#
+
+if MACH_SPEAR300
+
+choice
+	prompt "SPEAr300 Boards"
+	default BOARD_SPEAR300_EVB
+
+config BOARD_SPEAR300_EVB
+	bool "SPEAr300 Evaluation Board"
+	help
+	  Supports ST SPEAr300 Evaluation Board
+endchoice
+
+endif	#MACH_SPEAR300
diff --git a/arch/arm/mach-spear3xx/Kconfig310 b/arch/arm/mach-spear3xx/Kconfig310
new file mode 100644
index 0000000..60e7442
--- /dev/null
+++ b/arch/arm/mach-spear3xx/Kconfig310
@@ -0,0 +1,17 @@
+#
+# SPEAr310 machine configuration file
+#
+
+if MACH_SPEAR310
+
+choice
+	prompt "SPEAr310 Boards"
+	default BOARD_SPEAR310_EVB
+
+config BOARD_SPEAR310_EVB
+	bool "SPEAr310 Evaluation Board"
+	help
+	  Supports ST SPEAr310 Evaluation Board
+endchoice
+
+endif	#MACH_SPEAR310
diff --git a/arch/arm/mach-spear3xx/Kconfig320 b/arch/arm/mach-spear3xx/Kconfig320
new file mode 100644
index 0000000..1c1d438
--- /dev/null
+++ b/arch/arm/mach-spear3xx/Kconfig320
@@ -0,0 +1,17 @@
+#
+# SPEAr320 machine configuration file
+#
+
+if MACH_SPEAR320
+
+choice
+	prompt "SPEAr320 Boards"
+	default BOARD_SPEAR320_EVB
+
+config BOARD_SPEAR320_EVB
+	bool "SPEAr320 Evaluation Board"
+	help
+	  Supports ST SPEAr320 Evaluation Board
+endchoice
+
+endif	#MACH_SPEAR320
diff --git a/arch/arm/mach-spear3xx/Makefile b/arch/arm/mach-spear3xx/Makefile
new file mode 100644
index 0000000..b248624
--- /dev/null
+++ b/arch/arm/mach-spear3xx/Makefile
@@ -0,0 +1,26 @@
+#
+# Makefile for SPEAr3XX machine series
+#
+
+# common files
+obj-y	+= spear3xx.o clock.o
+
+# spear300 specific files
+obj-$(CONFIG_MACH_SPEAR300) += spear300.o
+
+# spear300 boards files
+obj-$(CONFIG_BOARD_SPEAR300_EVB) += spear300_evb.o
+
+
+# spear310 specific files
+obj-$(CONFIG_MACH_SPEAR310) += spear310.o
+
+# spear310 boards files
+obj-$(CONFIG_BOARD_SPEAR310_EVB) += spear310_evb.o
+
+
+# spear320 specific files
+obj-$(CONFIG_MACH_SPEAR320) += spear320.o
+
+# spear320 boards files
+obj-$(CONFIG_BOARD_SPEAR320_EVB) += spear320_evb.o
diff --git a/arch/arm/mach-spear3xx/Makefile.boot b/arch/arm/mach-spear3xx/Makefile.boot
new file mode 100644
index 0000000..7a1f3c0
--- /dev/null
+++ b/arch/arm/mach-spear3xx/Makefile.boot
@@ -0,0 +1,3 @@
+zreladdr-y	:= 0x00008000
+params_phys-y	:= 0x00000100
+initrd_phys-y	:= 0x00800000
diff --git a/arch/arm/mach-spear3xx/spear300.c b/arch/arm/mach-spear3xx/spear300.c
new file mode 100644
index 0000000..63aca8f
--- /dev/null
+++ b/arch/arm/mach-spear3xx/spear300.c
@@ -0,0 +1,45 @@
+/*
+ * arch/arm/mach-spear3xx/spear300.c
+ *
+ * SPEAr300 machine source file
+ *
+ * Copyright (C) 2009 ST Microelectronics
+ * Viresh Kumar<viresh.kumar@st.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/types.h>
+#include <linux/amba/pl061.h>
+#include <linux/ptrace.h>
+#include <asm/irq.h>
+#include <mach/generic.h>
+#include <mach/spear.h>
+
+/* Add spear300 specific devices here */
+/* arm gpio1 device registeration */
+static struct pl061_platform_data gpio1_plat_data = {
+	.gpio_base	= 8,
+	.irq_base	= SPEAR_GPIO1_INT_BASE,
+};
+
+struct amba_device gpio1_device = {
+	.dev = {
+		.init_name = "gpio1",
+		.platform_data = &gpio1_plat_data,
+	},
+	.res = {
+		.start = SPEAR300_GPIO_BASE,
+		.end = SPEAR300_GPIO_BASE + SPEAR300_GPIO_SIZE - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	.irq = {IRQ_GEN_RAS_1, NO_IRQ},
+};
+
+void __init spear300_init(void)
+{
+	/* call spear3xx family common init function */
+	spear3xx_init();
+}
diff --git a/arch/arm/mach-spear3xx/spear300_evb.c b/arch/arm/mach-spear3xx/spear300_evb.c
new file mode 100644
index 0000000..1272a38
--- /dev/null
+++ b/arch/arm/mach-spear3xx/spear300_evb.c
@@ -0,0 +1,55 @@
+/*
+ * arch/arm/mach-spear3xx/spear300_evb.c
+ *
+ * SPEAr300 evaluation board source file
+ *
+ * Copyright (C) 2009 ST Microelectronics
+ * Viresh Kumar<viresh.kumar@st.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <asm/mach/arch.h>
+#include <asm/mach-types.h>
+#include <mach/generic.h>
+#include <mach/spear.h>
+
+static struct amba_device *amba_devs[] __initdata = {
+	/* spear3xx specific devices */
+	&gpio_device,
+	&uart_device,
+
+	/* spear300 specific devices */
+	&gpio1_device,
+};
+
+static struct platform_device *plat_devs[] __initdata = {
+	/* spear3xx specific devices */
+
+	/* spear300 specific devices */
+};
+
+static void __init spear300_evb_init(void)
+{
+	unsigned int i;
+
+	/* call spear300 machine init function */
+	spear300_init();
+
+	/* Add Platform Devices */
+	platform_add_devices(plat_devs, ARRAY_SIZE(plat_devs));
+
+	/* Add Amba Devices */
+	for (i = 0; i < ARRAY_SIZE(amba_devs); i++)
+		amba_device_register(amba_devs[i], &iomem_resource);
+}
+
+MACHINE_START(SPEAR300, "ST-SPEAR300-EVB")
+	.boot_params	=	0x00000100,
+	.map_io		=	spear3xx_map_io,
+	.init_irq	=	spear3xx_init_irq,
+	.timer		=	&spear_sys_timer,
+	.init_machine	=	spear300_evb_init,
+MACHINE_END
diff --git a/arch/arm/mach-spear3xx/spear310.c b/arch/arm/mach-spear3xx/spear310.c
new file mode 100644
index 0000000..6eb62f9
--- /dev/null
+++ b/arch/arm/mach-spear3xx/spear310.c
@@ -0,0 +1,25 @@
+/*
+ * arch/arm/mach-spear3xx/spear310.c
+ *
+ * SPEAr310 machine source file
+ *
+ * Copyright (C) 2009 ST Microelectronics
+ * Viresh Kumar<viresh.kumar@st.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/ptrace.h>
+#include <asm/irq.h>
+#include <mach/generic.h>
+#include <mach/spear.h>
+
+/* Add spear310 specific devices here */
+
+void __init spear310_init(void)
+{
+	/* call spear3xx family common init function */
+	spear3xx_init();
+}
diff --git a/arch/arm/mach-spear3xx/spear310_evb.c b/arch/arm/mach-spear3xx/spear310_evb.c
new file mode 100644
index 0000000..e781b2b
--- /dev/null
+++ b/arch/arm/mach-spear3xx/spear310_evb.c
@@ -0,0 +1,54 @@
+/*
+ * arch/arm/mach-spear3xx/spear310_evb.c
+ *
+ * SPEAr310 evaluation board source file
+ *
+ * Copyright (C) 2009 ST Microelectronics
+ * Viresh Kumar<viresh.kumar@st.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <asm/mach/arch.h>
+#include <asm/mach-types.h>
+#include <mach/generic.h>
+#include <mach/spear.h>
+
+static struct amba_device *amba_devs[] __initdata = {
+	/* spear3xx specific devices */
+	&gpio_device,
+	&uart_device,
+
+	/* spear310 specific devices */
+};
+
+static struct platform_device *plat_devs[] __initdata = {
+	/* spear3xx specific devices */
+
+	/* spear310 specific devices */
+};
+
+static void __init spear310_evb_init(void)
+{
+	unsigned int i;
+
+	/* call spear310 machine init function */
+	spear310_init();
+
+	/* Add Platform Devices */
+	platform_add_devices(plat_devs, ARRAY_SIZE(plat_devs));
+
+	/* Add Amba Devices */
+	for (i = 0; i < ARRAY_SIZE(amba_devs); i++)
+		amba_device_register(amba_devs[i], &iomem_resource);
+}
+
+MACHINE_START(SPEAR310, "ST-SPEAR310-EVB")
+	.boot_params	=	0x00000100,
+	.map_io		=	spear3xx_map_io,
+	.init_irq	=	spear3xx_init_irq,
+	.timer		=	&spear_sys_timer,
+	.init_machine	=	spear310_evb_init,
+MACHINE_END
diff --git a/arch/arm/mach-spear3xx/spear320.c b/arch/arm/mach-spear3xx/spear320.c
new file mode 100644
index 0000000..72d4548
--- /dev/null
+++ b/arch/arm/mach-spear3xx/spear320.c
@@ -0,0 +1,25 @@
+/*
+ * arch/arm/mach-spear3xx/spear320.c
+ *
+ * SPEAr320 machine source file
+ *
+ * Copyright (C) 2009 ST Microelectronics
+ * Viresh Kumar<viresh.kumar@st.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/ptrace.h>
+#include <asm/irq.h>
+#include <mach/generic.h>
+#include <mach/spear.h>
+
+/* Add spear320 specific devices here */
+
+void __init spear320_init(void)
+{
+	/* call spear3xx family common init function */
+	spear3xx_init();
+}
diff --git a/arch/arm/mach-spear3xx/spear320_evb.c b/arch/arm/mach-spear3xx/spear320_evb.c
new file mode 100644
index 0000000..85bc4d2
--- /dev/null
+++ b/arch/arm/mach-spear3xx/spear320_evb.c
@@ -0,0 +1,54 @@
+/*
+ * arch/arm/mach-spear3xx/spear320_evb.c
+ *
+ * SPEAr320 evaluation board source file
+ *
+ * Copyright (C) 2009 ST Microelectronics
+ * Viresh Kumar<viresh.kumar@st.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <asm/mach/arch.h>
+#include <asm/mach-types.h>
+#include <mach/generic.h>
+#include <mach/spear.h>
+
+static struct amba_device *amba_devs[] __initdata = {
+	/* spear3xx specific devices */
+	&gpio_device,
+	&uart_device,
+
+	/* spear320 specific devices */
+};
+
+static struct platform_device *plat_devs[] __initdata = {
+	/* spear3xx specific devices */
+
+	/* spear320 specific devices */
+};
+
+static void __init spear320_evb_init(void)
+{
+	unsigned int i;
+
+	/* call spear320 machine init function */
+	spear320_init();
+
+	/* Add Platform Devices */
+	platform_add_devices(plat_devs, ARRAY_SIZE(plat_devs));
+
+	/* Add Amba Devices */
+	for (i = 0; i < ARRAY_SIZE(amba_devs); i++)
+		amba_device_register(amba_devs[i], &iomem_resource);
+}
+
+MACHINE_START(SPEAR320, "ST-SPEAR320-EVB")
+	.boot_params	=	0x00000100,
+	.map_io		=	spear3xx_map_io,
+	.init_irq	=	spear3xx_init_irq,
+	.timer		=	&spear_sys_timer,
+	.init_machine	=	spear320_evb_init,
+MACHINE_END
diff --git a/arch/arm/mach-spear3xx/spear3xx.c b/arch/arm/mach-spear3xx/spear3xx.c
new file mode 100644
index 0000000..82ebcd3
--- /dev/null
+++ b/arch/arm/mach-spear3xx/spear3xx.c
@@ -0,0 +1,101 @@
+/*
+ * arch/arm/mach-spear3xx/spear3xx.c
+ *
+ * SPEAr3XX machines common source file
+ *
+ * Copyright (C) 2009 ST Microelectronics
+ * Viresh Kumar<viresh.kumar@st.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/types.h>
+#include <linux/amba/pl061.h>
+#include <linux/ptrace.h>
+#include <linux/io.h>
+#include <asm/hardware/vic.h>
+#include <asm/irq.h>
+#include <asm/mach/arch.h>
+#include <mach/generic.h>
+#include <mach/spear.h>
+
+/* Add spear3xx machines common devices here */
+/* gpio device registeration */
+static struct pl061_platform_data gpio_plat_data = {
+	.gpio_base	= 0,
+	.irq_base	= SPEAR_GPIO_INT_BASE,
+};
+
+struct amba_device gpio_device = {
+	.dev = {
+		.init_name = "gpio",
+		.platform_data = &gpio_plat_data,
+	},
+	.res = {
+		.start = SPEAR3XX_ICM3_GPIO_BASE,
+		.end = SPEAR3XX_ICM3_GPIO_BASE + SPEAR3XX_ICM3_GPIO_SIZE - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	.irq = {IRQ_BASIC_GPIO, NO_IRQ},
+};
+
+/* uart device registeration */
+struct amba_device uart_device = {
+	.dev = {
+		.init_name = "uart",
+	},
+	.res = {
+		.start = SPEAR3XX_ICM1_UART_BASE,
+		.end = SPEAR3XX_ICM1_UART_BASE + SPEAR3XX_ICM1_UART_SIZE - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	.irq = {IRQ_UART, NO_IRQ},
+};
+
+/* Do spear3xx familiy common initialization part here */
+void __init spear3xx_init(void)
+{
+	/* nothing to do for now */
+}
+
+/* This will initialize vic */
+void __init spear3xx_init_irq(void)
+{
+	vic_init((void __iomem *)VA_SPEAR3XX_ML1_VIC_BASE, 0, ~0, 0);
+}
+
+/* Following will create static virtual/physical mappings */
+struct map_desc spear3xx_io_desc[] __initdata = {
+	{
+		.virtual	= VA_SPEAR3XX_ICM1_UART_BASE,
+		.pfn		= __phys_to_pfn(SPEAR3XX_ICM1_UART_BASE),
+		.length		= SPEAR3XX_ICM1_UART_SIZE,
+		.type		= MT_DEVICE
+	}, {
+		.virtual	= VA_SPEAR3XX_ML1_VIC_BASE,
+		.pfn		= __phys_to_pfn(SPEAR3XX_ML1_VIC_BASE),
+		.length		= SPEAR3XX_ML1_VIC_SIZE,
+		.type		= MT_DEVICE
+	}, {
+		.virtual	= VA_SPEAR3XX_ICM3_SYS_CTRL_BASE,
+		.pfn		= __phys_to_pfn(SPEAR3XX_ICM3_SYS_CTRL_BASE),
+		.length		= SPEAR3XX_ICM3_SYS_CTRL_SIZE,
+		.type		= MT_DEVICE
+	}, {
+		.virtual	= VA_SPEAR3XX_ICM3_MISC_REG_BASE,
+		.pfn		= __phys_to_pfn(SPEAR3XX_ICM3_MISC_REG_BASE),
+		.length		= SPEAR3XX_ICM3_MISC_REG_SIZE,
+		.type		= MT_DEVICE
+	},
+};
+
+/* This will create static memory mapping for selected devices */
+void __init spear3xx_map_io(void)
+{
+	iotable_init(spear3xx_io_desc, ARRAY_SIZE(spear3xx_io_desc));
+
+	/* This will initialize clock framework */
+	clk_init();
+}
-- 
1.6.0.2
