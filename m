From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 24 Jun 2016 11:41:28 +0200
Subject: [PATCH 3/7] ARM: ux500: remove cpu_is_u* helpers
In-Reply-To: <20160624094132.1852086-1-arnd@arndb.de>
References: <20160624094132.1852086-1-arnd@arndb.de>
Message-ID: <20160624094132.1852086-4-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These functions are all unused now and can be removed.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-ux500/id.h | 107 -----------------------------------------------
 1 file changed, 107 deletions(-)

diff --git a/arch/arm/mach-ux500/id.h b/arch/arm/mach-ux500/id.h
index bcc58a8cccbc..929f78ecf3df 100644
--- a/arch/arm/mach-ux500/id.h
+++ b/arch/arm/mach-ux500/id.h
@@ -32,113 +32,6 @@ static inline unsigned int __attribute_const__ dbx500_revision(void)
 	return dbx500_id.revision;
 }
 
-/*
- * SOCs
- */
-
-static inline bool __attribute_const__ cpu_is_u8500(void)
-{
-	return dbx500_partnumber() == 0x8500;
-}
-
-static inline bool __attribute_const__ cpu_is_u8520(void)
-{
-	return dbx500_partnumber() == 0x8520;
-}
-
-static inline bool cpu_is_u8500_family(void)
-{
-	return cpu_is_u8500() || cpu_is_u8520();
-}
-
-static inline bool __attribute_const__ cpu_is_u9540(void)
-{
-	return dbx500_partnumber() == 0x9540;
-}
-
-static inline bool __attribute_const__ cpu_is_u8540(void)
-{
-	return dbx500_partnumber() == 0x8540;
-}
-
-static inline bool __attribute_const__ cpu_is_u8580(void)
-{
-	return dbx500_partnumber() == 0x8580;
-}
-
-static inline bool cpu_is_ux540_family(void)
-{
-	return cpu_is_u9540() || cpu_is_u8540() || cpu_is_u8580();
-}
-
-/*
- * 8500 revisions
- */
-
-static inline bool __attribute_const__ cpu_is_u8500ed(void)
-{
-	return cpu_is_u8500() && dbx500_revision() == 0x00;
-}
-
-static inline bool __attribute_const__ cpu_is_u8500v1(void)
-{
-	return cpu_is_u8500() && (dbx500_revision() & 0xf0) == 0xA0;
-}
-
-static inline bool __attribute_const__ cpu_is_u8500v10(void)
-{
-	return cpu_is_u8500() && dbx500_revision() == 0xA0;
-}
-
-static inline bool __attribute_const__ cpu_is_u8500v11(void)
-{
-	return cpu_is_u8500() && dbx500_revision() == 0xA1;
-}
-
-static inline bool __attribute_const__ cpu_is_u8500v2(void)
-{
-	return cpu_is_u8500() && ((dbx500_revision() & 0xf0) == 0xB0);
-}
-
-static inline bool cpu_is_u8500v20(void)
-{
-	return cpu_is_u8500() && (dbx500_revision() == 0xB0);
-}
-
-static inline bool cpu_is_u8500v21(void)
-{
-	return cpu_is_u8500() && (dbx500_revision() == 0xB1);
-}
-
-static inline bool cpu_is_u8500v22(void)
-{
-	return cpu_is_u8500() && (dbx500_revision() == 0xB2);
-}
-
-static inline bool cpu_is_u8500v20_or_later(void)
-{
-	return (cpu_is_u8500() && !cpu_is_u8500v10() && !cpu_is_u8500v11());
-}
-
-/*
- * 8540 revisions
- */
-
-static inline bool __attribute_const__ cpu_is_u8540v10(void)
-{
-	return cpu_is_u8540() && dbx500_revision() == 0xA0;
-}
-
-static inline bool __attribute_const__ cpu_is_u8580v10(void)
-{
-	return cpu_is_u8580() && dbx500_revision() == 0xA0;
-}
-
-static inline bool ux500_is_svp(void)
-{
-	return false;
-}
-
 #define ux500_unknown_soc()	BUG()
 
 #endif
-- 
2.9.0
