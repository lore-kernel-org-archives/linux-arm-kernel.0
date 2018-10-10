From: lkundrak@v3.sk (Lubomir Rintel)
Date: Wed, 10 Oct 2018 19:09:28 +0200
Subject: [PATCH 03/11] spi: pxa2xx: Use an enum for type
In-Reply-To: <20181010170936.316862-1-lkundrak@v3.sk>
References: <20181010170936.316862-1-lkundrak@v3.sk>
Message-ID: <20181010170936.316862-4-lkundrak@v3.sk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

That seems to be the correct type.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/spi/spi-pxa2xx.c   | 6 +++---
 include/linux/pxa2xx_ssp.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 14f4ea59caff..f674541675bb 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1429,7 +1429,7 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
 	struct resource *res;
 	const struct acpi_device_id *adev_id = NULL;
 	const struct pci_device_id *pcidev_id = NULL;
-	int type;
+	enum pxa_ssp_type type;
 
 	adev = ACPI_COMPANION(&pdev->dev);
 
@@ -1443,9 +1443,9 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
 		return NULL;
 
 	if (adev_id)
-		type = (int)adev_id->driver_data;
+		type = (enum pxa_ssp_type)adev_id->driver_data;
 	else if (pcidev_id)
-		type = (int)pcidev_id->driver_data;
+		type = (enum pxa_ssp_type)pcidev_id->driver_data;
 	else
 		return NULL;
 
diff --git a/include/linux/pxa2xx_ssp.h b/include/linux/pxa2xx_ssp.h
index 13b4244d44c1..262e1f318836 100644
--- a/include/linux/pxa2xx_ssp.h
+++ b/include/linux/pxa2xx_ssp.h
@@ -217,7 +217,7 @@ struct ssp_device {
 
 	const char	*label;
 	int		port_id;
-	int		type;
+	enum pxa_ssp_type type;
 	int		use_count;
 	int		irq;
 
-- 
2.19.0
