From: wfp5p@virginia.edu (Bill Pemberton)
Date: Mon, 19 Nov 2012 13:21:30 -0500
Subject: [PATCH 141/493] spi: remove use of __devexit_p
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Message-ID: <1353349642-3677-141-git-send-email-wfp5p@virginia.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_HOTPLUG is going away as an option so __devexit_p is no longer
needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: Grant Likely <grant.likely@secretlab.ca> 
Cc: Wan ZongShun <mcuos.com@gmail.com> 
Cc: Eric Miao <eric.y.miao@gmail.com> 
Cc: Russell King <linux@arm.linux.org.uk> 
Cc: Haojian Zhuang <haojian.zhuang@gmail.com> 
Cc: Ben Dooks <ben-linux@fluff.org> 
Cc: Kukjin Kim <kgene.kim@samsung.com> 
Cc: Barry Song <baohua.song@csr.com> 
Cc: spi-devel-general at lists.sourceforge.net 
Cc: linux-arm-kernel at lists.infradead.org 
Cc: linux-samsung-soc at vger.kernel.org 
---
 drivers/spi/spi-altera.c         | 2 +-
 drivers/spi/spi-ath79.c          | 2 +-
 drivers/spi/spi-bcm63xx.c        | 2 +-
 drivers/spi/spi-bfin-sport.c     | 2 +-
 drivers/spi/spi-bfin5xx.c        | 2 +-
 drivers/spi/spi-coldfire-qspi.c  | 2 +-
 drivers/spi/spi-davinci.c        | 2 +-
 drivers/spi/spi-dw-mmio.c        | 2 +-
 drivers/spi/spi-dw-pci.c         | 2 +-
 drivers/spi/spi-ep93xx.c         | 2 +-
 drivers/spi/spi-falcon.c         | 2 +-
 drivers/spi/spi-fsl-espi.c       | 2 +-
 drivers/spi/spi-fsl-spi.c        | 4 ++--
 drivers/spi/spi-gpio.c           | 2 +-
 drivers/spi/spi-imx.c            | 2 +-
 drivers/spi/spi-mpc512x-psc.c    | 2 +-
 drivers/spi/spi-mpc52xx-psc.c    | 2 +-
 drivers/spi/spi-mpc52xx.c        | 2 +-
 drivers/spi/spi-mxs.c            | 2 +-
 drivers/spi/spi-nuc900.c         | 2 +-
 drivers/spi/spi-oc-tiny.c        | 2 +-
 drivers/spi/spi-octeon.c         | 2 +-
 drivers/spi/spi-omap2-mcspi.c    | 2 +-
 drivers/spi/spi-pl022.c          | 2 +-
 drivers/spi/spi-pxa2xx-pci.c     | 2 +-
 drivers/spi/spi-rspi.c           | 2 +-
 drivers/spi/spi-s3c24xx.c        | 2 +-
 drivers/spi/spi-sh-hspi.c        | 2 +-
 drivers/spi/spi-sh.c             | 2 +-
 drivers/spi/spi-sirf.c           | 2 +-
 drivers/spi/spi-stmp.c           | 2 +-
 drivers/spi/spi-tegra20-sflash.c | 2 +-
 drivers/spi/spi-tegra20-slink.c  | 2 +-
 drivers/spi/spi-ti-ssp.c         | 2 +-
 drivers/spi/spi-tle62x0.c        | 2 +-
 drivers/spi/spi-topcliff-pch.c   | 4 ++--
 drivers/spi/spi-xcomm.c          | 2 +-
 drivers/spi/spi-xilinx.c         | 2 +-
 drivers/spi/spidev.c             | 2 +-
 39 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/drivers/spi/spi-altera.c b/drivers/spi/spi-altera.c
index f1fec2a..7c63e71 100644
--- a/drivers/spi/spi-altera.c
+++ b/drivers/spi/spi-altera.c
@@ -311,7 +311,7 @@ MODULE_DEVICE_TABLE(of, altera_spi_match);
 
 static struct platform_driver altera_spi_driver = {
 	.probe = altera_spi_probe,
-	.remove = __devexit_p(altera_spi_remove),
+	.remove = altera_spi_remove,
 	.driver = {
 		.name = DRV_NAME,
 		.owner = THIS_MODULE,
diff --git a/drivers/spi/spi-ath79.c b/drivers/spi/spi-ath79.c
index 249077e..403b2d0 100644
--- a/drivers/spi/spi-ath79.c
+++ b/drivers/spi/spi-ath79.c
@@ -265,7 +265,7 @@ static __devexit int ath79_spi_remove(struct platform_device *pdev)
 
 static struct platform_driver ath79_spi_driver = {
 	.probe		= ath79_spi_probe,
-	.remove		= __devexit_p(ath79_spi_remove),
+	.remove		= ath79_spi_remove,
 	.driver		= {
 		.name	= DRV_NAME,
 		.owner	= THIS_MODULE,
diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index 6d97047..5f45c08 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -514,7 +514,7 @@ static struct platform_driver bcm63xx_spi_driver = {
 		.pm	= BCM63XX_SPI_PM_OPS,
 	},
 	.probe		= bcm63xx_spi_probe,
-	.remove		= __devexit_p(bcm63xx_spi_remove),
+	.remove		= bcm63xx_spi_remove,
 };
 
 module_platform_driver(bcm63xx_spi_driver);
diff --git a/drivers/spi/spi-bfin-sport.c b/drivers/spi/spi-bfin-sport.c
index 6555ecd..dbd244c 100644
--- a/drivers/spi/spi-bfin-sport.c
+++ b/drivers/spi/spi-bfin-sport.c
@@ -935,7 +935,7 @@ static struct platform_driver bfin_sport_spi_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe   = bfin_sport_spi_probe,
-	.remove  = __devexit_p(bfin_sport_spi_remove),
+	.remove  = bfin_sport_spi_remove,
 	.suspend = bfin_sport_spi_suspend,
 	.resume  = bfin_sport_spi_resume,
 };
diff --git a/drivers/spi/spi-bfin5xx.c b/drivers/spi/spi-bfin5xx.c
index 9bb4d4a..5c35826 100644
--- a/drivers/spi/spi-bfin5xx.c
+++ b/drivers/spi/spi-bfin5xx.c
@@ -1477,7 +1477,7 @@ static struct platform_driver bfin_spi_driver = {
 	},
 	.suspend	= bfin_spi_suspend,
 	.resume		= bfin_spi_resume,
-	.remove		= __devexit_p(bfin_spi_remove),
+	.remove		= bfin_spi_remove,
 };
 
 static int __init bfin_spi_init(void)
diff --git a/drivers/spi/spi-coldfire-qspi.c b/drivers/spi/spi-coldfire-qspi.c
index 764bfee..f94820b 100644
--- a/drivers/spi/spi-coldfire-qspi.c
+++ b/drivers/spi/spi-coldfire-qspi.c
@@ -594,7 +594,7 @@ static struct platform_driver mcfqspi_driver = {
 	.driver.owner	= THIS_MODULE,
 	.driver.pm	= &mcfqspi_pm,
 	.probe		= mcfqspi_probe,
-	.remove		= __devexit_p(mcfqspi_remove),
+	.remove		= mcfqspi_remove,
 };
 module_platform_driver(mcfqspi_driver);
 
diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index 147dfa8..d02f95c 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -980,7 +980,7 @@ static struct platform_driver davinci_spi_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = davinci_spi_probe,
-	.remove = __devexit_p(davinci_spi_remove),
+	.remove = davinci_spi_remove,
 };
 module_platform_driver(davinci_spi_driver);
 
diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index db2f1ba..86161e2 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -129,7 +129,7 @@ static int __devexit dw_spi_mmio_remove(struct platform_device *pdev)
 
 static struct platform_driver dw_spi_mmio_driver = {
 	.probe		= dw_spi_mmio_probe,
-	.remove		= __devexit_p(dw_spi_mmio_remove),
+	.remove		= dw_spi_mmio_remove,
 	.driver		= {
 		.name	= DRIVER_NAME,
 		.owner	= THIS_MODULE,
diff --git a/drivers/spi/spi-dw-pci.c b/drivers/spi/spi-dw-pci.c
index ff81abb..371cf72 100644
--- a/drivers/spi/spi-dw-pci.c
+++ b/drivers/spi/spi-dw-pci.c
@@ -159,7 +159,7 @@ static struct pci_driver dw_spi_driver = {
 	.name =		DRIVER_NAME,
 	.id_table =	pci_ids,
 	.probe =	spi_pci_probe,
-	.remove =	__devexit_p(spi_pci_remove),
+	.remove =	spi_pci_remove,
 	.suspend =	spi_suspend,
 	.resume	=	spi_resume,
 };
diff --git a/drivers/spi/spi-ep93xx.c b/drivers/spi/spi-ep93xx.c
index 3a21959..8a4fd41 100644
--- a/drivers/spi/spi-ep93xx.c
+++ b/drivers/spi/spi-ep93xx.c
@@ -1180,7 +1180,7 @@ static struct platform_driver ep93xx_spi_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= ep93xx_spi_probe,
-	.remove		= __devexit_p(ep93xx_spi_remove),
+	.remove		= ep93xx_spi_remove,
 };
 module_platform_driver(ep93xx_spi_driver);
 
diff --git a/drivers/spi/spi-falcon.c b/drivers/spi/spi-falcon.c
index 8f6aa73..a9ca966 100644
--- a/drivers/spi/spi-falcon.c
+++ b/drivers/spi/spi-falcon.c
@@ -455,7 +455,7 @@ MODULE_DEVICE_TABLE(of, falcon_sflash_match);
 
 static struct platform_driver falcon_sflash_driver = {
 	.probe	= falcon_sflash_probe,
-	.remove	= __devexit_p(falcon_sflash_remove),
+	.remove	= falcon_sflash_remove,
 	.driver = {
 		.name	= DRV_NAME,
 		.owner	= THIS_MODULE,
diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index 27bdc47..f1c98b896 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -743,7 +743,7 @@ static struct platform_driver fsl_espi_driver = {
 		.of_match_table = of_fsl_espi_match,
 	},
 	.probe		= of_fsl_espi_probe,
-	.remove		= __devexit_p(of_fsl_espi_remove),
+	.remove		= of_fsl_espi_remove,
 };
 module_platform_driver(fsl_espi_driver);
 
diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
index 6a62934..e026ee0a 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -1105,7 +1105,7 @@ static struct platform_driver of_fsl_spi_driver = {
 		.of_match_table = of_fsl_spi_match,
 	},
 	.probe		= of_fsl_spi_probe,
-	.remove		= __devexit_p(of_fsl_spi_remove),
+	.remove		= of_fsl_spi_remove,
 };
 
 #ifdef CONFIG_MPC832x_RDB
@@ -1147,7 +1147,7 @@ static int __devexit plat_mpc8xxx_spi_remove(struct platform_device *pdev)
 MODULE_ALIAS("platform:mpc8xxx_spi");
 static struct platform_driver mpc8xxx_spi_driver = {
 	.probe = plat_mpc8xxx_spi_probe,
-	.remove = __devexit_p(plat_mpc8xxx_spi_remove),
+	.remove = plat_mpc8xxx_spi_remove,
 	.driver = {
 		.name = "mpc8xxx_spi",
 		.owner = THIS_MODULE,
diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
index a2b50c5..3c66647 100644
--- a/drivers/spi/spi-gpio.c
+++ b/drivers/spi/spi-gpio.c
@@ -518,7 +518,7 @@ static struct platform_driver spi_gpio_driver = {
 		.of_match_table = of_match_ptr(spi_gpio_dt_ids),
 	},
 	.probe		= spi_gpio_probe,
-	.remove		= __devexit_p(spi_gpio_remove),
+	.remove		= spi_gpio_remove,
 };
 module_platform_driver(spi_gpio_driver);
 
diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index c9a0d84..5316213 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -942,7 +942,7 @@ static struct platform_driver spi_imx_driver = {
 		   },
 	.id_table = spi_imx_devtype,
 	.probe = spi_imx_probe,
-	.remove = __devexit_p(spi_imx_remove),
+	.remove = spi_imx_remove,
 };
 module_platform_driver(spi_imx_driver);
 
diff --git a/drivers/spi/spi-mpc512x-psc.c b/drivers/spi/spi-mpc512x-psc.c
index 0a1e39e..b1e8183 100644
--- a/drivers/spi/spi-mpc512x-psc.c
+++ b/drivers/spi/spi-mpc512x-psc.c
@@ -553,7 +553,7 @@ MODULE_DEVICE_TABLE(of, mpc512x_psc_spi_of_match);
 
 static struct platform_driver mpc512x_psc_spi_of_driver = {
 	.probe = mpc512x_psc_spi_of_probe,
-	.remove = __devexit_p(mpc512x_psc_spi_of_remove),
+	.remove = mpc512x_psc_spi_of_remove,
 	.driver = {
 		.name = "mpc512x-psc-spi",
 		.owner = THIS_MODULE,
diff --git a/drivers/spi/spi-mpc52xx-psc.c b/drivers/spi/spi-mpc52xx-psc.c
index bd47d26..5c67eb2 100644
--- a/drivers/spi/spi-mpc52xx-psc.c
+++ b/drivers/spi/spi-mpc52xx-psc.c
@@ -505,7 +505,7 @@ MODULE_DEVICE_TABLE(of, mpc52xx_psc_spi_of_match);
 
 static struct platform_driver mpc52xx_psc_spi_of_driver = {
 	.probe = mpc52xx_psc_spi_of_probe,
-	.remove = __devexit_p(mpc52xx_psc_spi_of_remove),
+	.remove = mpc52xx_psc_spi_of_remove,
 	.driver = {
 		.name = "mpc52xx-psc-spi",
 		.owner = THIS_MODULE,
diff --git a/drivers/spi/spi-mpc52xx.c b/drivers/spi/spi-mpc52xx.c
index 0454106..c4baba5 100644
--- a/drivers/spi/spi-mpc52xx.c
+++ b/drivers/spi/spi-mpc52xx.c
@@ -560,6 +560,6 @@ static struct platform_driver mpc52xx_spi_of_driver = {
 		.of_match_table = mpc52xx_spi_match,
 	},
 	.probe = mpc52xx_spi_probe,
-	.remove = __devexit_p(mpc52xx_spi_remove),
+	.remove = mpc52xx_spi_remove,
 };
 module_platform_driver(mpc52xx_spi_of_driver);
diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
index 86dd04d..476a855 100644
--- a/drivers/spi/spi-mxs.c
+++ b/drivers/spi/spi-mxs.c
@@ -659,7 +659,7 @@ static int __devexit mxs_spi_remove(struct platform_device *pdev)
 
 static struct platform_driver mxs_spi_driver = {
 	.probe	= mxs_spi_probe,
-	.remove	= __devexit_p(mxs_spi_remove),
+	.remove	= mxs_spi_remove,
 	.driver	= {
 		.name	= DRIVER_NAME,
 		.owner	= THIS_MODULE,
diff --git a/drivers/spi/spi-nuc900.c b/drivers/spi/spi-nuc900.c
index a6eca6f..8220291 100644
--- a/drivers/spi/spi-nuc900.c
+++ b/drivers/spi/spi-nuc900.c
@@ -477,7 +477,7 @@ static int __devexit nuc900_spi_remove(struct platform_device *dev)
 
 static struct platform_driver nuc900_spi_driver = {
 	.probe		= nuc900_spi_probe,
-	.remove		= __devexit_p(nuc900_spi_remove),
+	.remove		= nuc900_spi_remove,
 	.driver		= {
 		.name	= "nuc900-spi",
 		.owner	= THIS_MODULE,
diff --git a/drivers/spi/spi-oc-tiny.c b/drivers/spi/spi-oc-tiny.c
index 9d9071b..b468362 100644
--- a/drivers/spi/spi-oc-tiny.c
+++ b/drivers/spi/spi-oc-tiny.c
@@ -399,7 +399,7 @@ MODULE_DEVICE_TABLE(of, tiny_spi_match);
 
 static struct platform_driver tiny_spi_driver = {
 	.probe = tiny_spi_probe,
-	.remove = __devexit_p(tiny_spi_remove),
+	.remove = tiny_spi_remove,
 	.driver = {
 		.name = DRV_NAME,
 		.owner = THIS_MODULE,
diff --git a/drivers/spi/spi-octeon.c b/drivers/spi/spi-octeon.c
index ea8fb2e..95ef28d 100644
--- a/drivers/spi/spi-octeon.c
+++ b/drivers/spi/spi-octeon.c
@@ -352,7 +352,7 @@ static struct platform_driver octeon_spi_driver = {
 		.of_match_table = octeon_spi_match,
 	},
 	.probe		= octeon_spi_probe,
-	.remove		= __devexit_p(octeon_spi_remove),
+	.remove		= octeon_spi_remove,
 };
 
 module_platform_driver(octeon_spi_driver);
diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index cc4f2dd..130128c 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -1351,7 +1351,7 @@ static struct platform_driver omap2_mcspi_driver = {
 		.of_match_table = omap_mcspi_of_match,
 	},
 	.probe =	omap2_mcspi_probe,
-	.remove =	__devexit_p(omap2_mcspi_remove),
+	.remove =	omap2_mcspi_remove,
 };
 
 module_platform_driver(omap2_mcspi_driver);
diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index 1361868..0c25209 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -2484,7 +2484,7 @@ static struct amba_driver pl022_driver = {
 	},
 	.id_table	= pl022_ids,
 	.probe		= pl022_probe,
-	.remove		= __devexit_p(pl022_remove),
+	.remove		= pl022_remove,
 };
 
 static int __init pl022_init(void)
diff --git a/drivers/spi/spi-pxa2xx-pci.c b/drivers/spi/spi-pxa2xx-pci.c
index 9f6ba34..bd30ca0 100644
--- a/drivers/spi/spi-pxa2xx-pci.c
+++ b/drivers/spi/spi-pxa2xx-pci.c
@@ -161,7 +161,7 @@ static struct pci_driver ce4100_spi_driver = {
 	.name           = "ce4100_spi",
 	.id_table       = ce4100_spi_devices,
 	.probe          = ce4100_spi_probe,
-	.remove         = __devexit_p(ce4100_spi_remove),
+	.remove         = ce4100_spi_remove,
 };
 
 module_pci_driver(ce4100_spi_driver);
diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 30faf6d..e9e95fe 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -827,7 +827,7 @@ error1:
 
 static struct platform_driver rspi_driver = {
 	.probe =	rspi_probe,
-	.remove =	__devexit_p(rspi_remove),
+	.remove =	rspi_remove,
 	.driver		= {
 		.name = "rspi",
 		.owner	= THIS_MODULE,
diff --git a/drivers/spi/spi-s3c24xx.c b/drivers/spi/spi-s3c24xx.c
index a2a080b..50f5d93 100644
--- a/drivers/spi/spi-s3c24xx.c
+++ b/drivers/spi/spi-s3c24xx.c
@@ -722,7 +722,7 @@ static const struct dev_pm_ops s3c24xx_spi_pmops = {
 MODULE_ALIAS("platform:s3c2410-spi");
 static struct platform_driver s3c24xx_spi_driver = {
 	.probe		= s3c24xx_spi_probe,
-	.remove		= __devexit_p(s3c24xx_spi_remove),
+	.remove		= s3c24xx_spi_remove,
 	.driver		= {
 		.name	= "s3c2410-spi",
 		.owner	= THIS_MODULE,
diff --git a/drivers/spi/spi-sh-hspi.c b/drivers/spi/spi-sh-hspi.c
index 796c077..96963d7 100644
--- a/drivers/spi/spi-sh-hspi.c
+++ b/drivers/spi/spi-sh-hspi.c
@@ -314,7 +314,7 @@ static int __devexit hspi_remove(struct platform_device *pdev)
 
 static struct platform_driver hspi_driver = {
 	.probe = hspi_probe,
-	.remove = __devexit_p(hspi_remove),
+	.remove = hspi_remove,
 	.driver = {
 		.name = "sh-hspi",
 		.owner = THIS_MODULE,
diff --git a/drivers/spi/spi-sh.c b/drivers/spi/spi-sh.c
index 79442c3..6d779e2 100644
--- a/drivers/spi/spi-sh.c
+++ b/drivers/spi/spi-sh.c
@@ -539,7 +539,7 @@ static int __devinit spi_sh_probe(struct platform_device *pdev)
 
 static struct platform_driver spi_sh_driver = {
 	.probe = spi_sh_probe,
-	.remove = __devexit_p(spi_sh_remove),
+	.remove = spi_sh_remove,
 	.driver = {
 		.name = "sh_spi",
 		.owner = THIS_MODULE,
diff --git a/drivers/spi/spi-sirf.c b/drivers/spi/spi-sirf.c
index ecc3d97..2818b05 100644
--- a/drivers/spi/spi-sirf.c
+++ b/drivers/spi/spi-sirf.c
@@ -673,7 +673,7 @@ static struct platform_driver spi_sirfsoc_driver = {
 		.of_match_table = spi_sirfsoc_of_match,
 	},
 	.probe = spi_sirfsoc_probe,
-	.remove = __devexit_p(spi_sirfsoc_remove),
+	.remove = spi_sirfsoc_remove,
 };
 module_platform_driver(spi_sirfsoc_driver);
 
diff --git a/drivers/spi/spi-stmp.c b/drivers/spi/spi-stmp.c
index 911e904..3bd4f85 100644
--- a/drivers/spi/spi-stmp.c
+++ b/drivers/spi/spi-stmp.c
@@ -647,7 +647,7 @@ static int stmp_spi_resume(struct platform_device *pdev)
 
 static struct platform_driver stmp_spi_driver = {
 	.probe	= stmp_spi_probe,
-	.remove	= __devexit_p(stmp_spi_remove),
+	.remove	= stmp_spi_remove,
 	.driver = {
 		.name = "stmp3xxx_ssp",
 		.owner = THIS_MODULE,
diff --git a/drivers/spi/spi-tegra20-sflash.c b/drivers/spi/spi-tegra20-sflash.c
index 54eb948..60c2eaf 100644
--- a/drivers/spi/spi-tegra20-sflash.c
+++ b/drivers/spi/spi-tegra20-sflash.c
@@ -655,7 +655,7 @@ static struct platform_driver tegra_sflash_driver = {
 		.of_match_table	= of_match_ptr(tegra_sflash_of_match),
 	},
 	.probe =	tegra_sflash_probe,
-	.remove =	__devexit_p(tegra_sflash_remove),
+	.remove =	tegra_sflash_remove,
 };
 module_platform_driver(tegra_sflash_driver);
 
diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20-slink.c
index 7882b50..d581d7d 100644
--- a/drivers/spi/spi-tegra20-slink.c
+++ b/drivers/spi/spi-tegra20-slink.c
@@ -1348,7 +1348,7 @@ static struct platform_driver tegra_slink_driver = {
 		.of_match_table	= of_match_ptr(tegra_slink_of_match),
 	},
 	.probe =	tegra_slink_probe,
-	.remove =	__devexit_p(tegra_slink_remove),
+	.remove =	tegra_slink_remove,
 };
 module_platform_driver(tegra_slink_driver);
 
diff --git a/drivers/spi/spi-ti-ssp.c b/drivers/spi/spi-ti-ssp.c
index 3f6f6e8..d9fa150 100644
--- a/drivers/spi/spi-ti-ssp.c
+++ b/drivers/spi/spi-ti-ssp.c
@@ -378,7 +378,7 @@ static int __devexit ti_ssp_spi_remove(struct platform_device *pdev)
 
 static struct platform_driver ti_ssp_spi_driver = {
 	.probe		= ti_ssp_spi_probe,
-	.remove		= __devexit_p(ti_ssp_spi_remove),
+	.remove		= ti_ssp_spi_remove,
 	.driver		= {
 		.name	= "ti-ssp-spi",
 		.owner	= THIS_MODULE,
diff --git a/drivers/spi/spi-tle62x0.c b/drivers/spi/spi-tle62x0.c
index 2442102..a68cef9 100644
--- a/drivers/spi/spi-tle62x0.c
+++ b/drivers/spi/spi-tle62x0.c
@@ -313,7 +313,7 @@ static struct spi_driver tle62x0_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= tle62x0_probe,
-	.remove		= __devexit_p(tle62x0_remove),
+	.remove		= tle62x0_remove,
 };
 
 module_spi_driver(tle62x0_driver);
diff --git a/drivers/spi/spi-topcliff-pch.c b/drivers/spi/spi-topcliff-pch.c
index 135f740..6dd9f12 100644
--- a/drivers/spi/spi-topcliff-pch.c
+++ b/drivers/spi/spi-topcliff-pch.c
@@ -1619,7 +1619,7 @@ static struct platform_driver pch_spi_pd_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = pch_spi_pd_probe,
-	.remove = __devexit_p(pch_spi_pd_remove),
+	.remove = pch_spi_pd_remove,
 	.suspend = pch_spi_pd_suspend,
 	.resume = pch_spi_pd_resume
 };
@@ -1776,7 +1776,7 @@ static struct pci_driver pch_spi_pcidev_driver = {
 	.name = "pch_spi",
 	.id_table = pch_spi_pcidev_id,
 	.probe = pch_spi_probe,
-	.remove = __devexit_p(pch_spi_remove),
+	.remove = pch_spi_remove,
 	.suspend = pch_spi_suspend,
 	.resume = pch_spi_resume,
 };
diff --git a/drivers/spi/spi-xcomm.c b/drivers/spi/spi-xcomm.c
index 266a847..b413ee3 100644
--- a/drivers/spi/spi-xcomm.c
+++ b/drivers/spi/spi-xcomm.c
@@ -267,7 +267,7 @@ static struct i2c_driver spi_xcomm_driver = {
 	},
 	.id_table	= spi_xcomm_ids,
 	.probe		= spi_xcomm_probe,
-	.remove		= __devexit_p(spi_xcomm_remove),
+	.remove		= spi_xcomm_remove,
 };
 module_i2c_driver(spi_xcomm_driver);
 
diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
index 4c5a663..da5018e 100644
--- a/drivers/spi/spi-xilinx.c
+++ b/drivers/spi/spi-xilinx.c
@@ -531,7 +531,7 @@ MODULE_ALIAS("platform:" XILINX_SPI_NAME);
 
 static struct platform_driver xilinx_spi_driver = {
 	.probe = xilinx_spi_probe,
-	.remove = __devexit_p(xilinx_spi_remove),
+	.remove = xilinx_spi_remove,
 	.driver = {
 		.name = XILINX_SPI_NAME,
 		.owner = THIS_MODULE,
diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index e44abc9..253b2c7 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -658,7 +658,7 @@ static struct spi_driver spidev_spi_driver = {
 		.of_match_table = of_match_ptr(spidev_dt_ids),
 	},
 	.probe =	spidev_probe,
-	.remove =	__devexit_p(spidev_remove),
+	.remove =	spidev_remove,
 
 	/* NOTE:  suspend/resume methods are not necessary here.
 	 * We don't do anything except pass the requests to/from
-- 
1.8.0
