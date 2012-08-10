From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 10 Aug 2012 10:43:54 +0200
Subject: [PATCH 1/4] ARM: ux500: delete remnant U5500 macros
Message-ID: <1344588234-8597-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

The code using these ASIC detection functions is now gone so
we remove it.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/include/mach/id.h | 29 -----------------------------
 1 file changed, 29 deletions(-)

diff --git a/arch/arm/mach-ux500/include/mach/id.h b/arch/arm/mach-ux500/include/mach/id.h
index c6e2db9..87aa921 100644
--- a/arch/arm/mach-ux500/include/mach/id.h
+++ b/arch/arm/mach-ux500/include/mach/id.h
@@ -51,35 +51,6 @@ static inline bool cpu_is_u8500_family(void)
 	return cpu_is_u8500() || cpu_is_u9540();
 }
 
-static inline bool __attribute_const__ cpu_is_u5500(void)
-{
-	return dbx500_partnumber() == 0x5500;
-}
-
-/*
- * 5500 revisions
- */
-
-static inline bool __attribute_const__ cpu_is_u5500v1(void)
-{
-	return cpu_is_u5500() && (dbx500_revision() & 0xf0) == 0xA0;
-}
-
-static inline bool __attribute_const__ cpu_is_u5500v2(void)
-{
-	return (dbx500_id.revision & 0xf0) == 0xB0;
-}
-
-static inline bool __attribute_const__ cpu_is_u5500v20(void)
-{
-	return cpu_is_u5500() && ((dbx500_revision() & 0xf0) == 0xB0);
-}
-
-static inline bool __attribute_const__ cpu_is_u5500v21(void)
-{
-	return cpu_is_u5500() && (dbx500_revision() == 0xB1);
-}
-
 /*
  * 8500 revisions
  */
-- 
1.7.11.3
