From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 18 Apr 2013 11:12:04 +0100
Subject: [PATCH 22/32] dmaengine: ste_dma40: Allocate plat_data on declaration
In-Reply-To: <1366279934-30761-1-git-send-email-lee.jones@linaro.org>
References: <1366279934-30761-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1366279934-30761-23-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's the way that most other drivers do it.

Very trivial clean-up which reduces line count and simplifies code.

Cc: Vinod Koul <vinod.koul@intel.com>
Cc: Dan Williams <djbw@fb.com>
Cc: Per Forlin <per.forlin@stericsson.com>
Cc: Rabin Vincent <rabin@rab.in>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/dma/ste_dma40.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index 805049c..6f9f801 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -3119,7 +3119,7 @@ static int __init d40_phy_res_init(struct d40_base *base)
 
 static struct d40_base * __init d40_hw_detect_init(struct platform_device *pdev)
 {
-	struct stedma40_platform_data *plat_data;
+	struct stedma40_platform_data *plat_data = pdev->dev.platform_data;
 	struct clk *clk = NULL;
 	void __iomem *virtbase = NULL;
 	struct resource *res = NULL;
@@ -3190,8 +3190,6 @@ static struct d40_base * __init d40_hw_detect_init(struct platform_device *pdev)
 		goto failure;
 	}
 
-	plat_data = pdev->dev.platform_data;
-
 	/* The number of physical channels on this HW */
 	if (plat_data->num_of_phy_chans)
 		num_phy_chans = plat_data->num_of_phy_chans;
-- 
1.7.10.4
