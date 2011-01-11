From: rabin@rab.in (Rabin Vincent)
Date: Tue, 11 Jan 2011 23:12:05 +0530
Subject: [PATCH] bitops: remove condition code clobber for CLZ
Message-ID: <1294767725-14814-1-git-send-email-rabin@rab.in>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CLZ instruction does not alter the condition flags, so remove the
"cc" clobber from the inline asm for fls().

Signed-off-by: Rabin Vincent <rabin@rab.in>
---
 arch/arm/include/asm/bitops.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/include/asm/bitops.h b/arch/arm/include/asm/bitops.h
index 338ff19..7b1bb2b 100644
--- a/arch/arm/include/asm/bitops.h
+++ b/arch/arm/include/asm/bitops.h
@@ -285,7 +285,7 @@ static inline int fls(int x)
 	if (__builtin_constant_p(x))
 	       return constant_fls(x);
 
-	asm("clz\t%0, %1" : "=r" (ret) : "r" (x) : "cc");
+	asm("clz\t%0, %1" : "=r" (ret) : "r" (x));
        	ret = 32 - ret;
 	return ret;
 }
-- 
1.7.2.3
