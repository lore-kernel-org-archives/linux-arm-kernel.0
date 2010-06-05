From: mcuos.com@gmail.com (Wan ZongShun)
Date: Sat, 05 Jun 2010 17:07:06 +0800
Subject: [PATCHv2 1/3] MTD/pxa: use __devinit for pxa2xx_flash_probe
Message-ID: <4C0A13BA.6050700@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is to use the '__devinit' for pxa2xx_flash_probe.

Signed-off-by: Wan ZongShun <mcuos.com@gmail.com>
Acked-by: Eric Miao <eric.y.miao@gmail.com>

---
 drivers/mtd/maps/pxa2xx-flash.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mtd/maps/pxa2xx-flash.c b/drivers/mtd/maps/pxa2xx-flash.c
index dd90880..d8ae634 100644
--- a/drivers/mtd/maps/pxa2xx-flash.c
+++ b/drivers/mtd/maps/pxa2xx-flash.c
@@ -51,7 +51,7 @@ struct pxa2xx_flash_info {
 static const char *probes[] = { "RedBoot", "cmdlinepart", NULL };


-static int __init pxa2xx_flash_probe(struct platform_device *pdev)
+static int __devinit pxa2xx_flash_probe(struct platform_device *pdev)
 {
 	struct flash_platform_data *flash = pdev->dev.platform_data;
 	struct pxa2xx_flash_info *info;
-- 
1.6.3.3
