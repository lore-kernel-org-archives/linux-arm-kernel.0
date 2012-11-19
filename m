From: wfp5p@virginia.edu (Bill Pemberton)
Date: Mon, 19 Nov 2012 13:20:24 -0500
Subject: [PATCH 075/493] mfd: remove use of __devexit_p
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Message-ID: <1353349642-3677-75-git-send-email-wfp5p@virginia.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_HOTPLUG is going away as an option so __devexit_p is no longer
needed.

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
 drivers/mfd/88pm860x-core.c       | 2 +-
 drivers/mfd/ab3100-core.c         | 2 +-
 drivers/mfd/ab8500-core.c         | 2 +-
 drivers/mfd/ab8500-debugfs.c      | 2 +-
 drivers/mfd/ab8500-gpadc.c        | 2 +-
 drivers/mfd/ab8500-sysctrl.c      | 2 +-
 drivers/mfd/adp5520.c             | 2 +-
 drivers/mfd/arizona-i2c.c         | 2 +-
 drivers/mfd/arizona-spi.c         | 2 +-
 drivers/mfd/asic3.c               | 2 +-
 drivers/mfd/cs5535-mfd.c          | 2 +-
 drivers/mfd/da903x.c              | 2 +-
 drivers/mfd/da9052-i2c.c          | 2 +-
 drivers/mfd/da9052-spi.c          | 2 +-
 drivers/mfd/da9055-i2c.c          | 2 +-
 drivers/mfd/davinci_voicecodec.c  | 2 +-
 drivers/mfd/ezx-pcap.c            | 2 +-
 drivers/mfd/intel_msic.c          | 2 +-
 drivers/mfd/janz-cmodio.c         | 2 +-
 drivers/mfd/jz4740-adc.c          | 2 +-
 drivers/mfd/lm3533-core.c         | 2 +-
 drivers/mfd/lp8788.c              | 2 +-
 drivers/mfd/lpc_ich.c             | 2 +-
 drivers/mfd/lpc_sch.c             | 2 +-
 drivers/mfd/max8925-i2c.c         | 2 +-
 drivers/mfd/mc13xxx-i2c.c         | 2 +-
 drivers/mfd/mc13xxx-spi.c         | 2 +-
 drivers/mfd/omap-usb-tll.c        | 2 +-
 drivers/mfd/pcf50633-adc.c        | 2 +-
 drivers/mfd/pcf50633-core.c       | 2 +-
 drivers/mfd/pm8921-core.c         | 2 +-
 drivers/mfd/rc5t583.c             | 2 +-
 drivers/mfd/rdc321x-southbridge.c | 2 +-
 drivers/mfd/rtsx_pcr.c            | 2 +-
 drivers/mfd/sm501.c               | 2 +-
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
 drivers/mfd/twl6040.c             | 2 +-
 drivers/mfd/vx855.c               | 2 +-
 drivers/mfd/wl1273-core.c         | 2 +-
 drivers/mfd/wm831x-spi.c          | 2 +-
 drivers/mfd/wm8994-core.c         | 2 +-
 59 files changed, 59 insertions(+), 59 deletions(-)

diff --git a/drivers/mfd/88pm800.c b/drivers/mfd/88pm800.c
index ce229ea..321a50c 100644
--- a/drivers/mfd/88pm800.c
+++ b/drivers/mfd/88pm800.c
@@ -576,7 +576,7 @@ static struct i2c_driver pm800_driver = {
 		.pm = &pm80x_pm_ops,
 		},
 	.probe = pm800_probe,
-	.remove = __devexit_p(pm800_remove),
+	.remove = pm800_remove,
 	.id_table = pm80x_id_table,
 };
 
diff --git a/drivers/mfd/88pm805.c b/drivers/mfd/88pm805.c
index c20a311..41e0488 100644
--- a/drivers/mfd/88pm805.c
+++ b/drivers/mfd/88pm805.c
@@ -281,7 +281,7 @@ static struct i2c_driver pm805_driver = {
 		.pm = &pm80x_pm_ops,
 		},
 	.probe = pm805_probe,
-	.remove = __devexit_p(pm805_remove),
+	.remove = pm805_remove,
 	.id_table = pm80x_id_table,
 };
 
diff --git a/drivers/mfd/88pm860x-core.c b/drivers/mfd/88pm860x-core.c
index 8fa86ed..c2d5595 100644
--- a/drivers/mfd/88pm860x-core.c
+++ b/drivers/mfd/88pm860x-core.c
@@ -1258,7 +1258,7 @@ static struct i2c_driver pm860x_driver = {
 		.of_match_table	= of_match_ptr(pm860x_dt_ids),
 	},
 	.probe		= pm860x_probe,
-	.remove		= __devexit_p(pm860x_remove),
+	.remove		= pm860x_remove,
 	.id_table	= pm860x_id_table,
 };
 
diff --git a/drivers/mfd/ab3100-core.c b/drivers/mfd/ab3100-core.c
index 2b3dde5..8355d4e 100644
--- a/drivers/mfd/ab3100-core.c
+++ b/drivers/mfd/ab3100-core.c
@@ -986,7 +986,7 @@ static struct i2c_driver ab3100_driver = {
 	},
 	.id_table	= ab3100_id,
 	.probe		= ab3100_probe,
-	.remove		= __devexit_p(ab3100_remove),
+	.remove		= ab3100_remove,
 };
 
 static int __init ab3100_i2c_init(void)
diff --git a/drivers/mfd/ab8500-core.c b/drivers/mfd/ab8500-core.c
index 148d2ee..dff2e1d 100644
--- a/drivers/mfd/ab8500-core.c
+++ b/drivers/mfd/ab8500-core.c
@@ -1451,7 +1451,7 @@ static struct platform_driver ab8500_core_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe	= ab8500_probe,
-	.remove	= __devexit_p(ab8500_remove),
+	.remove	= ab8500_remove,
 	.id_table = ab8500_id,
 };
 
diff --git a/drivers/mfd/ab8500-debugfs.c b/drivers/mfd/ab8500-debugfs.c
index c4cb806..efdbc7b 100644
--- a/drivers/mfd/ab8500-debugfs.c
+++ b/drivers/mfd/ab8500-debugfs.c
@@ -614,7 +614,7 @@ static struct platform_driver ab8500_debug_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe  = ab8500_debug_probe,
-	.remove = __devexit_p(ab8500_debug_remove)
+	.remove = ab8500_debug_remove
 };
 
 static int __init ab8500_debug_init(void)
diff --git a/drivers/mfd/ab8500-gpadc.c b/drivers/mfd/ab8500-gpadc.c
index 29d72a2..97daf61 100644
--- a/drivers/mfd/ab8500-gpadc.c
+++ b/drivers/mfd/ab8500-gpadc.c
@@ -651,7 +651,7 @@ static int __devexit ab8500_gpadc_remove(struct platform_device *pdev)
 
 static struct platform_driver ab8500_gpadc_driver = {
 	.probe = ab8500_gpadc_probe,
-	.remove = __devexit_p(ab8500_gpadc_remove),
+	.remove = ab8500_gpadc_remove,
 	.driver = {
 		.name = "ab8500-gpadc",
 		.owner = THIS_MODULE,
diff --git a/drivers/mfd/ab8500-sysctrl.c b/drivers/mfd/ab8500-sysctrl.c
index c28d4eb..d8cc157 100644
--- a/drivers/mfd/ab8500-sysctrl.c
+++ b/drivers/mfd/ab8500-sysctrl.c
@@ -67,7 +67,7 @@ static struct platform_driver ab8500_sysctrl_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = ab8500_sysctrl_probe,
-	.remove = __devexit_p(ab8500_sysctrl_remove),
+	.remove = ab8500_sysctrl_remove,
 };
 
 static int __init ab8500_sysctrl_init(void)
diff --git a/drivers/mfd/adp5520.c b/drivers/mfd/adp5520.c
index ea8b947..f664a52 100644
--- a/drivers/mfd/adp5520.c
+++ b/drivers/mfd/adp5520.c
@@ -356,7 +356,7 @@ static struct i2c_driver adp5520_driver = {
 		.pm	= &adp5520_pm,
 	},
 	.probe		= adp5520_probe,
-	.remove		= __devexit_p(adp5520_remove),
+	.remove		= adp5520_remove,
 	.id_table 	= adp5520_id,
 };
 
diff --git a/drivers/mfd/arizona-i2c.c b/drivers/mfd/arizona-i2c.c
index 570c4b4..43d1647 100644
--- a/drivers/mfd/arizona-i2c.c
+++ b/drivers/mfd/arizona-i2c.c
@@ -86,7 +86,7 @@ static struct i2c_driver arizona_i2c_driver = {
 		.pm	= &arizona_pm_ops,
 	},
 	.probe		= arizona_i2c_probe,
-	.remove		= __devexit_p(arizona_i2c_remove),
+	.remove		= arizona_i2c_remove,
 	.id_table	= arizona_i2c_id,
 };
 
diff --git a/drivers/mfd/arizona-spi.c b/drivers/mfd/arizona-spi.c
index df2e5a8..cc79b82 100644
--- a/drivers/mfd/arizona-spi.c
+++ b/drivers/mfd/arizona-spi.c
@@ -86,7 +86,7 @@ static struct spi_driver arizona_spi_driver = {
 		.pm	= &arizona_pm_ops,
 	},
 	.probe		= arizona_spi_probe,
-	.remove		= __devexit_p(arizona_spi_remove),
+	.remove		= arizona_spi_remove,
 	.id_table	= arizona_spi_ids,
 };
 
diff --git a/drivers/mfd/asic3.c b/drivers/mfd/asic3.c
index 62f0883..b0720d7 100644
--- a/drivers/mfd/asic3.c
+++ b/drivers/mfd/asic3.c
@@ -1071,7 +1071,7 @@ static struct platform_driver asic3_device_driver = {
 	.driver		= {
 		.name	= "asic3",
 	},
-	.remove		= __devexit_p(asic3_remove),
+	.remove		= asic3_remove,
 	.shutdown	= asic3_shutdown,
 };
 
diff --git a/drivers/mfd/cs5535-mfd.c b/drivers/mfd/cs5535-mfd.c
index 2b28213..5d3878a 100644
--- a/drivers/mfd/cs5535-mfd.c
+++ b/drivers/mfd/cs5535-mfd.c
@@ -183,7 +183,7 @@ static struct pci_driver cs5535_mfd_driver = {
 	.name = DRV_NAME,
 	.id_table = cs5535_mfd_pci_tbl,
 	.probe = cs5535_mfd_probe,
-	.remove = __devexit_p(cs5535_mfd_remove),
+	.remove = cs5535_mfd_remove,
 };
 
 module_pci_driver(cs5535_mfd_driver);
diff --git a/drivers/mfd/da903x.c b/drivers/mfd/da903x.c
index 1924b85..c715475 100644
--- a/drivers/mfd/da903x.c
+++ b/drivers/mfd/da903x.c
@@ -560,7 +560,7 @@ static struct i2c_driver da903x_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= da903x_probe,
-	.remove		= __devexit_p(da903x_remove),
+	.remove		= da903x_remove,
 	.id_table	= da903x_id_table,
 };
 
diff --git a/drivers/mfd/da9052-i2c.c b/drivers/mfd/da9052-i2c.c
index 352c58b..8af0f0c 100644
--- a/drivers/mfd/da9052-i2c.c
+++ b/drivers/mfd/da9052-i2c.c
@@ -131,7 +131,7 @@ static int __devexit da9052_i2c_remove(struct i2c_client *client)
 
 static struct i2c_driver da9052_i2c_driver = {
 	.probe = da9052_i2c_probe,
-	.remove = __devexit_p(da9052_i2c_remove),
+	.remove = da9052_i2c_remove,
 	.id_table = da9052_i2c_id,
 	.driver = {
 		.name = "da9052",
diff --git a/drivers/mfd/da9052-spi.c b/drivers/mfd/da9052-spi.c
index dbeadc5..cbcc9be 100644
--- a/drivers/mfd/da9052-spi.c
+++ b/drivers/mfd/da9052-spi.c
@@ -76,7 +76,7 @@ static struct spi_device_id da9052_spi_id[] = {
 
 static struct spi_driver da9052_spi_driver = {
 	.probe = da9052_spi_probe,
-	.remove = __devexit_p(da9052_spi_remove),
+	.remove = da9052_spi_remove,
 	.id_table = da9052_spi_id,
 	.driver = {
 		.name = "da9052",
diff --git a/drivers/mfd/da9055-i2c.c b/drivers/mfd/da9055-i2c.c
index 88f6dca..dbaca7b 100644
--- a/drivers/mfd/da9055-i2c.c
+++ b/drivers/mfd/da9055-i2c.c
@@ -60,7 +60,7 @@ static struct i2c_device_id da9055_i2c_id[] = {
 
 static struct i2c_driver da9055_i2c_driver = {
 	.probe = da9055_i2c_probe,
-	.remove = __devexit_p(da9055_i2c_remove),
+	.remove = da9055_i2c_remove,
 	.id_table = da9055_i2c_id,
 	.driver = {
 		.name = "da9055",
diff --git a/drivers/mfd/davinci_voicecodec.c b/drivers/mfd/davinci_voicecodec.c
index 45e83a6..b2b0397 100644
--- a/drivers/mfd/davinci_voicecodec.c
+++ b/drivers/mfd/davinci_voicecodec.c
@@ -174,7 +174,7 @@ static struct platform_driver davinci_vc_driver = {
 		.name = "davinci_voicecodec",
 		.owner = THIS_MODULE,
 	},
-	.remove	= __devexit_p(davinci_vc_remove),
+	.remove	= davinci_vc_remove,
 };
 
 static int __init davinci_vc_init(void)
diff --git a/drivers/mfd/ezx-pcap.c b/drivers/mfd/ezx-pcap.c
index db662e2..d7e4de04 100644
--- a/drivers/mfd/ezx-pcap.c
+++ b/drivers/mfd/ezx-pcap.c
@@ -525,7 +525,7 @@ ret:
 
 static struct spi_driver ezxpcap_driver = {
 	.probe	= ezx_pcap_probe,
-	.remove = __devexit_p(ezx_pcap_remove),
+	.remove = ezx_pcap_remove,
 	.driver = {
 		.name	= "ezx-pcap",
 		.owner	= THIS_MODULE,
diff --git a/drivers/mfd/intel_msic.c b/drivers/mfd/intel_msic.c
index 266bdc5..c5f478e 100644
--- a/drivers/mfd/intel_msic.c
+++ b/drivers/mfd/intel_msic.c
@@ -457,7 +457,7 @@ static int __devexit intel_msic_remove(struct platform_device *pdev)
 
 static struct platform_driver intel_msic_driver = {
 	.probe		= intel_msic_probe,
-	.remove		= __devexit_p(intel_msic_remove),
+	.remove		= intel_msic_remove,
 	.driver		= {
 		.name	= "intel_msic",
 		.owner	= THIS_MODULE,
diff --git a/drivers/mfd/janz-cmodio.c b/drivers/mfd/janz-cmodio.c
index 965c480..1a36277 100644
--- a/drivers/mfd/janz-cmodio.c
+++ b/drivers/mfd/janz-cmodio.c
@@ -280,7 +280,7 @@ static struct pci_driver cmodio_pci_driver = {
 	.name     = DRV_NAME,
 	.id_table = cmodio_pci_ids,
 	.probe    = cmodio_pci_probe,
-	.remove   = __devexit_p(cmodio_pci_remove),
+	.remove   = cmodio_pci_remove,
 };
 
 module_pci_driver(cmodio_pci_driver);
diff --git a/drivers/mfd/jz4740-adc.c b/drivers/mfd/jz4740-adc.c
index c6b6d7d..9aed2a6 100644
--- a/drivers/mfd/jz4740-adc.c
+++ b/drivers/mfd/jz4740-adc.c
@@ -332,7 +332,7 @@ static int __devexit jz4740_adc_remove(struct platform_device *pdev)
 
 static struct platform_driver jz4740_adc_driver = {
 	.probe	= jz4740_adc_probe,
-	.remove = __devexit_p(jz4740_adc_remove),
+	.remove = jz4740_adc_remove,
 	.driver = {
 		.name = "jz4740-adc",
 		.owner = THIS_MODULE,
diff --git a/drivers/mfd/lm3533-core.c b/drivers/mfd/lm3533-core.c
index 24212f4..e7aa2a5 100644
--- a/drivers/mfd/lm3533-core.c
+++ b/drivers/mfd/lm3533-core.c
@@ -648,7 +648,7 @@ static struct i2c_driver lm3533_i2c_driver = {
 	},
 	.id_table	= lm3533_i2c_ids,
 	.probe		= lm3533_i2c_probe,
-	.remove		= __devexit_p(lm3533_i2c_remove),
+	.remove		= lm3533_i2c_remove,
 };
 
 static int __init lm3533_i2c_init(void)
diff --git a/drivers/mfd/lp8788.c b/drivers/mfd/lp8788.c
index 3e94a69..e1d7c9f 100644
--- a/drivers/mfd/lp8788.c
+++ b/drivers/mfd/lp8788.c
@@ -224,7 +224,7 @@ static struct i2c_driver lp8788_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = lp8788_probe,
-	.remove = __devexit_p(lp8788_remove),
+	.remove = lp8788_remove,
 	.id_table = lp8788_ids,
 };
 
diff --git a/drivers/mfd/lpc_ich.c b/drivers/mfd/lpc_ich.c
index a22544f..a43c73a 100644
--- a/drivers/mfd/lpc_ich.c
+++ b/drivers/mfd/lpc_ich.c
@@ -888,7 +888,7 @@ static struct pci_driver lpc_ich_driver = {
 	.name		= "lpc_ich",
 	.id_table	= lpc_ich_ids,
 	.probe		= lpc_ich_probe,
-	.remove		= __devexit_p(lpc_ich_remove),
+	.remove		= lpc_ich_remove,
 };
 
 static int __init lpc_ich_init(void)
diff --git a/drivers/mfd/lpc_sch.c b/drivers/mfd/lpc_sch.c
index f6b9c5c..27477f4 100644
--- a/drivers/mfd/lpc_sch.c
+++ b/drivers/mfd/lpc_sch.c
@@ -173,7 +173,7 @@ static struct pci_driver lpc_sch_driver = {
 	.name		= "lpc_sch",
 	.id_table	= lpc_sch_ids,
 	.probe		= lpc_sch_probe,
-	.remove		= __devexit_p(lpc_sch_remove),
+	.remove		= lpc_sch_remove,
 };
 
 module_pci_driver(lpc_sch_driver);
diff --git a/drivers/mfd/max8925-i2c.c b/drivers/mfd/max8925-i2c.c
index d9e4b36..375e047 100644
--- a/drivers/mfd/max8925-i2c.c
+++ b/drivers/mfd/max8925-i2c.c
@@ -210,7 +210,7 @@ static struct i2c_driver max8925_driver = {
 		.pm     = &max8925_pm_ops,
 	},
 	.probe		= max8925_probe,
-	.remove		= __devexit_p(max8925_remove),
+	.remove		= max8925_remove,
 	.id_table	= max8925_id_table,
 };
 
diff --git a/drivers/mfd/mc13xxx-i2c.c b/drivers/mfd/mc13xxx-i2c.c
index bfc1284..71e0386 100644
--- a/drivers/mfd/mc13xxx-i2c.c
+++ b/drivers/mfd/mc13xxx-i2c.c
@@ -112,7 +112,7 @@ static struct i2c_driver mc13xxx_i2c_driver = {
 		.of_match_table = mc13xxx_dt_ids,
 	},
 	.probe = mc13xxx_i2c_probe,
-	.remove = __devexit_p(mc13xxx_i2c_remove),
+	.remove = mc13xxx_i2c_remove,
 };
 
 static int __init mc13xxx_i2c_init(void)
diff --git a/drivers/mfd/mc13xxx-spi.c b/drivers/mfd/mc13xxx-spi.c
index afca4f9..bfe72be 100644
--- a/drivers/mfd/mc13xxx-spi.c
+++ b/drivers/mfd/mc13xxx-spi.c
@@ -179,7 +179,7 @@ static struct spi_driver mc13xxx_spi_driver = {
 		.of_match_table = mc13xxx_dt_ids,
 	},
 	.probe = mc13xxx_spi_probe,
-	.remove = __devexit_p(mc13xxx_spi_remove),
+	.remove = mc13xxx_spi_remove,
 };
 
 static int __init mc13xxx_init(void)
diff --git a/drivers/mfd/omap-usb-tll.c b/drivers/mfd/omap-usb-tll.c
index 0db0dfa..d8f713b 100644
--- a/drivers/mfd/omap-usb-tll.c
+++ b/drivers/mfd/omap-usb-tll.c
@@ -424,7 +424,7 @@ static struct platform_driver usbtll_omap_driver = {
 		.pm		= &usbtllomap_dev_pm_ops,
 	},
 	.probe		= usbtll_omap_probe,
-	.remove		= __devexit_p(usbtll_omap_remove),
+	.remove		= usbtll_omap_remove,
 };
 
 int omap_tll_enable(void)
diff --git a/drivers/mfd/pcf50633-adc.c b/drivers/mfd/pcf50633-adc.c
index 3927c17..a285b51 100644
--- a/drivers/mfd/pcf50633-adc.c
+++ b/drivers/mfd/pcf50633-adc.c
@@ -246,7 +246,7 @@ static struct platform_driver pcf50633_adc_driver = {
 		.name = "pcf50633-adc",
 	},
 	.probe = pcf50633_adc_probe,
-	.remove = __devexit_p(pcf50633_adc_remove),
+	.remove = pcf50633_adc_remove,
 };
 
 module_platform_driver(pcf50633_adc_driver);
diff --git a/drivers/mfd/pcf50633-core.c b/drivers/mfd/pcf50633-core.c
index 45ce1fb..ad438e8 100644
--- a/drivers/mfd/pcf50633-core.c
+++ b/drivers/mfd/pcf50633-core.c
@@ -308,7 +308,7 @@ static struct i2c_driver pcf50633_driver = {
 	},
 	.id_table = pcf50633_id_table,
 	.probe = pcf50633_probe,
-	.remove = __devexit_p(pcf50633_remove),
+	.remove = pcf50633_remove,
 };
 
 static int __init pcf50633_init(void)
diff --git a/drivers/mfd/pm8921-core.c b/drivers/mfd/pm8921-core.c
index e873b157..24d57bc 100644
--- a/drivers/mfd/pm8921-core.c
+++ b/drivers/mfd/pm8921-core.c
@@ -187,7 +187,7 @@ static int __devexit pm8921_remove(struct platform_device *pdev)
 
 static struct platform_driver pm8921_driver = {
 	.probe		= pm8921_probe,
-	.remove		= __devexit_p(pm8921_remove),
+	.remove		= pm8921_remove,
 	.driver		= {
 		.name	= "pm8921-core",
 		.owner	= THIS_MODULE,
diff --git a/drivers/mfd/rc5t583.c b/drivers/mfd/rc5t583.c
index f1a024e..d38ee24 100644
--- a/drivers/mfd/rc5t583.c
+++ b/drivers/mfd/rc5t583.c
@@ -325,7 +325,7 @@ static struct i2c_driver rc5t583_i2c_driver = {
 		   .owner = THIS_MODULE,
 		   },
 	.probe = rc5t583_i2c_probe,
-	.remove = __devexit_p(rc5t583_i2c_remove),
+	.remove = rc5t583_i2c_remove,
 	.id_table = rc5t583_i2c_id,
 };
 
diff --git a/drivers/mfd/rdc321x-southbridge.c b/drivers/mfd/rdc321x-southbridge.c
index fbabc3cb..3303963 100644
--- a/drivers/mfd/rdc321x-southbridge.c
+++ b/drivers/mfd/rdc321x-southbridge.c
@@ -106,7 +106,7 @@ static struct pci_driver rdc321x_sb_driver = {
 	.name		= "RDC321x Southbridge",
 	.id_table	= rdc321x_sb_table,
 	.probe		= rdc321x_sb_probe,
-	.remove		= __devexit_p(rdc321x_sb_remove),
+	.remove		= rdc321x_sb_remove,
 };
 
 module_pci_driver(rdc321x_sb_driver);
diff --git a/drivers/mfd/rtsx_pcr.c b/drivers/mfd/rtsx_pcr.c
index 3a44efa..11e671c 100644
--- a/drivers/mfd/rtsx_pcr.c
+++ b/drivers/mfd/rtsx_pcr.c
@@ -1241,7 +1241,7 @@ static struct pci_driver rtsx_pci_driver = {
 	.name = DRV_NAME_RTSX_PCI,
 	.id_table = rtsx_pci_ids,
 	.probe = rtsx_pci_probe,
-	.remove = __devexit_p(rtsx_pci_remove),
+	.remove = rtsx_pci_remove,
 	.suspend = rtsx_pci_suspend,
 	.resume = rtsx_pci_resume,
 };
diff --git a/drivers/mfd/sm501.c b/drivers/mfd/sm501.c
index d927dd4..777af5e 100644
--- a/drivers/mfd/sm501.c
+++ b/drivers/mfd/sm501.c
@@ -1723,7 +1723,7 @@ static struct pci_driver sm501_pci_driver = {
 	.name		= "sm501",
 	.id_table	= sm501_pci_tbl,
 	.probe		= sm501_pci_probe,
-	.remove		= __devexit_p(sm501_pci_remove),
+	.remove		= sm501_pci_remove,
 };
 
 MODULE_ALIAS("platform:sm501");
diff --git a/drivers/mfd/stmpe-i2c.c b/drivers/mfd/stmpe-i2c.c
index 947a06a..6a6aed7 100644
--- a/drivers/mfd/stmpe-i2c.c
+++ b/drivers/mfd/stmpe-i2c.c
@@ -88,7 +88,7 @@ static struct i2c_driver stmpe_i2c_driver = {
 	.driver.pm	= &stmpe_dev_pm_ops,
 #endif
 	.probe		= stmpe_i2c_probe,
-	.remove		= __devexit_p(stmpe_i2c_remove),
+	.remove		= stmpe_i2c_remove,
 	.id_table	= stmpe_i2c_id,
 };
 
diff --git a/drivers/mfd/stmpe-spi.c b/drivers/mfd/stmpe-spi.c
index 9edfe86..29590ad 100644
--- a/drivers/mfd/stmpe-spi.c
+++ b/drivers/mfd/stmpe-spi.c
@@ -128,7 +128,7 @@ static struct spi_driver stmpe_spi_driver = {
 #endif
 	},
 	.probe		= stmpe_spi_probe,
-	.remove		= __devexit_p(stmpe_spi_remove),
+	.remove		= stmpe_spi_remove,
 	.id_table	= stmpe_spi_id,
 };
 
diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
index 65fe609..d258b59 100644
--- a/drivers/mfd/syscon.c
+++ b/drivers/mfd/syscon.c
@@ -156,7 +156,7 @@ static struct platform_driver syscon_driver = {
 		.of_match_table = of_syscon_match,
 	},
 	.probe		= syscon_probe,
-	.remove		= __devexit_p(syscon_remove),
+	.remove		= syscon_remove,
 };
 
 static int __init syscon_init(void)
diff --git a/drivers/mfd/tc3589x.c b/drivers/mfd/tc3589x.c
index 8f4c853..553ce95 100644
--- a/drivers/mfd/tc3589x.c
+++ b/drivers/mfd/tc3589x.c
@@ -458,7 +458,7 @@ static struct i2c_driver tc3589x_driver = {
 	.driver.owner	= THIS_MODULE,
 	.driver.pm	= &tc3589x_dev_pm_ops,
 	.probe		= tc3589x_probe,
-	.remove		= __devexit_p(tc3589x_remove),
+	.remove		= tc3589x_remove,
 	.id_table	= tc3589x_id,
 };
 
diff --git a/drivers/mfd/tc6387xb.c b/drivers/mfd/tc6387xb.c
index 413c891..186f053 100644
--- a/drivers/mfd/tc6387xb.c
+++ b/drivers/mfd/tc6387xb.c
@@ -229,7 +229,7 @@ static struct platform_driver tc6387xb_platform_driver = {
 		.name		= "tc6387xb",
 	},
 	.probe		= tc6387xb_probe,
-	.remove		= __devexit_p(tc6387xb_remove),
+	.remove		= tc6387xb_remove,
 	.suspend        = tc6387xb_suspend,
 	.resume         = tc6387xb_resume,
 };
diff --git a/drivers/mfd/tc6393xb.c b/drivers/mfd/tc6393xb.c
index dcab026..9411a88 100644
--- a/drivers/mfd/tc6393xb.c
+++ b/drivers/mfd/tc6393xb.c
@@ -831,7 +831,7 @@ static int tc6393xb_resume(struct platform_device *dev)
 
 static struct platform_driver tc6393xb_driver = {
 	.probe = tc6393xb_probe,
-	.remove = __devexit_p(tc6393xb_remove),
+	.remove = tc6393xb_remove,
 	.suspend = tc6393xb_suspend,
 	.resume = tc6393xb_resume,
 
diff --git a/drivers/mfd/ti-ssp.c b/drivers/mfd/ti-ssp.c
index 7c3675a..1c31f87 100644
--- a/drivers/mfd/ti-ssp.c
+++ b/drivers/mfd/ti-ssp.c
@@ -451,7 +451,7 @@ static int __devexit ti_ssp_remove(struct platform_device *pdev)
 
 static struct platform_driver ti_ssp_driver = {
 	.probe		= ti_ssp_probe,
-	.remove		= __devexit_p(ti_ssp_remove),
+	.remove		= ti_ssp_remove,
 	.driver		= {
 		.name	= "ti-ssp",
 		.owner	= THIS_MODULE,
diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
index e947dd8..5b4c274 100644
--- a/drivers/mfd/ti_am335x_tscadc.c
+++ b/drivers/mfd/ti_am335x_tscadc.c
@@ -266,7 +266,7 @@ static struct platform_driver ti_tscadc_driver = {
 		.pm	= TSCADC_PM_OPS,
 	},
 	.probe	= ti_tscadc_probe,
-	.remove	= __devexit_p(ti_tscadc_remove),
+	.remove	= ti_tscadc_remove,
 
 };
 
diff --git a/drivers/mfd/timberdale.c b/drivers/mfd/timberdale.c
index cccc626..61badec 100644
--- a/drivers/mfd/timberdale.c
+++ b/drivers/mfd/timberdale.c
@@ -867,7 +867,7 @@ static struct pci_driver timberdale_pci_driver = {
 	.name = DRIVER_NAME,
 	.id_table = timberdale_pci_tbl,
 	.probe = timb_probe,
-	.remove = __devexit_p(timb_remove),
+	.remove = timb_remove,
 };
 
 static int __init timberdale_init(void)
diff --git a/drivers/mfd/tps6105x.c b/drivers/mfd/tps6105x.c
index 14051bd..4538960 100644
--- a/drivers/mfd/tps6105x.c
+++ b/drivers/mfd/tps6105x.c
@@ -226,7 +226,7 @@ static struct i2c_driver tps6105x_driver = {
 		.name	= "tps6105x",
 	},
 	.probe		= tps6105x_probe,
-	.remove		= __devexit_p(tps6105x_remove),
+	.remove		= tps6105x_remove,
 	.id_table	= tps6105x_id,
 };
 
diff --git a/drivers/mfd/tps65090.c b/drivers/mfd/tps65090.c
index 074ae32..d43ff16 100644
--- a/drivers/mfd/tps65090.c
+++ b/drivers/mfd/tps65090.c
@@ -354,7 +354,7 @@ static struct i2c_driver tps65090_driver = {
 		.pm	= &tps65090_pm_ops,
 	},
 	.probe		= tps65090_i2c_probe,
-	.remove		= __devexit_p(tps65090_i2c_remove),
+	.remove		= tps65090_i2c_remove,
 	.id_table	= tps65090_id_table,
 };
 
diff --git a/drivers/mfd/tps65217.c b/drivers/mfd/tps65217.c
index 3fb32e6..76360c10 100644
--- a/drivers/mfd/tps65217.c
+++ b/drivers/mfd/tps65217.c
@@ -237,7 +237,7 @@ static struct i2c_driver tps65217_driver = {
 	},
 	.id_table	= tps65217_id_table,
 	.probe		= tps65217_probe,
-	.remove		= __devexit_p(tps65217_remove),
+	.remove		= tps65217_remove,
 };
 
 static int __init tps65217_init(void)
diff --git a/drivers/mfd/tps6586x.c b/drivers/mfd/tps6586x.c
index c11539a..664e07c 100644
--- a/drivers/mfd/tps6586x.c
+++ b/drivers/mfd/tps6586x.c
@@ -623,7 +623,7 @@ static struct i2c_driver tps6586x_driver = {
 		.of_match_table = of_match_ptr(tps6586x_of_match),
 	},
 	.probe		= tps6586x_i2c_probe,
-	.remove		= __devexit_p(tps6586x_i2c_remove),
+	.remove		= tps6586x_i2c_remove,
 	.id_table	= tps6586x_id_table,
 };
 
diff --git a/drivers/mfd/tps65910.c b/drivers/mfd/tps65910.c
index 0d79ce2..a3d732b 100644
--- a/drivers/mfd/tps65910.c
+++ b/drivers/mfd/tps65910.c
@@ -327,7 +327,7 @@ static struct i2c_driver tps65910_i2c_driver = {
 		   .of_match_table = of_match_ptr(tps65910_of_match),
 	},
 	.probe = tps65910_i2c_probe,
-	.remove = __devexit_p(tps65910_i2c_remove),
+	.remove = tps65910_i2c_remove,
 	.id_table = tps65910_i2c_id,
 };
 
diff --git a/drivers/mfd/tps65911-comparator.c b/drivers/mfd/tps65911-comparator.c
index 0b6e361..a025587 100644
--- a/drivers/mfd/tps65911-comparator.c
+++ b/drivers/mfd/tps65911-comparator.c
@@ -169,7 +169,7 @@ static struct platform_driver tps65911_comparator_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = tps65911_comparator_probe,
-	.remove = __devexit_p(tps65911_comparator_remove),
+	.remove = tps65911_comparator_remove,
 };
 
 static int __init tps65911_comparator_init(void)
diff --git a/drivers/mfd/tps65912-spi.c b/drivers/mfd/tps65912-spi.c
index 27d3302..054315d 100644
--- a/drivers/mfd/tps65912-spi.c
+++ b/drivers/mfd/tps65912-spi.c
@@ -114,7 +114,7 @@ static struct spi_driver tps65912_spi_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe	= tps65912_spi_probe,
-	.remove = __devexit_p(tps65912_spi_remove),
+	.remove = tps65912_spi_remove,
 };
 
 static int __init tps65912_spi_init(void)
diff --git a/drivers/mfd/twl4030-audio.c b/drivers/mfd/twl4030-audio.c
index 5c11acf..08f9905 100644
--- a/drivers/mfd/twl4030-audio.c
+++ b/drivers/mfd/twl4030-audio.c
@@ -291,7 +291,7 @@ static struct platform_driver twl4030_audio_driver = {
 		.of_match_table = twl4030_audio_of_match,
 	},
 	.probe		= twl4030_audio_probe,
-	.remove		= __devexit_p(twl4030_audio_remove),
+	.remove		= twl4030_audio_remove,
 };
 
 module_platform_driver(twl4030_audio_driver);
diff --git a/drivers/mfd/twl6040.c b/drivers/mfd/twl6040.c
index e5f7b79..dde1754 100644
--- a/drivers/mfd/twl6040.c
+++ b/drivers/mfd/twl6040.c
@@ -736,7 +736,7 @@ static struct i2c_driver twl6040_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe		= twl6040_probe,
-	.remove		= __devexit_p(twl6040_remove),
+	.remove		= twl6040_remove,
 	.id_table	= twl6040_i2c_id,
 };
 
diff --git a/drivers/mfd/vx855.c b/drivers/mfd/vx855.c
index b9a636d..c5a7df8 100644
--- a/drivers/mfd/vx855.c
+++ b/drivers/mfd/vx855.c
@@ -128,7 +128,7 @@ static struct pci_driver vx855_pci_driver = {
 	.name		= "vx855",
 	.id_table	= vx855_pci_tbl,
 	.probe		= vx855_probe,
-	.remove		= __devexit_p(vx855_remove),
+	.remove		= vx855_remove,
 };
 
 module_pci_driver(vx855_pci_driver);
diff --git a/drivers/mfd/wl1273-core.c b/drivers/mfd/wl1273-core.c
index 86e0e43..7f3f389 100644
--- a/drivers/mfd/wl1273-core.c
+++ b/drivers/mfd/wl1273-core.c
@@ -262,7 +262,7 @@ static struct i2c_driver wl1273_core_driver = {
 	},
 	.probe = wl1273_core_probe,
 	.id_table = wl1273_driver_id_table,
-	.remove = __devexit_p(wl1273_core_remove),
+	.remove = wl1273_core_remove,
 };
 
 static int __init wl1273_core_init(void)
diff --git a/drivers/mfd/wm831x-spi.c b/drivers/mfd/wm831x-spi.c
index 4bceee9..4329a3a 100644
--- a/drivers/mfd/wm831x-spi.c
+++ b/drivers/mfd/wm831x-spi.c
@@ -99,7 +99,7 @@ static struct spi_driver wm831x_spi_driver = {
 	},
 	.id_table	= wm831x_spi_ids,
 	.probe		= wm831x_spi_probe,
-	.remove		= __devexit_p(wm831x_spi_remove),
+	.remove		= wm831x_spi_remove,
 	.shutdown	= wm831x_spi_shutdown,
 };
 
diff --git a/drivers/mfd/wm8994-core.c b/drivers/mfd/wm8994-core.c
index 8fefc96..bb9cf52 100644
--- a/drivers/mfd/wm8994-core.c
+++ b/drivers/mfd/wm8994-core.c
@@ -744,7 +744,7 @@ static struct i2c_driver wm8994_i2c_driver = {
 		.of_match_table = wm8994_of_match,
 	},
 	.probe = wm8994_i2c_probe,
-	.remove = __devexit_p(wm8994_i2c_remove),
+	.remove = wm8994_i2c_remove,
 	.id_table = wm8994_i2c_id,
 };
 
-- 
1.8.0
