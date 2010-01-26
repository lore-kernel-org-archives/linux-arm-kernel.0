From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue, 26 Jan 2010 22:28:42 +0100
Subject: [PATCH 3/4] zImage: __armv3_mpu_cache_flush: respect should-be-zero
	specification
In-Reply-To: <20100126203835.GC17642@pengutronix.de>
References: <20100126203835.GC17642@pengutronix.de>
Message-ID: <1264541323-3454-3-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Probably the register content for cache operations is "don't care" in
practice, but as r1 is explicitly zeroed, use that one.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/boot/compressed/head.S |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index f6d665f..15534ea 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -1003,7 +1003,7 @@ no_cache_id:
 __armv3_mmu_cache_flush:
 __armv3_mpu_cache_flush:
 		mov	r1, #0
-		mcr	p15, 0, r0, c7, c0, 0	@ invalidate whole cache v3
+		mcr	p15, 0, r1, c7, c0, 0	@ invalidate whole cache v3
 		mov	pc, lr
 
 /*
-- 
1.6.6
