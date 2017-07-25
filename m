From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 25 Jul 2017 11:55:38 +0100
Subject: [PATCH 1/6] arm64: mm: Fix set_memory_valid() declaration
In-Reply-To: <cover.1500397441.git.robin.murphy@arm.com>
References: <cover.1500397441.git.robin.murphy@arm.com>
Message-ID: <a7b0cd687d7d2ee9315db4fc9a86b8dff2892875.1500397441.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Clearly, set_memory_valid() has never been seen in the same room as its
declaration... Whilst the type mismatch is such that kexec probably
wasn't broken in practice, fix it to match the definition as it should.

Fixes: 9b0aa14e3155 ("arm64: mm: add set_memory_valid()")
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 arch/arm64/include/asm/cacheflush.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/cacheflush.h b/arch/arm64/include/asm/cacheflush.h
index d74a284abdc2..4d4f650c290e 100644
--- a/arch/arm64/include/asm/cacheflush.h
+++ b/arch/arm64/include/asm/cacheflush.h
@@ -150,6 +150,6 @@ static inline void flush_cache_vunmap(unsigned long start, unsigned long end)
 {
 }
 
-int set_memory_valid(unsigned long addr, unsigned long size, int enable);
+int set_memory_valid(unsigned long addr, int numpages, int enable);
 
 #endif
-- 
2.12.2.dirty
