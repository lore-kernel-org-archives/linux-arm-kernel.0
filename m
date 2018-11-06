From: sboyd@kernel.org (Stephen Boyd)
Date: Tue,  6 Nov 2018 10:36:07 -0800
Subject: [PATCH 2/4] clk: mediatek: Convert to
 platform_driver_probe_by_match_data()
In-Reply-To: <20181106183609.207702-1-sboyd@kernel.org>
References: <20181106183609.207702-1-sboyd@kernel.org>
Message-ID: <20181106183609.207702-3-sboyd@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use this function to reduce the boiler-plate code that the mediatek clk
driver needs to implement to probe clks for different devices within the
same driver.

Cc: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/mediatek/clk-mt2701.c     | 20 +-------------------
 drivers/clk/mediatek/clk-mt2712.c     | 20 +-------------------
 drivers/clk/mediatek/clk-mt6797.c     | 20 +-------------------
 drivers/clk/mediatek/clk-mt7622-eth.c | 20 +-------------------
 drivers/clk/mediatek/clk-mt7622-hif.c | 20 +-------------------
 drivers/clk/mediatek/clk-mt7622.c     | 20 +-------------------
 6 files changed, 6 insertions(+), 114 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt2701.c b/drivers/clk/mediatek/clk-mt2701.c
index ab6ab07f53e6..5dd8fb98ce49 100644
--- a/drivers/clk/mediatek/clk-mt2701.c
+++ b/drivers/clk/mediatek/clk-mt2701.c
@@ -1009,26 +1009,8 @@ static const struct of_device_id of_match_clk_mt2701[] = {
 	}
 };
 
-static int clk_mt2701_probe(struct platform_device *pdev)
-{
-	int (*clk_init)(struct platform_device *);
-	int r;
-
-	clk_init = of_device_get_match_data(&pdev->dev);
-	if (!clk_init)
-		return -EINVAL;
-
-	r = clk_init(pdev);
-	if (r)
-		dev_err(&pdev->dev,
-			"could not register clock provider: %s: %d\n",
-			pdev->name, r);
-
-	return r;
-}
-
 static struct platform_driver clk_mt2701_drv = {
-	.probe = clk_mt2701_probe,
+	.probe = platform_driver_probe_by_of_match_data,
 	.driver = {
 		.name = "clk-mt2701",
 		.of_match_table = of_match_clk_mt2701,
diff --git a/drivers/clk/mediatek/clk-mt2712.c b/drivers/clk/mediatek/clk-mt2712.c
index 991d4093726e..17c031d110ff 100644
--- a/drivers/clk/mediatek/clk-mt2712.c
+++ b/drivers/clk/mediatek/clk-mt2712.c
@@ -1441,26 +1441,8 @@ static const struct of_device_id of_match_clk_mt2712[] = {
 	}
 };
 
-static int clk_mt2712_probe(struct platform_device *pdev)
-{
-	int (*clk_probe)(struct platform_device *);
-	int r;
-
-	clk_probe = of_device_get_match_data(&pdev->dev);
-	if (!clk_probe)
-		return -EINVAL;
-
-	r = clk_probe(pdev);
-	if (r != 0)
-		dev_err(&pdev->dev,
-			"could not register clock provider: %s: %d\n",
-			pdev->name, r);
-
-	return r;
-}
-
 static struct platform_driver clk_mt2712_drv = {
-	.probe = clk_mt2712_probe,
+	.probe = platform_driver_probe_by_of_match_data,
 	.driver = {
 		.name = "clk-mt2712",
 		.owner = THIS_MODULE,
diff --git a/drivers/clk/mediatek/clk-mt6797.c b/drivers/clk/mediatek/clk-mt6797.c
index 5702bc974ed9..2d7ff3098cc9 100644
--- a/drivers/clk/mediatek/clk-mt6797.c
+++ b/drivers/clk/mediatek/clk-mt6797.c
@@ -680,26 +680,8 @@ static const struct of_device_id of_match_clk_mt6797[] = {
 	}
 };
 
-static int clk_mt6797_probe(struct platform_device *pdev)
-{
-	int (*clk_init)(struct platform_device *);
-	int r;
-
-	clk_init = of_device_get_match_data(&pdev->dev);
-	if (!clk_init)
-		return -EINVAL;
-
-	r = clk_init(pdev);
-	if (r)
-		dev_err(&pdev->dev,
-			"could not register clock provider: %s: %d\n",
-			pdev->name, r);
-
-	return r;
-}
-
 static struct platform_driver clk_mt6797_drv = {
-	.probe = clk_mt6797_probe,
+	.probe = platform_driver_probe_by_of_match_data,
 	.driver = {
 		.name = "clk-mt6797",
 		.of_match_table = of_match_clk_mt6797,
diff --git a/drivers/clk/mediatek/clk-mt7622-eth.c b/drivers/clk/mediatek/clk-mt7622-eth.c
index 6328127bbb3c..2ce825f19275 100644
--- a/drivers/clk/mediatek/clk-mt7622-eth.c
+++ b/drivers/clk/mediatek/clk-mt7622-eth.c
@@ -127,26 +127,8 @@ static const struct of_device_id of_match_clk_mt7622_eth[] = {
 	}
 };
 
-static int clk_mt7622_eth_probe(struct platform_device *pdev)
-{
-	int (*clk_init)(struct platform_device *);
-	int r;
-
-	clk_init = of_device_get_match_data(&pdev->dev);
-	if (!clk_init)
-		return -EINVAL;
-
-	r = clk_init(pdev);
-	if (r)
-		dev_err(&pdev->dev,
-			"could not register clock provider: %s: %d\n",
-			pdev->name, r);
-
-	return r;
-}
-
 static struct platform_driver clk_mt7622_eth_drv = {
-	.probe = clk_mt7622_eth_probe,
+	.probe = platform_driver_probe_by_of_match_data,
 	.driver = {
 		.name = "clk-mt7622-eth",
 		.of_match_table = of_match_clk_mt7622_eth,
diff --git a/drivers/clk/mediatek/clk-mt7622-hif.c b/drivers/clk/mediatek/clk-mt7622-hif.c
index a6e8534276c6..65f13808155d 100644
--- a/drivers/clk/mediatek/clk-mt7622-hif.c
+++ b/drivers/clk/mediatek/clk-mt7622-hif.c
@@ -140,26 +140,8 @@ static const struct of_device_id of_match_clk_mt7622_hif[] = {
 	}
 };
 
-static int clk_mt7622_hif_probe(struct platform_device *pdev)
-{
-	int (*clk_init)(struct platform_device *);
-	int r;
-
-	clk_init = of_device_get_match_data(&pdev->dev);
-	if (!clk_init)
-		return -EINVAL;
-
-	r = clk_init(pdev);
-	if (r)
-		dev_err(&pdev->dev,
-			"could not register clock provider: %s: %d\n",
-			pdev->name, r);
-
-	return r;
-}
-
 static struct platform_driver clk_mt7622_hif_drv = {
-	.probe = clk_mt7622_hif_probe,
+	.probe = platform_driver_probe_by_of_match_data,
 	.driver = {
 		.name = "clk-mt7622-hif",
 		.of_match_table = of_match_clk_mt7622_hif,
diff --git a/drivers/clk/mediatek/clk-mt7622.c b/drivers/clk/mediatek/clk-mt7622.c
index 92f7e32770c6..d7310fb5964f 100644
--- a/drivers/clk/mediatek/clk-mt7622.c
+++ b/drivers/clk/mediatek/clk-mt7622.c
@@ -746,26 +746,8 @@ static const struct of_device_id of_match_clk_mt7622[] = {
 	}
 };
 
-static int clk_mt7622_probe(struct platform_device *pdev)
-{
-	int (*clk_init)(struct platform_device *);
-	int r;
-
-	clk_init = of_device_get_match_data(&pdev->dev);
-	if (!clk_init)
-		return -EINVAL;
-
-	r = clk_init(pdev);
-	if (r)
-		dev_err(&pdev->dev,
-			"could not register clock provider: %s: %d\n",
-			pdev->name, r);
-
-	return r;
-}
-
 static struct platform_driver clk_mt7622_drv = {
-	.probe = clk_mt7622_probe,
+	.probe = platform_driver_probe_by_of_match_data,
 	.driver = {
 		.name = "clk-mt7622",
 		.of_match_table = of_match_clk_mt7622,
-- 
Sent by a computer through tubes
