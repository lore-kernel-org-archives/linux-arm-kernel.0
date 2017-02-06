From: panand@redhat.com (Pratyush Anand)
Date: Mon,  6 Feb 2017 19:46:22 +0530
Subject: [PATCH] arm64: do not trace atomic operations
Message-ID: <f3159358fc4feb62f25bbaca9b3f949bc4341f0b.1486390538.git.panand@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Atomic operation function symbols are exported,when
CONFIG_ARM64_LSE_ATOMICS is defined. Prefix them with notrace, so that
an user can not trace these functions. Tracing these functions causes
kernel crash.

Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 arch/arm64/include/asm/lse.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/lse.h b/arch/arm64/include/asm/lse.h
index fc756e22c84c..606b20910a5c 100644
--- a/arch/arm64/include/asm/lse.h
+++ b/arch/arm64/include/asm/lse.h
@@ -19,7 +19,7 @@
 __asm__(".arch_extension	lse");
 
 /* Move the ll/sc atomics out-of-line */
-#define __LL_SC_INLINE
+#define __LL_SC_INLINE		notrace
 #define __LL_SC_PREFIX(x)	__ll_sc_##x
 #define __LL_SC_EXPORT(x)	EXPORT_SYMBOL(__LL_SC_PREFIX(x))
 
-- 
2.9.3
