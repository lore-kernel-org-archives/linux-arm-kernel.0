From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Wed, 14 Jul 2010 10:32:39 +0800
Subject: [PATCH 1/6] arm/clps711x: fix debug macro compilation failure
In-Reply-To: <1279074759.517724.734812272398.0.gpush@pororo>
Message-ID: <1279074759.518291.312592731668.1.gpush@pororo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need mach/hardware.h for CLPS7111_VIRT_BASE.

Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>

---
 arch/arm/mach-clps711x/include/mach/debug-macro.S |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-clps711x/include/mach/debug-macro.S b/arch/arm/mach-clps711x/include/mach/debug-macro.S
index 2d61679..507c687 100644
--- a/arch/arm/mach-clps711x/include/mach/debug-macro.S
+++ b/arch/arm/mach-clps711x/include/mach/debug-macro.S
@@ -11,6 +11,7 @@
  *
 */
 
+#include <mach/hardware.h>
 #include <asm/hardware/clps7111.h>
 
 		.macro	addruart, rp, rv
