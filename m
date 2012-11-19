From: wfp5p@virginia.edu (Bill Pemberton)
Date: Mon, 19 Nov 2012 13:22:19 -0500
Subject: [PATCH 190/493] spi: remove use of __devinit
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Message-ID: <1353349642-3677-190-git-send-email-wfp5p@virginia.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_HOTPLUG is going away as an option so __devinit is no longer
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
 drivers/spi/spi-atmel.c          | 2 +-
 drivers/spi/spi-bcm63xx.c        | 2 +-
 drivers/spi/spi-bfin-sport.c     | 2 +-
 drivers/spi/spi-coldfire-qspi.c  | 2 +-
 drivers/spi/spi-davinci.c        | 2 +-
 drivers/spi/spi-dw-mmio.c        | 2 +-
 drivers/spi/spi-dw-pci.c         | 2 +-
 drivers/spi/spi-dw.c             | 4 ++--
 drivers/spi/spi-ep93xx.c         | 2 +-
 drivers/spi/spi-falcon.c         | 2 +-
 drivers/spi/spi-fsl-espi.c       | 4 ++--
 drivers/spi/spi-fsl-lib.c        | 2 +-
 drivers/spi/spi-fsl-spi.c        | 6 +++---
 drivers/spi/spi-gpio.c           | 6 +++---
 drivers/spi/spi-imx.c            | 2 +-
 drivers/spi/spi-mpc512x-psc.c    | 4 ++--
 drivers/spi/spi-mpc52xx-psc.c    | 4 ++--
 drivers/spi/spi-mpc52xx.c        | 2 +-
 drivers/spi/spi-mxs.c            | 2 +-
 drivers/spi/spi-nuc900.c         | 2 +-
 drivers/spi/spi-oc-tiny.c        | 6 +++---
 drivers/spi/spi-octeon.c         | 2 +-
 drivers/spi/spi-omap-100k.c      | 2 +-
 drivers/spi/spi-omap2-mcspi.c    | 4 ++--
 drivers/spi/spi-pl022.c          | 4 ++--
 drivers/spi/spi-pxa2xx-pci.c     | 2 +-
 drivers/spi/spi-pxa2xx.c         | 4 ++--
 drivers/spi/spi-rspi.c           | 4 ++--
 drivers/spi/spi-s3c24xx.c        | 2 +-
 drivers/spi/spi-s3c64xx.c        | 4 ++--
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
 drivers/spi/spi.c                | 2 +-
 drivers/spi/spidev.c             | 2 +-
 45 files changed, 61 insertions(+), 61 deletions(-)

diff --git a/drivers/spi/spi-altera.c b/drivers/spi/spi-altera.c
index 7c63e71..a369d44 100644
--- a/drivers/spi/spi-altera.c
+++ b/drivers/spi/spi-altera.c
@@ -215,7 +215,7 @@ static irqreturn_t altera_spi_irq(int irq, void *dev)
 	return IRQ_HANDLED;
 }
 
-static int __devinit altera_spi_probe(struct platform_device *pdev)
+static int altera_spi_probe(struct platform_device *pdev)
 {
 	struct altera_spi_platform_data *platp = pdev->dev.platform_data;
 	struct altera_spi *hw;
diff --git a/drivers/spi/spi-ath79.c b/drivers/spi/spi-ath79.c
index 403b2d0..13e6866 100644
--- a/drivers/spi/spi-ath79.c
+++ b/drivers/spi/spi-ath79.c
@@ -192,7 +192,7 @@ static u32 ath79_spi_txrx_mode0(struct spi_device *spi, unsigned nsecs,
 	return ath79_spi_rr(sp, AR71XX_SPI_REG_RDS);
 }
 
-static __devinit int ath79_spi_probe(struct platform_device *pdev)
+static int ath79_spi_probe(struct platform_device *pdev)
 {
 	struct spi_master *master;
 	struct ath79_spi *sp;
diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 61fb0ec..6b19cca 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -907,7 +907,7 @@ static void atmel_spi_cleanup(struct spi_device *spi)
 
 /*-------------------------------------------------------------------------*/
 
-static int __devinit atmel_spi_probe(struct platform_device *pdev)
+static int atmel_spi_probe(struct platform_device *pdev)
 {
 	struct resource		*regs;
 	int			irq;
diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index 5f45c08..73385be 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -329,7 +329,7 @@ static irqreturn_t bcm63xx_spi_interrupt(int irq, void *dev_id)
 }
 
 
-static int __devinit bcm63xx_spi_probe(struct platform_device *pdev)
+static int bcm63xx_spi_probe(struct platform_device *pdev)
 {
 	struct resource *r;
 	struct device *dev = &pdev->dev;
diff --git a/drivers/spi/spi-bfin-sport.c b/drivers/spi/spi-bfin-sport.c
index dbd244c..9b62c28 100644
--- a/drivers/spi/spi-bfin-sport.c
+++ b/drivers/spi/spi-bfin-sport.c
@@ -755,7 +755,7 @@ bfin_sport_spi_destroy_queue(struct bfin_sport_spi_master_data *drv_data)
 	return 0;
 }
 
-static int __devinit
+static int
 bfin_sport_spi_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
diff --git a/drivers/spi/spi-coldfire-qspi.c b/drivers/spi/spi-coldfire-qspi.c
index f94820b..f586b3b 100644
--- a/drivers/spi/spi-coldfire-qspi.c
+++ b/drivers/spi/spi-coldfire-qspi.c
@@ -401,7 +401,7 @@ static int mcfqspi_setup(struct spi_device *spi)
 	return 0;
 }
 
-static int __devinit mcfqspi_probe(struct platform_device *pdev)
+static int mcfqspi_probe(struct platform_device *pdev)
 {
 	struct spi_master *master;
 	struct mcfqspi *mcfqspi;
diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index d02f95c..c10be9f 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -769,7 +769,7 @@ rx_dma_failed:
  * It will invoke spi_bitbang_start to create work queue so that client driver
  * can register transfer method to work queue.
  */
-static int __devinit davinci_spi_probe(struct platform_device *pdev)
+static int davinci_spi_probe(struct platform_device *pdev)
 {
 	struct spi_master *master;
 	struct davinci_spi *dspi;
diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index 86161e2..9470c59 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -26,7 +26,7 @@ struct dw_spi_mmio {
 	struct clk     *clk;
 };
 
-static int __devinit dw_spi_mmio_probe(struct platform_device *pdev)
+static int dw_spi_mmio_probe(struct platform_device *pdev)
 {
 	struct dw_spi_mmio *dwsmmio;
 	struct dw_spi *dws;
diff --git a/drivers/spi/spi-dw-pci.c b/drivers/spi/spi-dw-pci.c
index 371cf72..d61d430 100644
--- a/drivers/spi/spi-dw-pci.c
+++ b/drivers/spi/spi-dw-pci.c
@@ -32,7 +32,7 @@ struct dw_spi_pci {
 	struct dw_spi	dws;
 };
 
-static int __devinit spi_pci_probe(struct pci_dev *pdev,
+static int spi_pci_probe(struct pci_dev *pdev,
 	const struct pci_device_id *ent)
 {
 	struct dw_spi_pci *dwpci;
diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index d1a495f..172b8b5 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -696,7 +696,7 @@ static void dw_spi_cleanup(struct spi_device *spi)
 	kfree(chip);
 }
 
-static int __devinit init_queue(struct dw_spi *dws)
+static int init_queue(struct dw_spi *dws)
 {
 	INIT_LIST_HEAD(&dws->queue);
 	spin_lock_init(&dws->lock);
@@ -795,7 +795,7 @@ static void spi_hw_init(struct dw_spi *dws)
 	}
 }
 
-int __devinit dw_spi_add_host(struct dw_spi *dws)
+int dw_spi_add_host(struct dw_spi *dws)
 {
 	struct spi_master *master;
 	int ret;
diff --git a/drivers/spi/spi-ep93xx.c b/drivers/spi/spi-ep93xx.c
index 8a4fd41..bb0eaf6 100644
--- a/drivers/spi/spi-ep93xx.c
+++ b/drivers/spi/spi-ep93xx.c
@@ -1023,7 +1023,7 @@ static void ep93xx_spi_release_dma(struct ep93xx_spi *espi)
 		free_page((unsigned long)espi->zeropage);
 }
 
-static int __devinit ep93xx_spi_probe(struct platform_device *pdev)
+static int ep93xx_spi_probe(struct platform_device *pdev)
 {
 	struct spi_master *master;
 	struct ep93xx_spi_info *info;
diff --git a/drivers/spi/spi-falcon.c b/drivers/spi/spi-falcon.c
index a9ca966..891e91c 100644
--- a/drivers/spi/spi-falcon.c
+++ b/drivers/spi/spi-falcon.c
@@ -403,7 +403,7 @@ static int falcon_sflash_xfer_one(struct spi_master *master,
 	return 0;
 }
 
-static int __devinit falcon_sflash_probe(struct platform_device *pdev)
+static int falcon_sflash_probe(struct platform_device *pdev)
 {
 	struct falcon_sflash *priv;
 	struct spi_master *master;
diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index f1c98b896..498fff2 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -587,7 +587,7 @@ static void fsl_espi_remove(struct mpc8xxx_spi *mspi)
 	iounmap(mspi->reg_base);
 }
 
-static struct spi_master * __devinit fsl_espi_probe(struct device *dev,
+static struct spi_master *fsl_espi_probe(struct device *dev,
 		struct resource *mem, unsigned int irq)
 {
 	struct fsl_spi_platform_data *pdata = dev->platform_data;
@@ -686,7 +686,7 @@ static int of_fsl_espi_get_chipselects(struct device *dev)
 	return 0;
 }
 
-static int __devinit of_fsl_espi_probe(struct platform_device *ofdev)
+static int of_fsl_espi_probe(struct platform_device *ofdev)
 {
 	struct device *dev = &ofdev->dev;
 	struct device_node *np = ofdev->dev.of_node;
diff --git a/drivers/spi/spi-fsl-lib.c b/drivers/spi/spi-fsl-lib.c
index 1503574..abf2a20 100644
--- a/drivers/spi/spi-fsl-lib.c
+++ b/drivers/spi/spi-fsl-lib.c
@@ -189,7 +189,7 @@ int __devexit mpc8xxx_spi_remove(struct device *dev)
 	return 0;
 }
 
-int __devinit of_mpc8xxx_spi_probe(struct platform_device *ofdev)
+int of_mpc8xxx_spi_probe(struct platform_device *ofdev)
 {
 	struct device *dev = &ofdev->dev;
 	struct device_node *np = ofdev->dev.of_node;
diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
index e026ee0a..a1e11f0 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -843,7 +843,7 @@ static void fsl_spi_remove(struct mpc8xxx_spi *mspi)
 	fsl_spi_cpm_free(mspi);
 }
 
-static struct spi_master * __devinit fsl_spi_probe(struct device *dev,
+static struct spi_master *fsl_spi_probe(struct device *dev,
 		struct resource *mem, unsigned int irq)
 {
 	struct fsl_spi_platform_data *pdata = dev->platform_data;
@@ -1041,7 +1041,7 @@ static int of_fsl_spi_free_chipselects(struct device *dev)
 	return 0;
 }
 
-static int __devinit of_fsl_spi_probe(struct platform_device *ofdev)
+static int of_fsl_spi_probe(struct platform_device *ofdev)
 {
 	struct device *dev = &ofdev->dev;
 	struct device_node *np = ofdev->dev.of_node;
@@ -1116,7 +1116,7 @@ static struct platform_driver of_fsl_spi_driver = {
  * tree can work with OpenFirmware driver. But for now we support old trees
  * as well.
  */
-static int __devinit plat_mpc8xxx_spi_probe(struct platform_device *pdev)
+static int plat_mpc8xxx_spi_probe(struct platform_device *pdev)
 {
 	struct resource *mem;
 	int irq;
diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
index 3c66647..f4251df 100644
--- a/drivers/spi/spi-gpio.c
+++ b/drivers/spi/spi-gpio.c
@@ -287,7 +287,7 @@ static void spi_gpio_cleanup(struct spi_device *spi)
 	spi_bitbang_cleanup(spi);
 }
 
-static int __devinit spi_gpio_alloc(unsigned pin, const char *label, bool is_in)
+static int spi_gpio_alloc(unsigned pin, const char *label, bool is_in)
 {
 	int value;
 
@@ -301,7 +301,7 @@ static int __devinit spi_gpio_alloc(unsigned pin, const char *label, bool is_in)
 	return value;
 }
 
-static int __devinit
+static int
 spi_gpio_request(struct spi_gpio_platform_data *pdata, const char *label,
 	u16 *res_flags)
 {
@@ -392,7 +392,7 @@ static inline int spi_gpio_probe_dt(struct platform_device *pdev)
 }
 #endif
 
-static int __devinit spi_gpio_probe(struct platform_device *pdev)
+static int spi_gpio_probe(struct platform_device *pdev)
 {
 	int				status;
 	struct spi_master		*master;
diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 5316213..dc0f99a 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -750,7 +750,7 @@ static void spi_imx_cleanup(struct spi_device *spi)
 {
 }
 
-static int __devinit spi_imx_probe(struct platform_device *pdev)
+static int spi_imx_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	const struct of_device_id *of_id =
diff --git a/drivers/spi/spi-mpc512x-psc.c b/drivers/spi/spi-mpc512x-psc.c
index b1e8183..599f0e5 100644
--- a/drivers/spi/spi-mpc512x-psc.c
+++ b/drivers/spi/spi-mpc512x-psc.c
@@ -406,7 +406,7 @@ static irqreturn_t mpc512x_psc_spi_isr(int irq, void *dev_id)
 }
 
 /* bus_num is used only for the case dev->platform_data == NULL */
-static int __devinit mpc512x_psc_spi_do_probe(struct device *dev, u32 regaddr,
+static int mpc512x_psc_spi_do_probe(struct device *dev, u32 regaddr,
 					      u32 size, unsigned int irq,
 					      s16 bus_num)
 {
@@ -508,7 +508,7 @@ static int __devexit mpc512x_psc_spi_do_remove(struct device *dev)
 	return 0;
 }
 
-static int __devinit mpc512x_psc_spi_of_probe(struct platform_device *op)
+static int mpc512x_psc_spi_of_probe(struct platform_device *op)
 {
 	const u32 *regaddr_p;
 	u64 regaddr64, size64;
diff --git a/drivers/spi/spi-mpc52xx-psc.c b/drivers/spi/spi-mpc52xx-psc.c
index 5c67eb2..43c2d27 100644
--- a/drivers/spi/spi-mpc52xx-psc.c
+++ b/drivers/spi/spi-mpc52xx-psc.c
@@ -363,7 +363,7 @@ static irqreturn_t mpc52xx_psc_spi_isr(int irq, void *dev_id)
 }
 
 /* bus_num is used only for the case dev->platform_data == NULL */
-static int __devinit mpc52xx_psc_spi_do_probe(struct device *dev, u32 regaddr,
+static int mpc52xx_psc_spi_do_probe(struct device *dev, u32 regaddr,
 				u32 size, unsigned int irq, s16 bus_num)
 {
 	struct fsl_spi_platform_data *pdata = dev->platform_data;
@@ -450,7 +450,7 @@ free_master:
 	return ret;
 }
 
-static int __devinit mpc52xx_psc_spi_of_probe(struct platform_device *op)
+static int mpc52xx_psc_spi_of_probe(struct platform_device *op)
 {
 	const u32 *regaddr_p;
 	u64 regaddr64, size64;
diff --git a/drivers/spi/spi-mpc52xx.c b/drivers/spi/spi-mpc52xx.c
index c4baba5..8b3c7da 100644
--- a/drivers/spi/spi-mpc52xx.c
+++ b/drivers/spi/spi-mpc52xx.c
@@ -390,7 +390,7 @@ static int mpc52xx_spi_transfer(struct spi_device *spi, struct spi_message *m)
 /*
  * OF Platform Bus Binding
  */
-static int __devinit mpc52xx_spi_probe(struct platform_device *op)
+static int mpc52xx_spi_probe(struct platform_device *op)
 {
 	struct spi_master *master;
 	struct mpc52xx_spi *ms;
diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
index 476a855..82b4424 100644
--- a/drivers/spi/spi-mxs.c
+++ b/drivers/spi/spi-mxs.c
@@ -509,7 +509,7 @@ static const struct of_device_id mxs_spi_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, mxs_spi_dt_ids);
 
-static int __devinit mxs_spi_probe(struct platform_device *pdev)
+static int mxs_spi_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *of_id =
 			of_match_device(mxs_spi_dt_ids, &pdev->dev);
diff --git a/drivers/spi/spi-nuc900.c b/drivers/spi/spi-nuc900.c
index 8220291..b477317 100644
--- a/drivers/spi/spi-nuc900.c
+++ b/drivers/spi/spi-nuc900.c
@@ -346,7 +346,7 @@ static void nuc900_init_spi(struct nuc900_spi *hw)
 	nuc900_enable_int(hw);
 }
 
-static int __devinit nuc900_spi_probe(struct platform_device *pdev)
+static int nuc900_spi_probe(struct platform_device *pdev)
 {
 	struct nuc900_spi *hw;
 	struct spi_master *master;
diff --git a/drivers/spi/spi-oc-tiny.c b/drivers/spi/spi-oc-tiny.c
index b468362..a10e2af 100644
--- a/drivers/spi/spi-oc-tiny.c
+++ b/drivers/spi/spi-oc-tiny.c
@@ -243,7 +243,7 @@ static irqreturn_t tiny_spi_irq(int irq, void *dev)
 #ifdef CONFIG_OF
 #include <linux/of_gpio.h>
 
-static int __devinit tiny_spi_of_probe(struct platform_device *pdev)
+static int tiny_spi_of_probe(struct platform_device *pdev)
 {
 	struct tiny_spi *hw = platform_get_drvdata(pdev);
 	struct device_node *np = pdev->dev.of_node;
@@ -277,13 +277,13 @@ static int __devinit tiny_spi_of_probe(struct platform_device *pdev)
 	return 0;
 }
 #else /* !CONFIG_OF */
-static int __devinit tiny_spi_of_probe(struct platform_device *pdev)
+static int tiny_spi_of_probe(struct platform_device *pdev)
 {
 	return 0;
 }
 #endif /* CONFIG_OF */
 
-static int __devinit tiny_spi_probe(struct platform_device *pdev)
+static int tiny_spi_probe(struct platform_device *pdev)
 {
 	struct tiny_spi_platform_data *platp = pdev->dev.platform_data;
 	struct tiny_spi *hw;
diff --git a/drivers/spi/spi-octeon.c b/drivers/spi/spi-octeon.c
index 95ef28d..44847c8 100644
--- a/drivers/spi/spi-octeon.c
+++ b/drivers/spi/spi-octeon.c
@@ -266,7 +266,7 @@ static int octeon_spi_nop_transfer_hardware(struct spi_master *master)
 	return 0;
 }
 
-static int __devinit octeon_spi_probe(struct platform_device *pdev)
+static int octeon_spi_probe(struct platform_device *pdev)
 {
 
 	struct resource *res_mem;
diff --git a/drivers/spi/spi-omap-100k.c b/drivers/spi/spi-omap-100k.c
index dfb4b7f..3aef7fa 100644
--- a/drivers/spi/spi-omap-100k.c
+++ b/drivers/spi/spi-omap-100k.c
@@ -486,7 +486,7 @@ static int __init omap1_spi100k_reset(struct omap1_spi100k *spi100k)
 	return 0;
 }
 
-static int __devinit omap1_spi100k_probe(struct platform_device *pdev)
+static int omap1_spi100k_probe(struct platform_device *pdev)
 {
 	struct spi_master       *master;
 	struct omap1_spi100k    *spi100k;
diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 130128c..e00c902 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -1092,7 +1092,7 @@ static int omap2_mcspi_transfer_one_message(struct spi_master *master,
 	return 0;
 }
 
-static int __devinit omap2_mcspi_master_setup(struct omap2_mcspi *mcspi)
+static int omap2_mcspi_master_setup(struct omap2_mcspi *mcspi)
 {
 	struct spi_master	*master = mcspi->master;
 	struct omap2_mcspi_regs	*ctx = &mcspi->ctx;
@@ -1145,7 +1145,7 @@ static const struct of_device_id omap_mcspi_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, omap_mcspi_of_match);
 
-static int __devinit omap2_mcspi_probe(struct platform_device *pdev)
+static int omap2_mcspi_probe(struct platform_device *pdev)
 {
 	struct spi_master	*master;
 	const struct omap2_mcspi_platform_config *pdata;
diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index 0c25209..a797a1a 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -1089,7 +1089,7 @@ err_alloc_rx_sg:
 	return -ENOMEM;
 }
 
-static int __devinit pl022_dma_probe(struct pl022 *pl022)
+static int pl022_dma_probe(struct pl022 *pl022)
 {
 	dma_cap_mask_t mask;
 
@@ -2058,7 +2058,7 @@ pl022_platform_data_dt_get(struct device *dev)
 	return pd;
 }
 
-static int __devinit
+static int
 pl022_probe(struct amba_device *adev, const struct amba_id *id)
 {
 	struct device *dev = &adev->dev;
diff --git a/drivers/spi/spi-pxa2xx-pci.c b/drivers/spi/spi-pxa2xx-pci.c
index bd30ca0..8e64f10 100644
--- a/drivers/spi/spi-pxa2xx-pci.c
+++ b/drivers/spi/spi-pxa2xx-pci.c
@@ -51,7 +51,7 @@ void pxa_ssp_free(struct ssp_device *ssp)
 }
 EXPORT_SYMBOL_GPL(pxa_ssp_free);
 
-static int __devinit ce4100_spi_probe(struct pci_dev *dev,
+static int ce4100_spi_probe(struct pci_dev *dev,
 		const struct pci_device_id *ent)
 {
 	int ret;
diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index dc25bee..5c8c4f5 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1438,7 +1438,7 @@ static void cleanup(struct spi_device *spi)
 	kfree(chip);
 }
 
-static int __devinit init_queue(struct driver_data *drv_data)
+static int init_queue(struct driver_data *drv_data)
 {
 	INIT_LIST_HEAD(&drv_data->queue);
 	spin_lock_init(&drv_data->lock);
@@ -1526,7 +1526,7 @@ static int destroy_queue(struct driver_data *drv_data)
 	return 0;
 }
 
-static int __devinit pxa2xx_spi_probe(struct platform_device *pdev)
+static int pxa2xx_spi_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct pxa2xx_spi_master *platform_info;
diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index e9e95fe..6cdd25e 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -661,7 +661,7 @@ static irqreturn_t rspi_irq(int irq, void *_sr)
 	return ret;
 }
 
-static int __devinit rspi_request_dma(struct rspi_data *rspi,
+static int rspi_request_dma(struct rspi_data *rspi,
 				      struct platform_device *pdev)
 {
 	struct rspi_plat_data *rspi_pd = pdev->dev.platform_data;
@@ -731,7 +731,7 @@ static int __devexit rspi_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devinit rspi_probe(struct platform_device *pdev)
+static int rspi_probe(struct platform_device *pdev)
 {
 	struct resource *res;
 	struct spi_master *master;
diff --git a/drivers/spi/spi-s3c24xx.c b/drivers/spi/spi-s3c24xx.c
index 50f5d93..5a9da14 100644
--- a/drivers/spi/spi-s3c24xx.c
+++ b/drivers/spi/spi-s3c24xx.c
@@ -506,7 +506,7 @@ static void s3c24xx_spi_initialsetup(struct s3c24xx_spi *hw)
 	}
 }
 
-static int __devinit s3c24xx_spi_probe(struct platform_device *pdev)
+static int s3c24xx_spi_probe(struct platform_device *pdev)
 {
 	struct s3c2410_spi_info *pdata;
 	struct s3c24xx_spi *hw;
diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index ae8b978..ad93231 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1054,7 +1054,7 @@ static void s3c64xx_spi_hwinit(struct s3c64xx_spi_driver_data *sdd, int channel)
 	flush_fifo(sdd);
 }
 
-static int __devinit s3c64xx_spi_get_dmares(
+static int s3c64xx_spi_get_dmares(
 			struct s3c64xx_spi_driver_data *sdd, bool tx)
 {
 	struct platform_device *pdev = sdd->pdev;
@@ -1133,7 +1133,7 @@ static void s3c64xx_spi_dt_gpio_free(struct s3c64xx_spi_driver_data *sdd)
 		gpio_free(sdd->gpios[idx]);
 }
 
-static struct __devinit s3c64xx_spi_info * s3c64xx_spi_parse_dt(
+static struct s3c64xx_spi_info * s3c64xx_spi_parse_dt(
 						struct device *dev)
 {
 	struct s3c64xx_spi_info *sci;
diff --git a/drivers/spi/spi-sh-hspi.c b/drivers/spi/spi-sh-hspi.c
index 96963d7..f536c48 100644
--- a/drivers/spi/spi-sh-hspi.c
+++ b/drivers/spi/spi-sh-hspi.c
@@ -229,7 +229,7 @@ static void hspi_cleanup(struct spi_device *spi)
 	dev_dbg(dev, "%s cleanup\n", spi->modalias);
 }
 
-static int __devinit hspi_probe(struct platform_device *pdev)
+static int hspi_probe(struct platform_device *pdev)
 {
 	struct resource *res;
 	struct spi_master *master;
diff --git a/drivers/spi/spi-sh.c b/drivers/spi/spi-sh.c
index 6d779e2..3a22b1f 100644
--- a/drivers/spi/spi-sh.c
+++ b/drivers/spi/spi-sh.c
@@ -444,7 +444,7 @@ static int __devexit spi_sh_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devinit spi_sh_probe(struct platform_device *pdev)
+static int spi_sh_probe(struct platform_device *pdev)
 {
 	struct resource *res;
 	struct spi_master *master;
diff --git a/drivers/spi/spi-sirf.c b/drivers/spi/spi-sirf.c
index 2818b05..3b8e1d1 100644
--- a/drivers/spi/spi-sirf.c
+++ b/drivers/spi/spi-sirf.c
@@ -479,7 +479,7 @@ static int spi_sirfsoc_setup(struct spi_device *spi)
 	return spi_sirfsoc_setup_transfer(spi, NULL);
 }
 
-static int __devinit spi_sirfsoc_probe(struct platform_device *pdev)
+static int spi_sirfsoc_probe(struct platform_device *pdev)
 {
 	struct sirfsoc_spi *sspi;
 	struct spi_master *master;
diff --git a/drivers/spi/spi-stmp.c b/drivers/spi/spi-stmp.c
index 3bd4f85..976d236 100644
--- a/drivers/spi/spi-stmp.c
+++ b/drivers/spi/spi-stmp.c
@@ -450,7 +450,7 @@ static irqreturn_t stmp_spi_irq_err(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int __devinit stmp_spi_probe(struct platform_device *dev)
+static int stmp_spi_probe(struct platform_device *dev)
 {
 	int err = 0;
 	struct spi_master *master;
diff --git a/drivers/spi/spi-tegra20-sflash.c b/drivers/spi/spi-tegra20-sflash.c
index 60c2eaf..ae4b7c2 100644
--- a/drivers/spi/spi-tegra20-sflash.c
+++ b/drivers/spi/spi-tegra20-sflash.c
@@ -457,7 +457,7 @@ static struct of_device_id tegra_sflash_of_match[] __devinitconst = {
 };
 MODULE_DEVICE_TABLE(of, tegra_sflash_of_match);
 
-static int __devinit tegra_sflash_probe(struct platform_device *pdev)
+static int tegra_sflash_probe(struct platform_device *pdev)
 {
 	struct spi_master	*master;
 	struct tegra_sflash_data	*tsd;
diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20-slink.c
index d581d7d..c0450e0 100644
--- a/drivers/spi/spi-tegra20-slink.c
+++ b/drivers/spi/spi-tegra20-slink.c
@@ -1115,7 +1115,7 @@ static struct of_device_id tegra_slink_of_match[] __devinitconst = {
 };
 MODULE_DEVICE_TABLE(of, tegra_slink_of_match);
 
-static int __devinit tegra_slink_probe(struct platform_device *pdev)
+static int tegra_slink_probe(struct platform_device *pdev)
 {
 	struct spi_master	*master;
 	struct tegra_slink_data	*tspi;
diff --git a/drivers/spi/spi-ti-ssp.c b/drivers/spi/spi-ti-ssp.c
index d9fa150..295bc8f 100644
--- a/drivers/spi/spi-ti-ssp.c
+++ b/drivers/spi/spi-ti-ssp.c
@@ -289,7 +289,7 @@ error_unlock:
 	return error;
 }
 
-static int __devinit ti_ssp_spi_probe(struct platform_device *pdev)
+static int ti_ssp_spi_probe(struct platform_device *pdev)
 {
 	const struct ti_ssp_spi_data *pdata;
 	struct ti_ssp_spi *hw;
diff --git a/drivers/spi/spi-tle62x0.c b/drivers/spi/spi-tle62x0.c
index a68cef9..22f5ed8 100644
--- a/drivers/spi/spi-tle62x0.c
+++ b/drivers/spi/spi-tle62x0.c
@@ -240,7 +240,7 @@ static int to_gpio_num(struct device_attribute *attr)
 	return -1;
 }
 
-static int __devinit tle62x0_probe(struct spi_device *spi)
+static int tle62x0_probe(struct spi_device *spi)
 {
 	struct tle62x0_state *st;
 	struct tle62x0_pdata *pdata;
diff --git a/drivers/spi/spi-topcliff-pch.c b/drivers/spi/spi-topcliff-pch.c
index 6dd9f12..12b3977 100644
--- a/drivers/spi/spi-topcliff-pch.c
+++ b/drivers/spi/spi-topcliff-pch.c
@@ -1401,7 +1401,7 @@ static void pch_alloc_dma_buf(struct pch_spi_board_data *board_dat,
 				PCH_BUF_SIZE, &dma->rx_buf_dma, GFP_KERNEL);
 }
 
-static int __devinit pch_spi_pd_probe(struct platform_device *plat_dev)
+static int pch_spi_pd_probe(struct platform_device *plat_dev)
 {
 	int ret;
 	struct spi_master *master;
@@ -1624,7 +1624,7 @@ static struct platform_driver pch_spi_pd_driver = {
 	.resume = pch_spi_pd_resume
 };
 
-static int __devinit pch_spi_probe(struct pci_dev *pdev,
+static int pch_spi_probe(struct pci_dev *pdev,
 				   const struct pci_device_id *id)
 {
 	struct pch_spi_board_data *board_dat;
diff --git a/drivers/spi/spi-xcomm.c b/drivers/spi/spi-xcomm.c
index b413ee3..d17e04d 100644
--- a/drivers/spi/spi-xcomm.c
+++ b/drivers/spi/spi-xcomm.c
@@ -217,7 +217,7 @@ static int spi_xcomm_setup(struct spi_device *spi)
 	return 0;
 }
 
-static int __devinit spi_xcomm_probe(struct i2c_client *i2c,
+static int spi_xcomm_probe(struct i2c_client *i2c,
 	const struct i2c_device_id *id)
 {
 	struct spi_xcomm *spi_xcomm;
diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
index da5018e..7b6ff06 100644
--- a/drivers/spi/spi-xilinx.c
+++ b/drivers/spi/spi-xilinx.c
@@ -462,7 +462,7 @@ void xilinx_spi_deinit(struct spi_master *master)
 }
 EXPORT_SYMBOL(xilinx_spi_deinit);
 
-static int __devinit xilinx_spi_probe(struct platform_device *dev)
+static int xilinx_spi_probe(struct platform_device *dev)
 {
 	struct xspi_platform_data *pdata;
 	struct resource *r;
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 37a8a2f..fdaf679 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -486,7 +486,7 @@ static void spi_match_master_to_boardinfo(struct spi_master *master,
  * The board info passed can safely be __initdata ... but be careful of
  * any embedded pointers (platform_data, etc), they're copied as-is.
  */
-int __devinit
+int
 spi_register_board_info(struct spi_board_info const *info, unsigned n)
 {
 	struct boardinfo *bi;
diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 253b2c7..e5e0214 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -573,7 +573,7 @@ static struct class *spidev_class;
 
 /*-------------------------------------------------------------------------*/
 
-static int __devinit spidev_probe(struct spi_device *spi)
+static int spidev_probe(struct spi_device *spi)
 {
 	struct spidev_data	*spidev;
 	int			status;
-- 
1.8.0
