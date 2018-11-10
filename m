From: mirq-linux@rere.qmqm.pl (=?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?=)
Date: Sat, 10 Nov 2018 21:37:04 +0100
Subject: [PATCH] ARM: init: update secondary_data register documentation
Message-ID: <ef535e3fe77f209336dbcab060388f74536a79dc.1541882139.git.mirq-linux@rere.qmqm.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix secondary_data pointer register and document other
occurrences in SMP boot code.

Fixes: 34d926266500 ("[ARM] Fix SMP booting")
Signed-off-by: Micha? Miros?aw <mirq-linux@rere.qmqm.pl>
---
 arch/arm/kernel/head.S | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index 6b1148cafffd..43d0ce070d29 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -413,7 +413,7 @@ ENDPROC(secondary_startup)
 ENDPROC(secondary_startup_arm)
 
 	/*
-	 * r6  = &secondary_data
+	 * r7  = &secondary_data
 	 */
 ENTRY(__secondary_switched)
 	ldr	sp, [r7, #12]			@ get secondary_data.stack
@@ -443,6 +443,7 @@ __secondary_data:
  *  r2  = atags or dtb pointer
  *  r4  = TTBR pointer (low word)
  *  r5  = TTBR pointer (high word if LPAE)
+ *  r7  = secondary_data pointer (SMP)
  *  r9  = processor ID
  *  r13 = *virtual* address to jump to upon completion
  */
@@ -480,6 +481,7 @@ ENDPROC(__enable_mmu)
  *  r0  = cp#15 control register
  *  r1  = machine ID
  *  r2  = atags or dtb pointer
+ *  r7  = secondary_data pointer (SMP)
  *  r9  = processor ID
  *  r13 = *virtual* address to jump to upon completion
  *
-- 
2.19.1
