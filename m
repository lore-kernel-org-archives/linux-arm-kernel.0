From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Wed, 14 Jul 2010 10:32:39 +0800
Subject: [PATCH 4/6] arm/plat-spear: fix debug macro compilation failure
In-Reply-To: <1279074759.517724.734812272398.0.gpush@pororo>
Message-ID: <1279074759.519307.502743529753.4.gpush@pororo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mov rx, =<immediate> isn't valid, use #<immediate> instead.

Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>

---
 arch/arm/plat-spear/include/plat/debug-macro.S |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-spear/include/plat/debug-macro.S b/arch/arm/plat-spear/include/plat/debug-macro.S
index d922310..e91270e 100644
--- a/arch/arm/plat-spear/include/plat/debug-macro.S
+++ b/arch/arm/plat-spear/include/plat/debug-macro.S
@@ -15,8 +15,8 @@
 #include <mach/spear.h>
 
 		.macro	addruart, rp, rv
-		mov	\rp, =SPEAR_DBG_UART_BASE		@ Physical base
-		mov	\rv, =VA_SPEAR_DBG_UART_BASE		@ Virtual base
+		mov	\rp, #SPEAR_DBG_UART_BASE		@ Physical base
+		mov	\rv, #VA_SPEAR_DBG_UART_BASE		@ Virtual base
 		.endm
 
 		.macro	senduart, rd, rx
