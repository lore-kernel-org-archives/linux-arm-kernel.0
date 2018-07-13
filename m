From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Fri, 13 Jul 2018 11:22:06 +0100
Subject: [PATCH] ARM: tcm: ensure inline stub functions are marked static
Message-ID: <E1fdvDC-0004xH-Vj@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ensure that the stubbed out tcm_init() is marked static, so we don't
end up emitting the stub each time the header is included.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/mm/tcm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/tcm.h b/arch/arm/mm/tcm.h
index 8015ad434a40..24101925fe64 100644
--- a/arch/arm/mm/tcm.h
+++ b/arch/arm/mm/tcm.h
@@ -11,7 +11,7 @@
 void __init tcm_init(void);
 #else
 /* No TCM support, just blank inlines to be optimized out */
-inline void tcm_init(void)
+static inline void tcm_init(void)
 {
 }
 #endif
-- 
2.7.4
