From: mcuelenaere@gmail.com (Maurus Cuelenaere)
Date: Fri, 11 Jun 2010 21:49:05 +0200
Subject: [PATCH 6/9] ARM: S5PC100: Add crypto engine register definitions
In-Reply-To: <cover.1276284559.git.mcuelenaere@gmail.com>
References: <cover.1276284559.git.mcuelenaere@gmail.com>
Message-ID: <4C129331.7000001@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the physical address and size which corresponds to the crypto
engine on the S5PC100. It also adds the offsets for the crypto subsystems.

Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>
---
 arch/arm/mach-s5pc100/include/mach/map.h      |    4 +++
 arch/arm/mach-s5pc100/include/mach/regs-sss.h |   29 +++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-s5pc100/include/mach/regs-sss.h

diff --git a/arch/arm/mach-s5pc100/include/mach/map.h b/arch/arm/mach-s5pc100/include/mach/map.h
index 4681ebe..1d842b5 100644
--- a/arch/arm/mach-s5pc100/include/mach/map.h
+++ b/arch/arm/mach-s5pc100/include/mach/map.h
@@ -116,6 +116,10 @@
 #define S5PC100_PA_SDRAM	(0x20000000)
 #define S5PC1XX_PA_SDRAM	S5PC100_PA_SDRAM
 
+/* Crypto Engine */
+#define SAMSUNG_PA_SSS		(0xF4000000)
+#define SAMSUNG_SZ_SSS		(SZ_1M * 3 + SZ_64K)
+
 /* compatibility defines. */
 #define S3C_PA_RTC		S5PC100_PA_RTC
 #define S3C_PA_UART		S5PC100_PA_UART
diff --git a/arch/arm/mach-s5pc100/include/mach/regs-sss.h b/arch/arm/mach-s5pc100/include/mach/regs-sss.h
new file mode 100644
index 0000000..41b3e6b
--- /dev/null
+++ b/arch/arm/mach-s5pc100/include/mach/regs-sss.h
@@ -0,0 +1,29 @@
+/*
+ * linux/arch/arm/mach-s5pc100/include/mach/regs-sss.h
+ *
+ * Copyright (C) 2010 Maurus Cuelenaere
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#ifndef __MACH_S5PC100_REGS_SSS_H
+#define __MACH_S5PC100_REGS_SSS_H __FILE__
+
+#define SSS_OFF_CFG				(0x000000)
+#define SSS_OFF_FIFO_RX				(0x010000)
+#define SSS_OFF_AES_RX				(0x040000)
+#define SSS_OFF_TDES_RX				(0x050000)
+#define SSS_OFF_HASH_RX				(0x060000)
+
+#define SSS_OFF_FIFO_TX				(0x110000)
+#define SSS_OFF_AES_TX				(0x140000)
+#define SSS_OFF_TDES_TX				(0x150000)
+#define SSS_OFF_HASH_TX				(0x160000)
+
+#define SSS_OFF_SDMA_RX				(0x200000)
+#define SSS_OFF_SDMA_TX				(0x300000)
+
+#endif /* __MACH_S5PC100_REGS_SSS_H */
-- 
1.7.1
