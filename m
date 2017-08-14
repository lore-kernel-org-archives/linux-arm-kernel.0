From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Mon, 14 Aug 2017 09:44:28 +0100
Subject: [PATCH] ARM: entry: Remove dead code in sys_mmap2
In-Reply-To: <1502700269-24384-1-git-send-email-vladimir.murzin@arm.com>
References: <1502700269-24384-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1502700269-24384-2-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We support page size of 4K only, remove dead code.

Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/arm/kernel/entry-common.S | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index eb5cd77..52237ce 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -371,17 +371,8 @@ ENDPROC(sys_fstatfs64_wrapper)
  * offset, we return EINVAL.
  */
 sys_mmap2:
-#if PAGE_SHIFT > 12
-		tst	r5, #PGOFF_MASK
-		moveq	r5, r5, lsr #PAGE_SHIFT - 12
-		streq	r5, [sp, #4]
-		beq	sys_mmap_pgoff
-		mov	r0, #-EINVAL
-		ret	lr
-#else
 		str	r5, [sp, #4]
 		b	sys_mmap_pgoff
-#endif
 ENDPROC(sys_mmap2)
 
 #ifdef CONFIG_OABI_COMPAT
-- 
2.0.0
