From: icenowy@aosc.io (Icenowy Zheng)
Date: Sun, 22 Jul 2018 20:54:07 +0800
Subject: [PATCH] mmc: sunxi: allow 3.3V DDR when DDR is available
Message-ID: <20180722125407.43107-1-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some Allwinner boards feature an on-board eMMC with fixed 3.3V voltage
(e.g. Banana Pi M2+), and in this case both the eMMC and the SoC are
capable of doing 3.3V DDR transmission.

Add capability of 3.3V DDR when DDR is available (extra clock or new
timing).

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 drivers/mmc/host/sunxi-mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index 8e7f3e35ee3d..4ea8e2611079 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -1388,7 +1388,7 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
 				  MMC_CAP_ERASE | MMC_CAP_SDIO_IRQ;
 
 	if (host->cfg->clk_delays || host->use_new_timings)
-		mmc->caps      |= MMC_CAP_1_8V_DDR;
+		mmc->caps      |= MMC_CAP_1_8V_DDR | MMC_CAP_3_3V_DDR;
 
 	ret = mmc_of_parse(mmc);
 	if (ret)
-- 
2.18.0
