From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Wed, 14 Jul 2010 10:32:39 +0800
Subject: [PATCH 2/6] arm/h720x: fix debug macro compilation failure
In-Reply-To: <1279074759.517724.734812272398.0.gpush@pororo>
Message-ID: <1279074759.518642.528070270675.2.gpush@pororo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

IO_BASE shoule be IO_VIRT, and IO_START should be IO_PHYS. We also need
mach/hardware.h for these definitions.

Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>

---
 arch/arm/mach-h720x/include/mach/debug-macro.S |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-h720x/include/mach/debug-macro.S b/arch/arm/mach-h720x/include/mach/debug-macro.S
index 60c0c43..c2093e8 100644
--- a/arch/arm/mach-h720x/include/mach/debug-macro.S
+++ b/arch/arm/mach-h720x/include/mach/debug-macro.S
@@ -11,8 +11,10 @@
  *
 */
 
-		.equ    io_virt, IO_BASE
-		.equ    io_phys, IO_START
+#include <mach/hardware.h>
+
+		.equ    io_virt, IO_VIRT
+		.equ    io_phys, IO_PHYS
 
 		.macro  addruart, rp, rv
 		mov     \rp, #0x00020000	@ UART1
