From: linux@rasmusvillemoes.dk (Rasmus Villemoes)
Date: Tue, 16 Sep 2014 22:51:15 +0200
Subject: [PATCH 01/22] ARM: Replace strnicmp with strncasecmp
In-Reply-To: <1410900696-6481-1-git-send-email-linux@rasmusvillemoes.dk>
References: <1410900696-6481-1-git-send-email-linux@rasmusvillemoes.dk>
Message-ID: <1410900696-6481-2-git-send-email-linux@rasmusvillemoes.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The kernel used to contain two functions for length-delimited,
case-insensitive string comparison, strnicmp with correct semantics
and a slightly buggy strncasecmp. The latter is the POSIX name, so
strnicmp was renamed to strncasecmp, and strnicmp made into a wrapper
for the new strncasecmp to avoid breaking existing users.

To allow the compat wrapper strnicmp to be removed at some point in
the future, and to avoid the extra indirection cost, do
s/strnicmp/strncasecmp/g.

Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 arch/arm/mach-pxa/lpd270.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-pxa/lpd270.c b/arch/arm/mach-pxa/lpd270.c
index 9f6ec16..ad777b3 100644
--- a/arch/arm/mach-pxa/lpd270.c
+++ b/arch/arm/mach-pxa/lpd270.c
@@ -416,17 +416,17 @@ static struct pxafb_mach_info *lpd270_lcd_to_use;
 
 static int __init lpd270_set_lcd(char *str)
 {
-	if (!strnicmp(str, "lq057q3dc02", 11)) {
+	if (!strncasecmp(str, "lq057q3dc02", 11)) {
 		lpd270_lcd_to_use = &sharp_lq057q3dc02;
-	} else if (!strnicmp(str, "lq121s1dg31", 11)) {
+	} else if (!strncasecmp(str, "lq121s1dg31", 11)) {
 		lpd270_lcd_to_use = &sharp_lq121s1dg31;
-	} else if (!strnicmp(str, "lq036q1da01", 11)) {
+	} else if (!strncasecmp(str, "lq036q1da01", 11)) {
 		lpd270_lcd_to_use = &sharp_lq036q1da01;
-	} else if (!strnicmp(str, "lq64d343", 8)) {
+	} else if (!strncasecmp(str, "lq64d343", 8)) {
 		lpd270_lcd_to_use = &sharp_lq64d343;
-	} else if (!strnicmp(str, "lq10d368", 8)) {
+	} else if (!strncasecmp(str, "lq10d368", 8)) {
 		lpd270_lcd_to_use = &sharp_lq10d368;
-	} else if (!strnicmp(str, "lq035q7db02-20", 14)) {
+	} else if (!strncasecmp(str, "lq035q7db02-20", 14)) {
 		lpd270_lcd_to_use = &sharp_lq035q7db02_20;
 	} else {
 		printk(KERN_INFO "lpd270: unknown lcd panel [%s]\n", str);
-- 
2.0.4
