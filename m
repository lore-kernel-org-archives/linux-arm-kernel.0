From: zealcook@gmail.com (zealcook at gmail.com)
Date: Mon,  2 Nov 2009 11:53:48 +0800
Subject: [PATCH] KS8695: Fix macro definition bug in regs-switch.c
Message-ID: <4aee57dd.161bf30a.29cd.ffffd72f@mx.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: zeal <zealcook@gmail.com>

NOTE:
1. Macro style is so strange.
2. The value 0xc0 is not match with KS8695 manual. It should be 0x0c.

Signed-off-by: zeal <zealcook@gmail.com>
---
 arch/arm/mach-ks8695/include/mach/regs-switch.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-ks8695/include/mach/regs-switch.h b/arch/arm/mach-ks8695/include/mach/regs-switch.h
index 56d12e8..97e8acb 100644
--- a/arch/arm/mach-ks8695/include/mach/regs-switch.h
+++ b/arch/arm/mach-ks8695/include/mach/regs-switch.h
@@ -25,7 +25,7 @@
 #define KS8695_SEC1		(0x04)		/* Switch Engine Control 1 */
 #define KS8695_SEC2		(0x08)		/* Switch Engine Control 2 */
 
-#define KS8695_P(x)_C(z)	(0xc0 + (((x)-1)*3 + ((z)-1))*4)	/* Port Configuration Registers */
+#define KS8695_SEPXCZ(x,z)	(0x0c + (((x)-1)*3 + ((z)-1))*4)	/* Port Configuration Registers */
 
 #define KS8695_SEP12AN		(0x48)		/* Port 1 & 2 Auto-Negotiation */
 #define KS8695_SEP34AN		(0x4c)		/* Port 3 & 4 Auto-Negotiation */
-- 
1.4.4.4
