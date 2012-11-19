From: wfp5p@virginia.edu (Bill Pemberton)
Date: Mon, 19 Nov 2012 13:26:11 -0500
Subject: [PATCH 422/493] rtc: remove use of __devexit
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Message-ID: <1353349642-3677-422-git-send-email-wfp5p@virginia.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_HOTPLUG is going away as an option so __devexit is no
longer needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: Alessandro Zummo <a.zummo@towertech.it> 
Cc: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com> 
Cc: Linus Walleij <linus.walleij@linaro.org> 
Cc: Wan ZongShun <mcuos.com@gmail.com> 
Cc: Guan Xuetao <gxt@mprc.pku.edu.cn> 
Cc: rtc-linux at googlegroups.com 
Cc: linux-arm-kernel at lists.infradead.org 
Cc: uclinux-dist-devel at blackfin.uclinux.org 
Cc: patches at opensource.wolfsonmicro.com 
---
 drivers/rtc/rtc-88pm80x.c  | 2 +-
 drivers/rtc/rtc-88pm860x.c | 2 +-
 drivers/rtc/rtc-ab8500.c   | 2 +-
 drivers/rtc/rtc-at91sam9.c | 2 +-
 drivers/rtc/rtc-au1xxx.c   | 2 +-
 drivers/rtc/rtc-bfin.c     | 2 +-
 drivers/rtc/rtc-bq32k.c    | 2 +-
 drivers/rtc/rtc-bq4802.c   | 2 +-
 drivers/rtc/rtc-da9052.c   | 2 +-
 drivers/rtc/rtc-davinci.c  | 2 +-
 drivers/rtc/rtc-dm355evm.c | 2 +-
 drivers/rtc/rtc-ds1286.c   | 2 +-
 drivers/rtc/rtc-ds1302.c   | 2 +-
 drivers/rtc/rtc-ds1305.c   | 2 +-
 drivers/rtc/rtc-ds1307.c   | 2 +-
 drivers/rtc/rtc-ds1374.c   | 2 +-
 drivers/rtc/rtc-ds1390.c   | 2 +-
 drivers/rtc/rtc-ds1511.c   | 2 +-
 drivers/rtc/rtc-ds1553.c   | 2 +-
 drivers/rtc/rtc-ds1742.c   | 2 +-
 drivers/rtc/rtc-ds3232.c   | 2 +-
 drivers/rtc/rtc-ds3234.c   | 2 +-
 drivers/rtc/rtc-ep93xx.c   | 2 +-
 drivers/rtc/rtc-fm3130.c   | 2 +-
 drivers/rtc/rtc-imxdi.c    | 2 +-
 drivers/rtc/rtc-jz4740.c   | 2 +-
 drivers/rtc/rtc-lpc32xx.c  | 2 +-
 drivers/rtc/rtc-ls1x.c     | 2 +-
 drivers/rtc/rtc-m41t93.c   | 2 +-
 drivers/rtc/rtc-m41t94.c   | 2 +-
 drivers/rtc/rtc-m48t35.c   | 2 +-
 drivers/rtc/rtc-m48t59.c   | 2 +-
 drivers/rtc/rtc-m48t86.c   | 2 +-
 drivers/rtc/rtc-max6902.c  | 2 +-
 drivers/rtc/rtc-max8907.c  | 2 +-
 drivers/rtc/rtc-max8925.c  | 2 +-
 drivers/rtc/rtc-max8998.c  | 2 +-
 drivers/rtc/rtc-mpc5121.c  | 2 +-
 drivers/rtc/rtc-mrst.c     | 4 ++--
 drivers/rtc/rtc-mxc.c      | 2 +-
 drivers/rtc/rtc-nuc900.c   | 2 +-
 drivers/rtc/rtc-pcap.c     | 2 +-
 drivers/rtc/rtc-pcf2123.c  | 2 +-
 drivers/rtc/rtc-pcf50633.c | 2 +-
 drivers/rtc/rtc-pcf8583.c  | 2 +-
 drivers/rtc/rtc-pm8xxx.c   | 2 +-
 drivers/rtc/rtc-puv3.c     | 2 +-
 drivers/rtc/rtc-r9701.c    | 2 +-
 drivers/rtc/rtc-rc5t583.c  | 2 +-
 drivers/rtc/rtc-rs5c313.c  | 2 +-
 drivers/rtc/rtc-rs5c348.c  | 2 +-
 drivers/rtc/rtc-rv3029c2.c | 2 +-
 drivers/rtc/rtc-rx8025.c   | 2 +-
 drivers/rtc/rtc-rx8581.c   | 2 +-
 drivers/rtc/rtc-s3c.c      | 2 +-
 drivers/rtc/rtc-snvs.c     | 2 +-
 drivers/rtc/rtc-spear.c    | 2 +-
 drivers/rtc/rtc-stk17ta8.c | 2 +-
 drivers/rtc/rtc-tegra.c    | 2 +-
 drivers/rtc/rtc-test.c     | 2 +-
 drivers/rtc/rtc-tile.c     | 2 +-
 drivers/rtc/rtc-tps65910.c | 2 +-
 drivers/rtc/rtc-twl.c      | 2 +-
 drivers/rtc/rtc-vr41xx.c   | 2 +-
 drivers/rtc/rtc-vt8500.c   | 2 +-
 drivers/rtc/rtc-wm831x.c   | 2 +-
 drivers/rtc/rtc-wm8350.c   | 2 +-
 67 files changed, 68 insertions(+), 68 deletions(-)

diff --git a/drivers/rtc/rtc-88pm80x.c b/drivers/rtc/rtc-88pm80x.c
index 464488b..63b17eb 100644
--- a/drivers/rtc/rtc-88pm80x.c
+++ b/drivers/rtc/rtc-88pm80x.c
@@ -342,7 +342,7 @@ out:
 	return ret;
 }
 
-static int __devexit pm80x_rtc_remove(struct platform_device *pdev)
+static int pm80x_rtc_remove(struct platform_device *pdev)
 {
 	struct pm80x_rtc_info *info = platform_get_drvdata(pdev);
 	platform_set_drvdata(pdev, NULL);
diff --git a/drivers/rtc/rtc-88pm860x.c b/drivers/rtc/rtc-88pm860x.c
index 35ea7a4..c609a2a 100644
--- a/drivers/rtc/rtc-88pm860x.c
+++ b/drivers/rtc/rtc-88pm860x.c
@@ -412,7 +412,7 @@ out:
 	return ret;
 }
 
-static int __devexit pm860x_rtc_remove(struct platform_device *pdev)
+static int pm860x_rtc_remove(struct platform_device *pdev)
 {
 	struct pm860x_rtc_info *info = platform_get_drvdata(pdev);
 
diff --git a/drivers/rtc/rtc-ab8500.c b/drivers/rtc/rtc-ab8500.c
index 2c18afc..57cde2b 100644
--- a/drivers/rtc/rtc-ab8500.c
+++ b/drivers/rtc/rtc-ab8500.c
@@ -448,7 +448,7 @@ static int ab8500_rtc_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit ab8500_rtc_remove(struct platform_device *pdev)
+static int ab8500_rtc_remove(struct platform_device *pdev)
 {
 	struct rtc_device *rtc = platform_get_drvdata(pdev);
 	int irq = platform_get_irq_byname(pdev, "ALARM");
diff --git a/drivers/rtc/rtc-at91sam9.c b/drivers/rtc/rtc-at91sam9.c
index de4cc11..39cfd2e 100644
--- a/drivers/rtc/rtc-at91sam9.c
+++ b/drivers/rtc/rtc-at91sam9.c
@@ -387,7 +387,7 @@ fail:
 /*
  * Disable and remove the RTC driver
  */
-static int __devexit at91_rtc_remove(struct platform_device *pdev)
+static int at91_rtc_remove(struct platform_device *pdev)
 {
 	struct sam9_rtc	*rtc = platform_get_drvdata(pdev);
 	u32		mr = rtt_readl(rtc, MR);
diff --git a/drivers/rtc/rtc-au1xxx.c b/drivers/rtc/rtc-au1xxx.c
index 331a771..b309da4 100644
--- a/drivers/rtc/rtc-au1xxx.c
+++ b/drivers/rtc/rtc-au1xxx.c
@@ -116,7 +116,7 @@ out_err:
 	return ret;
 }
 
-static int __devexit au1xtoy_rtc_remove(struct platform_device *pdev)
+static int au1xtoy_rtc_remove(struct platform_device *pdev)
 {
 	struct rtc_device *rtcdev = platform_get_drvdata(pdev);
 
diff --git a/drivers/rtc/rtc-bfin.c b/drivers/rtc/rtc-bfin.c
index 863eae7..4ec614b 100644
--- a/drivers/rtc/rtc-bfin.c
+++ b/drivers/rtc/rtc-bfin.c
@@ -388,7 +388,7 @@ err:
 	return ret;
 }
 
-static int __devexit bfin_rtc_remove(struct platform_device *pdev)
+static int bfin_rtc_remove(struct platform_device *pdev)
 {
 	struct bfin_rtc *rtc = platform_get_drvdata(pdev);
 	struct device *dev = &pdev->dev;
diff --git a/drivers/rtc/rtc-bq32k.c b/drivers/rtc/rtc-bq32k.c
index 1f02ba6..036cb89 100644
--- a/drivers/rtc/rtc-bq32k.c
+++ b/drivers/rtc/rtc-bq32k.c
@@ -163,7 +163,7 @@ static int bq32k_probe(struct i2c_client *client,
 	return 0;
 }
 
-static int __devexit bq32k_remove(struct i2c_client *client)
+static int bq32k_remove(struct i2c_client *client)
 {
 	struct rtc_device *rtc = i2c_get_clientdata(client);
 
diff --git a/drivers/rtc/rtc-bq4802.c b/drivers/rtc/rtc-bq4802.c
index 3b40ff4..693be71 100644
--- a/drivers/rtc/rtc-bq4802.c
+++ b/drivers/rtc/rtc-bq4802.c
@@ -191,7 +191,7 @@ out_free:
 	goto out;
 }
 
-static int __devexit bq4802_remove(struct platform_device *pdev)
+static int bq4802_remove(struct platform_device *pdev)
 {
 	struct bq4802 *p = platform_get_drvdata(pdev);
 
diff --git a/drivers/rtc/rtc-da9052.c b/drivers/rtc/rtc-da9052.c
index 7e1758a..60b826e 100644
--- a/drivers/rtc/rtc-da9052.c
+++ b/drivers/rtc/rtc-da9052.c
@@ -262,7 +262,7 @@ err_free_irq:
 	return ret;
 }
 
-static int __devexit da9052_rtc_remove(struct platform_device *pdev)
+static int da9052_rtc_remove(struct platform_device *pdev)
 {
 	struct da9052_rtc *rtc = pdev->dev.platform_data;
 
diff --git a/drivers/rtc/rtc-davinci.c b/drivers/rtc/rtc-davinci.c
index 7ffc240..3f4e8ba 100644
--- a/drivers/rtc/rtc-davinci.c
+++ b/drivers/rtc/rtc-davinci.c
@@ -572,7 +572,7 @@ fail1:
 	return ret;
 }
 
-static int __devexit davinci_rtc_remove(struct platform_device *pdev)
+static int davinci_rtc_remove(struct platform_device *pdev)
 {
 	struct davinci_rtc *davinci_rtc = platform_get_drvdata(pdev);
 
diff --git a/drivers/rtc/rtc-dm355evm.c b/drivers/rtc/rtc-dm355evm.c
index 2323ae7..b2ed2c9 100644
--- a/drivers/rtc/rtc-dm355evm.c
+++ b/drivers/rtc/rtc-dm355evm.c
@@ -139,7 +139,7 @@ static int dm355evm_rtc_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit dm355evm_rtc_remove(struct platform_device *pdev)
+static int dm355evm_rtc_remove(struct platform_device *pdev)
 {
 	struct rtc_device *rtc = platform_get_drvdata(pdev);
 
diff --git a/drivers/rtc/rtc-ds1286.c b/drivers/rtc/rtc-ds1286.c
index f1c8681..d989412 100644
--- a/drivers/rtc/rtc-ds1286.c
+++ b/drivers/rtc/rtc-ds1286.c
@@ -376,7 +376,7 @@ out:
 	return ret;
 }
 
-static int __devexit ds1286_remove(struct platform_device *pdev)
+static int ds1286_remove(struct platform_device *pdev)
 {
 	struct ds1286_priv *priv = platform_get_drvdata(pdev);
 
diff --git a/drivers/rtc/rtc-ds1302.c b/drivers/rtc/rtc-ds1302.c
index 1f4e186..fdbcdb2 100644
--- a/drivers/rtc/rtc-ds1302.c
+++ b/drivers/rtc/rtc-ds1302.c
@@ -234,7 +234,7 @@ static int __init ds1302_rtc_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit ds1302_rtc_remove(struct platform_device *pdev)
+static int ds1302_rtc_remove(struct platform_device *pdev)
 {
 	struct rtc_device *rtc = platform_get_drvdata(pdev);
 
diff --git a/drivers/rtc/rtc-ds1305.c b/drivers/rtc/rtc-ds1305.c
index 62470f6..d578773 100644
--- a/drivers/rtc/rtc-ds1305.c
+++ b/drivers/rtc/rtc-ds1305.c
@@ -787,7 +787,7 @@ fail0:
 	return status;
 }
 
-static int __devexit ds1305_remove(struct spi_device *spi)
+static int ds1305_remove(struct spi_device *spi)
 {
 	struct ds1305 *ds1305 = spi_get_drvdata(spi);
 
diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index 00b0643..e77c4fc 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -938,7 +938,7 @@ exit_free:
 	return err;
 }
 
-static int __devexit ds1307_remove(struct i2c_client *client)
+static int ds1307_remove(struct i2c_client *client)
 {
 	struct ds1307 *ds1307 = i2c_get_clientdata(client);
 
diff --git a/drivers/rtc/rtc-ds1374.c b/drivers/rtc/rtc-ds1374.c
index 039a676..fef7686 100644
--- a/drivers/rtc/rtc-ds1374.c
+++ b/drivers/rtc/rtc-ds1374.c
@@ -391,7 +391,7 @@ out_free:
 	return ret;
 }
 
-static int __devexit ds1374_remove(struct i2c_client *client)
+static int ds1374_remove(struct i2c_client *client)
 {
 	struct ds1374 *ds1374 = i2c_get_clientdata(client);
 
diff --git a/drivers/rtc/rtc-ds1390.c b/drivers/rtc/rtc-ds1390.c
index 90b2c7c..f994257 100644
--- a/drivers/rtc/rtc-ds1390.c
+++ b/drivers/rtc/rtc-ds1390.c
@@ -156,7 +156,7 @@ static int ds1390_probe(struct spi_device *spi)
 	return res;
 }
 
-static int __devexit ds1390_remove(struct spi_device *spi)
+static int ds1390_remove(struct spi_device *spi)
 {
 	struct ds1390 *chip = spi_get_drvdata(spi);
 
diff --git a/drivers/rtc/rtc-ds1511.c b/drivers/rtc/rtc-ds1511.c
index 075578a..c9bf1fd 100644
--- a/drivers/rtc/rtc-ds1511.c
+++ b/drivers/rtc/rtc-ds1511.c
@@ -551,7 +551,7 @@ ds1511_rtc_probe(struct platform_device *pdev)
 	return ret;
 }
 
- static int __devexit
+ static int
 ds1511_rtc_remove(struct platform_device *pdev)
 {
 	struct rtc_plat_data *pdata = platform_get_drvdata(pdev);
diff --git a/drivers/rtc/rtc-ds1553.c b/drivers/rtc/rtc-ds1553.c
index 40a7464..25ce062 100644
--- a/drivers/rtc/rtc-ds1553.c
+++ b/drivers/rtc/rtc-ds1553.c
@@ -338,7 +338,7 @@ static int ds1553_rtc_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int __devexit ds1553_rtc_remove(struct platform_device *pdev)
+static int ds1553_rtc_remove(struct platform_device *pdev)
 {
 	struct rtc_plat_data *pdata = platform_get_drvdata(pdev);
 
diff --git a/drivers/rtc/rtc-ds1742.c b/drivers/rtc/rtc-ds1742.c
index 392d387..609c870 100644
--- a/drivers/rtc/rtc-ds1742.c
+++ b/drivers/rtc/rtc-ds1742.c
@@ -222,7 +222,7 @@ static int ds1742_rtc_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int __devexit ds1742_rtc_remove(struct platform_device *pdev)
+static int ds1742_rtc_remove(struct platform_device *pdev)
 {
 	struct rtc_plat_data *pdata = platform_get_drvdata(pdev);
 
diff --git a/drivers/rtc/rtc-ds3232.c b/drivers/rtc/rtc-ds3232.c
index 3af6d72..80df30b 100644
--- a/drivers/rtc/rtc-ds3232.c
+++ b/drivers/rtc/rtc-ds3232.c
@@ -439,7 +439,7 @@ out_free:
 	return ret;
 }
 
-static int __devexit ds3232_remove(struct i2c_client *client)
+static int ds3232_remove(struct i2c_client *client)
 {
 	struct ds3232 *ds3232 = i2c_get_clientdata(client);
 
diff --git a/drivers/rtc/rtc-ds3234.c b/drivers/rtc/rtc-ds3234.c
index 6892e49..7a4495e 100644
--- a/drivers/rtc/rtc-ds3234.c
+++ b/drivers/rtc/rtc-ds3234.c
@@ -156,7 +156,7 @@ static int ds3234_probe(struct spi_device *spi)
 	return 0;
 }
 
-static int __devexit ds3234_remove(struct spi_device *spi)
+static int ds3234_remove(struct spi_device *spi)
 {
 	struct rtc_device *rtc = spi_get_drvdata(spi);
 
diff --git a/drivers/rtc/rtc-ep93xx.c b/drivers/rtc/rtc-ep93xx.c
index c86082a..1a4e5e4 100644
--- a/drivers/rtc/rtc-ep93xx.c
+++ b/drivers/rtc/rtc-ep93xx.c
@@ -174,7 +174,7 @@ exit:
 	return err;
 }
 
-static int __devexit ep93xx_rtc_remove(struct platform_device *pdev)
+static int ep93xx_rtc_remove(struct platform_device *pdev)
 {
 	struct ep93xx_rtc *ep93xx_rtc = platform_get_drvdata(pdev);
 
diff --git a/drivers/rtc/rtc-fm3130.c b/drivers/rtc/rtc-fm3130.c
index 4b0befe..ee2c0b3 100644
--- a/drivers/rtc/rtc-fm3130.c
+++ b/drivers/rtc/rtc-fm3130.c
@@ -546,7 +546,7 @@ exit_free:
 	return err;
 }
 
-static int __devexit fm3130_remove(struct i2c_client *client)
+static int fm3130_remove(struct i2c_client *client)
 {
 	struct fm3130 *fm3130 = i2c_get_clientdata(client);
 
diff --git a/drivers/rtc/rtc-imxdi.c b/drivers/rtc/rtc-imxdi.c
index d4e4fab..8b6c71b 100644
--- a/drivers/rtc/rtc-imxdi.c
+++ b/drivers/rtc/rtc-imxdi.c
@@ -479,7 +479,7 @@ err:
 	return rc;
 }
 
-static int __devexit dryice_rtc_remove(struct platform_device *pdev)
+static int dryice_rtc_remove(struct platform_device *pdev)
 {
 	struct imxdi_dev *imxdi = platform_get_drvdata(pdev);
 
diff --git a/drivers/rtc/rtc-jz4740.c b/drivers/rtc/rtc-jz4740.c
index d51b703..1e48686 100644
--- a/drivers/rtc/rtc-jz4740.c
+++ b/drivers/rtc/rtc-jz4740.c
@@ -297,7 +297,7 @@ err_free:
 	return ret;
 }
 
-static int __devexit jz4740_rtc_remove(struct platform_device *pdev)
+static int jz4740_rtc_remove(struct platform_device *pdev)
 {
 	struct jz4740_rtc *rtc = platform_get_drvdata(pdev);
 
diff --git a/drivers/rtc/rtc-lpc32xx.c b/drivers/rtc/rtc-lpc32xx.c
index 81fb32c..40a5983 100644
--- a/drivers/rtc/rtc-lpc32xx.c
+++ b/drivers/rtc/rtc-lpc32xx.c
@@ -299,7 +299,7 @@ static int lpc32xx_rtc_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit lpc32xx_rtc_remove(struct platform_device *pdev)
+static int lpc32xx_rtc_remove(struct platform_device *pdev)
 {
 	struct lpc32xx_rtc *rtc = platform_get_drvdata(pdev);
 
diff --git a/drivers/rtc/rtc-ls1x.c b/drivers/rtc/rtc-ls1x.c
index bf308fc..f59b634 100644
--- a/drivers/rtc/rtc-ls1x.c
+++ b/drivers/rtc/rtc-ls1x.c
@@ -185,7 +185,7 @@ err:
 	return ret;
 }
 
-static int __devexit ls1x_rtc_remove(struct platform_device *pdev)
+static int ls1x_rtc_remove(struct platform_device *pdev)
 {
 	struct rtc_device *rtcdev = platform_get_drvdata(pdev);
 
diff --git a/drivers/rtc/rtc-m41t93.c b/drivers/rtc/rtc-m41t93.c
index ae9203b..4916968 100644
--- a/drivers/rtc/rtc-m41t93.c
+++ b/drivers/rtc/rtc-m41t93.c
@@ -195,7 +195,7 @@ static int m41t93_probe(struct spi_device *spi)
 }
 
 
-static int __devexit m41t93_remove(struct spi_device *spi)
+static int m41t93_remove(struct spi_device *spi)
 {
 	struct rtc_device *rtc = spi_get_drvdata(spi);
 
diff --git a/drivers/rtc/rtc-m41t94.c b/drivers/rtc/rtc-m41t94.c
index c2121cc..89266c6 100644
--- a/drivers/rtc/rtc-m41t94.c
+++ b/drivers/rtc/rtc-m41t94.c
@@ -134,7 +134,7 @@ static int m41t94_probe(struct spi_device *spi)
 	return 0;
 }
 
-static int __devexit m41t94_remove(struct spi_device *spi)
+static int m41t94_remove(struct spi_device *spi)
 {
 	struct rtc_device *rtc = spi_get_drvdata(spi);
 
diff --git a/drivers/rtc/rtc-m48t35.c b/drivers/rtc/rtc-m48t35.c
index d18e647..31c9190 100644
--- a/drivers/rtc/rtc-m48t35.c
+++ b/drivers/rtc/rtc-m48t35.c
@@ -194,7 +194,7 @@ out:
 	return ret;
 }
 
-static int __devexit m48t35_remove(struct platform_device *pdev)
+static int m48t35_remove(struct platform_device *pdev)
 {
 	struct m48t35_priv *priv = platform_get_drvdata(pdev);
 
diff --git a/drivers/rtc/rtc-m48t59.c b/drivers/rtc/rtc-m48t59.c
index b4cc7e9..130f29a 100644
--- a/drivers/rtc/rtc-m48t59.c
+++ b/drivers/rtc/rtc-m48t59.c
@@ -501,7 +501,7 @@ out:
 	return ret;
 }
 
-static int __devexit m48t59_rtc_remove(struct platform_device *pdev)
+static int m48t59_rtc_remove(struct platform_device *pdev)
 {
 	struct m48t59_private *m48t59 = platform_get_drvdata(pdev);
 	struct m48t59_plat_data *pdata = pdev->dev.platform_data;
diff --git a/drivers/rtc/rtc-m48t86.c b/drivers/rtc/rtc-m48t86.c
index 5f841b6..2ffbcac 100644
--- a/drivers/rtc/rtc-m48t86.c
+++ b/drivers/rtc/rtc-m48t86.c
@@ -164,7 +164,7 @@ static int m48t86_rtc_probe(struct platform_device *dev)
 	return 0;
 }
 
-static int __devexit m48t86_rtc_remove(struct platform_device *dev)
+static int m48t86_rtc_remove(struct platform_device *dev)
 {
 	struct rtc_device *rtc = platform_get_drvdata(dev);
 
diff --git a/drivers/rtc/rtc-max6902.c b/drivers/rtc/rtc-max6902.c
index 2f011cc..7d0bf69 100644
--- a/drivers/rtc/rtc-max6902.c
+++ b/drivers/rtc/rtc-max6902.c
@@ -143,7 +143,7 @@ static int max6902_probe(struct spi_device *spi)
 	return 0;
 }
 
-static int __devexit max6902_remove(struct spi_device *spi)
+static int max6902_remove(struct spi_device *spi)
 {
 	struct rtc_device *rtc = dev_get_drvdata(&spi->dev);
 
diff --git a/drivers/rtc/rtc-max8907.c b/drivers/rtc/rtc-max8907.c
index f48a841..1d049da 100644
--- a/drivers/rtc/rtc-max8907.c
+++ b/drivers/rtc/rtc-max8907.c
@@ -220,7 +220,7 @@ err_unregister:
 	return ret;
 }
 
-static int __devexit max8907_rtc_remove(struct platform_device *pdev)
+static int max8907_rtc_remove(struct platform_device *pdev)
 {
 	struct max8907_rtc *rtc = platform_get_drvdata(pdev);
 
diff --git a/drivers/rtc/rtc-max8925.c b/drivers/rtc/rtc-max8925.c
index afb63fe..a0c8265 100644
--- a/drivers/rtc/rtc-max8925.c
+++ b/drivers/rtc/rtc-max8925.c
@@ -292,7 +292,7 @@ out_irq:
 	return ret;
 }
 
-static int __devexit max8925_rtc_remove(struct platform_device *pdev)
+static int max8925_rtc_remove(struct platform_device *pdev)
 {
 	struct max8925_rtc_info *info = platform_get_drvdata(pdev);
 
diff --git a/drivers/rtc/rtc-max8998.c b/drivers/rtc/rtc-max8998.c
index fd1eed5..8f234a0 100644
--- a/drivers/rtc/rtc-max8998.c
+++ b/drivers/rtc/rtc-max8998.c
@@ -298,7 +298,7 @@ out_rtc:
 	return ret;
 }
 
-static int __devexit max8998_rtc_remove(struct platform_device *pdev)
+static int max8998_rtc_remove(struct platform_device *pdev)
 {
 	struct max8998_rtc_info *info = platform_get_drvdata(pdev);
 
diff --git a/drivers/rtc/rtc-mpc5121.c b/drivers/rtc/rtc-mpc5121.c
index 4e44699..bec10be 100644
--- a/drivers/rtc/rtc-mpc5121.c
+++ b/drivers/rtc/rtc-mpc5121.c
@@ -382,7 +382,7 @@ out_free:
 	return err;
 }
 
-static int __devexit mpc5121_rtc_remove(struct platform_device *op)
+static int mpc5121_rtc_remove(struct platform_device *op)
 {
 	struct mpc5121_rtc_data *rtc = dev_get_drvdata(&op->dev);
 	struct mpc5121_rtc_regs __iomem *regs = rtc->regs;
diff --git a/drivers/rtc/rtc-mrst.c b/drivers/rtc/rtc-mrst.c
index 68cb66e..82541ae 100644
--- a/drivers/rtc/rtc-mrst.c
+++ b/drivers/rtc/rtc-mrst.c
@@ -394,7 +394,7 @@ static void rtc_mrst_do_shutdown(void)
 	spin_unlock_irq(&rtc_lock);
 }
 
-static void __devexit rtc_mrst_do_remove(struct device *dev)
+static void rtc_mrst_do_remove(struct device *dev)
 {
 	struct mrst_rtc	*mrst = dev_get_drvdata(dev);
 	struct resource *iomem;
@@ -510,7 +510,7 @@ static int vinit vrtc_mrst_platform_probe(struct platform_device *pdev)
 			platform_get_irq(pdev, 0));
 }
 
-static int __devexit vrtc_mrst_platform_remove(struct platform_device *pdev)
+static int vrtc_mrst_platform_remove(struct platform_device *pdev)
 {
 	rtc_mrst_do_remove(&pdev->dev);
 	return 0;
diff --git a/drivers/rtc/rtc-mxc.c b/drivers/rtc/rtc-mxc.c
index cf20379..1c3ef72 100644
--- a/drivers/rtc/rtc-mxc.c
+++ b/drivers/rtc/rtc-mxc.c
@@ -460,7 +460,7 @@ exit_free_pdata:
 	return ret;
 }
 
-static int __devexit mxc_rtc_remove(struct platform_device *pdev)
+static int mxc_rtc_remove(struct platform_device *pdev)
 {
 	struct rtc_plat_data *pdata = platform_get_drvdata(pdev);
 
diff --git a/drivers/rtc/rtc-nuc900.c b/drivers/rtc/rtc-nuc900.c
index b3f418d..a636808 100644
--- a/drivers/rtc/rtc-nuc900.c
+++ b/drivers/rtc/rtc-nuc900.c
@@ -284,7 +284,7 @@ fail1:	kfree(nuc900_rtc);
 	return err;
 }
 
-static int __devexit nuc900_rtc_remove(struct platform_device *pdev)
+static int nuc900_rtc_remove(struct platform_device *pdev)
 {
 	struct nuc900_rtc *nuc900_rtc = platform_get_drvdata(pdev);
 	struct resource *res;
diff --git a/drivers/rtc/rtc-pcap.c b/drivers/rtc/rtc-pcap.c
index e33b94b6..e0019cd 100644
--- a/drivers/rtc/rtc-pcap.c
+++ b/drivers/rtc/rtc-pcap.c
@@ -183,7 +183,7 @@ fail_rtc:
 	return err;
 }
 
-static int __devexit pcap_rtc_remove(struct platform_device *pdev)
+static int pcap_rtc_remove(struct platform_device *pdev)
 {
 	struct pcap_rtc *pcap_rtc = platform_get_drvdata(pdev);
 
diff --git a/drivers/rtc/rtc-pcf2123.c b/drivers/rtc/rtc-pcf2123.c
index 3d39070..02b742a 100644
--- a/drivers/rtc/rtc-pcf2123.c
+++ b/drivers/rtc/rtc-pcf2123.c
@@ -319,7 +319,7 @@ kfree_exit:
 	return ret;
 }
 
-static int __devexit pcf2123_remove(struct spi_device *spi)
+static int pcf2123_remove(struct spi_device *spi)
 {
 	struct pcf2123_plat_data *pdata = spi->dev.platform_data;
 	int i;
diff --git a/drivers/rtc/rtc-pcf50633.c b/drivers/rtc/rtc-pcf50633.c
index 78ffaaa..e9f3135 100644
--- a/drivers/rtc/rtc-pcf50633.c
+++ b/drivers/rtc/rtc-pcf50633.c
@@ -272,7 +272,7 @@ static int pcf50633_rtc_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit pcf50633_rtc_remove(struct platform_device *pdev)
+static int pcf50633_rtc_remove(struct platform_device *pdev)
 {
 	struct pcf50633_rtc *rtc;
 
diff --git a/drivers/rtc/rtc-pcf8583.c b/drivers/rtc/rtc-pcf8583.c
index 55c9766..3415b8f 100644
--- a/drivers/rtc/rtc-pcf8583.c
+++ b/drivers/rtc/rtc-pcf8583.c
@@ -294,7 +294,7 @@ exit_kfree:
 	return err;
 }
 
-static int __devexit pcf8583_remove(struct i2c_client *client)
+static int pcf8583_remove(struct i2c_client *client)
 {
 	struct pcf8583 *pcf8583 = i2c_get_clientdata(client);
 
diff --git a/drivers/rtc/rtc-pm8xxx.c b/drivers/rtc/rtc-pm8xxx.c
index 39afdf0..f1a6557 100644
--- a/drivers/rtc/rtc-pm8xxx.c
+++ b/drivers/rtc/rtc-pm8xxx.c
@@ -485,7 +485,7 @@ fail_rtc_enable:
 	return rc;
 }
 
-static int __devexit pm8xxx_rtc_remove(struct platform_device *pdev)
+static int pm8xxx_rtc_remove(struct platform_device *pdev)
 {
 	struct pm8xxx_rtc *rtc_dd = platform_get_drvdata(pdev);
 
diff --git a/drivers/rtc/rtc-puv3.c b/drivers/rtc/rtc-puv3.c
index 619287d..0407e13 100644
--- a/drivers/rtc/rtc-puv3.c
+++ b/drivers/rtc/rtc-puv3.c
@@ -220,7 +220,7 @@ static void puv3_rtc_enable(struct platform_device *pdev, int en)
 	}
 }
 
-static int __devexit puv3_rtc_remove(struct platform_device *dev)
+static int puv3_rtc_remove(struct platform_device *dev)
 {
 	struct rtc_device *rtc = platform_get_drvdata(dev);
 
diff --git a/drivers/rtc/rtc-r9701.c b/drivers/rtc/rtc-r9701.c
index cf856e7..7726f4a 100644
--- a/drivers/rtc/rtc-r9701.c
+++ b/drivers/rtc/rtc-r9701.c
@@ -164,7 +164,7 @@ static int r9701_probe(struct spi_device *spi)
 	return 0;
 }
 
-static int __devexit r9701_remove(struct spi_device *spi)
+static int r9701_remove(struct spi_device *spi)
 {
 	struct rtc_device *rtc = dev_get_drvdata(&spi->dev);
 
diff --git a/drivers/rtc/rtc-rc5t583.c b/drivers/rtc/rtc-rc5t583.c
index 69e8287..eb3194d 100644
--- a/drivers/rtc/rtc-rc5t583.c
+++ b/drivers/rtc/rtc-rc5t583.c
@@ -271,7 +271,7 @@ static int rc5t583_rtc_probe(struct platform_device *pdev)
  * Disable rc5t583 RTC interrupts.
  * Sets status flag to free.
  */
-static int __devexit rc5t583_rtc_remove(struct platform_device *pdev)
+static int rc5t583_rtc_remove(struct platform_device *pdev)
 {
 	struct rc5t583_rtc *rc5t583_rtc = dev_get_drvdata(&pdev->dev);
 
diff --git a/drivers/rtc/rtc-rs5c313.c b/drivers/rtc/rtc-rs5c313.c
index ae3f9fd..37f488e 100644
--- a/drivers/rtc/rtc-rs5c313.c
+++ b/drivers/rtc/rtc-rs5c313.c
@@ -377,7 +377,7 @@ static int rs5c313_rtc_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit rs5c313_rtc_remove(struct platform_device *pdev)
+static int rs5c313_rtc_remove(struct platform_device *pdev)
 {
 	struct rtc_device *rtc = platform_get_drvdata( pdev );
 
diff --git a/drivers/rtc/rtc-rs5c348.c b/drivers/rtc/rtc-rs5c348.c
index 40a5e05..72ef10b 100644
--- a/drivers/rtc/rtc-rs5c348.c
+++ b/drivers/rtc/rtc-rs5c348.c
@@ -218,7 +218,7 @@ static int rs5c348_probe(struct spi_device *spi)
 	return ret;
 }
 
-static int __devexit rs5c348_remove(struct spi_device *spi)
+static int rs5c348_remove(struct spi_device *spi)
 {
 	struct rs5c348_plat_data *pdata = spi->dev.platform_data;
 	struct rtc_device *rtc = pdata->rtc;
diff --git a/drivers/rtc/rtc-rv3029c2.c b/drivers/rtc/rtc-rv3029c2.c
index 52d87e8..93d07e5 100644
--- a/drivers/rtc/rtc-rv3029c2.c
+++ b/drivers/rtc/rtc-rv3029c2.c
@@ -418,7 +418,7 @@ exit_unregister:
 	return rc;
 }
 
-static int __devexit rv3029c2_remove(struct i2c_client *client)
+static int rv3029c2_remove(struct i2c_client *client)
 {
 	struct rtc_device *rtc = i2c_get_clientdata(client);
 
diff --git a/drivers/rtc/rtc-rx8025.c b/drivers/rtc/rtc-rx8025.c
index 5de60a3..dcee700 100644
--- a/drivers/rtc/rtc-rx8025.c
+++ b/drivers/rtc/rtc-rx8025.c
@@ -614,7 +614,7 @@ errout:
 	return err;
 }
 
-static int __devexit rx8025_remove(struct i2c_client *client)
+static int rx8025_remove(struct i2c_client *client)
 {
 	struct rx8025_data *rx8025 = i2c_get_clientdata(client);
 	struct mutex *lock = &rx8025->rtc->ops_lock;
diff --git a/drivers/rtc/rtc-rx8581.c b/drivers/rtc/rtc-rx8581.c
index 2062458..370b31f 100644
--- a/drivers/rtc/rtc-rx8581.c
+++ b/drivers/rtc/rtc-rx8581.c
@@ -251,7 +251,7 @@ static int rx8581_probe(struct i2c_client *client,
 	return 0;
 }
 
-static int __devexit rx8581_remove(struct i2c_client *client)
+static int rx8581_remove(struct i2c_client *client)
 {
 	struct rtc_device *rtc = i2c_get_clientdata(client);
 
diff --git a/drivers/rtc/rtc-s3c.c b/drivers/rtc/rtc-s3c.c
index 44bebef..53b9546 100644
--- a/drivers/rtc/rtc-s3c.c
+++ b/drivers/rtc/rtc-s3c.c
@@ -423,7 +423,7 @@ static void s3c_rtc_enable(struct platform_device *pdev, int en)
 	clk_disable(rtc_clk);
 }
 
-static int __devexit s3c_rtc_remove(struct platform_device *dev)
+static int s3c_rtc_remove(struct platform_device *dev)
 {
 	struct rtc_device *rtc = platform_get_drvdata(dev);
 
diff --git a/drivers/rtc/rtc-snvs.c b/drivers/rtc/rtc-snvs.c
index bc3671a..d5ec785 100644
--- a/drivers/rtc/rtc-snvs.c
+++ b/drivers/rtc/rtc-snvs.c
@@ -294,7 +294,7 @@ static int snvs_rtc_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit snvs_rtc_remove(struct platform_device *pdev)
+static int snvs_rtc_remove(struct platform_device *pdev)
 {
 	struct snvs_rtc_data *data = platform_get_drvdata(pdev);
 
diff --git a/drivers/rtc/rtc-spear.c b/drivers/rtc/rtc-spear.c
index c71cc09..c2121b5 100644
--- a/drivers/rtc/rtc-spear.c
+++ b/drivers/rtc/rtc-spear.c
@@ -425,7 +425,7 @@ err_disable_clock:
 	return status;
 }
 
-static int __devexit spear_rtc_remove(struct platform_device *pdev)
+static int spear_rtc_remove(struct platform_device *pdev)
 {
 	struct spear_rtc_config *config = platform_get_drvdata(pdev);
 
diff --git a/drivers/rtc/rtc-stk17ta8.c b/drivers/rtc/rtc-stk17ta8.c
index 63deb9c..7e4a6f6 100644
--- a/drivers/rtc/rtc-stk17ta8.c
+++ b/drivers/rtc/rtc-stk17ta8.c
@@ -347,7 +347,7 @@ static int stk17ta8_rtc_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int __devexit stk17ta8_rtc_remove(struct platform_device *pdev)
+static int stk17ta8_rtc_remove(struct platform_device *pdev)
 {
 	struct rtc_plat_data *pdata = platform_get_drvdata(pdev);
 
diff --git a/drivers/rtc/rtc-tegra.c b/drivers/rtc/rtc-tegra.c
index 2b1a7bd..5ba2f75 100644
--- a/drivers/rtc/rtc-tegra.c
+++ b/drivers/rtc/rtc-tegra.c
@@ -375,7 +375,7 @@ err_dev_unreg:
 	return ret;
 }
 
-static int __devexit tegra_rtc_remove(struct platform_device *pdev)
+static int tegra_rtc_remove(struct platform_device *pdev)
 {
 	struct tegra_rtc_info *info = platform_get_drvdata(pdev);
 
diff --git a/drivers/rtc/rtc-test.c b/drivers/rtc/rtc-test.c
index 9b23e9f..b92e0f6 100644
--- a/drivers/rtc/rtc-test.c
+++ b/drivers/rtc/rtc-test.c
@@ -119,7 +119,7 @@ err:
 	return err;
 }
 
-static int __devexit test_remove(struct platform_device *plat_dev)
+static int test_remove(struct platform_device *plat_dev)
 {
 	struct rtc_device *rtc = platform_get_drvdata(plat_dev);
 
diff --git a/drivers/rtc/rtc-tile.c b/drivers/rtc/rtc-tile.c
index f051430..62db484 100644
--- a/drivers/rtc/rtc-tile.c
+++ b/drivers/rtc/rtc-tile.c
@@ -94,7 +94,7 @@ static int tile_rtc_probe(struct platform_device *dev)
 /*
  * Device cleanup routine.
  */
-static int __devexit tile_rtc_remove(struct platform_device *dev)
+static int tile_rtc_remove(struct platform_device *dev)
 {
 	struct rtc_device *rtc = platform_get_drvdata(dev);
 
diff --git a/drivers/rtc/rtc-tps65910.c b/drivers/rtc/rtc-tps65910.c
index dee057d..23bdf9d 100644
--- a/drivers/rtc/rtc-tps65910.c
+++ b/drivers/rtc/rtc-tps65910.c
@@ -285,7 +285,7 @@ static int tps65910_rtc_probe(struct platform_device *pdev)
  * Disable tps65910 RTC interrupts.
  * Sets status flag to free.
  */
-static int __devexit tps65910_rtc_remove(struct platform_device *pdev)
+static int tps65910_rtc_remove(struct platform_device *pdev)
 {
 	/* leave rtc running, but disable irqs */
 	struct rtc_device *rtc = platform_get_drvdata(pdev);
diff --git a/drivers/rtc/rtc-twl.c b/drivers/rtc/rtc-twl.c
index 0eda428..4dbe68c 100644
--- a/drivers/rtc/rtc-twl.c
+++ b/drivers/rtc/rtc-twl.c
@@ -535,7 +535,7 @@ out1:
  * Disable all TWL RTC module interrupts.
  * Sets status flag to free.
  */
-static int __devexit twl_rtc_remove(struct platform_device *pdev)
+static int twl_rtc_remove(struct platform_device *pdev)
 {
 	/* leave rtc running, but disable irqs */
 	struct rtc_device *rtc = platform_get_drvdata(pdev);
diff --git a/drivers/rtc/rtc-vr41xx.c b/drivers/rtc/rtc-vr41xx.c
index 12c6e55..6c3774c 100644
--- a/drivers/rtc/rtc-vr41xx.c
+++ b/drivers/rtc/rtc-vr41xx.c
@@ -373,7 +373,7 @@ err_rtc1_iounmap:
 	return retval;
 }
 
-static int __devexit rtc_remove(struct platform_device *pdev)
+static int rtc_remove(struct platform_device *pdev)
 {
 	struct rtc_device *rtc;
 
diff --git a/drivers/rtc/rtc-vt8500.c b/drivers/rtc/rtc-vt8500.c
index dfed697..fd14187 100644
--- a/drivers/rtc/rtc-vt8500.c
+++ b/drivers/rtc/rtc-vt8500.c
@@ -279,7 +279,7 @@ err_release:
 	return ret;
 }
 
-static int __devexit vt8500_rtc_remove(struct platform_device *pdev)
+static int vt8500_rtc_remove(struct platform_device *pdev)
 {
 	struct vt8500_rtc *vt8500_rtc = platform_get_drvdata(pdev);
 
diff --git a/drivers/rtc/rtc-wm831x.c b/drivers/rtc/rtc-wm831x.c
index f5955bb..1b0affb 100644
--- a/drivers/rtc/rtc-wm831x.c
+++ b/drivers/rtc/rtc-wm831x.c
@@ -459,7 +459,7 @@ err:
 	return ret;
 }
 
-static int __devexit wm831x_rtc_remove(struct platform_device *pdev)
+static int wm831x_rtc_remove(struct platform_device *pdev)
 {
 	struct wm831x_rtc *wm831x_rtc = platform_get_drvdata(pdev);
 	int alm_irq = platform_get_irq_byname(pdev, "ALM");
diff --git a/drivers/rtc/rtc-wm8350.c b/drivers/rtc/rtc-wm8350.c
index c7ac9e2..8ad86ae 100644
--- a/drivers/rtc/rtc-wm8350.c
+++ b/drivers/rtc/rtc-wm8350.c
@@ -459,7 +459,7 @@ static int wm8350_rtc_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit wm8350_rtc_remove(struct platform_device *pdev)
+static int wm8350_rtc_remove(struct platform_device *pdev)
 {
 	struct wm8350 *wm8350 = platform_get_drvdata(pdev);
 	struct wm8350_rtc *wm_rtc = &wm8350->rtc;
-- 
1.8.0
