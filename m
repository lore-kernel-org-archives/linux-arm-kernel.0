From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Sun, 12 Jan 2014 12:13:36 +0100
Subject: [PATCH 3/9] spi: rspi: Use NULL as the clock ID
In-Reply-To: <1389525222-3482-1-git-send-email-geert@linux-m68k.org>
References: <1389525222-3482-1-git-send-email-geert@linux-m68k.org>
Message-ID: <1389525222-3482-4-git-send-email-geert@linux-m68k.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

There's only one RSPI/QSPI clock, so we can use NULL as the clock ID

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
---
 drivers/spi/spi-rspi.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index b6439c9505ac..6fd4770d22bd 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -1078,7 +1078,6 @@ static int rspi_probe(struct platform_device *pdev)
 	struct rspi_data *rspi;
 	int ret, irq;
 	unsigned int i;
-	char clk_name[16];
 	const struct rspi_plat_data *rspi_pd = dev_get_platdata(&pdev->dev);
 	const struct spi_ops *ops;
 	const struct platform_device_id *id_entry = pdev->id_entry;
@@ -1108,8 +1107,7 @@ static int rspi_probe(struct platform_device *pdev)
 		goto error1;
 	}
 
-	snprintf(clk_name, sizeof(clk_name), "%s%d", id_entry->name, pdev->id);
-	rspi->clk = devm_clk_get(&pdev->dev, clk_name);
+	rspi->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(rspi->clk)) {
 		dev_err(&pdev->dev, "cannot get clock\n");
 		ret = PTR_ERR(rspi->clk);
-- 
1.7.9.5
