From: kbeldan@baylibre.com (Karl Beldan)
Date: Tue,  9 Aug 2016 17:15:15 +0000
Subject: [PATCH 1/4] memory: ti-aemif: Get a named clock rather than an
 unnamed one
In-Reply-To: <20160809171518.22690-1-kbeldan@baylibre.com>
References: <20160809171518.22690-1-kbeldan@baylibre.com>
Message-ID: <20160809171518.22690-2-kbeldan@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Many davinci boards (da830 and da850 families) don't have their clocks
in DT yet and won't be successful in getting an unnamed aemif clock.
Also the sole current users of ti-aemif (keystone boards) use 'aemif' as
their aemif device clock clock-name and should remain unaffected.

Signed-off-by: Karl Beldan <kbeldan@baylibre.com>
---
 drivers/memory/ti-aemif.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memory/ti-aemif.c b/drivers/memory/ti-aemif.c
index a579a0f..c251fc8 100644
--- a/drivers/memory/ti-aemif.c
+++ b/drivers/memory/ti-aemif.c
@@ -345,7 +345,7 @@ static int aemif_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, aemif);
 
-	aemif->clk = devm_clk_get(dev, NULL);
+	aemif->clk = devm_clk_get(dev, "aemif");
 	if (IS_ERR(aemif->clk)) {
 		dev_err(dev, "cannot get clock 'aemif'\n");
 		return PTR_ERR(aemif->clk);
-- 
2.9.2
