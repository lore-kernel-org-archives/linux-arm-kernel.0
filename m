From: chanho.min@lge.com (Chanho Min)
Date: Tue, 4 Sep 2012 17:01:43 +0900
Subject: [PATCH] ARM: Fix build warning in do_alignment.
Message-ID: <011401cd8a73$85edd1c0$91c97540$@min@lge.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the following build warning:

arch/arm/mm/alignment.c: In function 'do_alignment':
arch/arm/mm/alignment.c:327:15: warning: 'offset.un' may be used uninitialized in this function [-Wuninitialized]
arch/arm/mm/alignment.c:749:21: note: 'offset.un' was declared here

Signed-off-by: Chanho Min <chanho.min@lge.com>
---
 arch/arm/mm/alignment.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/alignment.c b/arch/arm/mm/alignment.c
index 9107231..f83b38c 100644
--- a/arch/arm/mm/alignment.c
+++ b/arch/arm/mm/alignment.c
@@ -746,7 +746,7 @@ do_alignment_t32_to_handler(unsigned long *pinstr, struct pt_regs *regs,
 static int
 do_alignment(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 {
-	union offset_union offset;
+	union offset_union offset = {0};
 	unsigned long instr = 0, instrptr;
 	int (*handler)(unsigned long addr, unsigned long instr, struct pt_regs *regs);
 	unsigned int type;
-- 
1.7.9.5
