From: will.deacon@arm.com (Will Deacon)
Date: Wed,  9 Oct 2013 15:54:28 +0100
Subject: [PATCH 3/3] arm64: cmpxchg: implement cmpxchg64_relaxed
In-Reply-To: <1381330468-32625-1-git-send-email-will.deacon@arm.com>
References: <1381330468-32625-1-git-send-email-will.deacon@arm.com>
Message-ID: <1381330468-32625-4-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch introduces cmpxchg64_relaxed for arm64 using the existing
cmpxchg_local macro, which performs a cmpxchg operation (up to 64 bits)
without barrier semantics.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/cmpxchg.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/include/asm/cmpxchg.h b/arch/arm64/include/asm/cmpxchg.h
index 8a8ce0e..3914c0d 100644
--- a/arch/arm64/include/asm/cmpxchg.h
+++ b/arch/arm64/include/asm/cmpxchg.h
@@ -173,4 +173,6 @@ static inline unsigned long __cmpxchg_mb(volatile void *ptr, unsigned long old,
 #define cmpxchg64(ptr,o,n)		cmpxchg((ptr),(o),(n))
 #define cmpxchg64_local(ptr,o,n)	cmpxchg_local((ptr),(o),(n))
 
+#define cmpxchg64_relaxed(ptr,o,n)	cmpxchg_local((ptr),(o),(n))
+
 #endif	/* __ASM_CMPXCHG_H */
-- 
1.8.2.2
