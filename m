From: dave.martin@linaro.org (Dave Martin)
Date: Thu,  7 Jul 2011 15:27:44 +0100
Subject: [PATCH v4 37/40] ARM: mm: tlb-v4wb: Use the new processor struct
	macros
In-Reply-To: <1310048867-14172-1-git-send-email-dave.martin@linaro.org>
References: <1310048867-14172-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1310048867-14172-38-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/mm/tlb-v4wb.S |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mm/tlb-v4wb.S b/arch/arm/mm/tlb-v4wb.S
index cb829ca..c04598f 100644
--- a/arch/arm/mm/tlb-v4wb.S
+++ b/arch/arm/mm/tlb-v4wb.S
@@ -69,9 +69,5 @@ ENTRY(v4wb_flush_kern_tlb_range)
 
 	__INITDATA
 
-	.type	v4wb_tlb_fns, #object
-ENTRY(v4wb_tlb_fns)
-	.long	v4wb_flush_user_tlb_range
-	.long	v4wb_flush_kern_tlb_range
-	.long	v4wb_tlb_flags
-	.size	v4wb_tlb_fns, . - v4wb_tlb_fns
+	/* define struct cpu_tlb_fns (see <asm/tlbflush.h> and proc-macros.S) */
+	define_tlb_functions v4wb, v4wb_tlb_flags
-- 
1.7.4.1
