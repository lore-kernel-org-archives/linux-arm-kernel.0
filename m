From: wfp5p@virginia.edu (Bill Pemberton)
Date: Mon, 19 Nov 2012 13:26:16 -0500
Subject: [PATCH 427/493] spi: remove use of __devexit
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Message-ID: <1353349642-3677-427-git-send-email-wfp5p@virginia.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_HOTPLUG is going away as an option so __devexit is no
longer needed.

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
 drivers/spi/spi-atmel.c          | 2 +-
 drivers/spi/spi-bcm63xx.c        | 2 +-
 drivers/spi/spi-bfin-sport.c     | 2 +-
 drivers/spi/spi-bfin5xx.c        | 2 +-
 drivers/spi/spi-coldfire-qspi.c  | 2 +-
 drivers/spi/spi-davinci.c        | 2 +-
 drivers/spi/spi-dw-mmio.c        | 2 +-
 drivers/spi/spi-dw-pci.c         | 2 +-
 drivers/spi/spi-dw.c             | 2 +-
 drivers/spi/spi-ep93xx.c         | 2 +-
 drivers/spi/spi-falcon.c         | 2 +-
 drivers/spi/spi-fsl-espi.c       | 2 +-
 drivers/spi/spi-fsl-lib.c        | 2 +-
 drivers/spi/spi-fsl-spi.c        | 4 ++--
 drivers/spi/spi-gpio.c           | 2 +-
 drivers/spi/spi-imx.c            | 2 +-
 drivers/spi/spi-mpc512x-psc.c    | 4 ++--
 drivers/spi/spi-mpc52xx-psc.c    | 2 +-
 drivers/spi/spi-mpc52xx.c        | 2 +-
 drivers/spi/spi-mxs.c            | 2 +-
 drivers/spi/spi-nuc900.c         | 2 +-
 drivers/spi/spi-oc-tiny.c        | 2 +-
 drivers/spi/spi-octeon.c         | 2 +-
 drivers/spi/spi-omap2-mcspi.c    | 2 +-
 drivers/spi/spi-pl022.c          | 2 +-
 drivers/spi/spi-pxa2xx-pci.c     | 2 +-
 drivers/spi/spi-rspi.c           | 4 ++--
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
 42 files changed, 46 insertions(+), 46 deletions(-)

diff --git a/drivers/spi/spi-altera.c b/drivers/spi/spi-altera.c
index a369d44..5e7314a 100644
--- a/drivers/spi/spi-altera.c
+++ b/drivers/spi/spi-altera.c
@@ -290,7 +290,7 @@ exit:
 	return err;
 }
 
-static int __devexit altera_spi_remove(struct platform_device *dev)
+static int altera_spi_remove(struct platform_device *dev)
 {
 	struct altera_spi *hw = platform_get_drvdata(dev);
 	struct spi_master *master = hw->bitbang.master;
diff --git a/drivers/spi/spi-ath79.c b/drivers/spi/spi-ath79.c
index 13e6866..9a5d779 100644
--- a/drivers/spi/spi-ath79.c
+++ b/drivers/spi/spi-ath79.c
@@ -251,7 +251,7 @@ err_put_master:
 	return ret;
 }
 
-static __devexit int ath79_spi_remove(struct platform_device *pdev)
+static int ath79_spi_remove(struct platform_device *pdev)
 {
 	struct ath79_spi *sp = platform_get_drvdata(pdev);
 
diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 6b19cca..75c0c4f 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -1003,7 +1003,7 @@ out_free:
 	return ret;
 }
 
-static int __devexit atmel_spi_remove(struct platform_device *pdev)
+static int atmel_spi_remove(struct platform_device *pdev)
 {
 	struct spi_master	*master = platform_get_drvdata(pdev);
 	struct atmel_spi	*as = spi_master_get_devdata(master);
diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index 73385be..f44ab55 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -449,7 +449,7 @@ out:
 	return ret;
 }
 
-static int __devexit bcm63xx_spi_remove(struct platform_device *pdev)
+static int bcm63xx_spi_remove(struct platform_device *pdev)
 {
 	struct spi_master *master = spi_master_get(platform_get_drvdata(pdev));
 	struct bcm63xx_spi *bs = spi_master_get_devdata(master);
diff --git a/drivers/spi/spi-bfin-sport.c b/drivers/spi/spi-bfin-sport.c
index 9b62c28..2a118de 100644
--- a/drivers/spi/spi-bfin-sport.c
+++ b/drivers/spi/spi-bfin-sport.c
@@ -863,7 +863,7 @@ bfin_sport_spi_probe(struct platform_device *pdev)
 }
 
 /* stop hardware and remove the driver */
-static int __devexit
+static int
 bfin_sport_spi_remove(struct platform_device *pdev)
 {
 	struct bfin_sport_spi_master_data *drv_data = platform_get_drvdata(pdev);
diff --git a/drivers/spi/spi-bfin5xx.c b/drivers/spi/spi-bfin5xx.c
index 5c35826..0429d83 100644
--- a/drivers/spi/spi-bfin5xx.c
+++ b/drivers/spi/spi-bfin5xx.c
@@ -1387,7 +1387,7 @@ out_error_get_res:
 }
 
 /* stop hardware and remove the driver */
-static int __devexit bfin_spi_remove(struct platform_device *pdev)
+static int bfin_spi_remove(struct platform_device *pdev)
 {
 	struct bfin_spi_master_data *drv_data = platform_get_drvdata(pdev);
 	int status = 0;
diff --git a/drivers/spi/spi-coldfire-qspi.c b/drivers/spi/spi-coldfire-qspi.c
index f586b3b..58466b8 100644
--- a/drivers/spi/spi-coldfire-qspi.c
+++ b/drivers/spi/spi-coldfire-qspi.c
@@ -515,7 +515,7 @@ fail0:
 	return status;
 }
 
-static int __devexit mcfqspi_remove(struct platform_device *pdev)
+static int mcfqspi_remove(struct platform_device *pdev)
 {
 	struct spi_master *master = platform_get_drvdata(pdev);
 	struct mcfqspi *mcfqspi = spi_master_get_devdata(master);
diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index c10be9f..13661e1 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -952,7 +952,7 @@ err:
  * It will also call spi_bitbang_stop to destroy the work queue which was
  * created by spi_bitbang_start.
  */
-static int __devexit davinci_spi_remove(struct platform_device *pdev)
+static int davinci_spi_remove(struct platform_device *pdev)
 {
 	struct davinci_spi *dspi;
 	struct spi_master *master;
diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index 9470c59..4a6d5c9 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -106,7 +106,7 @@ err_end:
 	return ret;
 }
 
-static int __devexit dw_spi_mmio_remove(struct platform_device *pdev)
+static int dw_spi_mmio_remove(struct platform_device *pdev)
 {
 	struct dw_spi_mmio *dwsmmio = platform_get_drvdata(pdev);
 	struct resource *mem;
diff --git a/drivers/spi/spi-dw-pci.c b/drivers/spi/spi-dw-pci.c
index d61d430..6055c8d 100644
--- a/drivers/spi/spi-dw-pci.c
+++ b/drivers/spi/spi-dw-pci.c
@@ -105,7 +105,7 @@ err_disable:
 	return ret;
 }
 
-static void __devexit spi_pci_remove(struct pci_dev *pdev)
+static void spi_pci_remove(struct pci_dev *pdev)
 {
 	struct dw_spi_pci *dwpci = pci_get_drvdata(pdev);
 
diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index 172b8b5..c1abc06 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -877,7 +877,7 @@ exit:
 }
 EXPORT_SYMBOL_GPL(dw_spi_add_host);
 
-void __devexit dw_spi_remove_host(struct dw_spi *dws)
+void dw_spi_remove_host(struct dw_spi *dws)
 {
 	int status = 0;
 
diff --git a/drivers/spi/spi-ep93xx.c b/drivers/spi/spi-ep93xx.c
index bb0eaf6..acb1e19 100644
--- a/drivers/spi/spi-ep93xx.c
+++ b/drivers/spi/spi-ep93xx.c
@@ -1138,7 +1138,7 @@ fail_release_master:
 	return error;
 }
 
-static int __devexit ep93xx_spi_remove(struct platform_device *pdev)
+static int ep93xx_spi_remove(struct platform_device *pdev)
 {
 	struct spi_master *master = platform_get_drvdata(pdev);
 	struct ep93xx_spi *espi = spi_master_get_devdata(master);
diff --git a/drivers/spi/spi-falcon.c b/drivers/spi/spi-falcon.c
index 891e91c..6a6f62e 100644
--- a/drivers/spi/spi-falcon.c
+++ b/drivers/spi/spi-falcon.c
@@ -438,7 +438,7 @@ static int falcon_sflash_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int __devexit falcon_sflash_remove(struct platform_device *pdev)
+static int falcon_sflash_remove(struct platform_device *pdev)
 {
 	struct falcon_sflash *priv = platform_get_drvdata(pdev);
 
diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index 498fff2..56e1002 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -725,7 +725,7 @@ err:
 	return ret;
 }
 
-static int __devexit of_fsl_espi_remove(struct platform_device *dev)
+static int of_fsl_espi_remove(struct platform_device *dev)
 {
 	return mpc8xxx_spi_remove(&dev->dev);
 }
diff --git a/drivers/spi/spi-fsl-lib.c b/drivers/spi/spi-fsl-lib.c
index abf2a20..8ade675 100644
--- a/drivers/spi/spi-fsl-lib.c
+++ b/drivers/spi/spi-fsl-lib.c
@@ -169,7 +169,7 @@ err:
 	return ret;
 }
 
-int __devexit mpc8xxx_spi_remove(struct device *dev)
+int mpc8xxx_spi_remove(struct device *dev)
 {
 	struct mpc8xxx_spi *mpc8xxx_spi;
 	struct spi_master *master;
diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
index a1e11f0..00aa65c 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -1081,7 +1081,7 @@ err:
 	return ret;
 }
 
-static int __devexit of_fsl_spi_remove(struct platform_device *ofdev)
+static int of_fsl_spi_remove(struct platform_device *ofdev)
 {
 	int ret;
 
@@ -1139,7 +1139,7 @@ static int plat_mpc8xxx_spi_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit plat_mpc8xxx_spi_remove(struct platform_device *pdev)
+static int plat_mpc8xxx_spi_remove(struct platform_device *pdev)
 {
 	return mpc8xxx_spi_remove(&pdev->dev);
 }
diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
index f4251df..995f265 100644
--- a/drivers/spi/spi-gpio.c
+++ b/drivers/spi/spi-gpio.c
@@ -485,7 +485,7 @@ gpio_free:
 	return status;
 }
 
-static int __devexit spi_gpio_remove(struct platform_device *pdev)
+static int spi_gpio_remove(struct platform_device *pdev)
 {
 	struct spi_gpio			*spi_gpio;
 	struct spi_gpio_platform_data	*pdata;
diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index dc0f99a..9049132 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -906,7 +906,7 @@ out_gpio_free:
 	return ret;
 }
 
-static int __devexit spi_imx_remove(struct platform_device *pdev)
+static int spi_imx_remove(struct platform_device *pdev)
 {
 	struct spi_master *master = platform_get_drvdata(pdev);
 	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
diff --git a/drivers/spi/spi-mpc512x-psc.c b/drivers/spi/spi-mpc512x-psc.c
index 599f0e5..cb3a310 100644
--- a/drivers/spi/spi-mpc512x-psc.c
+++ b/drivers/spi/spi-mpc512x-psc.c
@@ -492,7 +492,7 @@ free_master:
 	return ret;
 }
 
-static int __devexit mpc512x_psc_spi_do_remove(struct device *dev)
+static int mpc512x_psc_spi_do_remove(struct device *dev)
 {
 	struct spi_master *master = spi_master_get(dev_get_drvdata(dev));
 	struct mpc512x_psc_spi *mps = spi_master_get_devdata(master);
@@ -539,7 +539,7 @@ static int mpc512x_psc_spi_of_probe(struct platform_device *op)
 				irq_of_parse_and_map(op->dev.of_node, 0), id);
 }
 
-static int __devexit mpc512x_psc_spi_of_remove(struct platform_device *op)
+static int mpc512x_psc_spi_of_remove(struct platform_device *op)
 {
 	return mpc512x_psc_spi_do_remove(&op->dev);
 }
diff --git a/drivers/spi/spi-mpc52xx-psc.c b/drivers/spi/spi-mpc52xx-psc.c
index 43c2d27..291120b 100644
--- a/drivers/spi/spi-mpc52xx-psc.c
+++ b/drivers/spi/spi-mpc52xx-psc.c
@@ -479,7 +479,7 @@ static int mpc52xx_psc_spi_of_probe(struct platform_device *op)
 				irq_of_parse_and_map(op->dev.of_node, 0), id);
 }
 
-static int __devexit mpc52xx_psc_spi_of_remove(struct platform_device *op)
+static int mpc52xx_psc_spi_of_remove(struct platform_device *op)
 {
 	struct spi_master *master = spi_master_get(dev_get_drvdata(&op->dev));
 	struct mpc52xx_psc_spi *mps = spi_master_get_devdata(master);
diff --git a/drivers/spi/spi-mpc52xx.c b/drivers/spi/spi-mpc52xx.c
index 18c8865..29f7705 100644
--- a/drivers/spi/spi-mpc52xx.c
+++ b/drivers/spi/spi-mpc52xx.c
@@ -527,7 +527,7 @@ static int mpc52xx_spi_probe(struct platform_device *op)
 	return rc;
 }
 
-static int __devexit mpc52xx_spi_remove(struct platform_device *op)
+static int mpc52xx_spi_remove(struct platform_device *op)
 {
 	struct spi_master *master = spi_master_get(dev_get_drvdata(&op->dev));
 	struct mpc52xx_spi *ms = spi_master_get_devdata(master);
diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
index 82b4424..a3ede24 100644
--- a/drivers/spi/spi-mxs.c
+++ b/drivers/spi/spi-mxs.c
@@ -636,7 +636,7 @@ out_master_free:
 	return ret;
 }
 
-static int __devexit mxs_spi_remove(struct platform_device *pdev)
+static int mxs_spi_remove(struct platform_device *pdev)
 {
 	struct spi_master *master;
 	struct mxs_spi *spi;
diff --git a/drivers/spi/spi-nuc900.c b/drivers/spi/spi-nuc900.c
index b477317..b3f9ec8 100644
--- a/drivers/spi/spi-nuc900.c
+++ b/drivers/spi/spi-nuc900.c
@@ -453,7 +453,7 @@ err_nomem:
 	return err;
 }
 
-static int __devexit nuc900_spi_remove(struct platform_device *dev)
+static int nuc900_spi_remove(struct platform_device *dev)
 {
 	struct nuc900_spi *hw = platform_get_drvdata(dev);
 
diff --git a/drivers/spi/spi-oc-tiny.c b/drivers/spi/spi-oc-tiny.c
index a10e2af..432e66e 100644
--- a/drivers/spi/spi-oc-tiny.c
+++ b/drivers/spi/spi-oc-tiny.c
@@ -373,7 +373,7 @@ exit:
 	return err;
 }
 
-static int __devexit tiny_spi_remove(struct platform_device *pdev)
+static int tiny_spi_remove(struct platform_device *pdev)
 {
 	struct tiny_spi *hw = platform_get_drvdata(pdev);
 	struct spi_master *master = hw->bitbang.master;
diff --git a/drivers/spi/spi-octeon.c b/drivers/spi/spi-octeon.c
index 44847c8..24daf96 100644
--- a/drivers/spi/spi-octeon.c
+++ b/drivers/spi/spi-octeon.c
@@ -326,7 +326,7 @@ fail:
 	return err;
 }
 
-static int __devexit octeon_spi_remove(struct platform_device *pdev)
+static int octeon_spi_remove(struct platform_device *pdev)
 {
 	struct octeon_spi *p = platform_get_drvdata(pdev);
 	u64 register_base = p->register_base;
diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index e00c902..8f03860 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -1282,7 +1282,7 @@ free_master:
 	return status;
 }
 
-static int __devexit omap2_mcspi_remove(struct platform_device *pdev)
+static int omap2_mcspi_remove(struct platform_device *pdev)
 {
 	struct spi_master	*master;
 	struct omap2_mcspi	*mcspi;
diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index a797a1a..5733b28 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -2275,7 +2275,7 @@ pl022_probe(struct amba_device *adev, const struct amba_id *id)
 	return status;
 }
 
-static int __devexit
+static int
 pl022_remove(struct amba_device *adev)
 {
 	struct pl022 *pl022 = amba_get_drvdata(adev);
diff --git a/drivers/spi/spi-pxa2xx-pci.c b/drivers/spi/spi-pxa2xx-pci.c
index 8e64f10..cf95587 100644
--- a/drivers/spi/spi-pxa2xx-pci.c
+++ b/drivers/spi/spi-pxa2xx-pci.c
@@ -129,7 +129,7 @@ err_nomem:
 	return ret;
 }
 
-static void __devexit ce4100_spi_remove(struct pci_dev *dev)
+static void ce4100_spi_remove(struct pci_dev *dev)
 {
 	struct ce4100_info *spi_info;
 	struct ssp_device *ssp;
diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 6cdd25e..902f2fb 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -709,7 +709,7 @@ static int rspi_request_dma(struct rspi_data *rspi,
 	return 0;
 }
 
-static void __devexit rspi_release_dma(struct rspi_data *rspi)
+static void rspi_release_dma(struct rspi_data *rspi)
 {
 	if (rspi->chan_tx)
 		dma_release_channel(rspi->chan_tx);
@@ -717,7 +717,7 @@ static void __devexit rspi_release_dma(struct rspi_data *rspi)
 		dma_release_channel(rspi->chan_rx);
 }
 
-static int __devexit rspi_remove(struct platform_device *pdev)
+static int rspi_remove(struct platform_device *pdev)
 {
 	struct rspi_data *rspi = dev_get_drvdata(&pdev->dev);
 
diff --git a/drivers/spi/spi-s3c24xx.c b/drivers/spi/spi-s3c24xx.c
index 5a9da14..02d6460 100644
--- a/drivers/spi/spi-s3c24xx.c
+++ b/drivers/spi/spi-s3c24xx.c
@@ -663,7 +663,7 @@ static int s3c24xx_spi_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int __devexit s3c24xx_spi_remove(struct platform_device *dev)
+static int s3c24xx_spi_remove(struct platform_device *dev)
 {
 	struct s3c24xx_spi *hw = platform_get_drvdata(dev);
 
diff --git a/drivers/spi/spi-sh-hspi.c b/drivers/spi/spi-sh-hspi.c
index f536c48..5a64b0d 100644
--- a/drivers/spi/spi-sh-hspi.c
+++ b/drivers/spi/spi-sh-hspi.c
@@ -300,7 +300,7 @@ static int hspi_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int __devexit hspi_remove(struct platform_device *pdev)
+static int hspi_remove(struct platform_device *pdev)
 {
 	struct hspi_priv *hspi = dev_get_drvdata(&pdev->dev);
 
diff --git a/drivers/spi/spi-sh.c b/drivers/spi/spi-sh.c
index 3a22b1f..3c3600a 100644
--- a/drivers/spi/spi-sh.c
+++ b/drivers/spi/spi-sh.c
@@ -432,7 +432,7 @@ static irqreturn_t spi_sh_irq(int irq, void *_ss)
 	return IRQ_HANDLED;
 }
 
-static int __devexit spi_sh_remove(struct platform_device *pdev)
+static int spi_sh_remove(struct platform_device *pdev)
 {
 	struct spi_sh_data *ss = dev_get_drvdata(&pdev->dev);
 
diff --git a/drivers/spi/spi-sirf.c b/drivers/spi/spi-sirf.c
index 3b8e1d1..e0f43a5 100644
--- a/drivers/spi/spi-sirf.c
+++ b/drivers/spi/spi-sirf.c
@@ -604,7 +604,7 @@ err_cs:
 	return ret;
 }
 
-static int  __devexit spi_sirfsoc_remove(struct platform_device *pdev)
+static int  spi_sirfsoc_remove(struct platform_device *pdev)
 {
 	struct spi_master *master;
 	struct sirfsoc_spi *sspi;
diff --git a/drivers/spi/spi-stmp.c b/drivers/spi/spi-stmp.c
index 976d236..da57473 100644
--- a/drivers/spi/spi-stmp.c
+++ b/drivers/spi/spi-stmp.c
@@ -589,7 +589,7 @@ out0:
 	return err;
 }
 
-static int __devexit stmp_spi_remove(struct platform_device *dev)
+static int stmp_spi_remove(struct platform_device *dev)
 {
 	struct stmp_spi *ss;
 	struct spi_master *master;
diff --git a/drivers/spi/spi-tegra20-sflash.c b/drivers/spi/spi-tegra20-sflash.c
index 30995bf..448a8cc 100644
--- a/drivers/spi/spi-tegra20-sflash.c
+++ b/drivers/spi/spi-tegra20-sflash.c
@@ -575,7 +575,7 @@ exit_free_master:
 	return ret;
 }
 
-static int __devexit tegra_sflash_remove(struct platform_device *pdev)
+static int tegra_sflash_remove(struct platform_device *pdev)
 {
 	struct spi_master *master = dev_get_drvdata(&pdev->dev);
 	struct tegra_sflash_data	*tsd = spi_master_get_devdata(master);
diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20-slink.c
index cab1926..651167f 100644
--- a/drivers/spi/spi-tegra20-slink.c
+++ b/drivers/spi/spi-tegra20-slink.c
@@ -1261,7 +1261,7 @@ exit_free_master:
 	return ret;
 }
 
-static int __devexit tegra_slink_remove(struct platform_device *pdev)
+static int tegra_slink_remove(struct platform_device *pdev)
 {
 	struct spi_master *master = dev_get_drvdata(&pdev->dev);
 	struct tegra_slink_data	*tspi = spi_master_get_devdata(master);
diff --git a/drivers/spi/spi-ti-ssp.c b/drivers/spi/spi-ti-ssp.c
index 295bc8f..46992ca 100644
--- a/drivers/spi/spi-ti-ssp.c
+++ b/drivers/spi/spi-ti-ssp.c
@@ -357,7 +357,7 @@ error_wq:
 	return error;
 }
 
-static int __devexit ti_ssp_spi_remove(struct platform_device *pdev)
+static int ti_ssp_spi_remove(struct platform_device *pdev)
 {
 	struct ti_ssp_spi *hw = platform_get_drvdata(pdev);
 	int error;
diff --git a/drivers/spi/spi-tle62x0.c b/drivers/spi/spi-tle62x0.c
index 22f5ed8..6b0874d 100644
--- a/drivers/spi/spi-tle62x0.c
+++ b/drivers/spi/spi-tle62x0.c
@@ -294,7 +294,7 @@ static int tle62x0_probe(struct spi_device *spi)
 	return ret;
 }
 
-static int __devexit tle62x0_remove(struct spi_device *spi)
+static int tle62x0_remove(struct spi_device *spi)
 {
 	struct tle62x0_state *st = spi_get_drvdata(spi);
 	int ptr;
diff --git a/drivers/spi/spi-topcliff-pch.c b/drivers/spi/spi-topcliff-pch.c
index 12b3977..f756481 100644
--- a/drivers/spi/spi-topcliff-pch.c
+++ b/drivers/spi/spi-topcliff-pch.c
@@ -1498,7 +1498,7 @@ err_pci_iomap:
 	return ret;
 }
 
-static int __devexit pch_spi_pd_remove(struct platform_device *plat_dev)
+static int pch_spi_pd_remove(struct platform_device *plat_dev)
 {
 	struct pch_spi_board_data *board_dat = dev_get_platdata(&plat_dev->dev);
 	struct pch_spi_data *data = platform_get_drvdata(plat_dev);
@@ -1705,7 +1705,7 @@ err_no_mem:
 	return retval;
 }
 
-static void __devexit pch_spi_remove(struct pci_dev *pdev)
+static void pch_spi_remove(struct pci_dev *pdev)
 {
 	int i;
 	struct pch_pd_dev_save *pd_dev_save = pci_get_drvdata(pdev);
diff --git a/drivers/spi/spi-xcomm.c b/drivers/spi/spi-xcomm.c
index d17e04d..4d3ec8b 100644
--- a/drivers/spi/spi-xcomm.c
+++ b/drivers/spi/spi-xcomm.c
@@ -246,7 +246,7 @@ static int spi_xcomm_probe(struct i2c_client *i2c,
 	return ret;
 }
 
-static int __devexit spi_xcomm_remove(struct i2c_client *i2c)
+static int spi_xcomm_remove(struct i2c_client *i2c)
 {
 	struct spi_master *master = i2c_get_clientdata(i2c);
 
diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
index 7b6ff06..e1d7696 100644
--- a/drivers/spi/spi-xilinx.c
+++ b/drivers/spi/spi-xilinx.c
@@ -518,7 +518,7 @@ static int xilinx_spi_probe(struct platform_device *dev)
 	return 0;
 }
 
-static int __devexit xilinx_spi_remove(struct platform_device *dev)
+static int xilinx_spi_remove(struct platform_device *dev)
 {
 	xilinx_spi_deinit(platform_get_drvdata(dev));
 	platform_set_drvdata(dev, 0);
diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index e5e0214..2e0655d 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -622,7 +622,7 @@ static int spidev_probe(struct spi_device *spi)
 	return status;
 }
 
-static int __devexit spidev_remove(struct spi_device *spi)
+static int spidev_remove(struct spi_device *spi)
 {
 	struct spidev_data	*spidev = spi_get_drvdata(spi);
 
-- 
1.8.0
