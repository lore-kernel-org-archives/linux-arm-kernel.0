From: wfp5p@virginia.edu (Bill Pemberton)
Date: Mon, 19 Nov 2012 13:20:26 -0500
Subject: =?UTF-8?q?=5BPATCH=20077/493=5D=20mmc=3A=20remove=20use=20of=20=5F=5Fdevexit=5Fp?=
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Message-ID: <1353349642-3677-77-git-send-email-wfp5p@virginia.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_HOTPLUG is going away as an option so __devexit_p is no longer
needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: Chris Ball <cjb@laptop.org> 
Cc: "Micha? Miros?aw" <mirq-linux@rere.qmqm.pl> 
Cc: Jarkko Lavinen <jarkko.lavinen@nokia.com> 
Cc: Venkatraman S <svenkatr@ti.com> 
Cc: Viresh Kumar <viresh.linux@gmail.com> 
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de> 
Cc: Ian Molton <ian@mnementh.co.uk> 
Cc: Bruce Chang <brucechang@via.com.tw> 
Cc: Harald Welte <HaraldWelte@viatech.com> 
Cc: Pierre Ossman <pierre@ossman.eu> 
Cc: uclinux-dist-devel at blackfin.uclinux.org 
Cc: linux-mmc at vger.kernel.org 
Cc: linux-omap at vger.kernel.org 
Cc: linux-arm-kernel at lists.infradead.org 
Cc: spear-devel at list.st.com 
---
 drivers/mmc/host/bfin_sdh.c        | 2 +-
 drivers/mmc/host/cb710-mmc.c       | 2 +-
 drivers/mmc/host/dw_mmc-pci.c      | 2 +-
 drivers/mmc/host/dw_mmc-pltfm.c    | 2 +-
 drivers/mmc/host/jz4740_mmc.c      | 2 +-
 drivers/mmc/host/mmc_spi.c         | 2 +-
 drivers/mmc/host/mmci.c            | 2 +-
 drivers/mmc/host/omap.c            | 2 +-
 drivers/mmc/host/omap_hsmmc.c      | 2 +-
 drivers/mmc/host/s3cmci.c          | 2 +-
 drivers/mmc/host/sdhci-cns3xxx.c   | 2 +-
 drivers/mmc/host/sdhci-dove.c      | 2 +-
 drivers/mmc/host/sdhci-esdhc-imx.c | 2 +-
 drivers/mmc/host/sdhci-of-esdhc.c  | 2 +-
 drivers/mmc/host/sdhci-of-hlwd.c   | 2 +-
 drivers/mmc/host/sdhci-pci.c       | 2 +-
 drivers/mmc/host/sdhci-pxav2.c     | 2 +-
 drivers/mmc/host/sdhci-pxav3.c     | 2 +-
 drivers/mmc/host/sdhci-s3c.c       | 2 +-
 drivers/mmc/host/sdhci-spear.c     | 2 +-
 drivers/mmc/host/sdhci-tegra.c     | 2 +-
 drivers/mmc/host/sh_mobile_sdhi.c  | 2 +-
 drivers/mmc/host/tmio_mmc.c        | 2 +-
 drivers/mmc/host/via-sdmmc.c       | 2 +-
 drivers/mmc/host/wbsd.c            | 4 ++--
 25 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/mmc/host/bfin_sdh.c b/drivers/mmc/host/bfin_sdh.c
index b9b463e..156ebe7 100644
--- a/drivers/mmc/host/bfin_sdh.c
+++ b/drivers/mmc/host/bfin_sdh.c
@@ -680,7 +680,7 @@ static int sdh_resume(struct platform_device *dev)
 
 static struct platform_driver sdh_driver = {
 	.probe   = sdh_probe,
-	.remove  = __devexit_p(sdh_remove),
+	.remove  = sdh_remove,
 	.suspend = sdh_suspend,
 	.resume  = sdh_resume,
 	.driver  = {
diff --git a/drivers/mmc/host/cb710-mmc.c b/drivers/mmc/host/cb710-mmc.c
index 83693fd..39280b5 100644
--- a/drivers/mmc/host/cb710-mmc.c
+++ b/drivers/mmc/host/cb710-mmc.c
@@ -773,7 +773,7 @@ static int __devexit cb710_mmc_exit(struct platform_device *pdev)
 static struct platform_driver cb710_mmc_driver = {
 	.driver.name = "cb710-mmc",
 	.probe = cb710_mmc_init,
-	.remove = __devexit_p(cb710_mmc_exit),
+	.remove = cb710_mmc_exit,
 #ifdef CONFIG_PM
 	.suspend = cb710_mmc_suspend,
 	.resume = cb710_mmc_resume,
diff --git a/drivers/mmc/host/dw_mmc-pci.c b/drivers/mmc/host/dw_mmc-pci.c
index 53a09cb..edb37e9 100644
--- a/drivers/mmc/host/dw_mmc-pci.c
+++ b/drivers/mmc/host/dw_mmc-pci.c
@@ -134,7 +134,7 @@ static struct pci_driver dw_mci_pci_driver = {
 	.name		= "dw_mmc_pci",
 	.id_table	= dw_mci_pci_id,
 	.probe		= dw_mci_pci_probe,
-	.remove		= __devexit_p(dw_mci_pci_remove),
+	.remove		= dw_mci_pci_remove,
 	.driver		=	{
 		.pm =   &dw_mci_pci_pmops
 	},
diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-pltfm.c
index 4e13370..4c1b1df 100644
--- a/drivers/mmc/host/dw_mmc-pltfm.c
+++ b/drivers/mmc/host/dw_mmc-pltfm.c
@@ -120,7 +120,7 @@ MODULE_DEVICE_TABLE(of, dw_mci_pltfm_match);
 
 static struct platform_driver dw_mci_pltfm_driver = {
 	.probe		= dw_mci_pltfm_probe,
-	.remove		= __devexit_p(dw_mci_pltfm_remove),
+	.remove		= dw_mci_pltfm_remove,
 	.driver		= {
 		.name		= "dw_mmc",
 		.of_match_table	= of_match_ptr(dw_mci_pltfm_match),
diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index c8852a8..31cf20f 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -1004,7 +1004,7 @@ const struct dev_pm_ops jz4740_mmc_pm_ops = {
 
 static struct platform_driver jz4740_mmc_driver = {
 	.probe = jz4740_mmc_probe,
-	.remove = __devexit_p(jz4740_mmc_remove),
+	.remove = jz4740_mmc_remove,
 	.driver = {
 		.name = "jz4740-mmc",
 		.owner = THIS_MODULE,
diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
index a600eab..f7df798 100644
--- a/drivers/mmc/host/mmc_spi.c
+++ b/drivers/mmc/host/mmc_spi.c
@@ -1529,7 +1529,7 @@ static struct spi_driver mmc_spi_driver = {
 		.of_match_table = mmc_spi_of_match_table,
 	},
 	.probe =	mmc_spi_probe,
-	.remove =	__devexit_p(mmc_spi_remove),
+	.remove =	mmc_spi_remove,
 };
 
 module_spi_driver(mmc_spi_driver);
diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 9446c17..705c3be 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1693,7 +1693,7 @@ static struct amba_driver mmci_driver = {
 		.pm	= &mmci_dev_pm_ops,
 	},
 	.probe		= mmci_probe,
-	.remove		= __devexit_p(mmci_remove),
+	.remove		= mmci_remove,
 	.id_table	= mmci_ids,
 };
 
diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index ae115c0..f65ec26 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -1583,7 +1583,7 @@ static int mmc_omap_resume(struct platform_device *pdev)
 
 static struct platform_driver mmc_omap_driver = {
 	.probe		= mmc_omap_probe,
-	.remove		= __devexit_p(mmc_omap_remove),
+	.remove		= mmc_omap_remove,
 	.suspend	= mmc_omap_suspend,
 	.resume		= mmc_omap_resume,
 	.driver		= {
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 7546cb2..8f5c7e2 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -2156,7 +2156,7 @@ static struct dev_pm_ops omap_hsmmc_dev_pm_ops = {
 
 static struct platform_driver omap_hsmmc_driver = {
 	.probe		= omap_hsmmc_probe,
-	.remove		= __devexit_p(omap_hsmmc_remove),
+	.remove		= omap_hsmmc_remove,
 	.driver		= {
 		.name = DRIVER_NAME,
 		.owner = THIS_MODULE,
diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
index 4638dda..a5fe5b2 100644
--- a/drivers/mmc/host/s3cmci.c
+++ b/drivers/mmc/host/s3cmci.c
@@ -1906,7 +1906,7 @@ static struct platform_driver s3cmci_driver = {
 	},
 	.id_table	= s3cmci_driver_ids,
 	.probe		= s3cmci_probe,
-	.remove		= __devexit_p(s3cmci_remove),
+	.remove		= s3cmci_remove,
 	.shutdown	= s3cmci_shutdown,
 };
 
diff --git a/drivers/mmc/host/sdhci-cns3xxx.c b/drivers/mmc/host/sdhci-cns3xxx.c
index 28a8708..9236fa9 100644
--- a/drivers/mmc/host/sdhci-cns3xxx.c
+++ b/drivers/mmc/host/sdhci-cns3xxx.c
@@ -112,7 +112,7 @@ static struct platform_driver sdhci_cns3xxx_driver = {
 		.pm	= SDHCI_PLTFM_PMOPS,
 	},
 	.probe		= sdhci_cns3xxx_probe,
-	.remove		= __devexit_p(sdhci_cns3xxx_remove),
+	.remove		= sdhci_cns3xxx_remove,
 };
 
 module_platform_driver(sdhci_cns3xxx_driver);
diff --git a/drivers/mmc/host/sdhci-dove.c b/drivers/mmc/host/sdhci-dove.c
index 8fd50a2..7ad1bb6 100644
--- a/drivers/mmc/host/sdhci-dove.c
+++ b/drivers/mmc/host/sdhci-dove.c
@@ -143,7 +143,7 @@ static struct platform_driver sdhci_dove_driver = {
 		.of_match_table = of_match_ptr(sdhci_dove_of_match_table),
 	},
 	.probe		= sdhci_dove_probe,
-	.remove		= __devexit_p(sdhci_dove_remove),
+	.remove		= sdhci_dove_remove,
 };
 
 module_platform_driver(sdhci_dove_driver);
diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index effc2ac..6a4e98e 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -637,7 +637,7 @@ static struct platform_driver sdhci_esdhc_imx_driver = {
 	},
 	.id_table	= imx_esdhc_devtype,
 	.probe		= sdhci_esdhc_imx_probe,
-	.remove		= __devexit_p(sdhci_esdhc_imx_remove),
+	.remove		= sdhci_esdhc_imx_remove,
 };
 
 module_platform_driver(sdhci_esdhc_imx_driver);
diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index 63d219f..d7eb4ed 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -234,7 +234,7 @@ static struct platform_driver sdhci_esdhc_driver = {
 		.pm = SDHCI_PLTFM_PMOPS,
 	},
 	.probe = sdhci_esdhc_probe,
-	.remove = __devexit_p(sdhci_esdhc_remove),
+	.remove = sdhci_esdhc_remove,
 };
 
 module_platform_driver(sdhci_esdhc_driver);
diff --git a/drivers/mmc/host/sdhci-of-hlwd.c b/drivers/mmc/host/sdhci-of-hlwd.c
index 0ce088ae..3b68069 100644
--- a/drivers/mmc/host/sdhci-of-hlwd.c
+++ b/drivers/mmc/host/sdhci-of-hlwd.c
@@ -90,7 +90,7 @@ static struct platform_driver sdhci_hlwd_driver = {
 		.pm = SDHCI_PLTFM_PMOPS,
 	},
 	.probe = sdhci_hlwd_probe,
-	.remove = __devexit_p(sdhci_hlwd_remove),
+	.remove = sdhci_hlwd_remove,
 };
 
 module_platform_driver(sdhci_hlwd_driver);
diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index 04936f3..7bc2270 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -1470,7 +1470,7 @@ static struct pci_driver sdhci_driver = {
 	.name =		"sdhci-pci",
 	.id_table =	pci_ids,
 	.probe =	sdhci_pci_probe,
-	.remove =	__devexit_p(sdhci_pci_remove),
+	.remove =	sdhci_pci_remove,
 	.driver =	{
 		.pm =   &sdhci_pci_pm_ops
 	},
diff --git a/drivers/mmc/host/sdhci-pxav2.c b/drivers/mmc/host/sdhci-pxav2.c
index 8e63a9c..964fc6d 100644
--- a/drivers/mmc/host/sdhci-pxav2.c
+++ b/drivers/mmc/host/sdhci-pxav2.c
@@ -275,7 +275,7 @@ static struct platform_driver sdhci_pxav2_driver = {
 		.pm	= SDHCI_PLTFM_PMOPS,
 	},
 	.probe		= sdhci_pxav2_probe,
-	.remove		= __devexit_p(sdhci_pxav2_remove),
+	.remove		= sdhci_pxav2_remove,
 };
 
 module_platform_driver(sdhci_pxav2_driver);
diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index e918a2b..a46cb67 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -346,7 +346,7 @@ static struct platform_driver sdhci_pxav3_driver = {
 		.pm	= SDHCI_PLTFM_PMOPS,
 	},
 	.probe		= sdhci_pxav3_probe,
-	.remove		= __devexit_p(sdhci_pxav3_remove),
+	.remove		= sdhci_pxav3_remove,
 };
 
 module_platform_driver(sdhci_pxav3_driver);
diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index a54dd5d..b62a0c1 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -916,7 +916,7 @@ MODULE_DEVICE_TABLE(of, sdhci_s3c_dt_match);
 
 static struct platform_driver sdhci_s3c_driver = {
 	.probe		= sdhci_s3c_probe,
-	.remove		= __devexit_p(sdhci_s3c_remove),
+	.remove		= sdhci_s3c_remove,
 	.id_table	= sdhci_s3c_driver_ids,
 	.driver		= {
 		.owner	= THIS_MODULE,
diff --git a/drivers/mmc/host/sdhci-spear.c b/drivers/mmc/host/sdhci-spear.c
index 6be89c0..3ba9479 100644
--- a/drivers/mmc/host/sdhci-spear.c
+++ b/drivers/mmc/host/sdhci-spear.c
@@ -336,7 +336,7 @@ static struct platform_driver sdhci_driver = {
 		.of_match_table = of_match_ptr(sdhci_spear_id_table),
 	},
 	.probe		= sdhci_probe,
-	.remove		= __devexit_p(sdhci_remove),
+	.remove		= sdhci_remove,
 };
 
 module_platform_driver(sdhci_driver);
diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index f9eb916..f284354 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -407,7 +407,7 @@ static struct platform_driver sdhci_tegra_driver = {
 		.pm	= SDHCI_PLTFM_PMOPS,
 	},
 	.probe		= sdhci_tegra_probe,
-	.remove		= __devexit_p(sdhci_tegra_remove),
+	.remove		= sdhci_tegra_remove,
 };
 
 module_platform_driver(sdhci_tegra_driver);
diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index 0bdc146..6a9a625 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -330,7 +330,7 @@ static struct platform_driver sh_mobile_sdhi_driver = {
 		.of_match_table = sh_mobile_sdhi_of_match,
 	},
 	.probe		= sh_mobile_sdhi_probe,
-	.remove		= __devexit_p(sh_mobile_sdhi_remove),
+	.remove		= sh_mobile_sdhi_remove,
 };
 
 module_platform_driver(sh_mobile_sdhi_driver);
diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
index 113ce6c..2f9bbdf 100644
--- a/drivers/mmc/host/tmio_mmc.c
+++ b/drivers/mmc/host/tmio_mmc.c
@@ -133,7 +133,7 @@ static struct platform_driver tmio_mmc_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = tmio_mmc_probe,
-	.remove = __devexit_p(tmio_mmc_remove),
+	.remove = tmio_mmc_remove,
 	.suspend = tmio_mmc_suspend,
 	.resume = tmio_mmc_resume,
 };
diff --git a/drivers/mmc/host/via-sdmmc.c b/drivers/mmc/host/via-sdmmc.c
index f18bece..d8f8a5e 100644
--- a/drivers/mmc/host/via-sdmmc.c
+++ b/drivers/mmc/host/via-sdmmc.c
@@ -1332,7 +1332,7 @@ static struct pci_driver via_sd_driver = {
 	.name = DRV_NAME,
 	.id_table = via_ids,
 	.probe = via_sd_probe,
-	.remove = __devexit_p(via_sd_remove),
+	.remove = via_sd_remove,
 	.suspend = via_sd_suspend,
 	.resume = via_sd_resume,
 };
diff --git a/drivers/mmc/host/wbsd.c b/drivers/mmc/host/wbsd.c
index 64acd9c..3c8ef59 100644
--- a/drivers/mmc/host/wbsd.c
+++ b/drivers/mmc/host/wbsd.c
@@ -1941,7 +1941,7 @@ static struct platform_device *wbsd_device;
 
 static struct platform_driver wbsd_driver = {
 	.probe		= wbsd_probe,
-	.remove		= __devexit_p(wbsd_remove),
+	.remove		= wbsd_remove,
 
 	.suspend	= wbsd_platform_suspend,
 	.resume		= wbsd_platform_resume,
@@ -1957,7 +1957,7 @@ static struct pnp_driver wbsd_pnp_driver = {
 	.name		= DRIVER_NAME,
 	.id_table	= pnp_dev_table,
 	.probe		= wbsd_pnp_probe,
-	.remove		= __devexit_p(wbsd_pnp_remove),
+	.remove		= wbsd_pnp_remove,
 
 	.suspend	= wbsd_pnp_suspend,
 	.resume		= wbsd_pnp_resume,
-- 
1.8.0
