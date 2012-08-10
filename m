From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 10 Aug 2012 10:44:01 +0200
Subject: [PATCH 2/4] ARM: ux500: add a U8520 detection macro
Message-ID: <1344588241-8633-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

In line with the other macros this detects the DB8520
ASIC variant.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/include/mach/id.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mach-ux500/include/mach/id.h b/arch/arm/mach-ux500/include/mach/id.h
index 87aa921..d1240e4 100644
--- a/arch/arm/mach-ux500/include/mach/id.h
+++ b/arch/arm/mach-ux500/include/mach/id.h
@@ -41,6 +41,11 @@ static inline bool __attribute_const__ cpu_is_u8500(void)
 	return dbx500_partnumber() == 0x8500;
 }
 
+static inline bool __attribute_const__ cpu_is_u8520(void)
+{
+	return dbx500_partnumber() == 0x8520;
+}
+
 static inline bool __attribute_const__ cpu_is_u9540(void)
 {
 	return dbx500_partnumber() == 0x9540;
-- 
1.7.11.3
