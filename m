From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue, 26 Jan 2010 22:28:43 +0100
Subject: [PATCH 4/4] zImage: annotate debug functions about corrupted registers
In-Reply-To: <20100126203835.GC17642@pengutronix.de>
References: <20100126203835.GC17642@pengutronix.de>
Message-ID: <1264541323-3454-4-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/boot/compressed/head.S |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index 15534ea..04bb6b4 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -1016,6 +1016,7 @@ __armv3_mpu_cache_flush:
 phexbuf:	.space	12
 		.size	phexbuf, . - phexbuf
 
+@ phex corrupts {r0, r1, r2, r3}
 phex:		adr	r3, phexbuf
 		mov	r2, #0
 		strb	r2, [r3, r1]
@@ -1030,6 +1031,7 @@ phex:		adr	r3, phexbuf
 		strb	r2, [r3, r1]
 		b	1b
 
+@ puts corrupts {r0, r1, r2, r3}
 puts:		loadsp	r3
 1:		ldrb	r2, [r0], #1
 		teq	r2, #0
@@ -1044,12 +1046,14 @@ puts:		loadsp	r3
 		teq	r0, #0
 		bne	1b
 		mov	pc, lr
+@ putc corrupts {r0, r1, r2, r3}
 putc:
 		mov	r2, r0
 		mov	r0, #0
 		loadsp	r3
 		b	2b
 
+@ memdump corrupts {r0, r1, r2, r3, r10, r11, r12, lr}
 memdump:	mov	r12, r0
 		mov	r10, lr
 		mov	r11, #0
-- 
1.6.6
