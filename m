From: jungseoklee85@gmail.com (Jungseok Lee)
Date: Tue, 2 Dec 2014 07:01:06 +0900
Subject: [PATCH] arm64: Implement support for read-mostly sections 
Message-ID: <7F4979C9-A608-4641-B2DD-0A09FBCCC4A0@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

I'm not fully understand why this code is missed in ARM64, so my analysis below
might be wrong.

Best Regards
Jungseok Lee

---->8----

As putting data which is read mostly together, we can avoid
unnecessary cache line bouncing.

Other architectures, such as ARM and x86, adopted the same idea.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Jungseok Lee <jungseoklee85@gmail.com>
---
 arch/arm64/include/asm/cache.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/include/asm/cache.h b/arch/arm64/include/asm/cache.h
index 88cc05b..c1a2a9f 100644
--- a/arch/arm64/include/asm/cache.h
+++ b/arch/arm64/include/asm/cache.h
@@ -30,6 +30,8 @@
  */
 #define ARCH_DMA_MINALIGN	L1_CACHE_BYTES
 
+#define __read_mostly __attribute__((__section__(".data..read_mostly")))
+
 #ifndef __ASSEMBLY__
 
 static inline int cache_line_size(void)
-- 
1.9.1
