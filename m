From: voice.shen@atmel.com (Bo Shen)
Date: Tue, 20 Nov 2012 16:38:17 +0800
Subject: [PATCH 1/2] ASoC: atmel-ssc: add phybase in device structure
Message-ID: <1353400698-19384-1-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Ferre <nicolas.ferre@atmel.com>

Useful for future dmaengine use.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/misc/atmel-ssc.c  |    2 ++
 include/linux/atmel-ssc.h |    1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/misc/atmel-ssc.c b/drivers/misc/atmel-ssc.c
index a769719..d07a9ed 100644
--- a/drivers/misc/atmel-ssc.c
+++ b/drivers/misc/atmel-ssc.c
@@ -157,6 +157,8 @@ static int ssc_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	ssc->phybase = regs->start;
+
 	ssc->clk = devm_clk_get(&pdev->dev, "pclk");
 	if (IS_ERR(ssc->clk)) {
 		dev_dbg(&pdev->dev, "no pclk clock defined\n");
diff --git a/include/linux/atmel-ssc.h b/include/linux/atmel-ssc.h
index 1ca0e32..deb0ae5 100644
--- a/include/linux/atmel-ssc.h
+++ b/include/linux/atmel-ssc.h
@@ -11,6 +11,7 @@ struct atmel_ssc_platform_data {
 
 struct ssc_device {
 	struct list_head	list;
+	resource_size_t		phybase;
 	void __iomem		*regs;
 	struct platform_device	*pdev;
 	struct atmel_ssc_platform_data *pdata;
-- 
1.7.9.5
