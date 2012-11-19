From: wfp5p@virginia.edu (Bill Pemberton)
Date: Mon, 19 Nov 2012 13:21:24 -0500
Subject: =?UTF-8?q?=5BPATCH=20135/493=5D=20mtd=3A=20remove=20use=20of=20=5F=5Fdevexit=5Fp?=
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Message-ID: <1353349642-3677-135-git-send-email-wfp5p@virginia.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_HOTPLUG is going away as an option so __devexit_p is no longer
needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: David Woodhouse <dwmw2@infradead.org> 
Cc: Wan ZongShun <mcuos.com@gmail.com> 
Cc: Kyungmin Park <kyungmin.park@samsung.com> 
Cc: linux-mtd at lists.infradead.org 
Cc: linux-arm-kernel at lists.infradead.org 
---
 drivers/mtd/devices/bcm47xxsflash.c    | 2 +-
 drivers/mtd/devices/m25p80.c           | 2 +-
 drivers/mtd/devices/mtd_dataflash.c    | 2 +-
 drivers/mtd/devices/spear_smi.c        | 2 +-
 drivers/mtd/devices/sst25l.c           | 2 +-
 drivers/mtd/maps/autcpu12-nvram.c      | 2 +-
 drivers/mtd/maps/bfin-async-flash.c    | 2 +-
 drivers/mtd/maps/gpio-addr-flash.c     | 2 +-
 drivers/mtd/maps/intel_vr_nor.c        | 2 +-
 drivers/mtd/maps/lantiq-flash.c        | 2 +-
 drivers/mtd/maps/latch-addr-flash.c    | 2 +-
 drivers/mtd/maps/pci.c                 | 2 +-
 drivers/mtd/maps/pismo.c               | 2 +-
 drivers/mtd/maps/pxa2xx-flash.c        | 2 +-
 drivers/mtd/maps/scb2_flash.c          | 2 +-
 drivers/mtd/maps/sun_uflash.c          | 2 +-
 drivers/mtd/maps/vmu-flash.c           | 2 +-
 drivers/mtd/nand/ams-delta.c           | 2 +-
 drivers/mtd/nand/au1550nd.c            | 2 +-
 drivers/mtd/nand/bf5xx_nand.c          | 2 +-
 drivers/mtd/nand/cafe_nand.c           | 2 +-
 drivers/mtd/nand/denali_dt.c           | 2 +-
 drivers/mtd/nand/fsl_upm.c             | 2 +-
 drivers/mtd/nand/gpmi-nand/gpmi-nand.c | 2 +-
 drivers/mtd/nand/jz4740_nand.c         | 2 +-
 drivers/mtd/nand/lpc32xx_mlc.c         | 2 +-
 drivers/mtd/nand/lpc32xx_slc.c         | 2 +-
 drivers/mtd/nand/mpc5121_nfc.c         | 2 +-
 drivers/mtd/nand/mxc_nand.c            | 2 +-
 drivers/mtd/nand/ndfc.c                | 2 +-
 drivers/mtd/nand/nuc900_nand.c         | 2 +-
 drivers/mtd/nand/orion_nand.c          | 2 +-
 drivers/mtd/nand/plat_nand.c           | 2 +-
 drivers/mtd/nand/sharpsl.c             | 2 +-
 drivers/mtd/nand/socrates_nand.c       | 2 +-
 drivers/mtd/onenand/generic.c          | 2 +-
 drivers/mtd/onenand/omap2.c            | 2 +-
 drivers/mtd/onenand/samsung.c          | 2 +-
 38 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/drivers/mtd/devices/bcm47xxsflash.c b/drivers/mtd/devices/bcm47xxsflash.c
index 2dc5a6f..113aced 100644
--- a/drivers/mtd/devices/bcm47xxsflash.c
+++ b/drivers/mtd/devices/bcm47xxsflash.c
@@ -77,7 +77,7 @@ static int __devexit bcm47xxsflash_remove(struct platform_device *pdev)
 }
 
 static struct platform_driver bcma_sflash_driver = {
-	.remove = __devexit_p(bcm47xxsflash_remove),
+	.remove = bcm47xxsflash_remove,
 	.driver = {
 		.name = "bcma_sflash",
 		.owner = THIS_MODULE,
diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index 7e2d8f9..9ffd3c5 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -993,7 +993,7 @@ static struct spi_driver m25p80_driver = {
 	},
 	.id_table	= m25p_ids,
 	.probe	= m25p_probe,
-	.remove	= __devexit_p(m25p_remove),
+	.remove	= m25p_remove,
 
 	/* REVISIT: many of these chips have deep power-down modes, which
 	 * should clearly be entered on suspend() to minimize power use.
diff --git a/drivers/mtd/devices/mtd_dataflash.c b/drivers/mtd/devices/mtd_dataflash.c
index 928fb0e..23ccc36 100644
--- a/drivers/mtd/devices/mtd_dataflash.c
+++ b/drivers/mtd/devices/mtd_dataflash.c
@@ -920,7 +920,7 @@ static struct spi_driver dataflash_driver = {
 	},
 
 	.probe		= dataflash_probe,
-	.remove		= __devexit_p(dataflash_remove),
+	.remove		= dataflash_remove,
 
 	/* FIXME:  investigate suspend and resume... */
 };
diff --git a/drivers/mtd/devices/spear_smi.c b/drivers/mtd/devices/spear_smi.c
index 39e9567..e27737c 100644
--- a/drivers/mtd/devices/spear_smi.c
+++ b/drivers/mtd/devices/spear_smi.c
@@ -1092,7 +1092,7 @@ static struct platform_driver spear_smi_driver = {
 #endif
 	},
 	.probe = spear_smi_probe,
-	.remove = __devexit_p(spear_smi_remove),
+	.remove = spear_smi_remove,
 };
 module_platform_driver(spear_smi_driver);
 
diff --git a/drivers/mtd/devices/sst25l.c b/drivers/mtd/devices/sst25l.c
index ab8a2f4..9ebf86d 100644
--- a/drivers/mtd/devices/sst25l.c
+++ b/drivers/mtd/devices/sst25l.c
@@ -428,7 +428,7 @@ static struct spi_driver sst25l_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= sst25l_probe,
-	.remove		= __devexit_p(sst25l_remove),
+	.remove		= sst25l_remove,
 };
 
 module_spi_driver(sst25l_driver);
diff --git a/drivers/mtd/maps/autcpu12-nvram.c b/drivers/mtd/maps/autcpu12-nvram.c
index 76fb594..ca0313d 100644
--- a/drivers/mtd/maps/autcpu12-nvram.c
+++ b/drivers/mtd/maps/autcpu12-nvram.c
@@ -121,7 +121,7 @@ static struct platform_driver autcpu12_nvram_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= autcpu12_nvram_probe,
-	.remove		= __devexit_p(autcpu12_nvram_remove),
+	.remove		= autcpu12_nvram_remove,
 };
 module_platform_driver(autcpu12_nvram_driver);
 
diff --git a/drivers/mtd/maps/bfin-async-flash.c b/drivers/mtd/maps/bfin-async-flash.c
index ef5cde8..340e8a2 100644
--- a/drivers/mtd/maps/bfin-async-flash.c
+++ b/drivers/mtd/maps/bfin-async-flash.c
@@ -184,7 +184,7 @@ static int __devexit bfin_flash_remove(struct platform_device *pdev)
 
 static struct platform_driver bfin_flash_driver = {
 	.probe		= bfin_flash_probe,
-	.remove		= __devexit_p(bfin_flash_remove),
+	.remove		= bfin_flash_remove,
 	.driver		= {
 		.name	= DRIVER_NAME,
 	},
diff --git a/drivers/mtd/maps/gpio-addr-flash.c b/drivers/mtd/maps/gpio-addr-flash.c
index e4de96b..670af9a 100644
--- a/drivers/mtd/maps/gpio-addr-flash.c
+++ b/drivers/mtd/maps/gpio-addr-flash.c
@@ -273,7 +273,7 @@ static int __devexit gpio_flash_remove(struct platform_device *pdev)
 
 static struct platform_driver gpio_flash_driver = {
 	.probe		= gpio_flash_probe,
-	.remove		= __devexit_p(gpio_flash_remove),
+	.remove		= gpio_flash_remove,
 	.driver		= {
 		.name	= DRIVER_NAME,
 	},
diff --git a/drivers/mtd/maps/intel_vr_nor.c b/drivers/mtd/maps/intel_vr_nor.c
index 93f0317..f6185d4 100644
--- a/drivers/mtd/maps/intel_vr_nor.c
+++ b/drivers/mtd/maps/intel_vr_nor.c
@@ -256,7 +256,7 @@ vr_nor_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
 static struct pci_driver vr_nor_pci_driver = {
 	.name = DRV_NAME,
 	.probe = vr_nor_pci_probe,
-	.remove = __devexit_p(vr_nor_pci_remove),
+	.remove = vr_nor_pci_remove,
 	.id_table = vr_nor_pci_ids,
 };
 
diff --git a/drivers/mtd/maps/lantiq-flash.c b/drivers/mtd/maps/lantiq-flash.c
index c03456f..4c032f1 100644
--- a/drivers/mtd/maps/lantiq-flash.c
+++ b/drivers/mtd/maps/lantiq-flash.c
@@ -209,7 +209,7 @@ MODULE_DEVICE_TABLE(of, ltq_mtd_match);
 
 static struct platform_driver ltq_mtd_driver = {
 	.probe = ltq_mtd_probe,
-	.remove = __devexit_p(ltq_mtd_remove),
+	.remove = ltq_mtd_remove,
 	.driver = {
 		.name = "ltq-nor",
 		.owner = THIS_MODULE,
diff --git a/drivers/mtd/maps/latch-addr-flash.c b/drivers/mtd/maps/latch-addr-flash.c
index 3c7ad17..962a76a 100644
--- a/drivers/mtd/maps/latch-addr-flash.c
+++ b/drivers/mtd/maps/latch-addr-flash.c
@@ -218,7 +218,7 @@ done:
 
 static struct platform_driver latch_addr_flash_driver = {
 	.probe		= latch_addr_flash_probe,
-	.remove		= __devexit_p(latch_addr_flash_remove),
+	.remove		= latch_addr_flash_remove,
 	.driver		= {
 		.name	= DRIVER_NAME,
 	},
diff --git a/drivers/mtd/maps/pci.c b/drivers/mtd/maps/pci.c
index 1c30c1a..ddc8c0c 100644
--- a/drivers/mtd/maps/pci.c
+++ b/drivers/mtd/maps/pci.c
@@ -326,7 +326,7 @@ mtd_pci_remove(struct pci_dev *dev)
 static struct pci_driver mtd_pci_driver = {
 	.name =		"MTD PCI",
 	.probe =	mtd_pci_probe,
-	.remove =	__devexit_p(mtd_pci_remove),
+	.remove =	mtd_pci_remove,
 	.id_table =	mtd_pci_ids,
 };
 
diff --git a/drivers/mtd/maps/pismo.c b/drivers/mtd/maps/pismo.c
index 65bd1cd..9f4e594 100644
--- a/drivers/mtd/maps/pismo.c
+++ b/drivers/mtd/maps/pismo.c
@@ -267,7 +267,7 @@ static struct i2c_driver pismo_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= pismo_probe,
-	.remove		= __devexit_p(pismo_remove),
+	.remove		= pismo_remove,
 	.id_table	= pismo_id,
 };
 
diff --git a/drivers/mtd/maps/pxa2xx-flash.c b/drivers/mtd/maps/pxa2xx-flash.c
index 81884c2..f913a1c 100644
--- a/drivers/mtd/maps/pxa2xx-flash.c
+++ b/drivers/mtd/maps/pxa2xx-flash.c
@@ -139,7 +139,7 @@ static struct platform_driver pxa2xx_flash_driver = {
 		.owner		= THIS_MODULE,
 	},
 	.probe		= pxa2xx_flash_probe,
-	.remove		= __devexit_p(pxa2xx_flash_remove),
+	.remove		= pxa2xx_flash_remove,
 	.shutdown	= pxa2xx_flash_shutdown,
 };
 
diff --git a/drivers/mtd/maps/scb2_flash.c b/drivers/mtd/maps/scb2_flash.c
index 9dcbc68..d527608 100644
--- a/drivers/mtd/maps/scb2_flash.c
+++ b/drivers/mtd/maps/scb2_flash.c
@@ -231,7 +231,7 @@ static struct pci_driver scb2_flash_driver = {
 	.name =     "Intel SCB2 BIOS Flash",
 	.id_table = scb2_flash_pci_ids,
 	.probe =    scb2_flash_probe,
-	.remove =   __devexit_p(scb2_flash_remove),
+	.remove =   scb2_flash_remove,
 };
 
 module_pci_driver(scb2_flash_driver);
diff --git a/drivers/mtd/maps/sun_uflash.c b/drivers/mtd/maps/sun_uflash.c
index 175e537..1c03ca7 100644
--- a/drivers/mtd/maps/sun_uflash.c
+++ b/drivers/mtd/maps/sun_uflash.c
@@ -155,7 +155,7 @@ static struct platform_driver uflash_driver = {
 		.of_match_table = uflash_match,
 	},
 	.probe		= uflash_probe,
-	.remove		= __devexit_p(uflash_remove),
+	.remove		= uflash_remove,
 };
 
 module_platform_driver(uflash_driver);
diff --git a/drivers/mtd/maps/vmu-flash.c b/drivers/mtd/maps/vmu-flash.c
index 2e2b094..5a83a26 100644
--- a/drivers/mtd/maps/vmu-flash.c
+++ b/drivers/mtd/maps/vmu-flash.c
@@ -802,7 +802,7 @@ static struct maple_driver vmu_flash_driver = {
 	.drv = {
 		.name =		"Dreamcast_visual_memory",
 		.probe =	probe_maple_vmu,
-		.remove = 	__devexit_p(remove_maple_vmu),
+		.remove =	remove_maple_vmu,
 	},
 };
 
diff --git a/drivers/mtd/nand/ams-delta.c b/drivers/mtd/nand/ams-delta.c
index 9e7723a..51dba43 100644
--- a/drivers/mtd/nand/ams-delta.c
+++ b/drivers/mtd/nand/ams-delta.c
@@ -289,7 +289,7 @@ static int __devexit ams_delta_cleanup(struct platform_device *pdev)
 
 static struct platform_driver ams_delta_nand_driver = {
 	.probe		= ams_delta_init,
-	.remove		= __devexit_p(ams_delta_cleanup),
+	.remove		= ams_delta_cleanup,
 	.driver		= {
 		.name	= "ams-delta-nand",
 		.owner	= THIS_MODULE,
diff --git a/drivers/mtd/nand/au1550nd.c b/drivers/mtd/nand/au1550nd.c
index 5c47b20..d84af46 100644
--- a/drivers/mtd/nand/au1550nd.c
+++ b/drivers/mtd/nand/au1550nd.c
@@ -509,7 +509,7 @@ static struct platform_driver au1550nd_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= au1550nd_probe,
-	.remove		= __devexit_p(au1550nd_remove),
+	.remove		= au1550nd_remove,
 };
 
 module_platform_driver(au1550nd_driver);
diff --git a/drivers/mtd/nand/bf5xx_nand.c b/drivers/mtd/nand/bf5xx_nand.c
index ab0caa7..0afd4ac 100644
--- a/drivers/mtd/nand/bf5xx_nand.c
+++ b/drivers/mtd/nand/bf5xx_nand.c
@@ -865,7 +865,7 @@ static int bf5xx_nand_resume(struct platform_device *dev)
 /* driver device registration */
 static struct platform_driver bf5xx_nand_driver = {
 	.probe		= bf5xx_nand_probe,
-	.remove		= __devexit_p(bf5xx_nand_remove),
+	.remove		= bf5xx_nand_remove,
 	.suspend	= bf5xx_nand_suspend,
 	.resume		= bf5xx_nand_resume,
 	.driver		= {
diff --git a/drivers/mtd/nand/cafe_nand.c b/drivers/mtd/nand/cafe_nand.c
index 2bb7170..1b62f04 100644
--- a/drivers/mtd/nand/cafe_nand.c
+++ b/drivers/mtd/nand/cafe_nand.c
@@ -887,7 +887,7 @@ static struct pci_driver cafe_nand_pci_driver = {
 	.name = "CAF? NAND",
 	.id_table = cafe_nand_tbl,
 	.probe = cafe_nand_probe,
-	.remove = __devexit_p(cafe_nand_remove),
+	.remove = cafe_nand_remove,
 	.resume = cafe_nand_resume,
 };
 
diff --git a/drivers/mtd/nand/denali_dt.c b/drivers/mtd/nand/denali_dt.c
index fbabbaa..445de7c 100644
--- a/drivers/mtd/nand/denali_dt.c
+++ b/drivers/mtd/nand/denali_dt.c
@@ -142,7 +142,7 @@ static int __devexit denali_dt_remove(struct platform_device *ofdev)
 
 static struct platform_driver denali_dt_driver = {
 	.probe		= denali_dt_probe,
-	.remove		= __devexit_p(denali_dt_remove),
+	.remove		= denali_dt_remove,
 	.driver		= {
 		.name	= "denali-nand-dt",
 		.owner	= THIS_MODULE,
diff --git a/drivers/mtd/nand/fsl_upm.c b/drivers/mtd/nand/fsl_upm.c
index 45df542..b40661d 100644
--- a/drivers/mtd/nand/fsl_upm.c
+++ b/drivers/mtd/nand/fsl_upm.c
@@ -350,7 +350,7 @@ static struct platform_driver of_fun_driver = {
 		.of_match_table = of_fun_match,
 	},
 	.probe		= fun_probe,
-	.remove		= __devexit_p(fun_remove),
+	.remove		= fun_remove,
 };
 
 module_platform_driver(of_fun_driver);
diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
index d376198..7ce6d01 100644
--- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
@@ -1692,7 +1692,7 @@ static struct platform_driver gpmi_nand_driver = {
 		.of_match_table = gpmi_nand_id_table,
 	},
 	.probe   = gpmi_nand_probe,
-	.remove  = __devexit_p(gpmi_nand_remove),
+	.remove  = gpmi_nand_remove,
 	.id_table = gpmi_ids,
 };
 module_platform_driver(gpmi_nand_driver);
diff --git a/drivers/mtd/nand/jz4740_nand.c b/drivers/mtd/nand/jz4740_nand.c
index 100b677..2552fe2 100644
--- a/drivers/mtd/nand/jz4740_nand.c
+++ b/drivers/mtd/nand/jz4740_nand.c
@@ -573,7 +573,7 @@ static int __devexit jz_nand_remove(struct platform_device *pdev)
 
 static struct platform_driver jz_nand_driver = {
 	.probe = jz_nand_probe,
-	.remove = __devexit_p(jz_nand_remove),
+	.remove = jz_nand_remove,
 	.driver = {
 		.name = "jz4740-nand",
 		.owner = THIS_MODULE,
diff --git a/drivers/mtd/nand/lpc32xx_mlc.c b/drivers/mtd/nand/lpc32xx_mlc.c
index c29b7ac..3115642 100644
--- a/drivers/mtd/nand/lpc32xx_mlc.c
+++ b/drivers/mtd/nand/lpc32xx_mlc.c
@@ -907,7 +907,7 @@ MODULE_DEVICE_TABLE(of, lpc32xx_nand_match);
 
 static struct platform_driver lpc32xx_nand_driver = {
 	.probe		= lpc32xx_nand_probe,
-	.remove		= __devexit_p(lpc32xx_nand_remove),
+	.remove		= lpc32xx_nand_remove,
 	.resume		= lpc32xx_nand_resume,
 	.suspend	= lpc32xx_nand_suspend,
 	.driver		= {
diff --git a/drivers/mtd/nand/lpc32xx_slc.c b/drivers/mtd/nand/lpc32xx_slc.c
index 32409c4..9e291b7 100644
--- a/drivers/mtd/nand/lpc32xx_slc.c
+++ b/drivers/mtd/nand/lpc32xx_slc.c
@@ -1021,7 +1021,7 @@ MODULE_DEVICE_TABLE(of, lpc32xx_nand_match);
 
 static struct platform_driver lpc32xx_nand_driver = {
 	.probe		= lpc32xx_nand_probe,
-	.remove		= __devexit_p(lpc32xx_nand_remove),
+	.remove		= lpc32xx_nand_remove,
 	.resume		= lpc32xx_nand_resume,
 	.suspend	= lpc32xx_nand_suspend,
 	.driver		= {
diff --git a/drivers/mtd/nand/mpc5121_nfc.c b/drivers/mtd/nand/mpc5121_nfc.c
index f776c85..17fe0c9 100644
--- a/drivers/mtd/nand/mpc5121_nfc.c
+++ b/drivers/mtd/nand/mpc5121_nfc.c
@@ -848,7 +848,7 @@ static struct of_device_id mpc5121_nfc_match[] __devinitdata = {
 
 static struct platform_driver mpc5121_nfc_driver = {
 	.probe		= mpc5121_nfc_probe,
-	.remove		= __devexit_p(mpc5121_nfc_remove),
+	.remove		= mpc5121_nfc_remove,
 	.driver		= {
 		.name = DRV_NAME,
 		.owner = THIS_MODULE,
diff --git a/drivers/mtd/nand/mxc_nand.c b/drivers/mtd/nand/mxc_nand.c
index 022dcdc..fbcb317 100644
--- a/drivers/mtd/nand/mxc_nand.c
+++ b/drivers/mtd/nand/mxc_nand.c
@@ -1580,7 +1580,7 @@ static struct platform_driver mxcnd_driver = {
 	},
 	.id_table = mxcnd_devtype,
 	.probe = mxcnd_probe,
-	.remove = __devexit_p(mxcnd_remove),
+	.remove = mxcnd_remove,
 };
 module_platform_driver(mxcnd_driver);
 
diff --git a/drivers/mtd/nand/ndfc.c b/drivers/mtd/nand/ndfc.c
index 5fd3f01..32e6bef 100644
--- a/drivers/mtd/nand/ndfc.c
+++ b/drivers/mtd/nand/ndfc.c
@@ -279,7 +279,7 @@ static struct platform_driver ndfc_driver = {
 		.of_match_table = ndfc_match,
 	},
 	.probe = ndfc_probe,
-	.remove = __devexit_p(ndfc_remove),
+	.remove = ndfc_remove,
 };
 
 module_platform_driver(ndfc_driver);
diff --git a/drivers/mtd/nand/nuc900_nand.c b/drivers/mtd/nand/nuc900_nand.c
index 94dc46bc..eed134c 100644
--- a/drivers/mtd/nand/nuc900_nand.c
+++ b/drivers/mtd/nand/nuc900_nand.c
@@ -340,7 +340,7 @@ static int __devexit nuc900_nand_remove(struct platform_device *pdev)
 
 static struct platform_driver nuc900_nand_driver = {
 	.probe		= nuc900_nand_probe,
-	.remove		= __devexit_p(nuc900_nand_remove),
+	.remove		= nuc900_nand_remove,
 	.driver		= {
 		.name	= "nuc900-fmi",
 		.owner	= THIS_MODULE,
diff --git a/drivers/mtd/nand/orion_nand.c b/drivers/mtd/nand/orion_nand.c
index aefaf8c..e6b296d 100644
--- a/drivers/mtd/nand/orion_nand.c
+++ b/drivers/mtd/nand/orion_nand.c
@@ -223,7 +223,7 @@ static struct of_device_id orion_nand_of_match_table[] = {
 #endif
 
 static struct platform_driver orion_nand_driver = {
-	.remove		= __devexit_p(orion_nand_remove),
+	.remove		= orion_nand_remove,
 	.driver		= {
 		.name	= "orion_nand",
 		.owner	= THIS_MODULE,
diff --git a/drivers/mtd/nand/plat_nand.c b/drivers/mtd/nand/plat_nand.c
index a47ee68..95a1dba 100644
--- a/drivers/mtd/nand/plat_nand.c
+++ b/drivers/mtd/nand/plat_nand.c
@@ -160,7 +160,7 @@ MODULE_DEVICE_TABLE(of, plat_nand_match);
 
 static struct platform_driver plat_nand_driver = {
 	.probe	= plat_nand_probe,
-	.remove	= __devexit_p(plat_nand_remove),
+	.remove	= plat_nand_remove,
 	.driver	= {
 		.name		= "gen_nand",
 		.owner		= THIS_MODULE,
diff --git a/drivers/mtd/nand/sharpsl.c b/drivers/mtd/nand/sharpsl.c
index 3421e37..541fd51 100644
--- a/drivers/mtd/nand/sharpsl.c
+++ b/drivers/mtd/nand/sharpsl.c
@@ -228,7 +228,7 @@ static struct platform_driver sharpsl_nand_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= sharpsl_nand_probe,
-	.remove		= __devexit_p(sharpsl_nand_remove),
+	.remove		= sharpsl_nand_remove,
 };
 
 module_platform_driver(sharpsl_nand_driver);
diff --git a/drivers/mtd/nand/socrates_nand.c b/drivers/mtd/nand/socrates_nand.c
index f3f28fa..78b1a04 100644
--- a/drivers/mtd/nand/socrates_nand.c
+++ b/drivers/mtd/nand/socrates_nand.c
@@ -251,7 +251,7 @@ static struct platform_driver socrates_nand_driver = {
 		.of_match_table = socrates_nand_match,
 	},
 	.probe		= socrates_nand_probe,
-	.remove		= __devexit_p(socrates_nand_remove),
+	.remove		= socrates_nand_remove,
 };
 
 module_platform_driver(socrates_nand_driver);
diff --git a/drivers/mtd/onenand/generic.c b/drivers/mtd/onenand/generic.c
index 1c4f97c..27aa44a 100644
--- a/drivers/mtd/onenand/generic.c
+++ b/drivers/mtd/onenand/generic.c
@@ -112,7 +112,7 @@ static struct platform_driver generic_onenand_driver = {
 		.owner		= THIS_MODULE,
 	},
 	.probe		= generic_onenand_probe,
-	.remove		= __devexit_p(generic_onenand_remove),
+	.remove		= generic_onenand_remove,
 };
 
 module_platform_driver(generic_onenand_driver);
diff --git a/drivers/mtd/onenand/omap2.c b/drivers/mtd/onenand/omap2.c
index 99f96e1..cb8ba6a 100644
--- a/drivers/mtd/onenand/omap2.c
+++ b/drivers/mtd/onenand/omap2.c
@@ -822,7 +822,7 @@ static int __devexit omap2_onenand_remove(struct platform_device *pdev)
 
 static struct platform_driver omap2_onenand_driver = {
 	.probe		= omap2_onenand_probe,
-	.remove		= __devexit_p(omap2_onenand_remove),
+	.remove		= omap2_onenand_remove,
 	.shutdown	= omap2_onenand_shutdown,
 	.driver		= {
 		.name	= DRIVER_NAME,
diff --git a/drivers/mtd/onenand/samsung.c b/drivers/mtd/onenand/samsung.c
index 8e4b3f2..3d462cb 100644
--- a/drivers/mtd/onenand/samsung.c
+++ b/drivers/mtd/onenand/samsung.c
@@ -1130,7 +1130,7 @@ static struct platform_driver s3c_onenand_driver = {
 	},
 	.id_table	= s3c_onenand_driver_ids,
 	.probe          = s3c_onenand_probe,
-	.remove         = __devexit_p(s3c_onenand_remove),
+	.remove         = s3c_onenand_remove,
 };
 
 module_platform_driver(s3c_onenand_driver);
-- 
1.8.0
