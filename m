From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 10 Jan 2014 15:00:06 +0800
Subject: [PATCH v2 05/16] blackfin: Update stmmac callback signatures
In-Reply-To: <1389337217-29032-1-git-send-email-wens@csie.org>
References: <1389337217-29032-1-git-send-email-wens@csie.org>
Message-ID: <1389337217-29032-6-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

stmmac callbacks have been extended for better seperation.
Update them to avoid breakage.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/blackfin/mach-bf609/boards/ezkit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/blackfin/mach-bf609/boards/ezkit.c b/arch/blackfin/mach-bf609/boards/ezkit.c
index 82beedd..05194e9 100644
--- a/arch/blackfin/mach-bf609/boards/ezkit.c
+++ b/arch/blackfin/mach-bf609/boards/ezkit.c
@@ -117,7 +117,7 @@ static struct stmmac_dma_cfg eth_dma_cfg = {
 	.pbl	= 2,
 };
 
-int stmmac_ptp_clk_init(struct platform_device *pdev)
+int stmmac_ptp_clk_init(struct platform_device *pdev, void *priv)
 {
 	bfin_write32(PADS0_EMAC_PTP_CLKSEL, 0);
 	return 0;
-- 
1.8.5.2
