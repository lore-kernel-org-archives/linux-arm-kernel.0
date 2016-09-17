From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 17 Sep 2016 17:17:30 +0200
Subject: [PATCH 09/24] ste_dma40: Delete unnecessary variable initialisations
 in d40_hw_detect_init()
In-Reply-To: <92810066-69b6-94e7-dcec-a28594b1328f@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
 <92810066-69b6-94e7-dcec-a28594b1328f@users.sourceforge.net>
Message-ID: <2dc8cf1c-6bf6-a320-0c61-c25835ca3146@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 17 Sep 2016 14:34:18 +0200

Five local variables will be set to an appropriate value a bit later.
Thus omit the explicit initialisation which became unnecessary with
a previous update step.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/dma/ste_dma40.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index c680dd3..ebb00a8 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -3142,11 +3142,11 @@ static int __init d40_phy_res_init(struct d40_base *base)
 static struct d40_base * __init d40_hw_detect_init(struct platform_device *pdev)
 {
 	struct stedma40_platform_data *plat_data = dev_get_platdata(&pdev->dev);
-	struct clk *clk = NULL;
-	void __iomem *virtbase = NULL;
-	struct resource *res = NULL;
-	struct d40_base *base = NULL;
-	int num_log_chans = 0;
+	struct clk *clk;
+	void __iomem *virtbase;
+	struct resource *res;
+	struct d40_base *base;
+	int num_log_chans;
 	int num_phy_chans;
 	int num_memcpy_chans;
 	int clk_ret = -EINVAL;
-- 
2.10.0
