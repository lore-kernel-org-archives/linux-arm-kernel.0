From: julien.thierry@arm.com (Julien Thierry)
Date: Wed, 30 Aug 2017 10:01:26 +0100
Subject: [PATCH 1/3] arm64: Use existing defines for mdscr
In-Reply-To: <1504083688-48334-1-git-send-email-julien.thierry@arm.com>
References: <1504083688-48334-1-git-send-email-julien.thierry@arm.com>
Message-ID: <1504083688-48334-2-git-send-email-julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>

---
 arch/arm64/include/asm/assembler.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 1b67c37..5d9e57a 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -30,6 +30,7 @@
 #include <asm/pgtable-hwdef.h>
 #include <asm/ptrace.h>
 #include <asm/thread_info.h>
+#include <asm/debug-monitors.h>

 /*
  * Enable and disable interrupts.
@@ -65,7 +66,7 @@
 	.macro	disable_step_tsk, flgs, tmp
 	tbz	\flgs, #TIF_SINGLESTEP, 9990f
 	mrs	\tmp, mdscr_el1
-	bic	\tmp, \tmp, #1
+	bic	\tmp, \tmp, #DBG_MDSCR_SS
 	msr	mdscr_el1, \tmp
 	isb	// Synchronise with enable_dbg
 9990:
@@ -75,7 +76,7 @@
 	tbz	\flgs, #TIF_SINGLESTEP, 9990f
 	disable_dbg
 	mrs	\tmp, mdscr_el1
-	orr	\tmp, \tmp, #1
+	orr	\tmp, \tmp, #DBG_MDSCR_SS
 	msr	mdscr_el1, \tmp
 9990:
 	.endm
--
1.9.1
