From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 10 Jun 2010 12:27:09 +0200
Subject: [PATCH 03/10] arm/zImage: __armv3_mpu_cache_flush: respect
	should-be-zero specification
In-Reply-To: <20100610102427.GC31057@pengutronix.de>
References: <20100610102427.GC31057@pengutronix.de>
Message-ID: <1276165636-20150-3-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Probably the register content for cache operations is "don't care" in
practice, but as r1 is explicitly zeroed, use that one.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/boot/compressed/head.S |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index 384150b..4058294 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -991,7 +991,7 @@ no_cache_id:
 __armv3_mmu_cache_flush:
 __armv3_mpu_cache_flush:
 		mov	r1, #0
-		mcr	p15, 0, r0, c7, c0, 0	@ invalidate whole cache v3
+		mcr	p15, 0, r1, c7, c0, 0	@ invalidate whole cache v3
 		mov	pc, lr
 
 /*
-- 
1.7.1
