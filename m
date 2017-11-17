From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Sat, 18 Nov 2017 01:58:21 +0530
Subject: [PATCH 5/6] mmc: sh_mmcif: Handle return value of platform_get_irq
In-Reply-To: <1510950502-22565-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1510950502-22565-1-git-send-email-arvind.yadav.cs@gmail.com>
Message-ID: <1510950502-22565-6-git-send-email-arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

platform_get_irq() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/mmc/host/sh_mmcif.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 53fb18b..481f2c4 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -1405,7 +1405,7 @@ static int sh_mmcif_probe(struct platform_device *pdev)
 
 	irq[0] = platform_get_irq(pdev, 0);
 	irq[1] = platform_get_irq(pdev, 1);
-	if (irq[0] < 0) {
+	if (irq[0] < 0 || irq[1] < 0) {
 		dev_err(dev, "Get irq error\n");
 		return -ENXIO;
 	}
-- 
2.7.4
