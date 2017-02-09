From: miles.chen@mediatek.com (Miles Chen)
Date: Thu, 9 Feb 2017 09:52:03 +0800
Subject: [PATCH] arm64: use linux/sizes.h for constants
Message-ID: <1486605123-30819-1-git-send-email-miles.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use linux/size.h to improve code readability.

Signed-off-by: Miles Chen <miles.chen@mediatek.com>
---
 arch/arm64/kernel/process.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index a3a2816..aaac783 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -407,7 +407,7 @@ unsigned long arch_align_stack(unsigned long sp)
 unsigned long arch_randomize_brk(struct mm_struct *mm)
 {
 	if (is_compat_task())
-		return randomize_page(mm->brk, 0x02000000);
+		return randomize_page(mm->brk, SZ_32M);
 	else
-		return randomize_page(mm->brk, 0x40000000);
+		return randomize_page(mm->brk, SZ_1G);
 }
-- 
1.9.1
