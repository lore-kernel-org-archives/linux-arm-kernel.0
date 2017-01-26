From: hkallweit1@gmail.com (Heiner Kallweit)
Date: Thu, 26 Jan 2017 23:09:01 +0100
Subject: [PATCH] mmc: meson-gx: set max block count to 256
Message-ID: <82cf7861-5cf8-302d-5354-435282d95619@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So far max_blk_count isn't set what results in a default of value 8
to be used (PAGE_SIZE / block size).
Set max_blk_count to 256 as used in the uboot driver.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 3308b5b6..030425be 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -799,6 +799,7 @@ static int meson_mmc_probe(struct platform_device *pdev)
 		goto free_host;
 	}
 
+	mmc->max_blk_count = 256;
 	mmc->ops = &meson_mmc_ops;
 	mmc_add_host(mmc);
 
-- 
2.11.0
