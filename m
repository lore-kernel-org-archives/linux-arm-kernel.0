From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue, 26 Jan 2010 22:28:40 +0100
Subject: [PATCH 1/4] zImage: fix comments for cache_on,
	cache_off and cache_clean_flush
In-Reply-To: <20100126203835.GC17642@pengutronix.de>
References: <20100126203835.GC17642@pengutronix.de>
Message-ID: <1264541323-3454-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds missing registers to the list of corrupted registers and
removes a wrong comment about r9 on entry

While at it the formatting of the comment to cache_off is changed to
resemble the other two.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/boot/compressed/head.S |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index 4fddc50..7cbab3c 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -339,9 +339,8 @@ params:		ldr	r0, =params_phys
  *  r6 = processor ID
  *  r7 = architecture number
  *  r8 = atags pointer
- *  r9 = run-time address of "start"  (???)
  * On exit,
- *  r1, r2, r3, r9, r10, r12 corrupted
+ *  r0, r1, r2, r3, r9, r10, r12 corrupted
  * This routine must preserve:
  *  r4, r5, r6, r7, r8
  */
@@ -778,9 +777,12 @@ proc_types:
  * Turn off the Cache and MMU.  ARMv3 does not support
  * reading the control register, but ARMv4 does.
  *
- * On entry,  r6 = processor ID
- * On exit,   r0, r1, r2, r3, r12 corrupted
- * This routine must preserve: r4, r6, r7
+ * On entry,
+ *  r6 = processor ID
+ * On exit,
+ *  r0, r1, r2, r3, r10, r12 corrupted
+ * This routine must preserve:
+ *  r4, r6, r7
  */
 		.align	5
 cache_off:	mov	r3, #12			@ cache_off function
@@ -855,7 +857,7 @@ __armv3_mmu_cache_off:
  * On entry,
  *  r6 = processor ID
  * On exit,
- *  r1, r2, r3, r11, r12 corrupted
+ *  r1, r2, r3, r10, r11, r12 corrupted
  * This routine must preserve:
  *  r0, r4, r5, r6, r7
  */
-- 
1.6.6
