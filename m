From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Wed, 14 Jul 2010 15:29:46 +0800
Subject: [PATCH 4/6] arm/plat-spear: fix debug macro compilation failure
In-Reply-To: <1279092586.619523.10182482328.0.gpush@pororo>
Message-ID: <1279092586.620769.218300709098.4.gpush@pororo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mov rx, =<immediate> isn't valid, use #<immediate> instead.

Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>

---
 arch/arm/plat-spear/include/plat/debug-macro.S |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-spear/include/plat/debug-macro.S b/arch/arm/plat-spear/include/plat/debug-macro.S
index 1670734..37fa593 100644
--- a/arch/arm/plat-spear/include/plat/debug-macro.S
+++ b/arch/arm/plat-spear/include/plat/debug-macro.S
@@ -17,8 +17,8 @@
 		.macro	addruart, rx
 		mrc	p15, 0, \rx, c1, c0
 		tst	\rx, #1					@ MMU enabled?
-		moveq	\rx, =SPEAR_DBG_UART_BASE		@ Physical base
-		movne	\rx, =VA_SPEAR_DBG_UART_BASE		@ Virtual base
+		moveq	\rx, #SPEAR_DBG_UART_BASE		@ Physical base
+		movne	\rx, #VA_SPEAR_DBG_UART_BASE		@ Virtual base
 		.endm
 
 		.macro	senduart, rd, rx
