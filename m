From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Wed, 19 Dec 2012 10:50:09 +0100
Subject: [PATCH] ARM: OMAP2+: Fix compillation error in mach-omap2/timer.c
Message-ID: <1355910609-31336-1-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

prom_add_property() has been renamed to of_add_property()
This patch fixes the following comilation error:

arch/arm/mach-omap2/timer.c: In function ?omap_get_timer_dt?:
arch/arm/mach-omap2/timer.c:178:3: error: implicit declaration of function ?prom_add_property? [-Werror=implicit-function-declaration]
cc1: some warnings being treated as errors
make[1]: *** [arch/arm/mach-omap2/timer.o] Error 1
make[1]: *** Waiting for unfinished jobs....

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
Hi Tony,

today's mainline does not compile due to this API rename in of core.
Not sure if we alreasy have fix for this pending.

Regards,
Peter

 arch/arm/mach-omap2/timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 7016637..cece724 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -175,7 +175,7 @@ static struct device_node * __init omap_get_timer_dt(struct of_device_id *match,
 			continue;
 		}
 
-		prom_add_property(np, &device_disabled);
+		of_add_property(np, &device_disabled);
 		return np;
 	}
 
-- 
1.8.0.2
