From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 19 Oct 2012 14:36:57 +0200
Subject: [PATCH] ARM: ux500: Introduce cpu_is_u8580()
Message-ID: <1350650217-25528-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Maxime Coquelin <maxime.coquelin@stericsson.com>

Detect the subrevision v1 of U8540 and U8580.

DB8580 is the FDSOI variant of DB8540. Some differences
with DB8540 related to clocks will need to be checked with
a cpu_is_u8580() function.

Signed-off-by: Maxime Coquelin <maxime.coquelin@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/include/mach/id.h | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-ux500/include/mach/id.h b/arch/arm/mach-ux500/include/mach/id.h
index 9c42642..bcc58a8 100644
--- a/arch/arm/mach-ux500/include/mach/id.h
+++ b/arch/arm/mach-ux500/include/mach/id.h
@@ -61,9 +61,14 @@ static inline bool __attribute_const__ cpu_is_u8540(void)
 	return dbx500_partnumber() == 0x8540;
 }
 
+static inline bool __attribute_const__ cpu_is_u8580(void)
+{
+	return dbx500_partnumber() == 0x8580;
+}
+
 static inline bool cpu_is_ux540_family(void)
 {
-	return cpu_is_u9540() || cpu_is_u8540();
+	return cpu_is_u9540() || cpu_is_u8540() || cpu_is_u8580();
 }
 
 /*
@@ -115,6 +120,20 @@ static inline bool cpu_is_u8500v20_or_later(void)
 	return (cpu_is_u8500() && !cpu_is_u8500v10() && !cpu_is_u8500v11());
 }
 
+/*
+ * 8540 revisions
+ */
+
+static inline bool __attribute_const__ cpu_is_u8540v10(void)
+{
+	return cpu_is_u8540() && dbx500_revision() == 0xA0;
+}
+
+static inline bool __attribute_const__ cpu_is_u8580v10(void)
+{
+	return cpu_is_u8580() && dbx500_revision() == 0xA0;
+}
+
 static inline bool ux500_is_svp(void)
 {
 	return false;
-- 
1.7.11.3
