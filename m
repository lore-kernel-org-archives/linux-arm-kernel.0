From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Thu, 22 Jul 2010 16:05:50 +0200
Subject: [PATCH v2] arm/ns9xxx: fix debug macro compilation failure
In-Reply-To: <20100722103834.GH31293@n2100.arm.linux.org.uk>
Message-ID: <1279807550.175247.143452709174.1.gpush@pororo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need asm/memory.h for NS9XXX_CSxSTAT_PHYS (via mach/memory.h).

Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>

---
v2: use asm/memory.h directly

---
 arch/arm/mach-ns9xxx/include/mach/debug-macro.S |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-ns9xxx/include/mach/debug-macro.S b/arch/arm/mach-ns9xxx/include/mach/debug-macro.S
index 0859336..5c934bd 100644
--- a/arch/arm/mach-ns9xxx/include/mach/debug-macro.S
+++ b/arch/arm/mach-ns9xxx/include/mach/debug-macro.S
@@ -8,6 +8,7 @@
  * the Free Software Foundation.
  */
 #include <mach/hardware.h>
+#include <asm/memory.h>
 
 #include <mach/regs-board-a9m9750dev.h>
 
