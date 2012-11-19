From: wfp5p@virginia.edu (Bill Pemberton)
Date: Mon, 19 Nov 2012 13:21:39 -0500
Subject: [PATCH 150/493] rtc: remove use of __devinit
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Message-ID: <1353349642-3677-150-git-send-email-wfp5p@virginia.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_HOTPLUG is going away as an option so __devinit is no longer
needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: Alessandro Zummo <a.zummo@towertech.it> 
Cc: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com> 
Cc: Linus Walleij <linus.walleij@linaro.org> 
Cc: Wan ZongShun <mcuos.com@gmail.com> 
Cc: Guan Xuetao <gxt@mprc.pku.edu.cn> 
Cc: rtc-linux at googlegroups.com 
Cc: linux-arm-kernel at lists.infradead.org 
Cc: uclinux-dist-devel at blackfin.uclinux.org 
---
 drivers/rtc/rtc-88pm80x.c  | 2 +-
 drivers/rtc/rtc-88pm860x.c | 4 ++--
 drivers/rtc/rtc-ab8500.c   | 2 +-
 drivers/rtc/rtc-at91sam9.c | 2 +-
 drivers/rtc/rtc-au1xxx.c   | 2 +-
 drivers/rtc/rtc-bfin.c     | 2 +-
 drivers/rtc/rtc-bq4802.c   | 2 +-
 drivers/rtc/rtc-cmos.c     | 9 +++------
 drivers/rtc/rtc-da9052.c   | 2 +-
 drivers/rtc/rtc-dm355evm.c | 2 +-
 drivers/rtc/rtc-ds1286.c   | 2 +-
 drivers/rtc/rtc-ds1305.c   | 2 +-
 drivers/rtc/rtc-ds1307.c   | 2 +-
 drivers/rtc/rtc-ds1390.c   | 2 +-
 drivers/rtc/rtc-ds1511.c   | 2 +-
 drivers/rtc/rtc-ds1553.c   | 2 +-
 drivers/rtc/rtc-ds1742.c   | 2 +-
 drivers/rtc/rtc-ds3232.c   | 2 +-
 drivers/rtc/rtc-ds3234.c   | 2 +-
 drivers/rtc/rtc-ep93xx.c   | 2 +-
 drivers/rtc/rtc-fm3130.c   | 2 +-
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
 drivers/rtc/rtc-mv.c       | 2 +-
 drivers/rtc/rtc-mxc.c      | 2 +-
 drivers/rtc/rtc-nuc900.c   | 2 +-
 drivers/rtc/rtc-pcap.c     | 2 +-
 drivers/rtc/rtc-pcf2123.c  | 2 +-
 drivers/rtc/rtc-pcf50633.c | 2 +-
 drivers/rtc/rtc-pm8xxx.c   | 2 +-
 drivers/rtc/rtc-puv3.c     | 2 +-
 drivers/rtc/rtc-r9701.c    | 2 +-
 drivers/rtc/rtc-rc5t583.c  | 2 +-
 drivers/rtc/rtc-rs5c348.c  | 2 +-
 drivers/rtc/rtc-rv3029c2.c | 2 +-
 drivers/rtc/rtc-rx8025.c   | 2 +-
 drivers/rtc/rtc-rx8581.c   | 2 +-
 drivers/rtc/rtc-s3c.c      | 2 +-
 drivers/rtc/rtc-snvs.c     | 2 +-
 drivers/rtc/rtc-spear.c    | 2 +-
 drivers/rtc/rtc-stk17ta8.c | 2 +-
 drivers/rtc/rtc-tegra.c    | 2 +-
 drivers/rtc/rtc-tile.c     | 2 +-
 drivers/rtc/rtc-tps65910.c | 2 +-
 drivers/rtc/rtc-twl.c      | 2 +-
 drivers/rtc/rtc-vr41xx.c   | 2 +-
 drivers/rtc/rtc-vt8500.c   | 2 +-
 59 files changed, 63 insertions(+), 66 deletions(-)

diff --git a/drivers/rtc/rtc-88pm80x.c b/drivers/rtc/rtc-88pm80x.c
index ff18b41..464488b 100644
--- a/drivers/rtc/rtc-88pm80x.c
+++ b/drivers/rtc/rtc-88pm80x.c
@@ -248,7 +248,7 @@ static int pm80x_rtc_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(pm80x_rtc_pm_ops, pm80x_rtc_suspend, pm80x_rtc_resume);
 
-static int __devinit pm80x_rtc_probe(struct platform_device *pdev)
+static int pm80x_rtc_probe(struct platform_device *pdev)
 {
 	struct pm80x_chip *chip = dev_get_drvdata(pdev->dev.parent);
 	struct pm80x_platform_data *pm80x_pdata;
diff --git a/drivers/rtc/rtc-88pm860x.c b/drivers/rtc/rtc-88pm860x.c
index 4a71030..35ea7a4 100644
--- a/drivers/rtc/rtc-88pm860x.c
+++ b/drivers/rtc/rtc-88pm860x.c
@@ -286,7 +286,7 @@ out:
 #endif
 
 #ifdef CONFIG_OF
-static int __devinit pm860x_rtc_dt_init(struct platform_device *pdev,
+static int pm860x_rtc_dt_init(struct platform_device *pdev,
 					struct pm860x_rtc_info *info)
 {
 	struct device_node *np = pdev->dev.parent->of_node;
@@ -307,7 +307,7 @@ static int __devinit pm860x_rtc_dt_init(struct platform_device *pdev,
 #define pm860x_rtc_dt_init(x, y)	(-1)
 #endif
 
-static int __devinit pm860x_rtc_probe(struct platform_device *pdev)
+static int pm860x_rtc_probe(struct platform_device *pdev)
 {
 	struct pm860x_chip *chip = dev_get_drvdata(pdev->dev.parent);
 	struct pm860x_rtc_pdata *pdata = NULL;
diff --git a/drivers/rtc/rtc-ab8500.c b/drivers/rtc/rtc-ab8500.c
index c6bb392..2c18afc 100644
--- a/drivers/rtc/rtc-ab8500.c
+++ b/drivers/rtc/rtc-ab8500.c
@@ -389,7 +389,7 @@ static const struct rtc_class_ops ab8500_rtc_ops = {
 	.alarm_irq_enable	= ab8500_rtc_irq_enable,
 };
 
-static int __devinit ab8500_rtc_probe(struct platform_device *pdev)
+static int ab8500_rtc_probe(struct platform_device *pdev)
 {
 	int err;
 	struct rtc_device *rtc;
diff --git a/drivers/rtc/rtc-at91sam9.c b/drivers/rtc/rtc-at91sam9.c
index 9e0c630..de4cc11 100644
--- a/drivers/rtc/rtc-at91sam9.c
+++ b/drivers/rtc/rtc-at91sam9.c
@@ -289,7 +289,7 @@ static const struct rtc_class_ops at91_rtc_ops = {
 /*
  * Initialize and install RTC driver
  */
-static int __devinit at91_rtc_probe(struct platform_device *pdev)
+static int at91_rtc_probe(struct platform_device *pdev)
 {
 	struct resource	*r, *r_gpbr;
 	struct sam9_rtc	*rtc;
diff --git a/drivers/rtc/rtc-au1xxx.c b/drivers/rtc/rtc-au1xxx.c
index 42a340e..331a771 100644
--- a/drivers/rtc/rtc-au1xxx.c
+++ b/drivers/rtc/rtc-au1xxx.c
@@ -62,7 +62,7 @@ static struct rtc_class_ops au1xtoy_rtc_ops = {
 	.set_time	= au1xtoy_rtc_set_time,
 };
 
-static int __devinit au1xtoy_rtc_probe(struct platform_device *pdev)
+static int au1xtoy_rtc_probe(struct platform_device *pdev)
 {
 	struct rtc_device *rtcdev;
 	unsigned long t;
diff --git a/drivers/rtc/rtc-bfin.c b/drivers/rtc/rtc-bfin.c
index 92403a5..863eae7 100644
--- a/drivers/rtc/rtc-bfin.c
+++ b/drivers/rtc/rtc-bfin.c
@@ -342,7 +342,7 @@ static struct rtc_class_ops bfin_rtc_ops = {
 	.alarm_irq_enable = bfin_rtc_alarm_irq_enable,
 };
 
-static int __devinit bfin_rtc_probe(struct platform_device *pdev)
+static int bfin_rtc_probe(struct platform_device *pdev)
 {
 	struct bfin_rtc *rtc;
 	struct device *dev = &pdev->dev;
diff --git a/drivers/rtc/rtc-bq4802.c b/drivers/rtc/rtc-bq4802.c
index 27d8225..3b40ff4 100644
--- a/drivers/rtc/rtc-bq4802.c
+++ b/drivers/rtc/rtc-bq4802.c
@@ -140,7 +140,7 @@ static const struct rtc_class_ops bq4802_ops = {
 	.set_time	= bq4802_set_time,
 };
 
-static int __devinit bq4802_probe(struct platform_device *pdev)
+static int bq4802_probe(struct platform_device *pdev)
 {
 	struct bq4802 *p = kzalloc(sizeof(*p), GFP_KERNEL);
 	int err = -ENOMEM;
diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index 4267789..16630aa 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -947,8 +947,7 @@ static void rtc_wake_off(struct device *dev)
  */
 static struct cmos_rtc_board_info acpi_rtc_info;
 
-static void __devinit
-cmos_wake_setup(struct device *dev)
+static void cmos_wake_setup(struct device *dev)
 {
 	if (acpi_disabled)
 		return;
@@ -980,8 +979,7 @@ cmos_wake_setup(struct device *dev)
 
 #else
 
-static void __devinit
-cmos_wake_setup(struct device *dev)
+static void cmos_wake_setup(struct device *dev)
 {
 }
 
@@ -991,8 +989,7 @@ cmos_wake_setup(struct device *dev)
 
 #include <linux/pnp.h>
 
-static int __devinit
-cmos_pnp_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
+static int cmos_pnp_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
 {
 	cmos_wake_setup(&pnp->dev);
 
diff --git a/drivers/rtc/rtc-da9052.c b/drivers/rtc/rtc-da9052.c
index 801c002..7e1758a 100644
--- a/drivers/rtc/rtc-da9052.c
+++ b/drivers/rtc/rtc-da9052.c
@@ -228,7 +228,7 @@ static const struct rtc_class_ops da9052_rtc_ops = {
 	.alarm_irq_enable = da9052_rtc_alarm_irq_enable,
 };
 
-static int __devinit da9052_rtc_probe(struct platform_device *pdev)
+static int da9052_rtc_probe(struct platform_device *pdev)
 {
 	struct da9052_rtc *rtc;
 	int ret;
diff --git a/drivers/rtc/rtc-dm355evm.c b/drivers/rtc/rtc-dm355evm.c
index 1896095..2323ae7 100644
--- a/drivers/rtc/rtc-dm355evm.c
+++ b/drivers/rtc/rtc-dm355evm.c
@@ -123,7 +123,7 @@ static struct rtc_class_ops dm355evm_rtc_ops = {
 
 /*----------------------------------------------------------------------*/
 
-static int __devinit dm355evm_rtc_probe(struct platform_device *pdev)
+static int dm355evm_rtc_probe(struct platform_device *pdev)
 {
 	struct rtc_device *rtc;
 
diff --git a/drivers/rtc/rtc-ds1286.c b/drivers/rtc/rtc-ds1286.c
index 9b0d2c6..f1c8681 100644
--- a/drivers/rtc/rtc-ds1286.c
+++ b/drivers/rtc/rtc-ds1286.c
@@ -329,7 +329,7 @@ static const struct rtc_class_ops ds1286_ops = {
 	.alarm_irq_enable = ds1286_alarm_irq_enable,
 };
 
-static int __devinit ds1286_probe(struct platform_device *pdev)
+static int ds1286_probe(struct platform_device *pdev)
 {
 	struct rtc_device *rtc;
 	struct resource *res;
diff --git a/drivers/rtc/rtc-ds1305.c b/drivers/rtc/rtc-ds1305.c
index 246dd80..62470f6 100644
--- a/drivers/rtc/rtc-ds1305.c
+++ b/drivers/rtc/rtc-ds1305.c
@@ -601,7 +601,7 @@ static struct bin_attribute nvram = {
  * Interface to SPI stack
  */
 
-static int __devinit ds1305_probe(struct spi_device *spi)
+static int ds1305_probe(struct spi_device *spi)
 {
 	struct ds1305			*ds1305;
 	int				status;
diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index 42fb32b..00b0643 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -617,7 +617,7 @@ ds1307_nvram_write(struct file *filp, struct kobject *kobj,
 
 /*----------------------------------------------------------------------*/
 
-static int __devinit ds1307_probe(struct i2c_client *client,
+static int ds1307_probe(struct i2c_client *client,
 				  const struct i2c_device_id *id)
 {
 	struct ds1307		*ds1307;
diff --git a/drivers/rtc/rtc-ds1390.c b/drivers/rtc/rtc-ds1390.c
index db9b139..90b2c7c 100644
--- a/drivers/rtc/rtc-ds1390.c
+++ b/drivers/rtc/rtc-ds1390.c
@@ -121,7 +121,7 @@ static const struct rtc_class_ops ds1390_rtc_ops = {
 	.set_time	= ds1390_set_time,
 };
 
-static int __devinit ds1390_probe(struct spi_device *spi)
+static int ds1390_probe(struct spi_device *spi)
 {
 	unsigned char tmp;
 	struct ds1390 *chip;
diff --git a/drivers/rtc/rtc-ds1511.c b/drivers/rtc/rtc-ds1511.c
index ae8da43..075578a 100644
--- a/drivers/rtc/rtc-ds1511.c
+++ b/drivers/rtc/rtc-ds1511.c
@@ -476,7 +476,7 @@ static struct bin_attribute ds1511_nvram_attr = {
 	.write = ds1511_nvram_write,
 };
 
- static int __devinit
+ static int
 ds1511_rtc_probe(struct platform_device *pdev)
 {
 	struct rtc_device *rtc;
diff --git a/drivers/rtc/rtc-ds1553.c b/drivers/rtc/rtc-ds1553.c
index 188fa63..40a7464 100644
--- a/drivers/rtc/rtc-ds1553.c
+++ b/drivers/rtc/rtc-ds1553.c
@@ -276,7 +276,7 @@ static struct bin_attribute ds1553_nvram_attr = {
 	.write = ds1553_nvram_write,
 };
 
-static int __devinit ds1553_rtc_probe(struct platform_device *pdev)
+static int ds1553_rtc_probe(struct platform_device *pdev)
 {
 	struct rtc_device *rtc;
 	struct resource *res;
diff --git a/drivers/rtc/rtc-ds1742.c b/drivers/rtc/rtc-ds1742.c
index 674808a..392d387 100644
--- a/drivers/rtc/rtc-ds1742.c
+++ b/drivers/rtc/rtc-ds1742.c
@@ -159,7 +159,7 @@ static ssize_t ds1742_nvram_write(struct file *filp, struct kobject *kobj,
 	return count;
 }
 
-static int __devinit ds1742_rtc_probe(struct platform_device *pdev)
+static int ds1742_rtc_probe(struct platform_device *pdev)
 {
 	struct rtc_device *rtc;
 	struct resource *res;
diff --git a/drivers/rtc/rtc-ds3232.c b/drivers/rtc/rtc-ds3232.c
index 7824a39..3af6d72 100644
--- a/drivers/rtc/rtc-ds3232.c
+++ b/drivers/rtc/rtc-ds3232.c
@@ -391,7 +391,7 @@ static const struct rtc_class_ops ds3232_rtc_ops = {
 	.alarm_irq_enable = ds3232_alarm_irq_enable,
 };
 
-static int __devinit ds3232_probe(struct i2c_client *client,
+static int ds3232_probe(struct i2c_client *client,
 		const struct i2c_device_id *id)
 {
 	struct ds3232 *ds3232;
diff --git a/drivers/rtc/rtc-ds3234.c b/drivers/rtc/rtc-ds3234.c
index 10882bac..6892e49 100644
--- a/drivers/rtc/rtc-ds3234.c
+++ b/drivers/rtc/rtc-ds3234.c
@@ -105,7 +105,7 @@ static const struct rtc_class_ops ds3234_rtc_ops = {
 	.set_time	= ds3234_set_time,
 };
 
-static int __devinit ds3234_probe(struct spi_device *spi)
+static int ds3234_probe(struct spi_device *spi)
 {
 	struct rtc_device *rtc;
 	unsigned char tmp;
diff --git a/drivers/rtc/rtc-ep93xx.c b/drivers/rtc/rtc-ep93xx.c
index 5dc0f43..c86082a 100644
--- a/drivers/rtc/rtc-ep93xx.c
+++ b/drivers/rtc/rtc-ep93xx.c
@@ -127,7 +127,7 @@ static const struct attribute_group ep93xx_rtc_sysfs_files = {
 	.attrs	= ep93xx_rtc_attrs,
 };
 
-static int __devinit ep93xx_rtc_probe(struct platform_device *pdev)
+static int ep93xx_rtc_probe(struct platform_device *pdev)
 {
 	struct ep93xx_rtc *ep93xx_rtc;
 	struct resource *res;
diff --git a/drivers/rtc/rtc-fm3130.c b/drivers/rtc/rtc-fm3130.c
index ac76078..4b0befe 100644
--- a/drivers/rtc/rtc-fm3130.c
+++ b/drivers/rtc/rtc-fm3130.c
@@ -361,7 +361,7 @@ static const struct rtc_class_ops fm3130_rtc_ops = {
 
 static struct i2c_driver fm3130_driver;
 
-static int __devinit fm3130_probe(struct i2c_client *client,
+static int fm3130_probe(struct i2c_client *client,
 				  const struct i2c_device_id *id)
 {
 	struct fm3130		*fm3130;
diff --git a/drivers/rtc/rtc-jz4740.c b/drivers/rtc/rtc-jz4740.c
index d9b28f3..d51b703 100644
--- a/drivers/rtc/rtc-jz4740.c
+++ b/drivers/rtc/rtc-jz4740.c
@@ -210,7 +210,7 @@ void jz4740_rtc_poweroff(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(jz4740_rtc_poweroff);
 
-static int __devinit jz4740_rtc_probe(struct platform_device *pdev)
+static int jz4740_rtc_probe(struct platform_device *pdev)
 {
 	int ret;
 	struct jz4740_rtc *rtc;
diff --git a/drivers/rtc/rtc-lpc32xx.c b/drivers/rtc/rtc-lpc32xx.c
index 010f50a..81fb32c 100644
--- a/drivers/rtc/rtc-lpc32xx.c
+++ b/drivers/rtc/rtc-lpc32xx.c
@@ -197,7 +197,7 @@ static const struct rtc_class_ops lpc32xx_rtc_ops = {
 	.alarm_irq_enable	= lpc32xx_rtc_alarm_irq_enable,
 };
 
-static int __devinit lpc32xx_rtc_probe(struct platform_device *pdev)
+static int lpc32xx_rtc_probe(struct platform_device *pdev)
 {
 	struct resource *res;
 	struct lpc32xx_rtc *rtc;
diff --git a/drivers/rtc/rtc-ls1x.c b/drivers/rtc/rtc-ls1x.c
index eac7cca..bf308fc 100644
--- a/drivers/rtc/rtc-ls1x.c
+++ b/drivers/rtc/rtc-ls1x.c
@@ -143,7 +143,7 @@ static struct rtc_class_ops  ls1x_rtc_ops = {
 	.set_time	= ls1x_rtc_set_time,
 };
 
-static int __devinit ls1x_rtc_probe(struct platform_device *pdev)
+static int ls1x_rtc_probe(struct platform_device *pdev)
 {
 	struct rtc_device *rtcdev;
 	unsigned long v;
diff --git a/drivers/rtc/rtc-m41t93.c b/drivers/rtc/rtc-m41t93.c
index 90ccaaf..ae9203b 100644
--- a/drivers/rtc/rtc-m41t93.c
+++ b/drivers/rtc/rtc-m41t93.c
@@ -170,7 +170,7 @@ static const struct rtc_class_ops m41t93_rtc_ops = {
 
 static struct spi_driver m41t93_driver;
 
-static int __devinit m41t93_probe(struct spi_device *spi)
+static int m41t93_probe(struct spi_device *spi)
 {
 	struct rtc_device *rtc;
 	int res;
diff --git a/drivers/rtc/rtc-m41t94.c b/drivers/rtc/rtc-m41t94.c
index 94ed51f..c2121cc 100644
--- a/drivers/rtc/rtc-m41t94.c
+++ b/drivers/rtc/rtc-m41t94.c
@@ -110,7 +110,7 @@ static const struct rtc_class_ops m41t94_rtc_ops = {
 
 static struct spi_driver m41t94_driver;
 
-static int __devinit m41t94_probe(struct spi_device *spi)
+static int m41t94_probe(struct spi_device *spi)
 {
 	struct rtc_device *rtc;
 	int res;
diff --git a/drivers/rtc/rtc-m48t35.c b/drivers/rtc/rtc-m48t35.c
index c3d5c14..d18e647 100644
--- a/drivers/rtc/rtc-m48t35.c
+++ b/drivers/rtc/rtc-m48t35.c
@@ -141,7 +141,7 @@ static const struct rtc_class_ops m48t35_ops = {
 	.set_time	= m48t35_set_time,
 };
 
-static int __devinit m48t35_probe(struct platform_device *pdev)
+static int m48t35_probe(struct platform_device *pdev)
 {
 	struct resource *res;
 	struct m48t35_priv *priv;
diff --git a/drivers/rtc/rtc-m48t59.c b/drivers/rtc/rtc-m48t59.c
index 3a89eda..b4cc7e9 100644
--- a/drivers/rtc/rtc-m48t59.c
+++ b/drivers/rtc/rtc-m48t59.c
@@ -383,7 +383,7 @@ static struct bin_attribute m48t59_nvram_attr = {
 	.write = m48t59_nvram_write,
 };
 
-static int __devinit m48t59_rtc_probe(struct platform_device *pdev)
+static int m48t59_rtc_probe(struct platform_device *pdev)
 {
 	struct m48t59_plat_data *pdata = pdev->dev.platform_data;
 	struct m48t59_private *m48t59 = NULL;
diff --git a/drivers/rtc/rtc-m48t86.c b/drivers/rtc/rtc-m48t86.c
index d8f11e8..5f841b6 100644
--- a/drivers/rtc/rtc-m48t86.c
+++ b/drivers/rtc/rtc-m48t86.c
@@ -144,7 +144,7 @@ static const struct rtc_class_ops m48t86_rtc_ops = {
 	.proc		= m48t86_rtc_proc,
 };
 
-static int __devinit m48t86_rtc_probe(struct platform_device *dev)
+static int m48t86_rtc_probe(struct platform_device *dev)
 {
 	unsigned char reg;
 	struct m48t86_ops *ops = dev->dev.platform_data;
diff --git a/drivers/rtc/rtc-max6902.c b/drivers/rtc/rtc-max6902.c
index dea9a64..2f011cc 100644
--- a/drivers/rtc/rtc-max6902.c
+++ b/drivers/rtc/rtc-max6902.c
@@ -120,7 +120,7 @@ static const struct rtc_class_ops max6902_rtc_ops = {
 	.set_time	= max6902_set_time,
 };
 
-static int __devinit max6902_probe(struct spi_device *spi)
+static int max6902_probe(struct spi_device *spi)
 {
 	struct rtc_device *rtc;
 	unsigned char tmp;
diff --git a/drivers/rtc/rtc-max8907.c b/drivers/rtc/rtc-max8907.c
index d10cc5e..f48a841 100644
--- a/drivers/rtc/rtc-max8907.c
+++ b/drivers/rtc/rtc-max8907.c
@@ -176,7 +176,7 @@ static const struct rtc_class_ops max8907_rtc_ops = {
 	.set_alarm	= max8907_rtc_set_alarm,
 };
 
-static int __devinit max8907_rtc_probe(struct platform_device *pdev)
+static int max8907_rtc_probe(struct platform_device *pdev)
 {
 	struct max8907 *max8907 = dev_get_drvdata(pdev->dev.parent);
 	struct max8907_rtc *rtc;
diff --git a/drivers/rtc/rtc-max8925.c b/drivers/rtc/rtc-max8925.c
index 84307b4..afb63fe 100644
--- a/drivers/rtc/rtc-max8925.c
+++ b/drivers/rtc/rtc-max8925.c
@@ -247,7 +247,7 @@ static const struct rtc_class_ops max8925_rtc_ops = {
 	.set_alarm	= max8925_rtc_set_alarm,
 };
 
-static int __devinit max8925_rtc_probe(struct platform_device *pdev)
+static int max8925_rtc_probe(struct platform_device *pdev)
 {
 	struct max8925_chip *chip = dev_get_drvdata(pdev->dev.parent);
 	struct max8925_rtc_info *info;
diff --git a/drivers/rtc/rtc-max8998.c b/drivers/rtc/rtc-max8998.c
index 6b828c4..fd1eed5 100644
--- a/drivers/rtc/rtc-max8998.c
+++ b/drivers/rtc/rtc-max8998.c
@@ -249,7 +249,7 @@ static const struct rtc_class_ops max8998_rtc_ops = {
 	.alarm_irq_enable = max8998_rtc_alarm_irq_enable,
 };
 
-static int __devinit max8998_rtc_probe(struct platform_device *pdev)
+static int max8998_rtc_probe(struct platform_device *pdev)
 {
 	struct max8998_dev *max8998 = dev_get_drvdata(pdev->dev.parent);
 	struct max8998_platform_data *pdata = dev_get_platdata(max8998->dev);
diff --git a/drivers/rtc/rtc-mpc5121.c b/drivers/rtc/rtc-mpc5121.c
index 151e7d3..5530c32 100644
--- a/drivers/rtc/rtc-mpc5121.c
+++ b/drivers/rtc/rtc-mpc5121.c
@@ -306,7 +306,7 @@ static const struct rtc_class_ops mpc5200_rtc_ops = {
 	.alarm_irq_enable = mpc5121_rtc_alarm_irq_enable,
 };
 
-static int __devinit mpc5121_rtc_probe(struct platform_device *op)
+static int mpc5121_rtc_probe(struct platform_device *op)
 {
 	struct mpc5121_rtc_data *rtc;
 	int err = 0;
diff --git a/drivers/rtc/rtc-mrst.c b/drivers/rtc/rtc-mrst.c
index 77dda3d..68cb66e 100644
--- a/drivers/rtc/rtc-mrst.c
+++ b/drivers/rtc/rtc-mrst.c
@@ -322,7 +322,7 @@ static irqreturn_t mrst_rtc_irq(int irq, void *p)
 	return IRQ_NONE;
 }
 
-static int __devinit
+static int
 vrtc_mrst_do_probe(struct device *dev, struct resource *iomem, int rtc_irq)
 {
 	int retval = 0;
@@ -503,7 +503,7 @@ static inline int mrst_poweroff(struct device *dev)
 
 #endif
 
-static int __devinit vrtc_mrst_platform_probe(struct platform_device *pdev)
+static int vinit vrtc_mrst_platform_probe(struct platform_device *pdev)
 {
 	return vrtc_mrst_do_probe(&pdev->dev,
 			platform_get_resource(pdev, IORESOURCE_MEM, 0),
diff --git a/drivers/rtc/rtc-mv.c b/drivers/rtc/rtc-mv.c
index ebc1649..57233c8 100644
--- a/drivers/rtc/rtc-mv.c
+++ b/drivers/rtc/rtc-mv.c
@@ -215,7 +215,7 @@ static const struct rtc_class_ops mv_rtc_alarm_ops = {
 	.alarm_irq_enable = mv_rtc_alarm_irq_enable,
 };
 
-static int __devinit mv_rtc_probe(struct platform_device *pdev)
+static int mv_rtc_probe(struct platform_device *pdev)
 {
 	struct resource *res;
 	struct rtc_plat_data *pdata;
diff --git a/drivers/rtc/rtc-mxc.c b/drivers/rtc/rtc-mxc.c
index 5d03801..cf20379 100644
--- a/drivers/rtc/rtc-mxc.c
+++ b/drivers/rtc/rtc-mxc.c
@@ -368,7 +368,7 @@ static struct rtc_class_ops mxc_rtc_ops = {
 	.alarm_irq_enable	= mxc_rtc_alarm_irq_enable,
 };
 
-static int __devinit mxc_rtc_probe(struct platform_device *pdev)
+static int mxc_rtc_probe(struct platform_device *pdev)
 {
 	struct resource *res;
 	struct rtc_device *rtc;
diff --git a/drivers/rtc/rtc-nuc900.c b/drivers/rtc/rtc-nuc900.c
index 5fa7adb..b3f418d 100644
--- a/drivers/rtc/rtc-nuc900.c
+++ b/drivers/rtc/rtc-nuc900.c
@@ -222,7 +222,7 @@ static struct rtc_class_ops nuc900_rtc_ops = {
 	.alarm_irq_enable = nuc900_alarm_irq_enable,
 };
 
-static int __devinit nuc900_rtc_probe(struct platform_device *pdev)
+static int nuc900_rtc_probe(struct platform_device *pdev)
 {
 	struct resource *res;
 	struct nuc900_rtc *nuc900_rtc;
diff --git a/drivers/rtc/rtc-pcap.c b/drivers/rtc/rtc-pcap.c
index a79dba6..e33b94b6 100644
--- a/drivers/rtc/rtc-pcap.c
+++ b/drivers/rtc/rtc-pcap.c
@@ -139,7 +139,7 @@ static const struct rtc_class_ops pcap_rtc_ops = {
 	.alarm_irq_enable = pcap_rtc_alarm_irq_enable,
 };
 
-static int __devinit pcap_rtc_probe(struct platform_device *pdev)
+static int pcap_rtc_probe(struct platform_device *pdev)
 {
 	struct pcap_rtc *pcap_rtc;
 	int timer_irq, alarm_irq;
diff --git a/drivers/rtc/rtc-pcf2123.c b/drivers/rtc/rtc-pcf2123.c
index bc481a9..3d39070 100644
--- a/drivers/rtc/rtc-pcf2123.c
+++ b/drivers/rtc/rtc-pcf2123.c
@@ -219,7 +219,7 @@ static const struct rtc_class_ops pcf2123_rtc_ops = {
 	.set_time	= pcf2123_rtc_set_time,
 };
 
-static int __devinit pcf2123_probe(struct spi_device *spi)
+static int pcf2123_probe(struct spi_device *spi)
 {
 	struct rtc_device *rtc;
 	struct pcf2123_plat_data *pdata;
diff --git a/drivers/rtc/rtc-pcf50633.c b/drivers/rtc/rtc-pcf50633.c
index 5122dad..78ffaaa 100644
--- a/drivers/rtc/rtc-pcf50633.c
+++ b/drivers/rtc/rtc-pcf50633.c
@@ -248,7 +248,7 @@ static void pcf50633_rtc_irq(int irq, void *data)
 	rtc->alarm_pending = 1;
 }
 
-static int __devinit pcf50633_rtc_probe(struct platform_device *pdev)
+static int pcf50633_rtc_probe(struct platform_device *pdev)
 {
 	struct pcf50633_rtc *rtc;
 
diff --git a/drivers/rtc/rtc-pm8xxx.c b/drivers/rtc/rtc-pm8xxx.c
index fce198f..39afdf0 100644
--- a/drivers/rtc/rtc-pm8xxx.c
+++ b/drivers/rtc/rtc-pm8xxx.c
@@ -382,7 +382,7 @@ rtc_alarm_handled:
 	return IRQ_HANDLED;
 }
 
-static int __devinit pm8xxx_rtc_probe(struct platform_device *pdev)
+static int pm8xxx_rtc_probe(struct platform_device *pdev)
 {
 	int rc;
 	u8 ctrl_reg;
diff --git a/drivers/rtc/rtc-puv3.c b/drivers/rtc/rtc-puv3.c
index 3414350..619287d 100644
--- a/drivers/rtc/rtc-puv3.c
+++ b/drivers/rtc/rtc-puv3.c
@@ -236,7 +236,7 @@ static int __devexit puv3_rtc_remove(struct platform_device *dev)
 	return 0;
 }
 
-static int __devinit puv3_rtc_probe(struct platform_device *pdev)
+static int puv3_rtc_probe(struct platform_device *pdev)
 {
 	struct rtc_device *rtc;
 	struct resource *res;
diff --git a/drivers/rtc/rtc-r9701.c b/drivers/rtc/rtc-r9701.c
index 7293b8e..cf856e7 100644
--- a/drivers/rtc/rtc-r9701.c
+++ b/drivers/rtc/rtc-r9701.c
@@ -119,7 +119,7 @@ static const struct rtc_class_ops r9701_rtc_ops = {
 	.set_time	= r9701_set_datetime,
 };
 
-static int __devinit r9701_probe(struct spi_device *spi)
+static int r9701_probe(struct spi_device *spi)
 {
 	struct rtc_device *rtc;
 	struct rtc_time dt;
diff --git a/drivers/rtc/rtc-rc5t583.c b/drivers/rtc/rtc-rc5t583.c
index 5d43c4e..69e8287 100644
--- a/drivers/rtc/rtc-rc5t583.c
+++ b/drivers/rtc/rtc-rc5t583.c
@@ -211,7 +211,7 @@ static const struct rtc_class_ops rc5t583_rtc_ops = {
 	.alarm_irq_enable = rc5t583_rtc_alarm_irq_enable,
 };
 
-static int __devinit rc5t583_rtc_probe(struct platform_device *pdev)
+static int rc5t583_rtc_probe(struct platform_device *pdev)
 {
 	struct rc5t583 *rc5t583 = dev_get_drvdata(pdev->dev.parent);
 	struct rc5t583_rtc *ricoh_rtc;
diff --git a/drivers/rtc/rtc-rs5c348.c b/drivers/rtc/rtc-rs5c348.c
index 4a8d0d4..40a5e05 100644
--- a/drivers/rtc/rtc-rs5c348.c
+++ b/drivers/rtc/rtc-rs5c348.c
@@ -152,7 +152,7 @@ static const struct rtc_class_ops rs5c348_rtc_ops = {
 
 static struct spi_driver rs5c348_driver;
 
-static int __devinit rs5c348_probe(struct spi_device *spi)
+static int rs5c348_probe(struct spi_device *spi)
 {
 	int ret;
 	struct rtc_device *rtc;
diff --git a/drivers/rtc/rtc-rv3029c2.c b/drivers/rtc/rtc-rv3029c2.c
index fe6cabf..52d87e8 100644
--- a/drivers/rtc/rtc-rv3029c2.c
+++ b/drivers/rtc/rtc-rv3029c2.c
@@ -385,7 +385,7 @@ static struct i2c_device_id rv3029c2_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, rv3029c2_id);
 
-static int __devinit
+static int
 rv3029c2_probe(struct i2c_client *client, const struct i2c_device_id *id)
 {
 	struct rtc_device *rtc;
diff --git a/drivers/rtc/rtc-rx8025.c b/drivers/rtc/rtc-rx8025.c
index ca28ce1..5de60a3 100644
--- a/drivers/rtc/rtc-rx8025.c
+++ b/drivers/rtc/rtc-rx8025.c
@@ -534,7 +534,7 @@ static void rx8025_sysfs_unregister(struct device *dev)
 	device_remove_file(dev, &dev_attr_clock_adjust_ppb);
 }
 
-static int __devinit rx8025_probe(struct i2c_client *client,
+static int rx8025_probe(struct i2c_client *client,
 				  const struct i2c_device_id *id)
 {
 	struct i2c_adapter *adapter = to_i2c_adapter(client->dev.parent);
diff --git a/drivers/rtc/rtc-rx8581.c b/drivers/rtc/rtc-rx8581.c
index 64f33c1..2062458 100644
--- a/drivers/rtc/rtc-rx8581.c
+++ b/drivers/rtc/rtc-rx8581.c
@@ -228,7 +228,7 @@ static const struct rtc_class_ops rx8581_rtc_ops = {
 	.set_time	= rx8581_rtc_set_time,
 };
 
-static int __devinit rx8581_probe(struct i2c_client *client,
+static int rx8581_probe(struct i2c_client *client,
 				const struct i2c_device_id *id)
 {
 	struct rtc_device *rtc;
diff --git a/drivers/rtc/rtc-s3c.c b/drivers/rtc/rtc-s3c.c
index 2fc2aab..44bebef 100644
--- a/drivers/rtc/rtc-s3c.c
+++ b/drivers/rtc/rtc-s3c.c
@@ -461,7 +461,7 @@ static inline int s3c_rtc_get_driver_data(struct platform_device *pdev)
 	return platform_get_device_id(pdev)->driver_data;
 }
 
-static int __devinit s3c_rtc_probe(struct platform_device *pdev)
+static int s3c_rtc_probe(struct platform_device *pdev)
 {
 	struct rtc_device *rtc;
 	struct rtc_time rtc_tm;
diff --git a/drivers/rtc/rtc-snvs.c b/drivers/rtc/rtc-snvs.c
index ee40be9..7db043f 100644
--- a/drivers/rtc/rtc-snvs.c
+++ b/drivers/rtc/rtc-snvs.c
@@ -241,7 +241,7 @@ static irqreturn_t snvs_rtc_irq_handler(int irq, void *dev_id)
 	return events ? IRQ_HANDLED : IRQ_NONE;
 }
 
-static int __devinit snvs_rtc_probe(struct platform_device *pdev)
+static int snvs_rtc_probe(struct platform_device *pdev)
 {
 	struct snvs_rtc_data *data;
 	struct resource *res;
diff --git a/drivers/rtc/rtc-spear.c b/drivers/rtc/rtc-spear.c
index 0b4763c..c71cc09 100644
--- a/drivers/rtc/rtc-spear.c
+++ b/drivers/rtc/rtc-spear.c
@@ -351,7 +351,7 @@ static struct rtc_class_ops spear_rtc_ops = {
 	.alarm_irq_enable = spear_alarm_irq_enable,
 };
 
-static int __devinit spear_rtc_probe(struct platform_device *pdev)
+static int spear_rtc_probe(struct platform_device *pdev)
 {
 	struct resource *res;
 	struct spear_rtc_config *config;
diff --git a/drivers/rtc/rtc-stk17ta8.c b/drivers/rtc/rtc-stk17ta8.c
index c92c5d0..63deb9c 100644
--- a/drivers/rtc/rtc-stk17ta8.c
+++ b/drivers/rtc/rtc-stk17ta8.c
@@ -285,7 +285,7 @@ static struct bin_attribute stk17ta8_nvram_attr = {
 	.write = stk17ta8_nvram_write,
 };
 
-static int __devinit stk17ta8_rtc_probe(struct platform_device *pdev)
+static int stk17ta8_rtc_probe(struct platform_device *pdev)
 {
 	struct resource *res;
 	unsigned int cal;
diff --git a/drivers/rtc/rtc-tegra.c b/drivers/rtc/rtc-tegra.c
index d88fa79..2b1a7bd 100644
--- a/drivers/rtc/rtc-tegra.c
+++ b/drivers/rtc/rtc-tegra.c
@@ -303,7 +303,7 @@ static struct rtc_class_ops tegra_rtc_ops = {
 	.alarm_irq_enable = tegra_rtc_alarm_irq_enable,
 };
 
-static int __devinit tegra_rtc_probe(struct platform_device *pdev)
+static int tegra_rtc_probe(struct platform_device *pdev)
 {
 	struct tegra_rtc_info *info;
 	struct resource *res;
diff --git a/drivers/rtc/rtc-tile.c b/drivers/rtc/rtc-tile.c
index 91566a1..f051430 100644
--- a/drivers/rtc/rtc-tile.c
+++ b/drivers/rtc/rtc-tile.c
@@ -76,7 +76,7 @@ static const struct rtc_class_ops tile_rtc_ops = {
 /*
  * Device probe routine.
  */
-static int __devinit tile_rtc_probe(struct platform_device *dev)
+static int tile_rtc_probe(struct platform_device *dev)
 {
 	struct rtc_device *rtc;
 
diff --git a/drivers/rtc/rtc-tps65910.c b/drivers/rtc/rtc-tps65910.c
index 8e412a7..dee057d 100644
--- a/drivers/rtc/rtc-tps65910.c
+++ b/drivers/rtc/rtc-tps65910.c
@@ -222,7 +222,7 @@ static const struct rtc_class_ops tps65910_rtc_ops = {
 	.alarm_irq_enable = tps65910_rtc_alarm_irq_enable,
 };
 
-static int __devinit tps65910_rtc_probe(struct platform_device *pdev)
+static int tps65910_rtc_probe(struct platform_device *pdev)
 {
 	struct tps65910 *tps65910 = NULL;
 	struct tps65910_rtc *tps_rtc = NULL;
diff --git a/drivers/rtc/rtc-twl.c b/drivers/rtc/rtc-twl.c
index 80eee79..0eda428 100644
--- a/drivers/rtc/rtc-twl.c
+++ b/drivers/rtc/rtc-twl.c
@@ -458,7 +458,7 @@ static struct rtc_class_ops twl_rtc_ops = {
 
 /*----------------------------------------------------------------------*/
 
-static int __devinit twl_rtc_probe(struct platform_device *pdev)
+static int twl_rtc_probe(struct platform_device *pdev)
 {
 	struct rtc_device *rtc;
 	int ret = -EINVAL;
diff --git a/drivers/rtc/rtc-vr41xx.c b/drivers/rtc/rtc-vr41xx.c
index 9eef727..12c6e55 100644
--- a/drivers/rtc/rtc-vr41xx.c
+++ b/drivers/rtc/rtc-vr41xx.c
@@ -280,7 +280,7 @@ static const struct rtc_class_ops vr41xx_rtc_ops = {
 	.set_alarm	= vr41xx_rtc_set_alarm,
 };
 
-static int __devinit rtc_probe(struct platform_device *pdev)
+static int rtc_probe(struct platform_device *pdev)
 {
 	struct resource *res;
 	struct rtc_device *rtc;
diff --git a/drivers/rtc/rtc-vt8500.c b/drivers/rtc/rtc-vt8500.c
index b9c9cf6..dfed697 100644
--- a/drivers/rtc/rtc-vt8500.c
+++ b/drivers/rtc/rtc-vt8500.c
@@ -205,7 +205,7 @@ static const struct rtc_class_ops vt8500_rtc_ops = {
 	.alarm_irq_enable = vt8500_alarm_irq_enable,
 };
 
-static int __devinit vt8500_rtc_probe(struct platform_device *pdev)
+static int vt8500_rtc_probe(struct platform_device *pdev)
 {
 	struct vt8500_rtc *vt8500_rtc;
 	int ret;
-- 
1.8.0
