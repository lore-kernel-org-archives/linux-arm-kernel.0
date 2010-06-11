From: mcuelenaere@gmail.com (Maurus Cuelenaere)
Date: Fri, 11 Jun 2010 21:49:00 +0200
Subject: [PATCH 5/9] ARM: S3C64XX: Add crypto engine register definitions
In-Reply-To: <cover.1276284559.git.mcuelenaere@gmail.com>
References: <cover.1276284559.git.mcuelenaere@gmail.com>
Message-ID: <4C12932C.8060803@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the physical address and size which corresponds to the crypto
engine on the S3C64XX. It also adds the offsets for the crypto subsystems.

Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>
---
 arch/arm/mach-s3c64xx/include/mach/map.h      |    3 ++
 arch/arm/mach-s3c64xx/include/mach/regs-sss.h |   27 +++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-s3c64xx/include/mach/regs-sss.h

diff --git a/arch/arm/mach-s3c64xx/include/mach/map.h b/arch/arm/mach-s3c64xx/include/mach/map.h
index 9fdd50c..fa80afc 100644
--- a/arch/arm/mach-s3c64xx/include/mach/map.h
+++ b/arch/arm/mach-s3c64xx/include/mach/map.h
@@ -87,6 +87,9 @@
 #define S3C64XX_PA_USB_HSPHY	(0x7C100000)
 #define S3C64XX_VA_USB_HSPHY	S3C_ADDR_CPU(0x00200000)
 
+#define SAMSUNG_PA_SSS		(0x7D000000)
+#define SAMSUNG_SZ_SSS		(SZ_1M * 10 + SZ_256)
+
 /* place VICs close together */
 #define VA_VIC0			(S3C_VA_IRQ + 0x00)
 #define VA_VIC1			(S3C_VA_IRQ + 0x10000)
diff --git a/arch/arm/mach-s3c64xx/include/mach/regs-sss.h b/arch/arm/mach-s3c64xx/include/mach/regs-sss.h
new file mode 100644
index 0000000..3a0769f
--- /dev/null
+++ b/arch/arm/mach-s3c64xx/include/mach/regs-sss.h
@@ -0,0 +1,27 @@
+/*
+ * linux/arch/arm/mach-s3c64xx/include/mach/regs-sss.h
+ *
+ * Copyright (C) 2010 Maurus Cuelenaere
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#ifndef __MACH_S3C64XX_REGS_SSS_H
+#define __MACH_S3C64XX_REGS_SSS_H __FILE__
+
+#define SSS_OFF_CFG				(0x000000)
+#define SSS_OFF_AES_RX				(0x100000)
+#define SSS_OFF_TDES_RX				(0x200000)
+#define SSS_OFF_HASH_RX				(0x300000)
+#define SSS_OFF_FIFO_RX				(0x400000)
+#define SSS_OFF_AES_TX				(0x500000)
+#define SSS_OFF_TDES_TX				(0x600000)
+#define SSS_OFF_HASH_TX				(0x700000)
+#define SSS_OFF_FIFO_TX				(0x800000)
+#define SSS_OFF_SDMA_RX				(0x900000)
+#define SSS_OFF_SDMA_TX				(0xA00000)
+
+#endif /* __MACH_S3C64XX_REGS_SSS_H */
-- 
1.7.1
