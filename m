From: varkabhadram@gmail.com (Varka Bhadram)
Date: Tue, 21 Oct 2014 16:03:32 +0530
Subject: [PATCH arm-soc 2/2] plat-omap: dmtimer: remove duplicate check on
 resource
In-Reply-To: <1413887612-25012-1-git-send-email-varkab@cdac.in>
References: <1413887612-25012-1-git-send-email-varkab@cdac.in>
Message-ID: <1413887612-25012-3-git-send-email-varkab@cdac.in>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sanity check on resource happening with devm_ioremap_resource().

Signed-off-by: Varka Bhadram <varkab@cdac.in>
---
 arch/arm/plat-omap/dmtimer.c |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index db10169..bed495a 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -815,10 +815,6 @@ static int omap_dm_timer_probe(struct platform_device *pdev)
 	}
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (unlikely(!mem)) {
-		dev_err(dev, "%s: no memory resource.\n", __func__);
-		return -ENODEV;
-	}
 
 	timer = devm_kzalloc(dev, sizeof(struct omap_dm_timer), GFP_KERNEL);
 	if (!timer) {
-- 
1.7.9.5
