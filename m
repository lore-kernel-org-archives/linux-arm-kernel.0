From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 18 Sep 2010 11:45:14 +0900
Subject: [PATCH 2/4] ARM: S5PV310: Add DMC registers and map_desc
In-Reply-To: <1284777916-23257-1-git-send-email-kgene.kim@samsung.com>
References: <1284777916-23257-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1284777916-23257-3-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sunyoung Kang <sy0816.kang@samsung.com>

This patch adds DMC io mapping for access it and adds registers.
This is used in checking DRAM memory type.

Signed-off-by: Sunyoung Kang <sy0816.kang@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5pv310/cpu.c                   |    5 +++++
 arch/arm/mach-s5pv310/include/mach/map.h      |    2 ++
 arch/arm/mach-s5pv310/include/mach/regs-mem.h |   23 +++++++++++++++++++++++
 3 files changed, 30 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-s5pv310/include/mach/regs-mem.h

diff --git a/arch/arm/mach-s5pv310/cpu.c b/arch/arm/mach-s5pv310/cpu.c
index 4add398..225ca53 100644
--- a/arch/arm/mach-s5pv310/cpu.c
+++ b/arch/arm/mach-s5pv310/cpu.c
@@ -61,6 +61,11 @@ static struct map_desc s5pv310_iodesc[] __initdata = {
 		.length		= SZ_4K,
 		.type		= MT_DEVICE,
 	}, {
+		.virtual	= (unsigned long)S5P_VA_DMC0,
+		.pfn		= __phys_to_pfn(S5PV310_PA_DMC0),
+		.length		= SZ_4K,
+		.type		= MT_DEVICE,
+	}, {
 		.virtual	= (unsigned long)S3C_VA_UART,
 		.pfn		= __phys_to_pfn(S3C_PA_UART),
 		.length		= SZ_512K,
diff --git a/arch/arm/mach-s5pv310/include/mach/map.h b/arch/arm/mach-s5pv310/include/mach/map.h
index aff6d23..2403abf 100644
--- a/arch/arm/mach-s5pv310/include/mach/map.h
+++ b/arch/arm/mach-s5pv310/include/mach/map.h
@@ -41,6 +41,8 @@
 
 #define S5PV310_PA_WATCHDOG		(0x10060000)
 
+#define S5PV310_PA_DMC0			(0x10400000)
+
 #define S5PV310_PA_COMBINER		(0x10448000)
 
 #define S5PV310_PA_COREPERI		(0x10500000)
diff --git a/arch/arm/mach-s5pv310/include/mach/regs-mem.h b/arch/arm/mach-s5pv310/include/mach/regs-mem.h
new file mode 100644
index 0000000..8342271
--- /dev/null
+++ b/arch/arm/mach-s5pv310/include/mach/regs-mem.h
@@ -0,0 +1,23 @@
+/* linux/arch/arm/mach-s5pv310/include/mach/regs-mem.h
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * S5PV310 - SROMC and DMC register definitions
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __ASM_ARCH_REGS_MEM_H
+#define __ASM_ARCH_REGS_MEM_H __FILE__
+
+#include <mach/map.h>
+
+#define S5P_DMC0_MEMCON_OFFSET		0x04
+
+#define S5P_DMC0_MEMTYPE_SHIFT		8
+#define S5P_DMC0_MEMTYPE_MASK		0xF
+
+#endif /* __ASM_ARCH_REGS_MEM_H */
-- 
1.6.2.5
