From: lee.jones@linaro.org (Lee Jones)
Date: Fri,  3 May 2013 15:32:10 +0100
Subject: [PATCH 24/63] dmaengine: ste_dma40: Allocate plat_data on declaration
In-Reply-To: <1367591569-32197-1-git-send-email-lee.jones@linaro.org>
References: <1367591569-32197-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1367591569-32197-25-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's the way that most other drivers do it.

Very trivial clean-up which reduces line count and simplifies code.

Acked-by: Vinod Koul <vnod.koul@intel.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/dma/ste_dma40.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index 6d81f44..ba50561 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -3132,7 +3132,7 @@ static int __init d40_phy_res_init(struct d40_base *base)
 
 static struct d40_base * __init d40_hw_detect_init(struct platform_device *pdev)
 {
-	struct stedma40_platform_data *plat_data;
+	struct stedma40_platform_data *plat_data = pdev->dev.platform_data;
 	struct clk *clk = NULL;
 	void __iomem *virtbase = NULL;
 	struct resource *res = NULL;
@@ -3203,8 +3203,6 @@ static struct d40_base * __init d40_hw_detect_init(struct platform_device *pdev)
 		goto failure;
 	}
 
-	plat_data = pdev->dev.platform_data;
-
 	/* The number of physical channels on this HW */
 	if (plat_data->num_of_phy_chans)
 		num_phy_chans = plat_data->num_of_phy_chans;
-- 
1.7.10.4
