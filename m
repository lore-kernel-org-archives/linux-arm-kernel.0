From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Wed, 14 Jul 2010 15:29:46 +0800
Subject: [PATCH 3/6] arm/l7200: fix debug macro compilation failure
In-Reply-To: <1279092586.619523.10182482328.0.gpush@pororo>
Message-ID: <1279092586.620474.573992787731.3.gpush@pororo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need mach/hardware.h for IO_BASE and IO_START.

Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>

---
 arch/arm/mach-l7200/include/mach/debug-macro.S |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-l7200/include/mach/debug-macro.S b/arch/arm/mach-l7200/include/mach/debug-macro.S
index b69ed34..872ca72 100644
--- a/arch/arm/mach-l7200/include/mach/debug-macro.S
+++ b/arch/arm/mach-l7200/include/mach/debug-macro.S
@@ -11,6 +11,8 @@
  *
 */
 
+#include <mach/hardware.h>
+
 		.equ	io_virt, IO_BASE
 		.equ	io_phys, IO_START
 
