From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri, 16 Oct 2009 12:09:31 -0700
Subject: [PATCH 27/46] davinci: DA8xx: CFGCHIP2 register definitions
In-Reply-To: <1255720190-7452-28-git-send-email-khilman@deeprootsystems.com>
References: <1255720190-7452-1-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-2-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-3-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-4-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-5-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-6-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-7-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-8-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-9-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-10-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-11-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-12-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-13-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-14-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-15-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-16-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-17-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-18-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-19-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-20-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-21-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-22-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-23-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-24-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-25-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-26-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-27-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-28-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1255720190-7452-29-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sshtylyov@ru.mvista.com>

These are needed by the MUSB and OHCI glue layers...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/include/mach/da8xx.h |    1 +
 arch/arm/mach-davinci/include/mach/usb.h   |   37 ++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-davinci/include/mach/usb.h

diff --git a/arch/arm/mach-davinci/include/mach/da8xx.h b/arch/arm/mach-davinci/include/mach/da8xx.h
index a152261..abb8a5b 100644
--- a/arch/arm/mach-davinci/include/mach/da8xx.h
+++ b/arch/arm/mach-davinci/include/mach/da8xx.h
@@ -36,6 +36,7 @@ extern void __iomem *da8xx_syscfg_base;
 #define DA8XX_SYSCFG_BASE	(IO_PHYS + 0x14000)
 #define DA8XX_SYSCFG_VIRT(x)	(da8xx_syscfg_base + (x))
 #define DA8XX_JTAG_ID_REG	0x18
+#define DA8XX_CFGCHIP2_REG	0x184
 #define DA8XX_CFGCHIP3_REG	0x188
 
 #define DA8XX_PSC0_BASE		0x01c10000
diff --git a/arch/arm/mach-davinci/include/mach/usb.h b/arch/arm/mach-davinci/include/mach/usb.h
new file mode 100644
index 0000000..d0fb412
--- /dev/null
+++ b/arch/arm/mach-davinci/include/mach/usb.h
@@ -0,0 +1,37 @@
+/*
+ * USB related definitions
+ *
+ * Copyright (C) 2009 MontaVista Software, Inc. <source@mvista.com>
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#ifndef __ASM_ARCH_USB_H
+#define __ASM_ARCH_USB_H
+
+/* DA8xx CFGCHIP2 (USB 2.0 PHY Control) register bits */
+#define CFGCHIP2_PHYCLKGD	(1 << 17)
+#define CFGCHIP2_VBUSSENSE	(1 << 16)
+#define CFGCHIP2_RESET		(1 << 15)
+#define CFGCHIP2_OTGMODE	(3 << 13)
+#define CFGCHIP2_NO_OVERRIDE	(0 << 13)
+#define CFGCHIP2_FORCE_HOST	(1 << 13)
+#define CFGCHIP2_FORCE_DEVICE 	(2 << 13)
+#define CFGCHIP2_FORCE_HOST_VBUS_LOW (3 << 13)
+#define CFGCHIP2_USB1PHYCLKMUX	(1 << 12)
+#define CFGCHIP2_USB2PHYCLKMUX	(1 << 11)
+#define CFGCHIP2_PHYPWRDN	(1 << 10)
+#define CFGCHIP2_OTGPWRDN	(1 << 9)
+#define CFGCHIP2_DATPOL 	(1 << 8)
+#define CFGCHIP2_USB1SUSPENDM	(1 << 7)
+#define CFGCHIP2_PHY_PLLON	(1 << 6)	/* override PLL suspend */
+#define CFGCHIP2_SESENDEN	(1 << 5)	/* Vsess_end comparator */
+#define CFGCHIP2_VBDTCTEN	(1 << 4)	/* Vbus comparator */
+#define CFGCHIP2_REFFREQ	(0xf << 0)
+#define CFGCHIP2_REFFREQ_12MHZ	(1 << 0)
+#define CFGCHIP2_REFFREQ_24MHZ	(2 << 0)
+#define CFGCHIP2_REFFREQ_48MHZ	(3 << 0)
+
+#endif	/* ifndef __ASM_ARCH_USB_H */
-- 
1.6.4.3
