From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 14 Mar 2013 21:24:27 +0100
Subject: [PATCH] ARM: decompressor: clearify a comment and minor typo fixes
Message-ID: <1363292667-9291-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
Hello,

this is what I noticed while digging through the decompressor's code.

Uwe

 arch/arm/boot/compressed/atags_to_fdt.c | 2 +-
 arch/arm/boot/compressed/head.S         | 9 +++++----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/compressed/atags_to_fdt.c b/arch/arm/boot/compressed/atags_to_fdt.c
index aabc02a..24fa535 100644
--- a/arch/arm/boot/compressed/atags_to_fdt.c
+++ b/arch/arm/boot/compressed/atags_to_fdt.c
@@ -87,7 +87,7 @@ static void merge_fdt_bootargs(void *fdt, const char *fdt_cmdline)
 /*
  * Convert and fold provided ATAGs into the provided FDT.
  *
- * REturn values:
+ * Return values:
  *    = 0 -> pretend success
  *    = 1 -> bad ATAG (may retry with another possible ATAG pointer)
  *    < 0 -> error from libfdt
diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index fe4d9c3..fe6d63a 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -258,7 +258,7 @@ restart:	adr	r0, LC0
 		 * If we do have a DTB appended to zImage, and we do have
 		 * an ATAG list around, we want the later to be translated
 		 * and folded into the former here.  To be on the safe side,
-		 * let's temporarily move  the stack away into the malloc
+		 * let's temporarily move the stack away into the malloc
 		 * area.  No GOT fixup has occurred yet, but none of the
 		 * code we're about to call uses any global variable.
 		*/
@@ -270,9 +270,10 @@ restart:	adr	r0, LC0
 		bl	atags_to_fdt
 
 		/*
-		 * If returned value is 1, there is no ATAG at the location
-		 * pointed by r8.  Try the typical 0x100 offset from start
-		 * of RAM and hope for the best.
+		 * If returned value is 1, there is neither an ATAG list nor a
+		 * device tree blob at the location pointed to by r8.  Try the
+		 * typical 0x100 offset from start of RAM and hope for the
+		 * best.
 		 */
 		cmp	r0, #1
 		sub	r0, r4, #TEXT_OFFSET
-- 
1.8.2.rc2
