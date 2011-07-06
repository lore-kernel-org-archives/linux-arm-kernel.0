From: bs14@csr.com (Barry Song)
Date: Wed, 6 Jul 2011 02:47:57 -0700
Subject: [PATCH 2/3] ARM: CSR: mapping early DEBUG_LL uart
In-Reply-To: <1309945678-18813-1-git-send-email-bs14@csr.com>
References: <1309945678-18813-1-git-send-email-bs14@csr.com>
Message-ID: <1309945678-18813-3-git-send-email-bs14@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Barry Song <bs14@csr.com>
---
 arch/arm/mach-prima2/Makefile |    1 +
 arch/arm/mach-prima2/lluart.c |   25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-prima2/lluart.c

diff --git a/arch/arm/mach-prima2/Makefile b/arch/arm/mach-prima2/Makefile
index d44f7ae..f2fba66 100644
--- a/arch/arm/mach-prima2/Makefile
+++ b/arch/arm/mach-prima2/Makefile
@@ -3,3 +3,4 @@ obj-y += irq.o
 obj-y += clock.o
 obj-y += rstc.o
 obj-y += prima2.o
+obj-$(CONFIG_DEBUG_LL) += lluart.o
diff --git a/arch/arm/mach-prima2/lluart.c b/arch/arm/mach-prima2/lluart.c
new file mode 100644
index 0000000..a89f9b3
--- /dev/null
+++ b/arch/arm/mach-prima2/lluart.c
@@ -0,0 +1,25 @@
+/*
+ * Static memory mapping for DEBUG_LL
+ *
+ * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+#include <linux/kernel.h>
+#include <asm/page.h>
+#include <asm/mach/map.h>
+#include <mach/map.h>
+#include <mach/uart.h>
+
+void __init sirfsoc_map_lluart(void)
+{
+	struct map_desc sirfsoc_lluart_map = {
+		.virtual        = SIRFSOC_UART1_VA_BASE,
+		.pfn            = __phys_to_pfn(SIRFSOC_UART1_PA_BASE),
+		.length         = SIRFSOC_UART1_SIZE,
+		.type           = MT_DEVICE,
+	};
+
+	iotable_init(&sirfsoc_lluart_map, 1);
+}
-- 
1.7.1



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
