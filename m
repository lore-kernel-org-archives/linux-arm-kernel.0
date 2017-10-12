From: julien.thierry@arm.com (Julien Thierry)
Date: Thu, 12 Oct 2017 14:43:02 +0100
Subject: [PATCH v3 1/2] arm64: Use existing defines for mdscr
In-Reply-To: <1507815783-39929-1-git-send-email-julien.thierry@arm.com>
References: <1507815783-39929-1-git-send-email-julien.thierry@arm.com>
Message-ID: <1507815783-39929-2-git-send-email-julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Reviewed-by: Alex Benn?e <alex.bennee@linaro.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/assembler.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index d58a625..3128a9c 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -25,6 +25,7 @@

 #include <asm/asm-offsets.h>
 #include <asm/cpufeature.h>
+#include <asm/debug-monitors.h>
 #include <asm/mmu_context.h>
 #include <asm/page.h>
 #include <asm/pgtable-hwdef.h>
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
