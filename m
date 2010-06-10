From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 10 Jun 2010 12:27:10 +0200
Subject: [PATCH 04/10] arm/zImage: fix comments for cache_on,
	cache_off and cache_clean_flush
In-Reply-To: <20100610102427.GC31057@pengutronix.de>
References: <20100610102427.GC31057@pengutronix.de>
Message-ID: <1276165636-20150-4-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds missing registers to the list of corrupted registers and
removes a wrong comment about r9 on entry

While at it the formatting of the comment to cache_off is changed to
resemble the other two.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/boot/compressed/head.S |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index 4058294..f8a210b 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -339,9 +339,8 @@ params:		ldr	r0, =params_phys
  *  r4 = kernel execution address
  *  r7 = architecture number
  *  r8 = atags pointer
- *  r9 = run-time address of "start"  (???)
  * On exit,
- *  r1, r2, r3, r9, r10, r12 corrupted
+ *  r0, r1, r2, r3, r9, r10, r12 corrupted
  * This routine must preserve:
  *  r4, r5, r6, r7, r8
  */
@@ -774,8 +773,10 @@ proc_types:
  * Turn off the Cache and MMU.  ARMv3 does not support
  * reading the control register, but ARMv4 does.
  *
- * On exit, r0, r1, r2, r3, r9, r12 corrupted
- * This routine must preserve: r4, r6, r7
+ * On exit,
+ *  r0, r1, r2, r3, r9, r12 corrupted
+ * This routine must preserve:
+ *  r4, r6, r7
  */
 		.align	5
 cache_off:	mov	r3, #12			@ cache_off function
@@ -848,7 +849,7 @@ __armv3_mmu_cache_off:
  * Clean and flush the cache to maintain consistency.
  *
  * On exit,
- *  r1, r2, r3, r9, r11, r12 corrupted
+ *  r1, r2, r3, r9, r10, r11, r12 corrupted
  * This routine must preserve:
  *  r0, r4, r5, r6, r7
  */
-- 
1.7.1
