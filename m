From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Wed, 14 Jul 2010 15:29:46 +0800
Subject: [PATCH 5/6] arm/ns9xxx: fix debug macro compilation failure
In-Reply-To: <1279092586.619523.10182482328.0.gpush@pororo>
Message-ID: <1279092586.621059.924358974704.5.gpush@pororo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need mach/memory.h for NS9XXX_CSxSTAT_PHYS, and mach/memory.h needs
asm/memory.h for UL().

Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>

---
 arch/arm/mach-ns9xxx/include/mach/debug-macro.S |    1 +
 arch/arm/mach-ns9xxx/include/mach/memory.h      |    2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/arm/mach-ns9xxx/include/mach/debug-macro.S b/arch/arm/mach-ns9xxx/include/mach/debug-macro.S
index 0859336..9966807 100644
--- a/arch/arm/mach-ns9xxx/include/mach/debug-macro.S
+++ b/arch/arm/mach-ns9xxx/include/mach/debug-macro.S
@@ -8,6 +8,7 @@
  * the Free Software Foundation.
  */
 #include <mach/hardware.h>
+#include <mach/memory.h>
 
 #include <mach/regs-board-a9m9750dev.h>
 
diff --git a/arch/arm/mach-ns9xxx/include/mach/memory.h b/arch/arm/mach-ns9xxx/include/mach/memory.h
index 6107193..b5bbda5 100644
--- a/arch/arm/mach-ns9xxx/include/mach/memory.h
+++ b/arch/arm/mach-ns9xxx/include/mach/memory.h
@@ -11,6 +11,8 @@
 #ifndef __ASM_ARCH_MEMORY_H
 #define __ASM_ARCH_MEMORY_H
 
+#include <asm/memory.h>
+
 /* x in [0..3] */
 #define NS9XXX_CSxSTAT_PHYS(x)	UL(((x) + 4) << 28)
 
