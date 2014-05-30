From: yamada.m@jp.panasonic.com (Masahiro Yamada)
Date: Fri, 30 May 2014 20:30:33 +0900
Subject: [PATCH] ARM: decompressor: a minor optimization
Message-ID: <1401449433-1963-1-git-send-email-yamada.m@jp.panasonic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"ldr sp, [r0, #28]" can be squashed into the previous ldm instruction.

Signed-off-by: Masahiro Yamada <yamada.m@jp.panasonic.com>
---
 arch/arm/boot/compressed/head.S | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index 066b034..8c392c5 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -194,8 +194,7 @@ not_angel:
 		blcs	cache_on
 
 restart:	adr	r0, LC0
-		ldmia	r0, {r1, r2, r3, r6, r10, r11, r12}
-		ldr	sp, [r0, #28]
+		ldmia	r0, {r1, r2, r3, r6, r10, r11, r12, sp}
 
 		/*
 		 * We might be running at a different address.  We need
-- 
1.9.1
