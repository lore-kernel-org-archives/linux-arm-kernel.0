From: chanho0207@gmail.com (Chanho Min)
Date: Mon, 10 Sep 2012 12:25:15 +0900
Subject: [PATCH] ARM: Fix build warning in do_alignment.
Message-ID: <CAOAMb1CTk1_dQAUiHy5ch=UxN7vSe0of81KcKbjPjCFqR9e9tw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the following build warning:

arch/arm/mm/alignment.c: In function 'do_alignment':
arch/arm/mm/alignment.c:327:15: warning: 'offset.un' may be used
uninitialized in this function [-Wuninitialized]
arch/arm/mm/alignment.c:749:21: note: 'offset.un' was declared here

Signed-off-by: Chanho Min <chanho.min@lge.com>
---
 arch/arm/mm/alignment.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/alignment.c b/arch/arm/mm/alignment.c
index 9107231..f83b38c 100644
--- a/arch/arm/mm/alignment.c
+++ b/arch/arm/mm/alignment.c
@@ -746,7 +746,7 @@ do_alignment_t32_to_handler(unsigned long *pinstr,
struct pt_regs *regs,
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
