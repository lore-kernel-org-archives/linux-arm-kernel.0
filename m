From: david.lanzendoerfer@o2s.ch (David =?utf-8?q?Lanzend=C3=B6rfer?=)
Date: Tue, 16 Dec 2014 01:38:01 +0100
Subject: [PATCH 4/4] mmc: sunxi: Removing unused code
In-Reply-To: <20141216003412.15488.54812.stgit@dizzy-6.o2s.ch>
References: <20141216003412.15488.54812.stgit@dizzy-6.o2s.ch>
Message-ID: <20141216003801.15488.82217.stgit@dizzy-6.o2s.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Removing a relict from reverse engineering of the Android driver code in
sunxi_mmc_clk_set_rate.

Signed-off-by: David Lanzend?rfer <david.lanzendoerfer@o2s.ch>
Reported-by: ?? <lixiang@allwinnertech.com>
---
 drivers/mmc/host/sunxi-mmc.c |   10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index 5331c88..f73a569 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -635,7 +635,7 @@ static int sunxi_mmc_oclk_onoff(struct sunxi_mmc_host *host, u32 oclk_en)
 static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *host,
 				  struct mmc_ios *ios)
 {
-	u32 rate, oclk_dly, rval, sclk_dly, src_clk;
+	u32 rate, oclk_dly, rval, sclk_dly;
 	int ret;
 
 	rate = clk_round_rate(host->clk_mmc, ios->clock);
@@ -680,14 +680,6 @@ static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *host,
 		sclk_dly = 4;
 	}
 
-	src_clk = clk_get_rate(clk_get_parent(host->clk_mmc));
-	if (src_clk >= 300000000 && src_clk <= 400000000) {
-		if (oclk_dly)
-			oclk_dly--;
-		if (sclk_dly)
-			sclk_dly--;
-	}
-
 	clk_sunxi_mmc_phase_control(host->clk_mmc, sclk_dly, oclk_dly);
 
 	return sunxi_mmc_oclk_onoff(host, 1);
