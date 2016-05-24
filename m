From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 24 May 2016 18:55:40 +0100
Subject: [PATCH 1/3] arm64: Remove orphaned __addr_ok() definition
Message-ID: <4656e09e40e832b2690fb0280975c70a541fb7ef.1464111462.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since commit 12a0ef7b0ac3 ("arm64: use generic strnlen_user and
strncpy_from_user functions"), the definition of __addr_ok() has been
languishing unused; eradicate the sucker.

CC: Will Deacon <will.deacon@arm.com>
CC: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 arch/arm64/include/asm/uaccess.h | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index 0685d74572af..9e397a542756 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -81,19 +81,6 @@ static inline void set_fs(mm_segment_t fs)
 #define segment_eq(a, b)	((a) == (b))
 
 /*
- * Return 1 if addr < current->addr_limit, 0 otherwise.
- */
-#define __addr_ok(addr)							\
-({									\
-	unsigned long flag;						\
-	asm("cmp %1, %0; cset %0, lo"					\
-		: "=&r" (flag)						\
-		: "r" (addr), "0" (current_thread_info()->addr_limit)	\
-		: "cc");						\
-	flag;								\
-})
-
-/*
  * Test whether a block of memory is a valid user space address.
  * Returns 1 if the range is valid, 0 otherwise.
  *
-- 
2.8.1.dirty
