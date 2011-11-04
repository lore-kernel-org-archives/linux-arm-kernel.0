From: jamie@jamieiles.com (Jamie Iles)
Date: Fri,  4 Nov 2011 01:13:20 +0000
Subject: [PATCH] picoxcell: add extra temp register to addruart
Message-ID: <1320369200-23868-1-git-send-email-jamie@jamieiles.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

639da5ee3 (ARM: add an extra temp register to the low level debugging
addruart macro) didn't include picoxcell as it hadn't been merged at the
time.  Fix up the compile breakage by adding the extra temp parameter.

Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---
 arch/arm/mach-picoxcell/include/mach/debug-macro.S |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-picoxcell/include/mach/debug-macro.S b/arch/arm/mach-picoxcell/include/mach/debug-macro.S
index 8f2c234..58d4ee3 100644
--- a/arch/arm/mach-picoxcell/include/mach/debug-macro.S
+++ b/arch/arm/mach-picoxcell/include/mach/debug-macro.S
@@ -14,7 +14,7 @@
 
 #define UART_SHIFT 2
 
-		.macro	addruart, rp, rv
+		.macro	addruart, rp, rv, tmp
 		ldr	\rv, =PHYS_TO_IO(PICOXCELL_UART1_BASE)
 		ldr	\rp, =PICOXCELL_UART1_BASE
 		.endm
-- 
1.7.5.4
