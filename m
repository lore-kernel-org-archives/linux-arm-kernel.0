From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 29 Oct 2012 22:13:07 +0530
Subject: [PATCH] ARM: mm: uninitialized warning corrections
Message-ID: <fb4b3c38a09b137f7823168e5f4770464b3c33bd.1351528855.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The variables here are really not used uninitialized.

arch/arm/mm/alignment.c: In function 'do_alignment':
arch/arm/mm/alignment.c:327:15: warning: 'offset.un' may be used uninitialized in this function [-Wmaybe-uninitialized]
arch/arm/mm/alignment.c:748:21: note: 'offset.un' was declared here

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/mm/alignment.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/alignment.c b/arch/arm/mm/alignment.c
index b9f60eb..223b4aa 100644
--- a/arch/arm/mm/alignment.c
+++ b/arch/arm/mm/alignment.c
@@ -745,7 +745,7 @@ do_alignment_t32_to_handler(unsigned long *pinstr, struct pt_regs *regs,
 static int
 do_alignment(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 {
-	union offset_union offset;
+	union offset_union uninitialized_var(offset);
 	unsigned long instr = 0, instrptr;
 	int (*handler)(unsigned long addr, unsigned long instr, struct pt_regs *regs);
 	unsigned int type;
-- 
1.7.12.rc2.18.g61b472e
