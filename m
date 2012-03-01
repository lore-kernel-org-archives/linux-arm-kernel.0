From: jg1.han@samsung.com (Jingoo Han)
Date: Thu, 01 Mar 2012 14:38:20 +0900
Subject: [PATCH v2 1/2] ARM: EXYNOS: Add USB HOST register definitions
Message-ID: <000701ccf76d$8316b0a0$894411e0$%han@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds USB HOST register definitions. The definition for
EHCI INSNREG00 regiser and corresponding bit field definitions are
added.

Signed-off-by: Sangwook Lee <sangwook.lee@linaro.org>
Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
v2: change the definition name from EHCI_ENA_xxx to EHCI_INSNREG00_ENA_xxx.

arch/arm/mach-exynos/include/mach/regs-usb-host.h |   24 +++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-exynos/include/mach/regs-usb-host.h

diff --git a/arch/arm/mach-exynos/include/mach/regs-usb-host.h b/arch/arm/mach-exynos/include/mach/regs-usb-host.h
new file mode 100644
index 0000000..572b7d4
--- /dev/null
+++ b/arch/arm/mach-exynos/include/mach/regs-usb-host.h
@@ -0,0 +1,24 @@
+/*
+ * Copyright (C) 2012 Samsung Electronics Co.Ltd
+ *		http://www.samsung.com
+ *
+ * EXYNOS - USB HOST register definitions
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __REGS_USB_HOST_H
+#define __REGS_USB_HOST_H __FILE__
+
+#define EHCI_INSNREG00(base)			(base + 0x90)
+#define EHCI_INSNREG00_ENA_INCR16		(0x1 << 25)
+#define EHCI_INSNREG00_ENA_INCR8		(0x1 << 24)
+#define EHCI_INSNREG00_ENA_INCR4		(0x1 << 23)
+#define EHCI_INSNREG00_ENA_INCRX_ALIGN		(0x1 << 22)
+#define EHCI_INSNREG00_ENABLE_DMA_BURST	\
+	(EHCI_INSNREG00_ENA_INCR16 | EHCI_INSNREG00_ENA_INCR8 |	\
+	 EHCI_INSNREG00_ENA_INCR4 | EHCI_INSNREG00_ENA_INCRX_ALIGN)
+
+#endif /* __REGS_USB_HOST_H */
-- 
1.7.1
