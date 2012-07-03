From: changbinx.du@intel.com (Du, ChangbinX)
Date: Tue, 3 Jul 2012 10:23:21 +0000
Subject: [PATCH] ARM: mm: fix unitialized variable warning
Message-ID: <0C18FE92A7765D4EB9EE5D38D86A563A0A18BB@SHSMSX101.ccr.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arch/arm/mm/alignment.c: In function ?do_alignment?:
arch/arm/mm/alignment.c:327:15: warning: ?offset.un? may be used uninitialized in this function [-Wuninitialized]
arch/arm/mm/alignment.c:749:21: note: ?offset.un? was declared here

Signed-off-by: Du, Changbin <changbin.du@gmail.com>
---
 arch/arm/mm/alignment.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/alignment.c b/arch/arm/mm/alignment.c
index 9107231..387a6cd 100644
--- a/arch/arm/mm/alignment.c
+++ b/arch/arm/mm/alignment.c
@@ -746,7 +746,7 @@ do_alignment_t32_to_handler(unsigned long *pinstr, struct pt_regs *regs,
 static int
 do_alignment(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 {
-	union offset_union offset;
+	union offset_union uninitialized_var(offset);
 	unsigned long instr = 0, instrptr;
 	int (*handler)(unsigned long addr, unsigned long instr, struct pt_regs *regs);
 	unsigned int type;
-- 
1.7.9.5
