From: behanw@converseincode.com (behanw at converseincode.com)
Date: Sun, 14 Sep 2014 22:30:15 -0700
Subject: [PATCH] arm64: LLVMLinux: Fix inline arm64 assembly for use with clang
In-Reply-To: <20140909101515.GB1754@arm.com>
References: <20140909101515.GB1754@arm.com>
Message-ID: <1410759015-15642-1-git-send-email-behanw@converseincode.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Charlebois <charlebm@gmail.com>

Remove '#' from immediate parameter in AARCH64 inline assembly in mmu.

This code now works with both gcc and clang.

Signed-off-by: Mark Charlebois <charlebm@gmail.com>
Signed-off-by: Behan Webster <behanw@converseincode.com>
---
 arch/arm64/mm/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index c555672..6894ef3 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -94,7 +94,7 @@ static int __init early_cachepolicy(char *p)
 	 */
 	asm volatile(
 	"	mrs	%0, mair_el1\n"
-	"	bfi	%0, %1, #%2, #8\n"
+	"	bfi	%0, %1, %2, #8\n"
 	"	msr	mair_el1, %0\n"
 	"	isb\n"
 	: "=&r" (tmp)
-- 
1.9.1
