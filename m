From: anton.vorontsov@linaro.org (Anton Vorontsov)
Date: Sun,  5 Aug 2012 16:03:32 -0700
Subject: [PATCH 2/9] ARM: plat-s3c24xx: Don't use FIQ_START
In-Reply-To: <20120805230238.GA1663@lizard>
References: <20120805230238.GA1663@lizard>
Message-ID: <1344207819-3415-2-git-send-email-anton.vorontsov@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We're about to remove FIQ_START mess, so move the platform-specific
detail inside platform-specific s3c24xx_set_fiq().

Signed-off-by: Anton Vorontsov <anton.vorontsov@linaro.org>
---
 arch/arm/plat-s3c24xx/irq.c |    2 +-
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
1.7.10.4
