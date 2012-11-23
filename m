From: anton.vorontsov@linaro.org (Anton Vorontsov)
Date: Thu, 22 Nov 2012 16:49:55 -0800
Subject: [PATCH 02/10] ARM: plat-s3c24xx: Don't use FIQ_START
In-Reply-To: <20121123003849.GA973@lizard.mcd25758.sjc.wayport.net>
References: <20121123003849.GA973@lizard.mcd25758.sjc.wayport.net>
Message-ID: <1353631803-4853-2-git-send-email-anton.vorontsov@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We're about to remove FIQ_START mess, so move the platform-specific
detail inside platform-specific s3c24xx_set_fiq().

Signed-off-by: Anton Vorontsov <anton.vorontsov@linaro.org>
Acked-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/plat-s3c24xx/irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/plat-s3c24xx/irq.c b/arch/arm/plat-s3c24xx/irq.c
index fe57bbb..e4e9567 100644
--- a/arch/arm/plat-s3c24xx/irq.c
+++ b/arch/arm/plat-s3c24xx/irq.c
@@ -503,7 +503,7 @@ int s3c24xx_set_fiq(unsigned int irq, bool on)
 	unsigned offs;
 
 	if (on) {
-		offs = irq - FIQ_START;
+		offs = irq - IRQ_EINT0;
 		if (offs > 31)
 			return -EINVAL;
 
-- 
1.8.0
