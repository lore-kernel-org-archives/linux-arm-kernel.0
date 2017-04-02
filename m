From: ynorov@caviumnetworks.com (Yury Norov)
Date: Sun, 2 Apr 2017 23:31:01 +0400
Subject: aarch64 build is broken on latest linux-next
Message-ID: <20170402193101.GA17966@yury-N73SV>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

I found that the patch f13d52cb (arm64: define BUG() instruction
without CONFIG_BUG) has a typo that breaks the build of next-20170331.
This simple patch fixes it.

Yury

---
 arch/arm64/include/asm/bug.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/bug.h b/arch/arm64/include/asm/bug.h
index 23cfff3..366448e 100644
--- a/arch/arm64/include/asm/bug.h
+++ b/arch/arm64/include/asm/bug.h
@@ -59,7 +59,7 @@ _BUGVERBOSE_LOCATION(__FILE__, __LINE__)		\
 	unreachable();					\
 } while (0)
 
-#define __WARN_FLAGS(flags) _BUG_FLAGS(BUGFLAG_WARNING|(flags))
+#define __WARN_FLAGS(flags) __BUG_FLAGS(BUGFLAG_WARNING|(flags))
 
 #define HAVE_ARCH_BUG
 
-- 
2.7.4
