From: viresh.kumar@st.com (Viresh Kumar)
Date: Fri, 14 Jan 2011 11:55:48 +0530
Subject: [PATCH] mm/alignment.c: fixing compilation warning
Message-ID: <b02c30e00140f027ff1cc3fb87a719b6939dd8eb.1294986242.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes following compilation warning:
warning: ?offset.un? may be used uninitialized in this function

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/mm/alignment.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mm/alignment.c b/arch/arm/mm/alignment.c
index 724ba3b..c5379f6 100644
--- a/arch/arm/mm/alignment.c
+++ b/arch/arm/mm/alignment.c
@@ -717,7 +717,7 @@ do_alignment_t32_to_handler(unsigned long *pinstr, struct pt_regs *regs,
 static int
 do_alignment(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 {
-	union offset_union offset;
+	union offset_union offset = {0};
 	unsigned long instr = 0, instrptr;
 	int (*handler)(unsigned long addr, unsigned long instr, struct pt_regs *regs);
 	unsigned int type;
-- 
1.7.2.2
