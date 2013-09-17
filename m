From: will.deacon@arm.com (Will Deacon)
Date: Tue, 17 Sep 2013 14:29:33 +0100
Subject: [PATCH v3 1/6] ARM: prefetch: remove redundant "cc" clobber
In-Reply-To: <1379424578-7477-1-git-send-email-will.deacon@arm.com>
References: <1379424578-7477-1-git-send-email-will.deacon@arm.com>
Message-ID: <1379424578-7477-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pld instruction does not affect the condition flags, so don't bother
clobbering them.

Acked-by: Nicolas Pitre <nico@linaro.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/processor.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/processor.h b/arch/arm/include/asm/processor.h
index 413f387..514a989 100644
--- a/arch/arm/include/asm/processor.h
+++ b/arch/arm/include/asm/processor.h
@@ -97,9 +97,7 @@ static inline void prefetch(const void *ptr)
 {
 	__asm__ __volatile__(
 		"pld\t%a0"
-		:
-		: "p" (ptr)
-		: "cc");
+		:: "p" (ptr));
 }
 
 #define ARCH_HAS_PREFETCHW
-- 
1.8.2.2
