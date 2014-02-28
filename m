From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 28 Feb 2014 14:42:56 +0100
Subject: [PATCH v6 11/11] powerpc: add support for reserved memory defined by
 device tree
In-Reply-To: <1393594976-16728-1-git-send-email-m.szyprowski@samsung.com>
References: <1393594976-16728-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1393594976-16728-12-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable reserved memory initialization from device tree.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/powerpc/Kconfig       |    1 +
 arch/powerpc/kernel/prom.c |    3 +++
 2 files changed, 4 insertions(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 957bf344c0f5..3b6617fed8fc 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -90,6 +90,7 @@ config PPC
 	select BINFMT_ELF
 	select OF
 	select OF_EARLY_FLATTREE
+	select OF_RESERVED_MEM
 	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_DYNAMIC_FTRACE
 	select HAVE_FUNCTION_TRACER
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index f58c0d3aaeb4..591986215801 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -33,6 +33,7 @@
 #include <linux/irq.h>
 #include <linux/memblock.h>
 #include <linux/of.h>
+#include <linux/of_fdt.h>
 
 #include <asm/prom.h>
 #include <asm/rtas.h>
@@ -588,6 +589,8 @@ static void __init early_reserve_mem_dt(void)
 			memblock_reserve(base, size);
 		}
 	}
+
+	early_init_fdt_scan_reserved_mem();
 }
 
 static void __init early_reserve_mem(void)
-- 
1.7.9.5
