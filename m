From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed,  5 Nov 2014 17:01:19 +0100
Subject: [PATCH v2 03/11] mfd: syscon: Add atmel-smc registers definition
In-Reply-To: <1415203287-21517-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1415203287-21517-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1415203287-21517-4-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Atmel AT91 SoCs have a memory range reserved for SMC (Static Memory
Controller) configuration.
Expose those registers so that drivers can make use of the smc syscon
declared in at91 DTs.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 include/linux/mfd/syscon/atmel-smc.h | 60 ++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 include/linux/mfd/syscon/atmel-smc.h

diff --git a/include/linux/mfd/syscon/atmel-smc.h b/include/linux/mfd/syscon/atmel-smc.h
new file mode 100644
index 0000000..430f486
--- /dev/null
+++ b/include/linux/mfd/syscon/atmel-smc.h
@@ -0,0 +1,60 @@
+/*
+ * Atmel SMC (Static Memory Controller) register offsets and bit definitions.
+ *
+ * Copyright (C) 2014 Atmel
+ * Copyright (C) 2014 Free Electrons
+ *
+ * Author: Boris Brezillon <boris.brezillon@free-electrons.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef _LINUX_MFD_SYSCON_ATMEL_SMC_H_
+#define _LINUX_MFD_SYSCON_ATMEL_SMC_H_
+
+#include <linux/regmap.h>
+
+#define AT91SAM9_SMC_GENERIC_OFFSET	0x00
+#define AT91SAM9_SMC_GENERIC_BLK_SZ	0x10
+
+#define SAMA5_SMC_GENERIC_OFFSET	0x600
+#define SAMA5_SMC_GENERIC_BLK_SZ	0x14
+
+#define AT91SAM9_SMC_SETUP(o)		((o) + 0x00)
+#define AT91SAM9_SMC_NWESETUP_SHFT	0
+#define AT91SAM9_SMC_NCS_WRSETUP_SHFT	8
+#define AT91SAM9_SMC_NRDSETUP_SHFT	16
+#define AT91SAM9_SMC_NCS_NRDSETUP_SHFT	24
+
+#define AT91SAM9_SMC_PULSE(o)		((o) + 0x04)
+
+#define AT91SAM9_SMC_CYCLE(o)		((o) + 0x08)
+
+#define AT91SAM9_SMC_MODE(o)		((o) + 0x0c)
+#define SAMA5_SMC_MODE(o)		((o) + 0x10)
+#define AT91_SMC_READMODE		BIT(0)
+#define AT91_SMC_WRITEMODE		BIT(1)
+#define AT91_SMC_EXNWMODE		GENMASK(5, 4)
+#define AT91_SMC_EXNWMODE_DISABLE	(0 << 4)
+#define AT91_SMC_EXNWMODE_FROZEN	(2 << 4)
+#define AT91_SMC_EXNWMODE_READY		(3 << 4)
+#define AT91_SMC_BAT			BIT(8)
+#define AT91_SMC_BAT_SELECT		(0 << 8)
+#define AT91_SMC_BAT_WRITE		(1 << 8)
+#define AT91_SMC_DBW			GENMASK(13, 12)
+#define AT91_SMC_DBW_8			(0 << 12)
+#define AT91_SMC_DBW_16			(1 << 12)
+#define AT91_SMC_DBW_32			(2 << 12)
+#define AT91_SMC_TDF			GENMASK(19, 16)
+#define AT91_SMC_TDF_(x)		(((x) & 0xf) << 16)
+#define AT91_SMC_TDFMODE		BIT(20)
+#define AT91_SMC_PMEN			BIT(24)
+#define AT91_SMC_PS			GENMASK(29, 28)
+#define AT91_SMC_PS_4			(0 << 28)
+#define AT91_SMC_PS_8			(1 << 28)
+#define AT91_SMC_PS_16			(2 << 28)
+#define AT91_SMC_PS_32			(3 << 28)
+
+#endif /* _LINUX_MFD_SYSCON_ATMEL_SMC_H_ */
-- 
1.9.1
