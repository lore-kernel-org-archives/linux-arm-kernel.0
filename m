From: corone.il.han@gmail.com (Il Han)
Date: Tue,  6 Sep 2011 20:45:48 +0900
Subject: [PATCH] head.S: The official name of the Cache Size Selection
	Register is CSSELR.
Message-ID: <1315309548-23188-1-git-send-email-corone.il.han@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The official name of the Cache Size Selection Register is CSSELR.
Modify it.

Signed-off-by: Il Han <corone.il.han@gmail.com>
---
 arch/arm/boot/compressed/head.S |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index e95a598..72026dc 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -949,8 +949,8 @@ loop1:
 		and	r1, r1, #7		@ mask of the bits for current cache only
 		cmp	r1, #2			@ see what cache we have at this level
 		blt	skip			@ skip if no cache, or just i-cache
-		mcr	p15, 2, r10, c0, c0, 0	@ select current cache level in cssr
-		mcr	p15, 0, r10, c7, c5, 4	@ isb to sych the new cssr&csidr
+		mcr	p15, 2, r10, c0, c0, 0	@ select current cache level in csselr
+		mcr	p15, 0, r10, c7, c5, 4	@ isb to sych the new csselr&csidr
 		mrc	p15, 1, r1, c0, c0, 0	@ read the new csidr
 		and	r2, r1, #7		@ extract the length of the cache lines
 		add	r2, r2, #4		@ add 4 (line length offset)
@@ -980,7 +980,7 @@ skip:
 finished:
 		ldmfd	sp!, {r0-r7, r9-r11}
 		mov	r10, #0			@ swith back to cache level 0
-		mcr	p15, 2, r10, c0, c0, 0	@ select current cache level in cssr
+		mcr	p15, 2, r10, c0, c0, 0	@ select current cache level in csselr
 iflush:
 		mcr	p15, 0, r10, c7, c10, 4	@ DSB
 		mcr	p15, 0, r10, c7, c5, 0	@ invalidate I+BTB
-- 
1.7.4.1
