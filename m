From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Fri, 10 Jul 2015 14:58:00 +0100
Subject: [PATCH] arm64: Remove unused macros from assembler.h
Message-ID: <1436536680-23661-1-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 68234df4ea79 ("arm64: kill flush_cache_all()") removed the
only users of these macros.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/include/asm/assembler.h | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 144b64ad96c3..e10516bbe833 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -50,18 +50,6 @@
 	.endm

 /*
- * Save/disable and restore interrupts.
- */
-	.macro	save_and_disable_irqs, olddaif
-	mrs	\olddaif, daif
-	disable_irq
-	.endm
-
-	.macro	restore_irqs, olddaif
-	msr	daif, \olddaif
-	.endm
-
-/*
  * Enable and disable debug exceptions.
  */
 	.macro	disable_dbg
--
2.4.3
