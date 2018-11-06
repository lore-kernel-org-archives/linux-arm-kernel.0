From: sboyd@kernel.org (Stephen Boyd)
Date: Tue,  6 Nov 2018 10:36:08 -0800
Subject: [PATCH 3/4] clk: mediatek: Drop THIS_MODULE from platform_driver
In-Reply-To: <20181106183609.207702-1-sboyd@kernel.org>
References: <20181106183609.207702-1-sboyd@kernel.org>
Message-ID: <20181106183609.207702-4-sboyd@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is already set by platform_driver_register(), so we can remove it
here.

Cc: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/mediatek/clk-mt2712.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clk/mediatek/clk-mt2712.c b/drivers/clk/mediatek/clk-mt2712.c
index 17c031d110ff..55f81f9bfdb5 100644
--- a/drivers/clk/mediatek/clk-mt2712.c
+++ b/drivers/clk/mediatek/clk-mt2712.c
@@ -1445,7 +1445,6 @@ static struct platform_driver clk_mt2712_drv = {
 	.probe = platform_driver_probe_by_of_match_data,
 	.driver = {
 		.name = "clk-mt2712",
-		.owner = THIS_MODULE,
 		.of_match_table = of_match_clk_mt2712,
 	},
 };
-- 
Sent by a computer through tubes
