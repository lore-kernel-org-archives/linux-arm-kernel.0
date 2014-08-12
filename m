From: schwab@linux-m68k.org (Andreas Schwab)
Date: Tue, 12 Aug 2014 19:20:22 +0200
Subject: [PATCH] arm/xen: fix wrong conflict resolution of xen merge
Message-ID: <87fvh1vd49.fsf@igel.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove duplicate definition of arch_gnttab_init.

Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
---
 arch/arm/xen/grant-table.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/xen/grant-table.c b/arch/arm/xen/grant-table.c
index 2c4041c..e437918 100644
--- a/arch/arm/xen/grant-table.c
+++ b/arch/arm/xen/grant-table.c
@@ -49,8 +49,3 @@ int arch_gnttab_init(unsigned long nr_shared)
 {
 	return 0;
 }
-
-int arch_gnttab_init(unsigned long nr_shared, unsigned long nr_status)
-{
-	return 0;
-}
-- 
2.0.4


-- 
Andreas Schwab, schwab at linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
