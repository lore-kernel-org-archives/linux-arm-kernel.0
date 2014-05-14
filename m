From: pebolle@tiscali.nl (Paul Bolle)
Date: Wed, 14 May 2014 10:12:07 +0200
Subject: [PATCH] ARM: remove check for CONFIG_DEBUG_LL_SER3
Message-ID: <1400055127.31197.1.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A check for CONFIG_DEBUG_LL_SER3 was added in v2.5.43. But the related
symbol DEBUG_LL_SER3 was already removed in v2.5.8. This check has
always evaluated to false. Remove it.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Untested.

 arch/arm/boot/compressed/head.S | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index 066b03480b63..c16e8bf31e0b 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -54,11 +54,7 @@
 #if defined(CONFIG_ARCH_SA1100)
 		.macro	loadsp, rb, tmp
 		mov	\rb, #0x80000000	@ physical base address
-#ifdef CONFIG_DEBUG_LL_SER3
-		add	\rb, \rb, #0x00050000	@ Ser3
-#else
 		add	\rb, \rb, #0x00010000	@ Ser1
-#endif
 		.endm
 #elif defined(CONFIG_ARCH_S3C24XX)
 		.macro loadsp, rb, tmp
-- 
1.9.0
