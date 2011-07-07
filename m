From: dave.martin@linaro.org (Dave Martin)
Date: Thu,  7 Jul 2011 15:27:41 +0100
Subject: [PATCH v4 34/40] ARM: mm: tlb-fa: Use the new processor struct macros
In-Reply-To: <1310048867-14172-1-git-send-email-dave.martin@linaro.org>
References: <1310048867-14172-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1310048867-14172-35-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/mm/tlb-fa.S |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mm/tlb-fa.S b/arch/arm/mm/tlb-fa.S
index 9694f1f..7a2e56c 100644
--- a/arch/arm/mm/tlb-fa.S
+++ b/arch/arm/mm/tlb-fa.S
@@ -67,9 +67,5 @@ ENTRY(fa_flush_kern_tlb_range)
 
 	__INITDATA
 
-	.type	fa_tlb_fns, #object
-ENTRY(fa_tlb_fns)
-	.long	fa_flush_user_tlb_range
-	.long	fa_flush_kern_tlb_range
-	.long	fa_tlb_flags
-	.size	fa_tlb_fns, . - fa_tlb_fns
+	/* define struct cpu_tlb_fns (see <asm/tlbflush.h> and proc-macros.S) */
+	define_tlb_functions fa, fa_tlb_flags
-- 
1.7.4.1
