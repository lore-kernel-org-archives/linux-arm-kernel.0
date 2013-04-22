From: gang.chen@asianux.com (Chen Gang)
Date: Mon, 22 Apr 2013 13:08:41 +0800
Subject: [PATCH] ARM64: kernel: compiling issue,
 define cmpxchg64 and cmpxchg64_local for outside using.
In-Reply-To: <2182812.ymprEm6XBb@wuerfel>
References: <51712E5E.2020809@asianux.com> <201304191412.54601.arnd@arndb.de>
 <5171FD67.2080104@asianux.com> <2182812.ymprEm6XBb@wuerfel>
Message-ID: <5174C5D9.3060109@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


  drivers use cmpxchg64, cmpxchg64_local ... to perform 64-bit operation,
  so they can cross 32-bit and 64-bit platforms (it is a standard way).


Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/arm64/include/asm/cmpxchg.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/include/asm/cmpxchg.h b/arch/arm64/include/asm/cmpxchg.h
index 968b5cb..8a8ce0e 100644
--- a/arch/arm64/include/asm/cmpxchg.h
+++ b/arch/arm64/include/asm/cmpxchg.h
@@ -170,4 +170,7 @@ static inline unsigned long __cmpxchg_mb(volatile void *ptr, unsigned long old,
 				       (unsigned long)(n),		\
 				       sizeof(*(ptr))))
 
+#define cmpxchg64(ptr,o,n)		cmpxchg((ptr),(o),(n))
+#define cmpxchg64_local(ptr,o,n)	cmpxchg_local((ptr),(o),(n))
+
 #endif	/* __ASM_CMPXCHG_H */
-- 
1.7.7.6
