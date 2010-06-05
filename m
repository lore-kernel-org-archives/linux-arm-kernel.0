From: mcuos.com@gmail.com (Wan ZongShun)
Date: Sat, 05 Jun 2010 14:48:57 +0800
Subject: [PATCH 3/3] MTD/pxa: use resource_size(res) for pxa2xx-flash
Message-ID: <4C09F359.1000100@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The size calculation is end - start + 1. But,sometimes, the '1' can
be forgotten carelessly, witch will have potential risk, so use resource_size
should be good habit.

Signed-off-by :Wan ZongShun <mcuos.com@gmail.com>

---
 drivers/mtd/maps/pxa2xx-flash.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mtd/maps/pxa2xx-flash.c b/drivers/mtd/maps/pxa2xx-flash.c
index 43f8bb8..6ed9a2d 100644
--- a/drivers/mtd/maps/pxa2xx-flash.c
+++ b/drivers/mtd/maps/pxa2xx-flash.c
@@ -79,7 +79,7 @@ static int __devinit pxa2xx_flash_probe(struct platform_device *pdev)
 	info->map.name = (char *) flash->name;
 	info->map.bankwidth = flash->width;
 	info->map.phys = res->start;
-	info->map.size = res->end - res->start + 1;
+	info->map.size = resource_size(res);
 	info->parts = flash->parts;
 	info->nr_parts = flash->nr_parts;

-- 
1.6.3.3
