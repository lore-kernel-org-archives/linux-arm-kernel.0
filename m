From: hechtb@gmail.com (Bastian Hecht)
Date: Wed, 12 Dec 2012 12:54:46 +0100
Subject: [PATCH 1/4 v2] spi: sh-msiof: Remove unneeded clock name
Message-ID: <1355313289-29769-1-git-send-email-hechtb+renesas@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bastian Hecht <hechtb@gmail.com>

clk_get() no longer needs a character string for associating the right
clock as this is done via the device struct now.

Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
---
v2: no changes

 drivers/spi/spi-sh-msiof.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 1f466bc..96358d0 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -597,7 +597,6 @@ static int sh_msiof_spi_probe(struct platform_device *pdev)
 	struct resource	*r;
 	struct spi_master *master;
 	struct sh_msiof_spi_priv *p;
-	char clk_name[16];
 	int i;
 	int ret;
 
@@ -614,10 +613,9 @@ static int sh_msiof_spi_probe(struct platform_device *pdev)
 	p->info = pdev->dev.platform_data;
 	init_completion(&p->done);
 
-	snprintf(clk_name, sizeof(clk_name), "msiof%d", pdev->id);
-	p->clk = clk_get(&pdev->dev, clk_name);
+	p->clk = clk_get(&pdev->dev, NULL);
 	if (IS_ERR(p->clk)) {
-		dev_err(&pdev->dev, "cannot get clock \"%s\"\n", clk_name);
+		dev_err(&pdev->dev, "cannot get clock\n");
 		ret = PTR_ERR(p->clk);
 		goto err1;
 	}
-- 
1.7.9.5
