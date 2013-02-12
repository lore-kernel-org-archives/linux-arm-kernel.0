From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Tue, 12 Feb 2013 11:27:56 +0000
Subject: [PATCH] ARM: mm: fix missing use of 'asid' to get asid value from
 mm->context.id
Message-ID: <1360668476-8525-1-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix missing use of the asid macro when getting the ASID from the mm->context.id field.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 arch/arm/mm/proc-v7-3level.S |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/proc-v7-3level.S b/arch/arm/mm/proc-v7-3level.S
index 50bf1da..6ffd78c 100644
--- a/arch/arm/mm/proc-v7-3level.S
+++ b/arch/arm/mm/proc-v7-3level.S
@@ -48,7 +48,7 @@
 ENTRY(cpu_v7_switch_mm)
 #ifdef CONFIG_MMU
 	mmid	r1, r1				@ get mm->context.id
-	and	r3, r1, #0xff
+	asid	r3, r1
 	mov	r3, r3, lsl #(48 - 32)		@ ASID
 	mcrr	p15, 0, r0, r3, c2		@ set TTB 0
 	isb
-- 
1.7.10.4
