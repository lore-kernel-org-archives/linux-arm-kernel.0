From: wfp5p@virginia.edu (Bill Pemberton)
Date: Mon, 19 Nov 2012 13:23:06 -0500
Subject: =?UTF-8?q?=5BPATCH=20237/493=5D=20mmc=3A=20remove=20use=20of=20=5F=5Fdevinit?=
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Message-ID: <1353349642-3677-237-git-send-email-wfp5p@virginia.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_HOTPLUG is going away as an option so __devinit is no longer
needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: Ludovic Desroches <ludovic.desroches@atmel.com> 
Cc: Chris Ball <cjb@laptop.org> 
Cc: Manuel Lauss <manuel.lauss@gmail.com> 
Cc: "Micha? Miros?aw" <mirq-linux@rere.qmqm.pl> 
Cc: Jarkko Lavinen <jarkko.lavinen@nokia.com> 
Cc: Venkatraman S <svenkatr@ti.com> 
Cc: Viresh Kumar <viresh.linux@gmail.com> 
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de> 
Cc: Ian Molton <ian@mnementh.co.uk> 
Cc: Bruce Chang <brucechang@via.com.tw> 
Cc: Harald Welte <HaraldWelte@viatech.com> 
Cc: Pierre Ossman <pierre@ossman.eu> 
Cc: linux-mmc at vger.kernel.org 
Cc: uclinux-dist-devel at blackfin.uclinux.org 
Cc: linux-omap at vger.kernel.org 
Cc: linux-arm-kernel at lists.infradead.org 
Cc: spear-devel at list.st.com 
---
 drivers/mmc/host/atmel-mci.c       |  2 +-
 drivers/mmc/host/au1xmmc.c         |  2 +-
 drivers/mmc/host/bfin_sdh.c        |  2 +-
 drivers/mmc/host/cb710-mmc.c       |  2 +-
 drivers/mmc/host/dw_mmc-pci.c      |  2 +-
 drivers/mmc/host/dw_mmc-pltfm.c    |  2 +-
 drivers/mmc/host/jz4740_mmc.c      |  8 ++++----
 drivers/mmc/host/mmci.c            |  6 +++---
 drivers/mmc/host/omap.c            |  4 ++--
 drivers/mmc/host/omap_hsmmc.c      |  2 +-
 drivers/mmc/host/pxamci.c          |  4 ++--
 drivers/mmc/host/s3cmci.c          |  2 +-
 drivers/mmc/host/sdhci-cns3xxx.c   |  2 +-
 drivers/mmc/host/sdhci-dove.c      |  2 +-
 drivers/mmc/host/sdhci-esdhc-imx.c |  4 ++--
 drivers/mmc/host/sdhci-of-esdhc.c  |  2 +-
 drivers/mmc/host/sdhci-of-hlwd.c   |  2 +-
 drivers/mmc/host/sdhci-pci.c       |  6 +++---
 drivers/mmc/host/sdhci-pxav2.c     |  2 +-
 drivers/mmc/host/sdhci-pxav3.c     |  2 +-
 drivers/mmc/host/sdhci-s3c.c       |  6 +++---
 drivers/mmc/host/sdhci-spear.c     |  8 +++-----
 drivers/mmc/host/sdhci-tegra.c     |  4 ++--
 drivers/mmc/host/sh_mmcif.c        |  2 +-
 drivers/mmc/host/sh_mobile_sdhi.c  |  2 +-
 drivers/mmc/host/tmio_mmc.c        |  2 +-
 drivers/mmc/host/tmio_mmc_pio.c    |  2 +-
 drivers/mmc/host/via-sdmmc.c       |  2 +-
 drivers/mmc/host/wbsd.c            | 18 +++++++++---------
 29 files changed, 52 insertions(+), 54 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index 8689989..722af1d 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -511,7 +511,7 @@ static const struct of_device_id atmci_dt_ids[] = {
 
 MODULE_DEVICE_TABLE(of, atmci_dt_ids);
 
-static struct mci_platform_data __devinit*
+static struct mci_platform_data*
 atmci_of_init(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
diff --git a/drivers/mmc/host/au1xmmc.c b/drivers/mmc/host/au1xmmc.c
index dbd0c8a..606c16a 100644
--- a/drivers/mmc/host/au1xmmc.c
+++ b/drivers/mmc/host/au1xmmc.c
@@ -943,7 +943,7 @@ static const struct mmc_host_ops au1xmmc_ops = {
 	.enable_sdio_irq = au1xmmc_enable_sdio_irq,
 };
 
-static int __devinit au1xmmc_probe(struct platform_device *pdev)
+static int au1xmmc_probe(struct platform_device *pdev)
 {
 	struct mmc_host *mmc;
 	struct au1xmmc_host *host;
diff --git a/drivers/mmc/host/bfin_sdh.c b/drivers/mmc/host/bfin_sdh.c
index 156ebe7..4ef3901 100644
--- a/drivers/mmc/host/bfin_sdh.c
+++ b/drivers/mmc/host/bfin_sdh.c
@@ -522,7 +522,7 @@ static void sdh_reset(void)
 	SSYNC();
 }
 
-static int __devinit sdh_probe(struct platform_device *pdev)
+static int sdh_probe(struct platform_device *pdev)
 {
 	struct mmc_host *mmc;
 	struct sdh_host *host;
diff --git a/drivers/mmc/host/cb710-mmc.c b/drivers/mmc/host/cb710-mmc.c
index 39280b5..c12a561 100644
--- a/drivers/mmc/host/cb710-mmc.c
+++ b/drivers/mmc/host/cb710-mmc.c
@@ -690,7 +690,7 @@ static int cb710_mmc_resume(struct platform_device *pdev)
 
 #endif /* CONFIG_PM */
 
-static int __devinit cb710_mmc_init(struct platform_device *pdev)
+static int cb710_mmc_init(struct platform_device *pdev)
 {
 	struct cb710_slot *slot = cb710_pdev_to_slot(pdev);
 	struct cb710_chip *chip = cb710_slot_to_chip(slot);
diff --git a/drivers/mmc/host/dw_mmc-pci.c b/drivers/mmc/host/dw_mmc-pci.c
index edb37e9..324c8bf 100644
--- a/drivers/mmc/host/dw_mmc-pci.c
+++ b/drivers/mmc/host/dw_mmc-pci.c
@@ -37,7 +37,7 @@ static struct dw_mci_board pci_board_data = {
 	.fifo_depth			= 32,
 };
 
-static int __devinit dw_mci_pci_probe(struct pci_dev *pdev,
+static int dw_mci_pci_probe(struct pci_dev *pdev,
 				  const struct pci_device_id *entries)
 {
 	struct dw_mci *host;
diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-pltfm.c
index 4c1b1df..ff73a87 100644
--- a/drivers/mmc/host/dw_mmc-pltfm.c
+++ b/drivers/mmc/host/dw_mmc-pltfm.c
@@ -62,7 +62,7 @@ int dw_mci_pltfm_register(struct platform_device *pdev,
 }
 EXPORT_SYMBOL_GPL(dw_mci_pltfm_register);
 
-static int __devinit dw_mci_pltfm_probe(struct platform_device *pdev)
+static int dw_mci_pltfm_probe(struct platform_device *pdev)
 {
 	return dw_mci_pltfm_register(pdev, NULL);
 }
diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index 31cf20f..81826be 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -702,7 +702,7 @@ static const struct jz_gpio_bulk_request jz4740_mmc_pins[] = {
 	JZ_GPIO_BULK_PIN(MSC_DATA3),
 };
 
-static int __devinit jz4740_mmc_request_gpio(struct device *dev, int gpio,
+static int jz4740_mmc_request_gpio(struct device *dev, int gpio,
 	const char *name, bool output, int value)
 {
 	int ret;
@@ -724,7 +724,7 @@ static int __devinit jz4740_mmc_request_gpio(struct device *dev, int gpio,
 	return 0;
 }
 
-static int __devinit jz4740_mmc_request_gpios(struct platform_device *pdev)
+static int jz4740_mmc_request_gpios(struct platform_device *pdev)
 {
 	int ret;
 	struct jz4740_mmc_platform_data *pdata = pdev->dev.platform_data;
@@ -759,7 +759,7 @@ err:
 	return ret;
 }
 
-static int __devinit jz4740_mmc_request_cd_irq(struct platform_device *pdev,
+static int jz4740_mmc_request_cd_irq(struct platform_device *pdev,
 	struct jz4740_mmc_host *host)
 {
 	struct jz4740_mmc_platform_data *pdata = pdev->dev.platform_data;
@@ -802,7 +802,7 @@ static inline size_t jz4740_mmc_num_pins(struct jz4740_mmc_host *host)
 	return num_pins;
 }
 
-static int __devinit jz4740_mmc_probe(struct platform_device* pdev)
+static int jz4740_mmc_probe(struct platform_device* pdev)
 {
 	int ret;
 	struct mmc_host *mmc;
diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 705c3be..bf5f7a5 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -262,7 +262,7 @@ static void mmci_init_sg(struct mmci_host *host, struct mmc_data *data)
  * no custom DMA interfaces are supported.
  */
 #ifdef CONFIG_DMA_ENGINE
-static void __devinit mmci_dma_setup(struct mmci_host *host)
+static void mmci_dma_setup(struct mmci_host *host)
 {
 	struct mmci_platform_data *plat = host->plat;
 	const char *rxname, *txname;
@@ -338,7 +338,7 @@ static void __devinit mmci_dma_setup(struct mmci_host *host)
 }
 
 /*
- * This is used in __devinit or __devexit so inline it
+ * This is used in or __devexit so inline it
  * so it can be discarded.
  */
 static inline void mmci_dma_release(struct mmci_host *host)
@@ -1262,7 +1262,7 @@ static void mmci_dt_populate_generic_pdata(struct device_node *np,
 }
 #endif
 
-static int __devinit mmci_probe(struct amba_device *dev,
+static int mmci_probe(struct amba_device *dev,
 	const struct amba_id *id)
 {
 	struct mmci_platform_data *plat = dev->dev.platform_data;
diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index f65ec26..5cd976a 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -1230,7 +1230,7 @@ static const struct mmc_host_ops mmc_omap_ops = {
 	.set_ios	= mmc_omap_set_ios,
 };
 
-static int __devinit mmc_omap_new_slot(struct mmc_omap_host *host, int id)
+static int mmc_omap_new_slot(struct mmc_omap_host *host, int id)
 {
 	struct mmc_omap_slot *slot = NULL;
 	struct mmc_host *mmc;
@@ -1325,7 +1325,7 @@ static void mmc_omap_remove_slot(struct mmc_omap_slot *slot)
 	mmc_free_host(mmc);
 }
 
-static int __devinit mmc_omap_probe(struct platform_device *pdev)
+static int mmc_omap_probe(struct platform_device *pdev)
 {
 	struct omap_mmc_platform_data *pdata = pdev->dev.platform_data;
 	struct mmc_omap_host *host = NULL;
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 8f5c7e2..492d8cf 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1717,7 +1717,7 @@ static inline struct omap_mmc_platform_data
 }
 #endif
 
-static int __devinit omap_hsmmc_probe(struct platform_device *pdev)
+static int omap_hsmmc_probe(struct platform_device *pdev)
 {
 	struct omap_mmc_platform_data *pdata = pdev->dev.platform_data;
 	struct mmc_host *mmc;
diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
index 3f9d6d5..2b2f65a 100644
--- a/drivers/mmc/host/pxamci.c
+++ b/drivers/mmc/host/pxamci.c
@@ -584,7 +584,7 @@ static const struct of_device_id pxa_mmc_dt_ids[] = {
 
 MODULE_DEVICE_TABLE(of, pxa_mmc_dt_ids);
 
-static int __devinit pxamci_of_init(struct platform_device *pdev)
+static int pxamci_of_init(struct platform_device *pdev)
 {
         struct device_node *np = pdev->dev.of_node;
         struct pxamci_platform_data *pdata;
@@ -614,7 +614,7 @@ static int __devinit pxamci_of_init(struct platform_device *pdev)
         return 0;
 }
 #else
-static int __devinit pxamci_of_init(struct platform_device *pdev)
+static int pxamci_of_init(struct platform_device *pdev)
 {
         return 0;
 }
diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
index a5fe5b2..b846a97 100644
--- a/drivers/mmc/host/s3cmci.c
+++ b/drivers/mmc/host/s3cmci.c
@@ -1540,7 +1540,7 @@ static inline void s3cmci_debugfs_remove(struct s3cmci_host *host) { }
 
 #endif /* CONFIG_DEBUG_FS */
 
-static int __devinit s3cmci_probe(struct platform_device *pdev)
+static int s3cmci_probe(struct platform_device *pdev)
 {
 	struct s3cmci_host *host;
 	struct mmc_host	*mmc;
diff --git a/drivers/mmc/host/sdhci-cns3xxx.c b/drivers/mmc/host/sdhci-cns3xxx.c
index 9236fa9..ce959dcf 100644
--- a/drivers/mmc/host/sdhci-cns3xxx.c
+++ b/drivers/mmc/host/sdhci-cns3xxx.c
@@ -95,7 +95,7 @@ static struct sdhci_pltfm_data sdhci_cns3xxx_pdata = {
 		  SDHCI_QUIRK_NONSTANDARD_CLOCK,
 };
 
-static int __devinit sdhci_cns3xxx_probe(struct platform_device *pdev)
+static int sdhci_cns3xxx_probe(struct platform_device *pdev)
 {
 	return sdhci_pltfm_register(pdev, &sdhci_cns3xxx_pdata);
 }
diff --git a/drivers/mmc/host/sdhci-dove.c b/drivers/mmc/host/sdhci-dove.c
index 7ad1bb6..334ec5c 100644
--- a/drivers/mmc/host/sdhci-dove.c
+++ b/drivers/mmc/host/sdhci-dove.c
@@ -78,7 +78,7 @@ static struct sdhci_pltfm_data sdhci_dove_pdata = {
 		  SDHCI_QUIRK_NO_HISPD_BIT,
 };
 
-static int __devinit sdhci_dove_probe(struct platform_device *pdev)
+static int sdhci_dove_probe(struct platform_device *pdev)
 {
 	struct sdhci_host *host;
 	struct sdhci_pltfm_host *pltfm_host;
diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 6a4e98e..cd741bb 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -403,7 +403,7 @@ static irqreturn_t cd_irq(int irq, void *data)
 };
 
 #ifdef CONFIG_OF
-static int __devinit
+static int
 sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
 			 struct esdhc_platform_data *boarddata)
 {
@@ -440,7 +440,7 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
 }
 #endif
 
-static int __devinit sdhci_esdhc_imx_probe(struct platform_device *pdev)
+static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *of_id =
 			of_match_device(imx_esdhc_dt_ids, &pdev->dev);
diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index d7eb4ed..1aceed7 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -208,7 +208,7 @@ static struct sdhci_pltfm_data sdhci_esdhc_pdata = {
 	.ops = &sdhci_esdhc_ops,
 };
 
-static int __devinit sdhci_esdhc_probe(struct platform_device *pdev)
+static int sdhci_esdhc_probe(struct platform_device *pdev)
 {
 	return sdhci_pltfm_register(pdev, &sdhci_esdhc_pdata);
 }
diff --git a/drivers/mmc/host/sdhci-of-hlwd.c b/drivers/mmc/host/sdhci-of-hlwd.c
index 3b68069..aa78f3c 100644
--- a/drivers/mmc/host/sdhci-of-hlwd.c
+++ b/drivers/mmc/host/sdhci-of-hlwd.c
@@ -66,7 +66,7 @@ static struct sdhci_pltfm_data sdhci_hlwd_pdata = {
 	.ops = &sdhci_hlwd_ops,
 };
 
-static int __devinit sdhci_hlwd_probe(struct platform_device *pdev)
+static int sdhci_hlwd_probe(struct platform_device *pdev)
 {
 	return sdhci_pltfm_register(pdev, &sdhci_hlwd_pdata);
 }
diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index 7bc2270..ff91651 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -1183,7 +1183,7 @@ static const struct dev_pm_ops sdhci_pci_pm_ops = {
  *                                                                           *
 \*****************************************************************************/
 
-static struct sdhci_pci_slot * __devinit sdhci_pci_probe_slot(
+static struct sdhci_pci_slot *sdhci_pci_probe_slot(
 	struct pci_dev *pdev, struct sdhci_pci_chip *chip, int first_bar,
 	int slotno)
 {
@@ -1338,7 +1338,7 @@ static void sdhci_pci_remove_slot(struct sdhci_pci_slot *slot)
 	sdhci_free_host(slot->host);
 }
 
-static void __devinit sdhci_pci_runtime_pm_allow(struct device *dev)
+static void sdhci_pci_runtime_pm_allow(struct device *dev)
 {
 	pm_runtime_put_noidle(dev);
 	pm_runtime_allow(dev);
@@ -1353,7 +1353,7 @@ static void __devexit sdhci_pci_runtime_pm_forbid(struct device *dev)
 	pm_runtime_get_noresume(dev);
 }
 
-static int __devinit sdhci_pci_probe(struct pci_dev *pdev,
+static int sdhci_pci_probe(struct pci_dev *pdev,
 				     const struct pci_device_id *ent)
 {
 	struct sdhci_pci_chip *chip;
diff --git a/drivers/mmc/host/sdhci-pxav2.c b/drivers/mmc/host/sdhci-pxav2.c
index 964fc6d..7d4dc19 100644
--- a/drivers/mmc/host/sdhci-pxav2.c
+++ b/drivers/mmc/host/sdhci-pxav2.c
@@ -166,7 +166,7 @@ static inline struct sdhci_pxa_platdata *pxav2_get_mmc_pdata(struct device *dev)
 }
 #endif
 
-static int __devinit sdhci_pxav2_probe(struct platform_device *pdev)
+static int sdhci_pxav2_probe(struct platform_device *pdev)
 {
 	struct sdhci_pltfm_host *pltfm_host;
 	struct sdhci_pxa_platdata *pdata = pdev->dev.platform_data;
diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index a46cb67..e89c809 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -214,7 +214,7 @@ static inline struct sdhci_pxa_platdata *pxav3_get_mmc_pdata(struct device *dev)
 }
 #endif
 
-static int __devinit sdhci_pxav3_probe(struct platform_device *pdev)
+static int sdhci_pxav3_probe(struct platform_device *pdev)
 {
 	struct sdhci_pltfm_host *pltfm_host;
 	struct sdhci_pxa_platdata *pdata = pdev->dev.platform_data;
diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index b62a0c1..f5dde9e 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -430,7 +430,7 @@ static void sdhci_s3c_setup_card_detect_gpio(struct sdhci_s3c *sc)
 }
 
 #ifdef CONFIG_OF
-static int __devinit sdhci_s3c_parse_dt(struct device *dev,
+static int sdhci_s3c_parse_dt(struct device *dev,
 		struct sdhci_host *host, struct s3c_sdhci_platdata *pdata)
 {
 	struct device_node *node = dev->of_node;
@@ -525,7 +525,7 @@ static int __devinit sdhci_s3c_parse_dt(struct device *dev,
 	return -EINVAL;
 }
 #else
-static int __devinit sdhci_s3c_parse_dt(struct device *dev,
+static int sdhci_s3c_parse_dt(struct device *dev,
 		struct sdhci_host *host, struct s3c_sdhci_platdata *pdata)
 {
 	return -EINVAL;
@@ -548,7 +548,7 @@ static inline struct sdhci_s3c_drv_data *sdhci_s3c_get_driver_data(
 			platform_get_device_id(pdev)->driver_data;
 }
 
-static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
+static int sdhci_s3c_probe(struct platform_device *pdev)
 {
 	struct s3c_sdhci_platdata *pdata;
 	struct sdhci_s3c_drv_data *drv_data;
diff --git a/drivers/mmc/host/sdhci-spear.c b/drivers/mmc/host/sdhci-spear.c
index 3ba9479..3fd1896 100644
--- a/drivers/mmc/host/sdhci-spear.c
+++ b/drivers/mmc/host/sdhci-spear.c
@@ -71,8 +71,7 @@ static irqreturn_t sdhci_gpio_irq(int irq, void *dev_id)
 }
 
 #ifdef CONFIG_OF
-static struct sdhci_plat_data * __devinit
-sdhci_probe_config_dt(struct platform_device *pdev)
+static struct sdhci_plat_data *sdhci_probe_config_dt(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct sdhci_plat_data *pdata = NULL;
@@ -96,14 +95,13 @@ sdhci_probe_config_dt(struct platform_device *pdev)
 	return pdata;
 }
 #else
-static struct sdhci_plat_data * __devinit
-sdhci_probe_config_dt(struct platform_device *pdev)
+static struct sdhci_plat_data *sdhci_probe_config_dt(struct platform_device *pdev)
 {
 	return ERR_PTR(-ENOSYS);
 }
 #endif
 
-static int __devinit sdhci_probe(struct platform_device *pdev)
+static int sdhci_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct sdhci_host *host;
diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index f284354..339c41e 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -217,7 +217,7 @@ static const struct of_device_id sdhci_tegra_dt_match[] __devinitdata = {
 };
 MODULE_DEVICE_TABLE(of, sdhci_dt_ids);
 
-static struct tegra_sdhci_platform_data * __devinit sdhci_tegra_dt_parse_pdata(
+static struct tegra_sdhci_platform_data *sdhci_tegra_dt_parse_pdata(
 						struct platform_device *pdev)
 {
 	struct tegra_sdhci_platform_data *plat;
@@ -244,7 +244,7 @@ static struct tegra_sdhci_platform_data * __devinit sdhci_tegra_dt_parse_pdata(
 	return plat;
 }
 
-static int __devinit sdhci_tegra_probe(struct platform_device *pdev)
+static int sdhci_tegra_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *match;
 	const struct sdhci_tegra_soc_data *soc_data;
diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index d25bc97..9872b52 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -1302,7 +1302,7 @@ static void sh_mmcif_init_ocr(struct sh_mmcif_host *host)
 		dev_warn(mmc_dev(mmc), "Platform OCR mask is ignored\n");
 }
 
-static int __devinit sh_mmcif_probe(struct platform_device *pdev)
+static int sh_mmcif_probe(struct platform_device *pdev)
 {
 	int ret = 0, irq[2];
 	struct mmc_host *mmc;
diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index 6a9a625..9125684 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -117,7 +117,7 @@ static const struct sh_mobile_sdhi_ops sdhi_ops = {
 	.cd_wakeup = sh_mobile_sdhi_cd_wakeup,
 };
 
-static int __devinit sh_mobile_sdhi_probe(struct platform_device *pdev)
+static int sh_mobile_sdhi_probe(struct platform_device *pdev)
 {
 	struct sh_mobile_sdhi *priv;
 	struct tmio_mmc_data *mmc_data;
diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
index 2f9bbdf..f415be8 100644
--- a/drivers/mmc/host/tmio_mmc.c
+++ b/drivers/mmc/host/tmio_mmc.c
@@ -57,7 +57,7 @@ static int tmio_mmc_resume(struct platform_device *dev)
 #define tmio_mmc_resume NULL
 #endif
 
-static int __devinit tmio_mmc_probe(struct platform_device *pdev)
+static int tmio_mmc_probe(struct platform_device *pdev)
 {
 	const struct mfd_cell *cell = mfd_get_cell(pdev);
 	struct tmio_mmc_data *pdata;
diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 0d8a9bb..50bf495 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -918,7 +918,7 @@ static void tmio_mmc_init_ocr(struct tmio_mmc_host *host)
 		dev_warn(mmc_dev(mmc), "Platform OCR mask is ignored\n");
 }
 
-int __devinit tmio_mmc_host_probe(struct tmio_mmc_host **host,
+int tmio_mmc_host_probe(struct tmio_mmc_host **host,
 				  struct platform_device *pdev,
 				  struct tmio_mmc_data *pdata)
 {
diff --git a/drivers/mmc/host/via-sdmmc.c b/drivers/mmc/host/via-sdmmc.c
index d8f8a5e..1f1a252 100644
--- a/drivers/mmc/host/via-sdmmc.c
+++ b/drivers/mmc/host/via-sdmmc.c
@@ -1082,7 +1082,7 @@ static void via_init_mmc_host(struct via_crdr_mmc_host *host)
 	msleep(1);
 }
 
-static int __devinit via_sd_probe(struct pci_dev *pcidev,
+static int via_sd_probe(struct pci_dev *pcidev,
 				    const struct pci_device_id *id)
 {
 	struct mmc_host *mmc;
diff --git a/drivers/mmc/host/wbsd.c b/drivers/mmc/host/wbsd.c
index 3c8ef59..d71358a 100644
--- a/drivers/mmc/host/wbsd.c
+++ b/drivers/mmc/host/wbsd.c
@@ -1196,7 +1196,7 @@ static irqreturn_t wbsd_irq(int irq, void *dev_id)
  * Allocate/free MMC structure.
  */
 
-static int __devinit wbsd_alloc_mmc(struct device *dev)
+static int wbsd_alloc_mmc(struct device *dev)
 {
 	struct mmc_host *mmc;
 	struct wbsd_host *host;
@@ -1288,7 +1288,7 @@ static void wbsd_free_mmc(struct device *dev)
  * Scan for known chip id:s
  */
 
-static int __devinit wbsd_scan(struct wbsd_host *host)
+static int wbsd_scan(struct wbsd_host *host)
 {
 	int i, j, k;
 	int id;
@@ -1344,7 +1344,7 @@ static int __devinit wbsd_scan(struct wbsd_host *host)
  * Allocate/free io port ranges
  */
 
-static int __devinit wbsd_request_region(struct wbsd_host *host, int base)
+static int wbsd_request_region(struct wbsd_host *host, int base)
 {
 	if (base & 0x7)
 		return -EINVAL;
@@ -1374,7 +1374,7 @@ static void wbsd_release_regions(struct wbsd_host *host)
  * Allocate/free DMA port and buffer
  */
 
-static void __devinit wbsd_request_dma(struct wbsd_host *host, int dma)
+static void wbsd_request_dma(struct wbsd_host *host, int dma)
 {
 	if (dma < 0)
 		return;
@@ -1452,7 +1452,7 @@ static void wbsd_release_dma(struct wbsd_host *host)
  * Allocate/free IRQ.
  */
 
-static int __devinit wbsd_request_irq(struct wbsd_host *host, int irq)
+static int wbsd_request_irq(struct wbsd_host *host, int irq)
 {
 	int ret;
 
@@ -1502,7 +1502,7 @@ static void  wbsd_release_irq(struct wbsd_host *host)
  * Allocate all resources for the host.
  */
 
-static int __devinit wbsd_request_resources(struct wbsd_host *host,
+static int wbsd_request_resources(struct wbsd_host *host,
 	int base, int irq, int dma)
 {
 	int ret;
@@ -1644,7 +1644,7 @@ static void wbsd_chip_poweroff(struct wbsd_host *host)
  *                                                                           *
 \*****************************************************************************/
 
-static int __devinit wbsd_init(struct device *dev, int base, int irq, int dma,
+static int wbsd_init(struct device *dev, int base, int irq, int dma,
 	int pnp)
 {
 	struct wbsd_host *host = NULL;
@@ -1762,7 +1762,7 @@ static void __devexit wbsd_shutdown(struct device *dev, int pnp)
  * Non-PnP
  */
 
-static int __devinit wbsd_probe(struct platform_device *dev)
+static int wbsd_probe(struct platform_device *dev)
 {
 	/* Use the module parameters for resources */
 	return wbsd_init(&dev->dev, param_io, param_irq, param_dma, 0);
@@ -1781,7 +1781,7 @@ static int __devexit wbsd_remove(struct platform_device *dev)
 
 #ifdef CONFIG_PNP
 
-static int __devinit
+static int
 wbsd_pnp_probe(struct pnp_dev *pnpdev, const struct pnp_device_id *dev_id)
 {
 	int io, irq, dma;
-- 
1.8.0
