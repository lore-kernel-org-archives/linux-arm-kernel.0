From: yamada.m@jp.panasonic.com (Masahiro Yamada)
Date: Fri, 28 Nov 2014 15:12:14 +0900
Subject: [PATCH] ARM: decompressor: fix a wrong comment
Message-ID: <1417155134-29808-1-git-send-email-yamada.m@jp.panasonic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This comment does not correspond to the actual code.

When zImage is loaded at a lower *OR* higher address of
the destination of Image, it won't overwrite itself.

Signed-off-by: Masahiro Yamada <yamada.m@jp.panasonic.com>
---

 arch/arm/boot/compressed/head.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index 68be901..9dff614 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -178,7 +178,7 @@ not_angel:
 
 		/*
 		 * Set up a page table only if it won't overwrite ourself.
-		 * That means r4 < pc && r4 - 16k page directory > &_end.
+		 * That means r4 < pc || r4 - 16k page directory > &_end.
 		 * Given that r4 > &_end is most unfrequent, we add a rough
 		 * additional 1MB of room for a possible appended DTB.
 		 */
-- 
1.9.1
