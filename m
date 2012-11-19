From: wfp5p@virginia.edu (Bill Pemberton)
Date: Mon, 19 Nov 2012 13:26:01 -0500
Subject: [PATCH 412/493] mfd: remove use of __devexit
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Message-ID: <1353349642-3677-412-git-send-email-wfp5p@virginia.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_HOTPLUG is going away as an option so __devexit is no
longer needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com> 
Cc: Peter Tyser <ptyser@xes-inc.com> 
Cc: David Brown <davidb@codeaurora.org> 
Cc: Daniel Walker <dwalker@fifo99.com> 
Cc: Bryan Huntsman <bryanh@codeaurora.org> 
Cc: linux-arm-kernel at lists.infradead.org 
Cc: device-drivers-devel at blackfin.uclinux.org 
Cc: patches at opensource.wolfsonmicro.com 
Cc: linux-arm-msm at vger.kernel.org 
---
 drivers/mfd/88pm800.c             | 2 +-
 drivers/mfd/88pm805.c             | 2 +-
 drivers/mfd/88pm860x-core.c       | 4 ++--
 drivers/mfd/ab3100-core.c         | 2 +-
 drivers/mfd/ab8500-core.c         | 2 +-
 drivers/mfd/ab8500-debugfs.c      | 2 +-
 drivers/mfd/ab8500-gpadc.c        | 2 +-
 drivers/mfd/ab8500-sysctrl.c      | 2 +-
 drivers/mfd/adp5520.c             | 2 +-
 drivers/mfd/arizona-core.c        | 2 +-
 drivers/mfd/arizona-i2c.c         | 2 +-
 drivers/mfd/arizona-spi.c         | 2 +-
 drivers/mfd/asic3.c               | 2 +-
 drivers/mfd/cs5535-mfd.c          | 2 +-
 drivers/mfd/da903x.c              | 2 +-
 drivers/mfd/da9052-i2c.c          | 2 +-
 drivers/mfd/da9052-spi.c          | 2 +-
 drivers/mfd/da9055-core.c         | 2 +-
 drivers/mfd/da9055-i2c.c          | 2 +-
 drivers/mfd/davinci_voicecodec.c  | 2 +-
 drivers/mfd/ezx-pcap.c            | 2 +-
 drivers/mfd/intel_msic.c          | 4 ++--
 drivers/mfd/janz-cmodio.c         | 2 +-
 drivers/mfd/jz4740-adc.c          | 2 +-
 drivers/mfd/lm3533-core.c         | 4 ++--
 drivers/mfd/lp8788.c              | 2 +-
 drivers/mfd/lpc_ich.c             | 2 +-
 drivers/mfd/lpc_sch.c             | 2 +-
 drivers/mfd/max8907.c             | 2 +-
 drivers/mfd/max8925-core.c        | 2 +-
 drivers/mfd/max8925-i2c.c         | 2 +-
 drivers/mfd/mc13xxx-i2c.c         | 2 +-
 drivers/mfd/mc13xxx-spi.c         | 2 +-
 drivers/mfd/omap-usb-host.c       | 2 +-
 drivers/mfd/omap-usb-tll.c        | 2 +-
 drivers/mfd/pcf50633-adc.c        | 2 +-
 drivers/mfd/pcf50633-core.c       | 2 +-
 drivers/mfd/pm8921-core.c         | 2 +-
 drivers/mfd/pm8xxx-irq.c          | 2 +-
 drivers/mfd/rc5t583.c             | 2 +-
 drivers/mfd/rdc321x-southbridge.c | 2 +-
 drivers/mfd/rtsx_pcr.c            | 2 +-
 drivers/mfd/sm501.c               | 2 +-
 drivers/mfd/sta2x11-mfd.c         | 2 +-
 drivers/mfd/stmpe-i2c.c           | 2 +-
 drivers/mfd/stmpe-spi.c           | 2 +-
 drivers/mfd/syscon.c              | 2 +-
 drivers/mfd/tc3589x.c             | 2 +-
 drivers/mfd/tc6387xb.c            | 2 +-
 drivers/mfd/tc6393xb.c            | 2 +-
 drivers/mfd/ti-ssp.c              | 2 +-
 drivers/mfd/ti_am335x_tscadc.c    | 2 +-
 drivers/mfd/timberdale.c          | 2 +-
 drivers/mfd/tps6105x.c            | 2 +-
 drivers/mfd/tps65090.c            | 2 +-
 drivers/mfd/tps65217.c            | 2 +-
 drivers/mfd/tps6586x.c            | 2 +-
 drivers/mfd/tps65910.c            | 2 +-
 drivers/mfd/tps65911-comparator.c | 2 +-
 drivers/mfd/tps65912-spi.c        | 2 +-
 drivers/mfd/twl4030-audio.c       | 2 +-
 drivers/mfd/twl4030-madc.c        | 2 +-
 drivers/mfd/twl6040.c             | 2 +-
 drivers/mfd/vx855.c               | 2 +-
 drivers/mfd/wm831x-spi.c          | 2 +-
 drivers/mfd/wm8994-core.c         | 4 ++--
 include/linux/mfd/abx500/ab8500.h | 2 +-
 include/linux/mfd/pm8xxx/irq.h    | 4 ++--
 68 files changed, 73 insertions(+), 73 deletions(-)

diff --git a/drivers/mfd/88pm800.c b/drivers/mfd/88pm800.c
index 6746ecd..391e23e 100644
--- a/drivers/mfd/88pm800.c
+++ b/drivers/mfd/88pm800.c
@@ -554,7 +554,7 @@ out_init:
 	return ret;
 }
 
-static int __devexit pm800_remove(struct i2c_client *client)
+static int pm800_remove(struct i2c_client *client)
 {
 	struct pm80x_chip *chip = i2c_get_clientdata(client);
 
diff --git a/drivers/mfd/88pm805.c b/drivers/mfd/88pm805.c
index 13c0994..e671230 100644
--- a/drivers/mfd/88pm805.c
+++ b/drivers/mfd/88pm805.c
@@ -262,7 +262,7 @@ out_init:
 	return ret;
 }
 
-static int __devexit pm805_remove(struct i2c_client *client)
+static int pm805_remove(struct i2c_client *client)
 {
 	struct pm80x_chip *chip = i2c_get_clientdata(client);
 
diff --git a/drivers/mfd/88pm860x-core.c b/drivers/mfd/88pm860x-core.c
index 20dd0d4..893fc1b 100644
--- a/drivers/mfd/88pm860x-core.c
+++ b/drivers/mfd/88pm860x-core.c
@@ -1077,7 +1077,7 @@ static int pm860x_device_init(struct pm860x_chip *chip,
 	return 0;
 }
 
-static void __devexit pm860x_device_exit(struct pm860x_chip *chip)
+static void pm860x_device_exit(struct pm860x_chip *chip)
 {
 	device_irq_exit(chip);
 	mfd_remove_devices(chip->dev);
@@ -1200,7 +1200,7 @@ err:
 	return ret;
 }
 
-static int __devexit pm860x_remove(struct i2c_client *client)
+static int pm860x_remove(struct i2c_client *client)
 {
 	struct pm860x_chip *chip = i2c_get_clientdata(client);
 
diff --git a/drivers/mfd/ab3100-core.c b/drivers/mfd/ab3100-core.c
index bf188bc..2ec7725 100644
--- a/drivers/mfd/ab3100-core.c
+++ b/drivers/mfd/ab3100-core.c
@@ -961,7 +961,7 @@ static int ab3100_probe(struct i2c_client *client,
 	return err;
 }
 
-static int __devexit ab3100_remove(struct i2c_client *client)
+static int ab3100_remove(struct i2c_client *client)
 {
 	struct ab3100 *ab3100 = i2c_get_clientdata(client);
 
diff --git a/drivers/mfd/ab8500-core.c b/drivers/mfd/ab8500-core.c
index d02d9f9..280a5eb 100644
--- a/drivers/mfd/ab8500-core.c
+++ b/drivers/mfd/ab8500-core.c
@@ -1418,7 +1418,7 @@ static int ab8500_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int __devexit ab8500_remove(struct platform_device *pdev)
+static int ab8500_remove(struct platform_device *pdev)
 {
 	struct ab8500 *ab8500 = platform_get_drvdata(pdev);
 
diff --git a/drivers/mfd/ab8500-debugfs.c b/drivers/mfd/ab8500-debugfs.c
index 4484368..5a8e707 100644
--- a/drivers/mfd/ab8500-debugfs.c
+++ b/drivers/mfd/ab8500-debugfs.c
@@ -597,7 +597,7 @@ exit_no_debugfs:
 	return -ENOMEM;
 }
 
-static int __devexit ab8500_debug_remove(struct platform_device *plf)
+static int ab8500_debug_remove(struct platform_device *plf)
 {
 	debugfs_remove(ab8500_val_file);
 	debugfs_remove(ab8500_address_file);
diff --git a/drivers/mfd/ab8500-gpadc.c b/drivers/mfd/ab8500-gpadc.c
index c5e168e..3fb1f40d 100644
--- a/drivers/mfd/ab8500-gpadc.c
+++ b/drivers/mfd/ab8500-gpadc.c
@@ -634,7 +634,7 @@ fail:
 	return ret;
 }
 
-static int __devexit ab8500_gpadc_remove(struct platform_device *pdev)
+static int ab8500_gpadc_remove(struct platform_device *pdev)
 {
 	struct ab8500_gpadc *gpadc = platform_get_drvdata(pdev);
 
diff --git a/drivers/mfd/ab8500-sysctrl.c b/drivers/mfd/ab8500-sysctrl.c
index 499263c..8a33b2c 100644
--- a/drivers/mfd/ab8500-sysctrl.c
+++ b/drivers/mfd/ab8500-sysctrl.c
@@ -55,7 +55,7 @@ static int ab8500_sysctrl_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit ab8500_sysctrl_remove(struct platform_device *pdev)
+static int ab8500_sysctrl_remove(struct platform_device *pdev)
 {
 	sysctrl_dev = NULL;
 	return 0;
diff --git a/drivers/mfd/adp5520.c b/drivers/mfd/adp5520.c
index f2f9d8f..210dd03 100644
--- a/drivers/mfd/adp5520.c
+++ b/drivers/mfd/adp5520.c
@@ -307,7 +307,7 @@ out_free_chip:
 	return ret;
 }
 
-static int __devexit adp5520_remove(struct i2c_client *client)
+static int adp5520_remove(struct i2c_client *client)
 {
 	struct adp5520_chip *chip = dev_get_drvdata(&client->dev);
 
diff --git a/drivers/mfd/arizona-core.c b/drivers/mfd/arizona-core.c
index 47e7116..12fdabf 100644
--- a/drivers/mfd/arizona-core.c
+++ b/drivers/mfd/arizona-core.c
@@ -553,7 +553,7 @@ err_early:
 }
 EXPORT_SYMBOL_GPL(arizona_dev_init);
 
-int __devexit arizona_dev_exit(struct arizona *arizona)
+int arizona_dev_exit(struct arizona *arizona)
 {
 	mfd_remove_devices(arizona->dev);
 	arizona_free_irq(arizona, ARIZONA_IRQ_UNDERCLOCKED, arizona);
diff --git a/drivers/mfd/arizona-i2c.c b/drivers/mfd/arizona-i2c.c
index aaf1a69..44a1bb9 100644
--- a/drivers/mfd/arizona-i2c.c
+++ b/drivers/mfd/arizona-i2c.c
@@ -65,7 +65,7 @@ static int arizona_i2c_probe(struct i2c_client *i2c,
 	return arizona_dev_init(arizona);
 }
 
-static int __devexit arizona_i2c_remove(struct i2c_client *i2c)
+static int arizona_i2c_remove(struct i2c_client *i2c)
 {
 	struct arizona *arizona = dev_get_drvdata(&i2c->dev);
 	arizona_dev_exit(arizona);
diff --git a/drivers/mfd/arizona-spi.c b/drivers/mfd/arizona-spi.c
index 9663caf..1b9fdd6 100644
--- a/drivers/mfd/arizona-spi.c
+++ b/drivers/mfd/arizona-spi.c
@@ -65,7 +65,7 @@ static int arizona_spi_probe(struct spi_device *spi)
 	return arizona_dev_init(arizona);
 }
 
-static int __devexit arizona_spi_remove(struct spi_device *spi)
+static int arizona_spi_remove(struct spi_device *spi)
 {
 	struct arizona *arizona = dev_get_drvdata(&spi->dev);
 	arizona_dev_exit(arizona);
diff --git a/drivers/mfd/asic3.c b/drivers/mfd/asic3.c
index b0720d7..1b15986 100644
--- a/drivers/mfd/asic3.c
+++ b/drivers/mfd/asic3.c
@@ -1039,7 +1039,7 @@ static int __init asic3_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int __devexit asic3_remove(struct platform_device *pdev)
+static int asic3_remove(struct platform_device *pdev)
 {
 	int ret;
 	struct asic3 *asic = platform_get_drvdata(pdev);
diff --git a/drivers/mfd/cs5535-mfd.c b/drivers/mfd/cs5535-mfd.c
index d9dc87f..2e4752a 100644
--- a/drivers/mfd/cs5535-mfd.c
+++ b/drivers/mfd/cs5535-mfd.c
@@ -166,7 +166,7 @@ err_disable:
 	return err;
 }
 
-static void __devexit cs5535_mfd_remove(struct pci_dev *pdev)
+static void cs5535_mfd_remove(struct pci_dev *pdev)
 {
 	mfd_remove_devices(&pdev->dev);
 	pci_disable_device(pdev);
diff --git a/drivers/mfd/da903x.c b/drivers/mfd/da903x.c
index 5fa1e91..05176cd 100644
--- a/drivers/mfd/da903x.c
+++ b/drivers/mfd/da903x.c
@@ -544,7 +544,7 @@ out_free_chip:
 	return ret;
 }
 
-static int __devexit da903x_remove(struct i2c_client *client)
+static int da903x_remove(struct i2c_client *client)
 {
 	struct da903x_chip *chip = i2c_get_clientdata(client);
 
diff --git a/drivers/mfd/da9052-i2c.c b/drivers/mfd/da9052-i2c.c
index 96f66ed..ac74a4d 100644
--- a/drivers/mfd/da9052-i2c.c
+++ b/drivers/mfd/da9052-i2c.c
@@ -121,7 +121,7 @@ static int da9052_i2c_probe(struct i2c_client *client,
 	return 0;
 }
 
-static int __devexit da9052_i2c_remove(struct i2c_client *client)
+static int da9052_i2c_remove(struct i2c_client *client)
 {
 	struct da9052 *da9052 = i2c_get_clientdata(client);
 
diff --git a/drivers/mfd/da9052-spi.c b/drivers/mfd/da9052-spi.c
index 1ad3243..61d63b9 100644
--- a/drivers/mfd/da9052-spi.c
+++ b/drivers/mfd/da9052-spi.c
@@ -58,7 +58,7 @@ static int da9052_spi_probe(struct spi_device *spi)
 	return 0;
 }
 
-static int __devexit da9052_spi_remove(struct spi_device *spi)
+static int da9052_spi_remove(struct spi_device *spi)
 {
 	struct da9052 *da9052 = dev_get_drvdata(&spi->dev);
 
diff --git a/drivers/mfd/da9055-core.c b/drivers/mfd/da9055-core.c
index 6f5a4984..f56a1a9 100644
--- a/drivers/mfd/da9055-core.c
+++ b/drivers/mfd/da9055-core.c
@@ -412,7 +412,7 @@ err:
 	return ret;
 }
 
-void __devexit da9055_device_exit(struct da9055 *da9055)
+void da9055_device_exit(struct da9055 *da9055)
 {
 	regmap_del_irq_chip(da9055->chip_irq, da9055->irq_data);
 	mfd_remove_devices(da9055->dev);
diff --git a/drivers/mfd/da9055-i2c.c b/drivers/mfd/da9055-i2c.c
index 7778d04..607387f 100644
--- a/drivers/mfd/da9055-i2c.c
+++ b/drivers/mfd/da9055-i2c.c
@@ -44,7 +44,7 @@ static int da9055_i2c_probe(struct i2c_client *i2c,
 	return da9055_device_init(da9055);
 }
 
-static int __devexit da9055_i2c_remove(struct i2c_client *i2c)
+static int da9055_i2c_remove(struct i2c_client *i2c)
 {
 	struct da9055 *da9055 = i2c_get_clientdata(i2c);
 
diff --git a/drivers/mfd/davinci_voicecodec.c b/drivers/mfd/davinci_voicecodec.c
index b2b0397..c0bcc87 100644
--- a/drivers/mfd/davinci_voicecodec.c
+++ b/drivers/mfd/davinci_voicecodec.c
@@ -151,7 +151,7 @@ fail1:
 	return ret;
 }
 
-static int __devexit davinci_vc_remove(struct platform_device *pdev)
+static int davinci_vc_remove(struct platform_device *pdev)
 {
 	struct davinci_vc *davinci_vc = platform_get_drvdata(pdev);
 
diff --git a/drivers/mfd/ezx-pcap.c b/drivers/mfd/ezx-pcap.c
index d81505e..b7a61f0 100644
--- a/drivers/mfd/ezx-pcap.c
+++ b/drivers/mfd/ezx-pcap.c
@@ -391,7 +391,7 @@ static int pcap_add_subdev(struct pcap_chip *pcap,
 	return ret;
 }
 
-static int __devexit ezx_pcap_remove(struct spi_device *spi)
+static int ezx_pcap_remove(struct spi_device *spi)
 {
 	struct pcap_chip *pcap = dev_get_drvdata(&spi->dev);
 	struct pcap_platform_data *pdata = spi->dev.platform_data;
diff --git a/drivers/mfd/intel_msic.c b/drivers/mfd/intel_msic.c
index 438ac3d..ab8d0b2 100644
--- a/drivers/mfd/intel_msic.c
+++ b/drivers/mfd/intel_msic.c
@@ -364,7 +364,7 @@ fail:
 	return ret;
 }
 
-static void __devexit intel_msic_remove_devices(struct intel_msic *msic)
+static void intel_msic_remove_devices(struct intel_msic *msic)
 {
 	struct platform_device *pdev = msic->pdev;
 	struct intel_msic_platform_data *pdata = pdev->dev.platform_data;
@@ -445,7 +445,7 @@ static int intel_msic_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit intel_msic_remove(struct platform_device *pdev)
+static int intel_msic_remove(struct platform_device *pdev)
 {
 	struct intel_msic *msic = platform_get_drvdata(pdev);
 
diff --git a/drivers/mfd/janz-cmodio.c b/drivers/mfd/janz-cmodio.c
index 55c479e..45ece11 100644
--- a/drivers/mfd/janz-cmodio.c
+++ b/drivers/mfd/janz-cmodio.c
@@ -254,7 +254,7 @@ out_return:
 	return ret;
 }
 
-static void __devexit cmodio_pci_remove(struct pci_dev *dev)
+static void cmodio_pci_remove(struct pci_dev *dev)
 {
 	struct cmodio_device *priv = pci_get_drvdata(dev);
 
diff --git a/drivers/mfd/jz4740-adc.c b/drivers/mfd/jz4740-adc.c
index c0d38c5..0b8b55b 100644
--- a/drivers/mfd/jz4740-adc.c
+++ b/drivers/mfd/jz4740-adc.c
@@ -307,7 +307,7 @@ err_free:
 	return ret;
 }
 
-static int __devexit jz4740_adc_remove(struct platform_device *pdev)
+static int jz4740_adc_remove(struct platform_device *pdev)
 {
 	struct jz4740_adc *adc = platform_get_drvdata(pdev);
 
diff --git a/drivers/mfd/lm3533-core.c b/drivers/mfd/lm3533-core.c
index 2b74508..ceebf2c 100644
--- a/drivers/mfd/lm3533-core.c
+++ b/drivers/mfd/lm3533-core.c
@@ -534,7 +534,7 @@ err_disable:
 	return ret;
 }
 
-static void __devexit lm3533_device_exit(struct lm3533 *lm3533)
+static void lm3533_device_exit(struct lm3533 *lm3533)
 {
 	dev_dbg(lm3533->dev, "%s\n", __func__);
 
@@ -624,7 +624,7 @@ static int lm3533_i2c_probe(struct i2c_client *i2c,
 	return 0;
 }
 
-static int __devexit lm3533_i2c_remove(struct i2c_client *i2c)
+static int lm3533_i2c_remove(struct i2c_client *i2c)
 {
 	struct lm3533 *lm3533 = i2c_get_clientdata(i2c);
 
diff --git a/drivers/mfd/lp8788.c b/drivers/mfd/lp8788.c
index e1d7c9f..c3d3c9b 100644
--- a/drivers/mfd/lp8788.c
+++ b/drivers/mfd/lp8788.c
@@ -203,7 +203,7 @@ static int lp8788_probe(struct i2c_client *cl, const struct i2c_device_id *id)
 			       ARRAY_SIZE(lp8788_devs), NULL, 0, NULL);
 }
 
-static int __devexit lp8788_remove(struct i2c_client *cl)
+static int lp8788_remove(struct i2c_client *cl)
 {
 	struct lp8788 *lp = i2c_get_clientdata(cl);
 
diff --git a/drivers/mfd/lpc_ich.c b/drivers/mfd/lpc_ich.c
index 7c83e1b..2ad24ca 100644
--- a/drivers/mfd/lpc_ich.c
+++ b/drivers/mfd/lpc_ich.c
@@ -878,7 +878,7 @@ static int lpc_ich_probe(struct pci_dev *dev,
 	return 0;
 }
 
-static void __devexit lpc_ich_remove(struct pci_dev *dev)
+static void lpc_ich_remove(struct pci_dev *dev)
 {
 	mfd_remove_devices(&dev->dev);
 	lpc_ich_restore_config_space(dev);
diff --git a/drivers/mfd/lpc_sch.c b/drivers/mfd/lpc_sch.c
index 5756a6a..5624fcb 100644
--- a/drivers/mfd/lpc_sch.c
+++ b/drivers/mfd/lpc_sch.c
@@ -164,7 +164,7 @@ out_dev:
 	return ret;
 }
 
-static void __devexit lpc_sch_remove(struct pci_dev *dev)
+static void lpc_sch_remove(struct pci_dev *dev)
 {
 	mfd_remove_devices(&dev->dev);
 }
diff --git a/drivers/mfd/max8907.c b/drivers/mfd/max8907.c
index 81ded7a..e9b1c93 100644
--- a/drivers/mfd/max8907.c
+++ b/drivers/mfd/max8907.c
@@ -288,7 +288,7 @@ err_alloc_drvdata:
 	return ret;
 }
 
-static __devexit int max8907_i2c_remove(struct i2c_client *i2c)
+static int max8907_i2c_remove(struct i2c_client *i2c)
 {
 	struct max8907 *max8907 = i2c_get_clientdata(i2c);
 
diff --git a/drivers/mfd/max8925-core.c b/drivers/mfd/max8925-core.c
index 60325c4..e32466e 100644
--- a/drivers/mfd/max8925-core.c
+++ b/drivers/mfd/max8925-core.c
@@ -901,7 +901,7 @@ out:
 	return ret;
 }
 
-void __devexit max8925_device_exit(struct max8925_chip *chip)
+void max8925_device_exit(struct max8925_chip *chip)
 {
 	if (chip->core_irq)
 		free_irq(chip->core_irq, chip);
diff --git a/drivers/mfd/max8925-i2c.c b/drivers/mfd/max8925-i2c.c
index 6e3d30a..00b5b45 100644
--- a/drivers/mfd/max8925-i2c.c
+++ b/drivers/mfd/max8925-i2c.c
@@ -168,7 +168,7 @@ static int max8925_probe(struct i2c_client *client,
 	return 0;
 }
 
-static int __devexit max8925_remove(struct i2c_client *client)
+static int max8925_remove(struct i2c_client *client)
 {
 	struct max8925_chip *chip = i2c_get_clientdata(client);
 
diff --git a/drivers/mfd/mc13xxx-i2c.c b/drivers/mfd/mc13xxx-i2c.c
index 71e0386..f745e27 100644
--- a/drivers/mfd/mc13xxx-i2c.c
+++ b/drivers/mfd/mc13xxx-i2c.c
@@ -95,7 +95,7 @@ static int mc13xxx_i2c_probe(struct i2c_client *client,
 	return ret;
 }
 
-static int __devexit mc13xxx_i2c_remove(struct i2c_client *client)
+static int mc13xxx_i2c_remove(struct i2c_client *client)
 {
 	struct mc13xxx *mc13xxx = dev_get_drvdata(&client->dev);
 
diff --git a/drivers/mfd/mc13xxx-spi.c b/drivers/mfd/mc13xxx-spi.c
index bfe72be..3032bae 100644
--- a/drivers/mfd/mc13xxx-spi.c
+++ b/drivers/mfd/mc13xxx-spi.c
@@ -162,7 +162,7 @@ static int mc13xxx_spi_probe(struct spi_device *spi)
 	return mc13xxx_common_init(mc13xxx, pdata, spi->irq);
 }
 
-static int __devexit mc13xxx_spi_remove(struct spi_device *spi)
+static int mc13xxx_spi_remove(struct spi_device *spi)
 {
 	struct mc13xxx *mc13xxx = dev_get_drvdata(&spi->dev);
 
diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
index 46f7982..770a0d0 100644
--- a/drivers/mfd/omap-usb-host.c
+++ b/drivers/mfd/omap-usb-host.c
@@ -655,7 +655,7 @@ end_probe:
  *
  * Reverses the effect of usbhs_omap_probe().
  */
-static int __devexit usbhs_omap_remove(struct platform_device *pdev)
+static int usbhs_omap_remove(struct platform_device *pdev)
 {
 	struct usbhs_hcd_omap *omap = platform_get_drvdata(pdev);
 
diff --git a/drivers/mfd/omap-usb-tll.c b/drivers/mfd/omap-usb-tll.c
index d1332c7..eb86915 100644
--- a/drivers/mfd/omap-usb-tll.c
+++ b/drivers/mfd/omap-usb-tll.c
@@ -348,7 +348,7 @@ end:
  *
  * Reverses the effect of usbtll_omap_probe().
  */
-static int __devexit usbtll_omap_remove(struct platform_device *pdev)
+static int usbtll_omap_remove(struct platform_device *pdev)
 {
 	struct usbtll_omap *tll = platform_get_drvdata(pdev);
 
diff --git a/drivers/mfd/pcf50633-adc.c b/drivers/mfd/pcf50633-adc.c
index dbd2f0d..18b53cb 100644
--- a/drivers/mfd/pcf50633-adc.c
+++ b/drivers/mfd/pcf50633-adc.c
@@ -218,7 +218,7 @@ static int pcf50633_adc_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit pcf50633_adc_remove(struct platform_device *pdev)
+static int pcf50633_adc_remove(struct platform_device *pdev)
 {
 	struct pcf50633_adc *adc = platform_get_drvdata(pdev);
 	int i, head;
diff --git a/drivers/mfd/pcf50633-core.c b/drivers/mfd/pcf50633-core.c
index fc47735..64803f1 100644
--- a/drivers/mfd/pcf50633-core.c
+++ b/drivers/mfd/pcf50633-core.c
@@ -275,7 +275,7 @@ static int pcf50633_probe(struct i2c_client *client,
 	return 0;
 }
 
-static int __devexit pcf50633_remove(struct i2c_client *client)
+static int pcf50633_remove(struct i2c_client *client)
 {
 	struct pcf50633 *pcf = i2c_get_clientdata(client);
 	int i;
diff --git a/drivers/mfd/pm8921-core.c b/drivers/mfd/pm8921-core.c
index 4349134..d4b297c 100644
--- a/drivers/mfd/pm8921-core.c
+++ b/drivers/mfd/pm8921-core.c
@@ -165,7 +165,7 @@ err_read_rev:
 	return rc;
 }
 
-static int __devexit pm8921_remove(struct platform_device *pdev)
+static int pm8921_remove(struct platform_device *pdev)
 {
 	struct pm8xxx_drvdata *drvdata;
 	struct pm8921 *pmic = NULL;
diff --git a/drivers/mfd/pm8xxx-irq.c b/drivers/mfd/pm8xxx-irq.c
index 59c20ea..1360e20 100644
--- a/drivers/mfd/pm8xxx-irq.c
+++ b/drivers/mfd/pm8xxx-irq.c
@@ -363,7 +363,7 @@ struct pm_irq_chip *  pm8xxx_irq_init(struct device *dev,
 	return chip;
 }
 
-int __devexit pm8xxx_irq_exit(struct pm_irq_chip *chip)
+int pm8xxx_irq_exit(struct pm_irq_chip *chip)
 {
 	irq_set_chained_handler(chip->devirq, NULL);
 	kfree(chip);
diff --git a/drivers/mfd/rc5t583.c b/drivers/mfd/rc5t583.c
index f721b13..14bdacc 100644
--- a/drivers/mfd/rc5t583.c
+++ b/drivers/mfd/rc5t583.c
@@ -303,7 +303,7 @@ err_add_devs:
 	return ret;
 }
 
-static int  __devexit rc5t583_i2c_remove(struct i2c_client *i2c)
+static int  rc5t583_i2c_remove(struct i2c_client *i2c)
 {
 	struct rc5t583 *rc5t583 = i2c_get_clientdata(i2c);
 
diff --git a/drivers/mfd/rdc321x-southbridge.c b/drivers/mfd/rdc321x-southbridge.c
index be46539..21b7bef 100644
--- a/drivers/mfd/rdc321x-southbridge.c
+++ b/drivers/mfd/rdc321x-southbridge.c
@@ -91,7 +91,7 @@ static int rdc321x_sb_probe(struct pci_dev *pdev,
 			       NULL, 0, NULL);
 }
 
-static void __devexit rdc321x_sb_remove(struct pci_dev *pdev)
+static void rdc321x_sb_remove(struct pci_dev *pdev)
 {
 	mfd_remove_devices(&pdev->dev);
 }
diff --git a/drivers/mfd/rtsx_pcr.c b/drivers/mfd/rtsx_pcr.c
index 7c3b635..801fbb3 100644
--- a/drivers/mfd/rtsx_pcr.c
+++ b/drivers/mfd/rtsx_pcr.c
@@ -1123,7 +1123,7 @@ disable:
 	return ret;
 }
 
-static void __devexit rtsx_pci_remove(struct pci_dev *pcidev)
+static void rtsx_pci_remove(struct pci_dev *pcidev)
 {
 	struct pcr_handle *handle = pci_get_drvdata(pcidev);
 	struct rtsx_pcr *pcr = handle->pcr;
diff --git a/drivers/mfd/sm501.c b/drivers/mfd/sm501.c
index 9b53733..9816c23 100644
--- a/drivers/mfd/sm501.c
+++ b/drivers/mfd/sm501.c
@@ -1685,7 +1685,7 @@ static void sm501_dev_remove(struct sm501_devdata *sm)
 	sm501_gpio_remove(sm);
 }
 
-static void __devexit sm501_pci_remove(struct pci_dev *dev)
+static void sm501_pci_remove(struct pci_dev *dev)
 {
 	struct sm501_devdata *sm = pci_get_drvdata(dev);
 
diff --git a/drivers/mfd/sta2x11-mfd.c b/drivers/mfd/sta2x11-mfd.c
index 57f3361..d6284cac 100644
--- a/drivers/mfd/sta2x11-mfd.c
+++ b/drivers/mfd/sta2x11-mfd.c
@@ -89,7 +89,7 @@ static int sta2x11_mfd_add(struct pci_dev *pdev, gfp_t flags)
 	return 0;
 }
 
-static int __devexit mfd_remove(struct pci_dev *pdev)
+static int mfd_remove(struct pci_dev *pdev)
 {
 	struct sta2x11_mfd *mfd = sta2x11_mfd_find(pdev);
 
diff --git a/drivers/mfd/stmpe-i2c.c b/drivers/mfd/stmpe-i2c.c
index 8195ca2..36df187 100644
--- a/drivers/mfd/stmpe-i2c.c
+++ b/drivers/mfd/stmpe-i2c.c
@@ -63,7 +63,7 @@ stmpe_i2c_probe(struct i2c_client *i2c, const struct i2c_device_id *id)
 	return stmpe_probe(&i2c_ci, id->driver_data);
 }
 
-static int __devexit stmpe_i2c_remove(struct i2c_client *i2c)
+static int stmpe_i2c_remove(struct i2c_client *i2c)
 {
 	struct stmpe *stmpe = dev_get_drvdata(&i2c->dev);
 
diff --git a/drivers/mfd/stmpe-spi.c b/drivers/mfd/stmpe-spi.c
index 5277433..973659f 100644
--- a/drivers/mfd/stmpe-spi.c
+++ b/drivers/mfd/stmpe-spi.c
@@ -101,7 +101,7 @@ stmpe_spi_probe(struct spi_device *spi)
 	return stmpe_probe(&spi_ci, id->driver_data);
 }
 
-static int __devexit stmpe_spi_remove(struct spi_device *spi)
+static int stmpe_spi_remove(struct spi_device *spi)
 {
 	struct stmpe *stmpe = dev_get_drvdata(&spi->dev);
 
diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
index 3dbfe9a..3f10591 100644
--- a/drivers/mfd/syscon.c
+++ b/drivers/mfd/syscon.c
@@ -138,7 +138,7 @@ static int syscon_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit syscon_remove(struct platform_device *pdev)
+static int syscon_remove(struct platform_device *pdev)
 {
 	struct syscon *syscon;
 
diff --git a/drivers/mfd/tc3589x.c b/drivers/mfd/tc3589x.c
index 7e197f7..a06d66b 100644
--- a/drivers/mfd/tc3589x.c
+++ b/drivers/mfd/tc3589x.c
@@ -402,7 +402,7 @@ out_free:
 	return ret;
 }
 
-static int __devexit tc3589x_remove(struct i2c_client *client)
+static int tc3589x_remove(struct i2c_client *client)
 {
 	struct tc3589x *tc3589x = i2c_get_clientdata(client);
 
diff --git a/drivers/mfd/tc6387xb.c b/drivers/mfd/tc6387xb.c
index ca18f26..366f7b9 100644
--- a/drivers/mfd/tc6387xb.c
+++ b/drivers/mfd/tc6387xb.c
@@ -208,7 +208,7 @@ err_no_irq:
 	return ret;
 }
 
-static int __devexit tc6387xb_remove(struct platform_device *dev)
+static int tc6387xb_remove(struct platform_device *dev)
 {
 	struct tc6387xb *tc6387xb = platform_get_drvdata(dev);
 
diff --git a/drivers/mfd/tc6393xb.c b/drivers/mfd/tc6393xb.c
index 1ff8ed6..15e1463 100644
--- a/drivers/mfd/tc6393xb.c
+++ b/drivers/mfd/tc6393xb.c
@@ -731,7 +731,7 @@ err_kzalloc:
 	return ret;
 }
 
-static int __devexit tc6393xb_remove(struct platform_device *dev)
+static int tc6393xb_remove(struct platform_device *dev)
 {
 	struct tc6393xb_platform_data *tcpd = dev->dev.platform_data;
 	struct tc6393xb *tc6393xb = platform_get_drvdata(dev);
diff --git a/drivers/mfd/ti-ssp.c b/drivers/mfd/ti-ssp.c
index b177f96..09a14ce 100644
--- a/drivers/mfd/ti-ssp.c
+++ b/drivers/mfd/ti-ssp.c
@@ -433,7 +433,7 @@ error_res:
 	return error;
 }
 
-static int __devexit ti_ssp_remove(struct platform_device *pdev)
+static int ti_ssp_remove(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct ti_ssp *ssp = dev_get_drvdata(dev);
diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
index bc86fc9..b7f9d76 100644
--- a/drivers/mfd/ti_am335x_tscadc.c
+++ b/drivers/mfd/ti_am335x_tscadc.c
@@ -205,7 +205,7 @@ err:
 	return err;
 }
 
-static int __devexit ti_tscadc_remove(struct platform_device *pdev)
+static int ti_tscadc_remove(struct platform_device *pdev)
 {
 	struct ti_tscadc_dev	*tscadc = platform_get_drvdata(pdev);
 
diff --git a/drivers/mfd/timberdale.c b/drivers/mfd/timberdale.c
index a305ac1..59e0ee2 100644
--- a/drivers/mfd/timberdale.c
+++ b/drivers/mfd/timberdale.c
@@ -840,7 +840,7 @@ err_enable:
 	return -ENODEV;
 }
 
-static void __devexit timb_remove(struct pci_dev *dev)
+static void timb_remove(struct pci_dev *dev)
 {
 	struct timberdale_device *priv = pci_get_drvdata(dev);
 
diff --git a/drivers/mfd/tps6105x.c b/drivers/mfd/tps6105x.c
index 75a84ac..1d302f5 100644
--- a/drivers/mfd/tps6105x.c
+++ b/drivers/mfd/tps6105x.c
@@ -199,7 +199,7 @@ fail:
 	return ret;
 }
 
-static int __devexit tps6105x_remove(struct i2c_client *client)
+static int tps6105x_remove(struct i2c_client *client)
 {
 	struct tps6105x *tps6105x = i2c_get_clientdata(client);
 
diff --git a/drivers/mfd/tps65090.c b/drivers/mfd/tps65090.c
index 0c446eb..382a857 100644
--- a/drivers/mfd/tps65090.c
+++ b/drivers/mfd/tps65090.c
@@ -308,7 +308,7 @@ err_exit:
 	return ret;
 }
 
-static int __devexit tps65090_i2c_remove(struct i2c_client *client)
+static int tps65090_i2c_remove(struct i2c_client *client)
 {
 	struct tps65090 *tps65090 = i2c_get_clientdata(client);
 
diff --git a/drivers/mfd/tps65217.c b/drivers/mfd/tps65217.c
index 8cba757..e14e252 100644
--- a/drivers/mfd/tps65217.c
+++ b/drivers/mfd/tps65217.c
@@ -214,7 +214,7 @@ static int tps65217_probe(struct i2c_client *client,
 	return 0;
 }
 
-static int __devexit tps65217_remove(struct i2c_client *client)
+static int tps65217_remove(struct i2c_client *client)
 {
 	struct tps65217 *tps = i2c_get_clientdata(client);
 
diff --git a/drivers/mfd/tps6586x.c b/drivers/mfd/tps6586x.c
index 0c5870b..232ae36 100644
--- a/drivers/mfd/tps6586x.c
+++ b/drivers/mfd/tps6586x.c
@@ -599,7 +599,7 @@ err_mfd_add:
 	return ret;
 }
 
-static int __devexit tps6586x_i2c_remove(struct i2c_client *client)
+static int tps6586x_i2c_remove(struct i2c_client *client)
 {
 	struct tps6586x *tps6586x = i2c_get_clientdata(client);
 
diff --git a/drivers/mfd/tps65910.c b/drivers/mfd/tps65910.c
index 3a34022..ce05465 100644
--- a/drivers/mfd/tps65910.c
+++ b/drivers/mfd/tps65910.c
@@ -302,7 +302,7 @@ static int tps65910_i2c_probe(struct i2c_client *i2c,
 	return ret;
 }
 
-static __devexit int tps65910_i2c_remove(struct i2c_client *i2c)
+static int tps65910_i2c_remove(struct i2c_client *i2c)
 {
 	struct tps65910 *tps65910 = i2c_get_clientdata(i2c);
 
diff --git a/drivers/mfd/tps65911-comparator.c b/drivers/mfd/tps65911-comparator.c
index b3d268f..c0816eb 100644
--- a/drivers/mfd/tps65911-comparator.c
+++ b/drivers/mfd/tps65911-comparator.c
@@ -152,7 +152,7 @@ static int tps65911_comparator_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static __devexit int tps65911_comparator_remove(struct platform_device *pdev)
+static int tps65911_comparator_remove(struct platform_device *pdev)
 {
 	struct tps65910 *tps65910;
 
diff --git a/drivers/mfd/tps65912-spi.c b/drivers/mfd/tps65912-spi.c
index 6366576..b45f460 100644
--- a/drivers/mfd/tps65912-spi.c
+++ b/drivers/mfd/tps65912-spi.c
@@ -99,7 +99,7 @@ static int tps65912_spi_probe(struct spi_device *spi)
 	return tps65912_device_init(tps65912);
 }
 
-static int __devexit tps65912_spi_remove(struct spi_device *spi)
+static int tps65912_spi_remove(struct spi_device *spi)
 {
 	struct tps65912 *tps65912 = spi_get_drvdata(spi);
 
diff --git a/drivers/mfd/twl4030-audio.c b/drivers/mfd/twl4030-audio.c
index aacccdc..e16edca 100644
--- a/drivers/mfd/twl4030-audio.c
+++ b/drivers/mfd/twl4030-audio.c
@@ -269,7 +269,7 @@ static int twl4030_audio_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int __devexit twl4030_audio_remove(struct platform_device *pdev)
+static int twl4030_audio_remove(struct platform_device *pdev)
 {
 	mfd_remove_devices(&pdev->dev);
 	platform_set_drvdata(pdev, NULL);
diff --git a/drivers/mfd/twl4030-madc.c b/drivers/mfd/twl4030-madc.c
index 228d5aa..a39dcf3 100644
--- a/drivers/mfd/twl4030-madc.c
+++ b/drivers/mfd/twl4030-madc.c
@@ -785,7 +785,7 @@ err_power:
 	return ret;
 }
 
-static int __devexit twl4030_madc_remove(struct platform_device *pdev)
+static int twl4030_madc_remove(struct platform_device *pdev)
 {
 	struct twl4030_madc_data *madc = platform_get_drvdata(pdev);
 
diff --git a/drivers/mfd/twl6040.c b/drivers/mfd/twl6040.c
index c7a1b13..545d3aa 100644
--- a/drivers/mfd/twl6040.c
+++ b/drivers/mfd/twl6040.c
@@ -700,7 +700,7 @@ err:
 	return ret;
 }
 
-static int __devexit twl6040_remove(struct i2c_client *client)
+static int twl6040_remove(struct i2c_client *client)
 {
 	struct twl6040 *twl6040 = i2c_get_clientdata(client);
 
diff --git a/drivers/mfd/vx855.c b/drivers/mfd/vx855.c
index 66ef03b..757ecc6 100644
--- a/drivers/mfd/vx855.c
+++ b/drivers/mfd/vx855.c
@@ -112,7 +112,7 @@ out:
 	return ret;
 }
 
-static void __devexit vx855_remove(struct pci_dev *pdev)
+static void vx855_remove(struct pci_dev *pdev)
 {
 	mfd_remove_devices(&pdev->dev);
 	pci_disable_device(pdev);
diff --git a/drivers/mfd/wm831x-spi.c b/drivers/mfd/wm831x-spi.c
index 4c7225a..4e70e15 100644
--- a/drivers/mfd/wm831x-spi.c
+++ b/drivers/mfd/wm831x-spi.c
@@ -51,7 +51,7 @@ static int wm831x_spi_probe(struct spi_device *spi)
 	return wm831x_device_init(wm831x, type, spi->irq);
 }
 
-static int __devexit wm831x_spi_remove(struct spi_device *spi)
+static int wm831x_spi_remove(struct spi_device *spi)
 {
 	struct wm831x *wm831x = dev_get_drvdata(&spi->dev);
 
diff --git a/drivers/mfd/wm8994-core.c b/drivers/mfd/wm8994-core.c
index 4e2432d..c7f62ac 100644
--- a/drivers/mfd/wm8994-core.c
+++ b/drivers/mfd/wm8994-core.c
@@ -671,7 +671,7 @@ err:
 	return ret;
 }
 
-static __devexit void wm8994_device_exit(struct wm8994 *wm8994)
+static void wm8994_device_exit(struct wm8994 *wm8994)
 {
 	pm_runtime_disable(wm8994->dev);
 	mfd_remove_devices(wm8994->dev);
@@ -715,7 +715,7 @@ static int wm8994_i2c_probe(struct i2c_client *i2c,
 	return wm8994_device_init(wm8994, i2c->irq);
 }
 
-static __devexit int wm8994_i2c_remove(struct i2c_client *i2c)
+static int wm8994_i2c_remove(struct i2c_client *i2c)
 {
 	struct wm8994 *wm8994 = i2c_get_clientdata(i2c);
 
diff --git a/include/linux/mfd/abx500/ab8500.h b/include/linux/mfd/abx500/ab8500.h
index 83f0bdc..1cb5698 100644
--- a/include/linux/mfd/abx500/ab8500.h
+++ b/include/linux/mfd/abx500/ab8500.h
@@ -293,7 +293,7 @@ struct ab8500_platform_data {
 
 extern int ab8500_init(struct ab8500 *ab8500,
 				 enum ab8500_version version);
-extern int __devexit ab8500_exit(struct ab8500 *ab8500);
+extern int ab8500_exit(struct ab8500 *ab8500);
 
 extern int ab8500_suspend(struct ab8500 *ab8500);
 
diff --git a/include/linux/mfd/pm8xxx/irq.h b/include/linux/mfd/pm8xxx/irq.h
index ddaa7f5..f83d6b4 100644
--- a/include/linux/mfd/pm8xxx/irq.h
+++ b/include/linux/mfd/pm8xxx/irq.h
@@ -39,7 +39,7 @@ struct pm_irq_chip;
 int pm8xxx_get_irq_stat(struct pm_irq_chip *chip, int irq);
 struct pm_irq_chip *pm8xxx_irq_init(struct device *dev,
 				const struct pm8xxx_irq_platform_data *pdata);
-int __devexit pm8xxx_irq_exit(struct pm_irq_chip *chip);
+int pm8xxx_irq_exit(struct pm_irq_chip *chip);
 #else
 static inline int pm8xxx_get_irq_stat(struct pm_irq_chip *chip, int irq)
 {
@@ -51,7 +51,7 @@ static inline struct pm_irq_chip *pm8xxx_irq_init(
 {
 	return ERR_PTR(-ENXIO);
 }
-static inline int __devexit pm8xxx_irq_exit(struct pm_irq_chip *chip)
+static inline int pm8xxx_irq_exit(struct pm_irq_chip *chip)
 {
 	return -ENXIO;
 }
-- 
1.8.0
