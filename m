From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 24 May 2016 18:55:41 +0100
Subject: [PATCH 2/3] ARM: Remove orphaned __addr_ok() definition
In-Reply-To: <4656e09e40e832b2690fb0280975c70a541fb7ef.1464111462.git.robin.murphy@arm.com>
References: <4656e09e40e832b2690fb0280975c70a541fb7ef.1464111462.git.robin.murphy@arm.com>
Message-ID: <ada1b17d509429958e4117b86d37ec3f93ec2753.1464111462.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since commit 8c56cc8be5b3 ("ARM: 7449/1: use generic strnlen_user and
strncpy_from_user functions"), the definition of __addr_ok() has been
languishing unused; eradicate the sucker.

CC: Russell King <linux@armlinux.org.uk>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 arch/arm/include/asm/uaccess.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm/include/asm/uaccess.h b/arch/arm/include/asm/uaccess.h
index 35c9db857ebe..7badc3e55109 100644
--- a/arch/arm/include/asm/uaccess.h
+++ b/arch/arm/include/asm/uaccess.h
@@ -104,14 +104,6 @@ static inline void set_fs(mm_segment_t fs)
 
 #define segment_eq(a, b)	((a) == (b))
 
-#define __addr_ok(addr) ({ \
-	unsigned long flag; \
-	__asm__("cmp %2, %0; movlo %0, #0" \
-		: "=&r" (flag) \
-		: "0" (current_thread_info()->addr_limit), "r" (addr) \
-		: "cc"); \
-	(flag == 0); })
-
 /* We use 33-bit arithmetic here... */
 #define __range_ok(addr, size) ({ \
 	unsigned long flag, roksum; \
-- 
2.8.1.dirty
