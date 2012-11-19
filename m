From: wfp5p@virginia.edu (Bill Pemberton)
Date: Mon, 19 Nov 2012 13:23:04 -0500
Subject: [PATCH 235/493] mfd: remove use of __devinit
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Message-ID: <1353349642-3677-235-git-send-email-wfp5p@virginia.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_HOTPLUG is going away as an option so __devinit is no longer
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
 drivers/mfd/88pm800.c             |  8 ++++----
 drivers/mfd/88pm805.c             |  6 +++---
 drivers/mfd/88pm80x.c             |  2 +-
 drivers/mfd/88pm860x-core.c       | 30 +++++++++++++++---------------
 drivers/mfd/ab3100-core.c         |  4 ++--
 drivers/mfd/ab8500-core.c         |  2 +-
 drivers/mfd/ab8500-debugfs.c      |  2 +-
 drivers/mfd/ab8500-gpadc.c        |  2 +-
 drivers/mfd/ab8500-sysctrl.c      |  2 +-
 drivers/mfd/adp5520.c             |  2 +-
 drivers/mfd/arizona-core.c        |  2 +-
 drivers/mfd/arizona-i2c.c         |  2 +-
 drivers/mfd/arizona-spi.c         |  2 +-
 drivers/mfd/cs5535-mfd.c          |  4 ++--
 drivers/mfd/da903x.c              |  6 +++---
 drivers/mfd/da9052-core.c         |  2 +-
 drivers/mfd/da9052-i2c.c          |  2 +-
 drivers/mfd/da9052-spi.c          |  2 +-
 drivers/mfd/da9055-core.c         |  2 +-
 drivers/mfd/da9055-i2c.c          |  2 +-
 drivers/mfd/db8500-prcmu.c        |  2 +-
 drivers/mfd/ezx-pcap.c            |  4 ++--
 drivers/mfd/htc-i2cpld.c          | 12 ++++++------
 drivers/mfd/intel_msic.c          |  4 ++--
 drivers/mfd/janz-cmodio.c         |  6 +++---
 drivers/mfd/jz4740-adc.c          |  2 +-
 drivers/mfd/lm3533-core.c         | 12 ++++++------
 drivers/mfd/lpc_ich.c             | 14 +++++++-------
 drivers/mfd/lpc_sch.c             |  2 +-
 drivers/mfd/max8907.c             |  2 +-
 drivers/mfd/max8925-core.c        |  4 ++--
 drivers/mfd/max8925-i2c.c         |  2 +-
 drivers/mfd/omap-usb-host.c       |  2 +-
 drivers/mfd/omap-usb-tll.c        |  2 +-
 drivers/mfd/palmas.c              |  4 ++--
 drivers/mfd/pcf50633-adc.c        |  2 +-
 drivers/mfd/pcf50633-core.c       |  2 +-
 drivers/mfd/pm8921-core.c         |  4 ++--
 drivers/mfd/pm8xxx-irq.c          |  2 +-
 drivers/mfd/rc5t583.c             |  2 +-
 drivers/mfd/rdc321x-southbridge.c |  2 +-
 drivers/mfd/rtsx_pcr.c            |  2 +-
 drivers/mfd/sm501.c               | 10 +++++-----
 drivers/mfd/sta2x11-mfd.c         |  4 ++--
 drivers/mfd/stmpe-i2c.c           |  2 +-
 drivers/mfd/stmpe-spi.c           |  2 +-
 drivers/mfd/stmpe.c               | 12 ++++++------
 drivers/mfd/syscon.c              |  2 +-
 drivers/mfd/tc3589x.c             |  4 ++--
 drivers/mfd/tc6387xb.c            |  2 +-
 drivers/mfd/tc6393xb.c            |  2 +-
 drivers/mfd/ti-ssp.c              |  2 +-
 drivers/mfd/ti_am335x_tscadc.c    |  2 +-
 drivers/mfd/timberdale.c          |  2 +-
 drivers/mfd/tps6105x.c            |  4 ++--
 drivers/mfd/tps65090.c            |  4 ++--
 drivers/mfd/tps65217.c            |  2 +-
 drivers/mfd/tps6586x.c            |  6 +++---
 drivers/mfd/tps65910.c            |  6 +++---
 drivers/mfd/tps65911-comparator.c |  2 +-
 drivers/mfd/tps65912-spi.c        |  2 +-
 drivers/mfd/twl-core.c            |  2 +-
 drivers/mfd/twl4030-audio.c       |  2 +-
 drivers/mfd/twl4030-madc.c        |  2 +-
 drivers/mfd/twl4030-power.c       | 20 ++++++++++----------
 drivers/mfd/twl6040.c             |  4 ++--
 drivers/mfd/vexpress-sysreg.c     |  2 +-
 drivers/mfd/vx855.c               |  2 +-
 drivers/mfd/wl1273-core.c         |  2 +-
 drivers/mfd/wm831x-spi.c          |  2 +-
 drivers/mfd/wm8994-core.c         |  4 ++--
 include/linux/mfd/88pm80x.h       |  2 +-
 include/linux/mfd/abx500/ab8500.h |  2 +-
 include/linux/mfd/pm8xxx/irq.h    |  4 ++--
 74 files changed, 149 insertions(+), 149 deletions(-)

diff --git a/drivers/mfd/88pm800.c b/drivers/mfd/88pm800.c
index 321a50c..6746ecd 100644
--- a/drivers/mfd/88pm800.c
+++ b/drivers/mfd/88pm800.c
@@ -248,7 +248,7 @@ static const struct regmap_irq pm800_irqs[] = {
 	},
 };
 
-static int __devinit device_gpadc_init(struct pm80x_chip *chip,
+static int device_gpadc_init(struct pm80x_chip *chip,
 				       struct pm80x_platform_data *pdata)
 {
 	struct pm80x_subchip *subchip = chip->subchip;
@@ -315,7 +315,7 @@ out:
 	return ret;
 }
 
-static int __devinit device_irq_init_800(struct pm80x_chip *chip)
+static int device_irq_init_800(struct pm80x_chip *chip)
 {
 	struct regmap *map = chip->regmap;
 	unsigned long flags = IRQF_TRIGGER_FALLING | IRQF_ONESHOT;
@@ -415,7 +415,7 @@ static void pm800_pages_exit(struct pm80x_chip *chip)
 	}
 }
 
-static int __devinit device_800_init(struct pm80x_chip *chip,
+static int device_800_init(struct pm80x_chip *chip,
 				     struct pm80x_platform_data *pdata)
 {
 	int ret, pmic_id;
@@ -499,7 +499,7 @@ out:
 	return ret;
 }
 
-static int __devinit pm800_probe(struct i2c_client *client,
+static int pm800_probe(struct i2c_client *client,
 				 const struct i2c_device_id *id)
 {
 	int ret = 0;
diff --git a/drivers/mfd/88pm805.c b/drivers/mfd/88pm805.c
index 41e0488..13c0994 100644
--- a/drivers/mfd/88pm805.c
+++ b/drivers/mfd/88pm805.c
@@ -135,7 +135,7 @@ static struct regmap_irq pm805_irqs[] = {
 	},
 };
 
-static int __devinit device_irq_init_805(struct pm80x_chip *chip)
+static int device_irq_init_805(struct pm80x_chip *chip)
 {
 	struct regmap *map = chip->regmap;
 	unsigned long flags = IRQF_TRIGGER_FALLING | IRQF_ONESHOT;
@@ -189,7 +189,7 @@ static struct regmap_irq_chip pm805_irq_chip = {
 	.ack_base = PM805_INT_STATUS1,
 };
 
-static int __devinit device_805_init(struct pm80x_chip *chip)
+static int device_805_init(struct pm80x_chip *chip)
 {
 	int ret = 0;
 	unsigned int val;
@@ -232,7 +232,7 @@ out_irq_init:
 	return ret;
 }
 
-static int __devinit pm805_probe(struct i2c_client *client,
+static int pm805_probe(struct i2c_client *client,
 				 const struct i2c_device_id *id)
 {
 	int ret = 0;
diff --git a/drivers/mfd/88pm80x.c b/drivers/mfd/88pm80x.c
index cd0bf52..1adb355 100644
--- a/drivers/mfd/88pm80x.c
+++ b/drivers/mfd/88pm80x.c
@@ -31,7 +31,7 @@ const struct regmap_config pm80x_regmap_config = {
 };
 EXPORT_SYMBOL_GPL(pm80x_regmap_config);
 
-int __devinit pm80x_init(struct i2c_client *client,
+int pm80x_init(struct i2c_client *client,
 				 const struct i2c_device_id *id)
 {
 	struct pm80x_chip *chip;
diff --git a/drivers/mfd/88pm860x-core.c b/drivers/mfd/88pm860x-core.c
index c2d5595..ad36ad7 100644
--- a/drivers/mfd/88pm860x-core.c
+++ b/drivers/mfd/88pm860x-core.c
@@ -565,7 +565,7 @@ static struct irq_domain_ops pm860x_irq_domain_ops = {
 	.xlate	= irq_domain_xlate_onetwocell,
 };
 
-static int __devinit device_irq_init(struct pm860x_chip *chip,
+static int device_irq_init(struct pm860x_chip *chip,
 				     struct pm860x_platform_data *pdata)
 {
 	struct i2c_client *i2c = (chip->id == CHIP_PM8607) ? chip->client \
@@ -730,7 +730,7 @@ out:
 }
 EXPORT_SYMBOL(pm8606_osc_disable);
 
-static void __devinit device_osc_init(struct i2c_client *i2c)
+static void device_osc_init(struct i2c_client *i2c)
 {
 	struct pm860x_chip *chip = i2c_get_clientdata(i2c);
 
@@ -745,7 +745,7 @@ static void __devinit device_osc_init(struct i2c_client *i2c)
 	chip->osc_status = PM8606_REF_GP_OSC_OFF;
 }
 
-static void __devinit device_bk_init(struct pm860x_chip *chip,
+static void device_bk_init(struct pm860x_chip *chip,
 				     struct pm860x_platform_data *pdata)
 {
 	int ret, i;
@@ -765,7 +765,7 @@ static void __devinit device_bk_init(struct pm860x_chip *chip,
 		dev_err(chip->dev, "Failed to add backlight subdev\n");
 }
 
-static void __devinit device_led_init(struct pm860x_chip *chip,
+static void device_led_init(struct pm860x_chip *chip,
 				      struct pm860x_platform_data *pdata)
 {
 	int ret, i;
@@ -787,7 +787,7 @@ static void __devinit device_led_init(struct pm860x_chip *chip,
 	}
 }
 
-static void __devinit device_regulator_init(struct pm860x_chip *chip,
+static void device_regulator_init(struct pm860x_chip *chip,
 					    struct pm860x_platform_data *pdata)
 {
 	int ret;
@@ -866,7 +866,7 @@ static void __devinit device_regulator_init(struct pm860x_chip *chip,
 	}
 }
 
-static void __devinit device_rtc_init(struct pm860x_chip *chip,
+static void device_rtc_init(struct pm860x_chip *chip,
 				      struct pm860x_platform_data *pdata)
 {
 	int ret;
@@ -885,7 +885,7 @@ static void __devinit device_rtc_init(struct pm860x_chip *chip,
 		dev_err(chip->dev, "Failed to add rtc subdev\n");
 }
 
-static void __devinit device_touch_init(struct pm860x_chip *chip,
+static void device_touch_init(struct pm860x_chip *chip,
 					struct pm860x_platform_data *pdata)
 {
 	int ret;
@@ -904,7 +904,7 @@ static void __devinit device_touch_init(struct pm860x_chip *chip,
 		dev_err(chip->dev, "Failed to add touch subdev\n");
 }
 
-static void __devinit device_power_init(struct pm860x_chip *chip,
+static void device_power_init(struct pm860x_chip *chip,
 					struct pm860x_platform_data *pdata)
 {
 	int ret;
@@ -951,7 +951,7 @@ static void __devinit device_power_init(struct pm860x_chip *chip,
 	}
 }
 
-static void __devinit device_onkey_init(struct pm860x_chip *chip,
+static void device_onkey_init(struct pm860x_chip *chip,
 					struct pm860x_platform_data *pdata)
 {
 	int ret;
@@ -965,7 +965,7 @@ static void __devinit device_onkey_init(struct pm860x_chip *chip,
 		dev_err(chip->dev, "Failed to add onkey subdev\n");
 }
 
-static void __devinit device_codec_init(struct pm860x_chip *chip,
+static void device_codec_init(struct pm860x_chip *chip,
 					struct pm860x_platform_data *pdata)
 {
 	int ret;
@@ -979,7 +979,7 @@ static void __devinit device_codec_init(struct pm860x_chip *chip,
 		dev_err(chip->dev, "Failed to add codec subdev\n");
 }
 
-static void __devinit device_8607_init(struct pm860x_chip *chip,
+static void device_8607_init(struct pm860x_chip *chip,
 				       struct i2c_client *i2c,
 				       struct pm860x_platform_data *pdata)
 {
@@ -1040,7 +1040,7 @@ out:
 	return;
 }
 
-static void __devinit device_8606_init(struct pm860x_chip *chip,
+static void device_8606_init(struct pm860x_chip *chip,
 				       struct i2c_client *i2c,
 				       struct pm860x_platform_data *pdata)
 {
@@ -1049,7 +1049,7 @@ static void __devinit device_8606_init(struct pm860x_chip *chip,
 	device_led_init(chip, pdata);
 }
 
-static int __devinit pm860x_device_init(struct pm860x_chip *chip,
+static int pm860x_device_init(struct pm860x_chip *chip,
 					struct pm860x_platform_data *pdata)
 {
 	chip->core_irq = 0;
@@ -1109,7 +1109,7 @@ static struct regmap_config pm860x_regmap_config = {
 	.val_bits = 8,
 };
 
-static int __devinit pm860x_dt_init(struct device_node *np,
+static int pm860x_dt_init(struct device_node *np,
 				    struct device *dev,
 				    struct pm860x_platform_data *pdata)
 {
@@ -1127,7 +1127,7 @@ static int __devinit pm860x_dt_init(struct device_node *np,
 	return 0;
 }
 
-static int __devinit pm860x_probe(struct i2c_client *client,
+static int pm860x_probe(struct i2c_client *client,
 				  const struct i2c_device_id *id)
 {
 	struct pm860x_platform_data *pdata = client->dev.platform_data;
diff --git a/drivers/mfd/ab3100-core.c b/drivers/mfd/ab3100-core.c
index 8355d4e..84b2303 100644
--- a/drivers/mfd/ab3100-core.c
+++ b/drivers/mfd/ab3100-core.c
@@ -708,7 +708,7 @@ ab3100_init_settings[] = {
 	},
 };
 
-static int __devinit ab3100_setup(struct ab3100 *ab3100)
+static int ab3100_setup(struct ab3100 *ab3100)
 {
 	int err = 0;
 	int i;
@@ -857,7 +857,7 @@ static const struct ab_family_id ids[] __devinitconst = {
 	},
 };
 
-static int __devinit ab3100_probe(struct i2c_client *client,
+static int ab3100_probe(struct i2c_client *client,
 				  const struct i2c_device_id *id)
 {
 	struct ab3100 *ab3100;
diff --git a/drivers/mfd/ab8500-core.c b/drivers/mfd/ab8500-core.c
index dff2e1d..058d4d0 100644
--- a/drivers/mfd/ab8500-core.c
+++ b/drivers/mfd/ab8500-core.c
@@ -1207,7 +1207,7 @@ static struct attribute_group ab9540_attr_group = {
 	.attrs	= ab9540_sysfs_entries,
 };
 
-static int __devinit ab8500_probe(struct platform_device *pdev)
+static int ab8500_probe(struct platform_device *pdev)
 {
 	static char *switch_off_status[] = {
 		"Swoff bit programming",
diff --git a/drivers/mfd/ab8500-debugfs.c b/drivers/mfd/ab8500-debugfs.c
index efdbc7b..4484368 100644
--- a/drivers/mfd/ab8500-debugfs.c
+++ b/drivers/mfd/ab8500-debugfs.c
@@ -552,7 +552,7 @@ static struct dentry *ab8500_bank_file;
 static struct dentry *ab8500_address_file;
 static struct dentry *ab8500_val_file;
 
-static int __devinit ab8500_debug_probe(struct platform_device *plf)
+static int ab8500_debug_probe(struct platform_device *plf)
 {
 	debug_bank = AB8500_MISC;
 	debug_address = AB8500_REV_REG & 0x00FF;
diff --git a/drivers/mfd/ab8500-gpadc.c b/drivers/mfd/ab8500-gpadc.c
index 97daf61..c5e168e 100644
--- a/drivers/mfd/ab8500-gpadc.c
+++ b/drivers/mfd/ab8500-gpadc.c
@@ -571,7 +571,7 @@ static void ab8500_gpadc_read_calibration_data(struct ab8500_gpadc *gpadc)
 		gpadc->cal_data[ADC_INPUT_VBAT].offset);
 }
 
-static int __devinit ab8500_gpadc_probe(struct platform_device *pdev)
+static int ab8500_gpadc_probe(struct platform_device *pdev)
 {
 	int ret = 0;
 	struct ab8500_gpadc *gpadc;
diff --git a/drivers/mfd/ab8500-sysctrl.c b/drivers/mfd/ab8500-sysctrl.c
index d8cc157..499263c 100644
--- a/drivers/mfd/ab8500-sysctrl.c
+++ b/drivers/mfd/ab8500-sysctrl.c
@@ -49,7 +49,7 @@ int ab8500_sysctrl_write(u16 reg, u8 mask, u8 value)
 		(u8)(reg & 0xFF), mask, value);
 }
 
-static int __devinit ab8500_sysctrl_probe(struct platform_device *pdev)
+static int ab8500_sysctrl_probe(struct platform_device *pdev)
 {
 	sysctrl_dev = &pdev->dev;
 	return 0;
diff --git a/drivers/mfd/adp5520.c b/drivers/mfd/adp5520.c
index f664a52..f2f9d8f 100644
--- a/drivers/mfd/adp5520.c
+++ b/drivers/mfd/adp5520.c
@@ -203,7 +203,7 @@ static int adp5520_remove_subdevs(struct adp5520_chip *chip)
 	return device_for_each_child(chip->dev, NULL, __remove_subdev);
 }
 
-static int __devinit adp5520_probe(struct i2c_client *client,
+static int adp5520_probe(struct i2c_client *client,
 					const struct i2c_device_id *id)
 {
 	struct adp5520_platform_data *pdata = client->dev.platform_data;
diff --git a/drivers/mfd/arizona-core.c b/drivers/mfd/arizona-core.c
index 1b48f20..47e7116 100644
--- a/drivers/mfd/arizona-core.c
+++ b/drivers/mfd/arizona-core.c
@@ -285,7 +285,7 @@ static struct mfd_cell wm5110_devs[] = {
 	{ .name = "wm5110-codec" },
 };
 
-int __devinit arizona_dev_init(struct arizona *arizona)
+int arizona_dev_init(struct arizona *arizona)
 {
 	struct device *dev = arizona->dev;
 	const char *type_name;
diff --git a/drivers/mfd/arizona-i2c.c b/drivers/mfd/arizona-i2c.c
index 43d1647..aaf1a69 100644
--- a/drivers/mfd/arizona-i2c.c
+++ b/drivers/mfd/arizona-i2c.c
@@ -22,7 +22,7 @@
 
 #include "arizona.h"
 
-static __devinit int arizona_i2c_probe(struct i2c_client *i2c,
+static int arizona_i2c_probe(struct i2c_client *i2c,
 					  const struct i2c_device_id *id)
 {
 	struct arizona *arizona;
diff --git a/drivers/mfd/arizona-spi.c b/drivers/mfd/arizona-spi.c
index cc79b82..9663caf 100644
--- a/drivers/mfd/arizona-spi.c
+++ b/drivers/mfd/arizona-spi.c
@@ -22,7 +22,7 @@
 
 #include "arizona.h"
 
-static int __devinit arizona_spi_probe(struct spi_device *spi)
+static int arizona_spi_probe(struct spi_device *spi)
 {
 	const struct spi_device_id *id = spi_get_device_id(spi);
 	struct arizona *arizona;
diff --git a/drivers/mfd/cs5535-mfd.c b/drivers/mfd/cs5535-mfd.c
index 5d3878a..0779b13 100644
--- a/drivers/mfd/cs5535-mfd.c
+++ b/drivers/mfd/cs5535-mfd.c
@@ -113,7 +113,7 @@ static __devinitdata struct mfd_cell cs5535_mfd_cells[] = {
 };
 
 #ifdef CONFIG_OLPC
-static void __devinit cs5535_clone_olpc_cells(void)
+static void cs5535_clone_olpc_cells(void)
 {
 	const char *acpi_clones[] = { "olpc-xo1-pm-acpi", "olpc-xo1-sci-acpi" };
 
@@ -126,7 +126,7 @@ static void __devinit cs5535_clone_olpc_cells(void)
 static void cs5535_clone_olpc_cells(void) { }
 #endif
 
-static int __devinit cs5535_mfd_probe(struct pci_dev *pdev,
+static int cs5535_mfd_probe(struct pci_dev *pdev,
 		const struct pci_device_id *id)
 {
 	int err, i;
diff --git a/drivers/mfd/da903x.c b/drivers/mfd/da903x.c
index c715475..5fa1e91 100644
--- a/drivers/mfd/da903x.c
+++ b/drivers/mfd/da903x.c
@@ -246,7 +246,7 @@ int da903x_query_status(struct device *dev, unsigned int sbits)
 }
 EXPORT_SYMBOL(da903x_query_status);
 
-static int __devinit da9030_init_chip(struct da903x_chip *chip)
+static int da9030_init_chip(struct da903x_chip *chip)
 {
 	uint8_t chip_id;
 	int err;
@@ -459,7 +459,7 @@ static int da903x_remove_subdevs(struct da903x_chip *chip)
 	return device_for_each_child(chip->dev, NULL, __remove_subdev);
 }
 
-static int __devinit da903x_add_subdevs(struct da903x_chip *chip,
+static int da903x_add_subdevs(struct da903x_chip *chip,
 					struct da903x_platform_data *pdata)
 {
 	struct da903x_subdev_info *subdev;
@@ -491,7 +491,7 @@ failed:
 	return ret;
 }
 
-static int __devinit da903x_probe(struct i2c_client *client,
+static int da903x_probe(struct i2c_client *client,
 				  const struct i2c_device_id *id)
 {
 	struct da903x_platform_data *pdata = client->dev.platform_data;
diff --git a/drivers/mfd/da9052-core.c b/drivers/mfd/da9052-core.c
index a0a62b2..c71c4a2 100644
--- a/drivers/mfd/da9052-core.c
+++ b/drivers/mfd/da9052-core.c
@@ -769,7 +769,7 @@ struct regmap_config da9052_regmap_config = {
 };
 EXPORT_SYMBOL_GPL(da9052_regmap_config);
 
-int __devinit da9052_device_init(struct da9052 *da9052, u8 chip_id)
+int da9052_device_init(struct da9052 *da9052, u8 chip_id)
 {
 	struct da9052_pdata *pdata = da9052->dev->platform_data;
 	int ret;
diff --git a/drivers/mfd/da9052-i2c.c b/drivers/mfd/da9052-i2c.c
index 8af0f0c..96f66ed 100644
--- a/drivers/mfd/da9052-i2c.c
+++ b/drivers/mfd/da9052-i2c.c
@@ -64,7 +64,7 @@ static const struct of_device_id dialog_dt_ids[] = {
 };
 #endif
 
-static int __devinit da9052_i2c_probe(struct i2c_client *client,
+static int da9052_i2c_probe(struct i2c_client *client,
 				       const struct i2c_device_id *id)
 {
 	struct da9052 *da9052;
diff --git a/drivers/mfd/da9052-spi.c b/drivers/mfd/da9052-spi.c
index cbcc9be..1ad3243 100644
--- a/drivers/mfd/da9052-spi.c
+++ b/drivers/mfd/da9052-spi.c
@@ -21,7 +21,7 @@
 
 #include <linux/mfd/da9052/da9052.h>
 
-static int __devinit da9052_spi_probe(struct spi_device *spi)
+static int da9052_spi_probe(struct spi_device *spi)
 {
 	int ret;
 	const struct spi_device_id *id = spi_get_device_id(spi);
diff --git a/drivers/mfd/da9055-core.c b/drivers/mfd/da9055-core.c
index ff6c77f3..6f5a4984 100644
--- a/drivers/mfd/da9055-core.c
+++ b/drivers/mfd/da9055-core.c
@@ -377,7 +377,7 @@ static struct regmap_irq_chip da9055_regmap_irq_chip = {
 	.num_irqs = ARRAY_SIZE(da9055_irqs),
 };
 
-int __devinit da9055_device_init(struct da9055 *da9055)
+int da9055_device_init(struct da9055 *da9055)
 {
 	struct da9055_pdata *pdata = da9055->dev->platform_data;
 	int ret;
diff --git a/drivers/mfd/da9055-i2c.c b/drivers/mfd/da9055-i2c.c
index dbaca7b..7778d04 100644
--- a/drivers/mfd/da9055-i2c.c
+++ b/drivers/mfd/da9055-i2c.c
@@ -18,7 +18,7 @@
 
 #include <linux/mfd/da9055/core.h>
 
-static int __devinit da9055_i2c_probe(struct i2c_client *i2c,
+static int da9055_i2c_probe(struct i2c_client *i2c,
 				      const struct i2c_device_id *id)
 {
 	struct da9055 *da9055;
diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
index a1b295f..dc8826d 100644
--- a/drivers/mfd/db8500-prcmu.c
+++ b/drivers/mfd/db8500-prcmu.c
@@ -3098,7 +3098,7 @@ static void db8500_prcmu_update_cpufreq(void)
  * prcmu_fw_init - arch init call for the Linux PRCMU fw init logic
  *
  */
-static int __devinit db8500_prcmu_probe(struct platform_device *pdev)
+static int db8500_prcmu_probe(struct platform_device *pdev)
 {
 	struct ab8500_platform_data *ab8500_platdata = pdev->dev.platform_data;
 	struct device_node *np = pdev->dev.of_node;
diff --git a/drivers/mfd/ezx-pcap.c b/drivers/mfd/ezx-pcap.c
index d7e4de04..d81505e 100644
--- a/drivers/mfd/ezx-pcap.c
+++ b/drivers/mfd/ezx-pcap.c
@@ -371,7 +371,7 @@ static int pcap_remove_subdev(struct device *dev, void *unused)
 	return 0;
 }
 
-static int __devinit pcap_add_subdev(struct pcap_chip *pcap,
+static int pcap_add_subdev(struct pcap_chip *pcap,
 						struct pcap_subdev *subdev)
 {
 	struct platform_device *pdev;
@@ -420,7 +420,7 @@ static int __devexit ezx_pcap_remove(struct spi_device *spi)
 	return 0;
 }
 
-static int __devinit ezx_pcap_probe(struct spi_device *spi)
+static int ezx_pcap_probe(struct spi_device *spi)
 {
 	struct pcap_platform_data *pdata = spi->dev.platform_data;
 	struct pcap_chip *pcap;
diff --git a/drivers/mfd/htc-i2cpld.c b/drivers/mfd/htc-i2cpld.c
index d55065c..324187c 100644
--- a/drivers/mfd/htc-i2cpld.c
+++ b/drivers/mfd/htc-i2cpld.c
@@ -327,7 +327,7 @@ static void htcpld_chip_reset(struct i2c_client *client)
 		client, (chip_data->cache_out = chip_data->reset));
 }
 
-static int __devinit htcpld_setup_chip_irq(
+static int htcpld_setup_chip_irq(
 		struct platform_device *pdev,
 		int chip_index)
 {
@@ -361,7 +361,7 @@ static int __devinit htcpld_setup_chip_irq(
 	return ret;
 }
 
-static int __devinit htcpld_register_chip_i2c(
+static int htcpld_register_chip_i2c(
 		struct platform_device *pdev,
 		int chip_index)
 {
@@ -419,7 +419,7 @@ static int __devinit htcpld_register_chip_i2c(
 	return 0;
 }
 
-static void __devinit htcpld_unregister_chip_i2c(
+static void htcpld_unregister_chip_i2c(
 		struct platform_device *pdev,
 		int chip_index)
 {
@@ -434,7 +434,7 @@ static void __devinit htcpld_unregister_chip_i2c(
 		i2c_unregister_device(chip->client);
 }
 
-static int __devinit htcpld_register_chip_gpio(
+static int htcpld_register_chip_gpio(
 		struct platform_device *pdev,
 		int chip_index)
 {
@@ -501,7 +501,7 @@ static int __devinit htcpld_register_chip_gpio(
 	return 0;
 }
 
-static int __devinit htcpld_setup_chips(struct platform_device *pdev)
+static int htcpld_setup_chips(struct platform_device *pdev)
 {
 	struct htcpld_data *htcpld;
 	struct device *dev = &pdev->dev;
@@ -563,7 +563,7 @@ static int __devinit htcpld_setup_chips(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devinit htcpld_core_probe(struct platform_device *pdev)
+static int htcpld_core_probe(struct platform_device *pdev)
 {
 	struct htcpld_data *htcpld;
 	struct device *dev = &pdev->dev;
diff --git a/drivers/mfd/intel_msic.c b/drivers/mfd/intel_msic.c
index c5f478e..438ac3d 100644
--- a/drivers/mfd/intel_msic.c
+++ b/drivers/mfd/intel_msic.c
@@ -306,7 +306,7 @@ int intel_msic_irq_read(struct intel_msic *msic, unsigned short reg, u8 *val)
 }
 EXPORT_SYMBOL_GPL(intel_msic_irq_read);
 
-static int __devinit intel_msic_init_devices(struct intel_msic *msic)
+static int intel_msic_init_devices(struct intel_msic *msic)
 {
 	struct platform_device *pdev = msic->pdev;
 	struct intel_msic_platform_data *pdata = pdev->dev.platform_data;
@@ -375,7 +375,7 @@ static void __devexit intel_msic_remove_devices(struct intel_msic *msic)
 		gpio_free(pdata->ocd->gpio);
 }
 
-static int __devinit intel_msic_probe(struct platform_device *pdev)
+static int intel_msic_probe(struct platform_device *pdev)
 {
 	struct intel_msic_platform_data *pdata = pdev->dev.platform_data;
 	struct intel_msic *msic;
diff --git a/drivers/mfd/janz-cmodio.c b/drivers/mfd/janz-cmodio.c
index 1a36277..55c479e 100644
--- a/drivers/mfd/janz-cmodio.c
+++ b/drivers/mfd/janz-cmodio.c
@@ -63,7 +63,7 @@ struct cmodio_device {
  * Subdevices using the mfd-core API
  */
 
-static int __devinit cmodio_setup_subdevice(struct cmodio_device *priv,
+static int cmodio_setup_subdevice(struct cmodio_device *priv,
 					    char *name, unsigned int devno,
 					    unsigned int modno)
 {
@@ -120,7 +120,7 @@ static int __devinit cmodio_setup_subdevice(struct cmodio_device *priv,
 }
 
 /* Probe each submodule using kernel parameters */
-static int __devinit cmodio_probe_submodules(struct cmodio_device *priv)
+static int cmodio_probe_submodules(struct cmodio_device *priv)
 {
 	struct pci_dev *pdev = priv->pdev;
 	unsigned int num_probed = 0;
@@ -177,7 +177,7 @@ static const struct attribute_group cmodio_sysfs_attr_group = {
  * PCI Driver
  */
 
-static int __devinit cmodio_pci_probe(struct pci_dev *dev,
+static int cmodio_pci_probe(struct pci_dev *dev,
 				      const struct pci_device_id *id)
 {
 	struct cmodio_device *priv;
diff --git a/drivers/mfd/jz4740-adc.c b/drivers/mfd/jz4740-adc.c
index 9aed2a6..c0d38c5 100644
--- a/drivers/mfd/jz4740-adc.c
+++ b/drivers/mfd/jz4740-adc.c
@@ -202,7 +202,7 @@ static struct mfd_cell jz4740_adc_cells[] = {
 	},
 };
 
-static int __devinit jz4740_adc_probe(struct platform_device *pdev)
+static int jz4740_adc_probe(struct platform_device *pdev)
 {
 	struct irq_chip_generic *gc;
 	struct irq_chip_type *ct;
diff --git a/drivers/mfd/lm3533-core.c b/drivers/mfd/lm3533-core.c
index e7aa2a5..2b74508 100644
--- a/drivers/mfd/lm3533-core.c
+++ b/drivers/mfd/lm3533-core.c
@@ -382,7 +382,7 @@ static struct attribute_group lm3533_attribute_group = {
 	.attrs		= lm3533_attributes
 };
 
-static int __devinit lm3533_device_als_init(struct lm3533 *lm3533)
+static int lm3533_device_als_init(struct lm3533 *lm3533)
 {
 	struct lm3533_platform_data *pdata = lm3533->dev->platform_data;
 	int ret;
@@ -405,7 +405,7 @@ static int __devinit lm3533_device_als_init(struct lm3533 *lm3533)
 	return 0;
 }
 
-static int __devinit lm3533_device_bl_init(struct lm3533 *lm3533)
+static int lm3533_device_bl_init(struct lm3533 *lm3533)
 {
 	struct lm3533_platform_data *pdata = lm3533->dev->platform_data;
 	int i;
@@ -434,7 +434,7 @@ static int __devinit lm3533_device_bl_init(struct lm3533 *lm3533)
 	return 0;
 }
 
-static int __devinit lm3533_device_led_init(struct lm3533 *lm3533)
+static int lm3533_device_led_init(struct lm3533 *lm3533)
 {
 	struct lm3533_platform_data *pdata = lm3533->dev->platform_data;
 	int i;
@@ -463,7 +463,7 @@ static int __devinit lm3533_device_led_init(struct lm3533 *lm3533)
 	return 0;
 }
 
-static int __devinit lm3533_device_setup(struct lm3533 *lm3533,
+static int lm3533_device_setup(struct lm3533 *lm3533,
 					struct lm3533_platform_data *pdata)
 {
 	int ret;
@@ -479,7 +479,7 @@ static int __devinit lm3533_device_setup(struct lm3533 *lm3533,
 	return 0;
 }
 
-static int __devinit lm3533_device_init(struct lm3533 *lm3533)
+static int lm3533_device_init(struct lm3533 *lm3533)
 {
 	struct lm3533_platform_data *pdata = lm3533->dev->platform_data;
 	int ret;
@@ -596,7 +596,7 @@ static struct regmap_config regmap_config = {
 	.precious_reg	= lm3533_precious_register,
 };
 
-static int __devinit lm3533_i2c_probe(struct i2c_client *i2c,
+static int lm3533_i2c_probe(struct i2c_client *i2c,
 					const struct i2c_device_id *id)
 {
 	struct lm3533 *lm3533;
diff --git a/drivers/mfd/lpc_ich.c b/drivers/mfd/lpc_ich.c
index a43c73a..9989175 100644
--- a/drivers/mfd/lpc_ich.c
+++ b/drivers/mfd/lpc_ich.c
@@ -672,7 +672,7 @@ static void lpc_ich_restore_config_space(struct pci_dev *dev)
 	}
 }
 
-static void __devinit lpc_ich_enable_acpi_space(struct pci_dev *dev)
+static void lpc_ich_enable_acpi_space(struct pci_dev *dev)
 {
 	u8 reg_save;
 
@@ -681,7 +681,7 @@ static void __devinit lpc_ich_enable_acpi_space(struct pci_dev *dev)
 	lpc_ich_acpi_save = reg_save;
 }
 
-static void __devinit lpc_ich_enable_gpio_space(struct pci_dev *dev)
+static void lpc_ich_enable_gpio_space(struct pci_dev *dev)
 {
 	u8 reg_save;
 
@@ -690,7 +690,7 @@ static void __devinit lpc_ich_enable_gpio_space(struct pci_dev *dev)
 	lpc_ich_gpio_save = reg_save;
 }
 
-static void __devinit lpc_ich_finalize_cell(struct mfd_cell *cell,
+static void lpc_ich_finalize_cell(struct mfd_cell *cell,
 					const struct pci_device_id *id)
 {
 	cell->platform_data = &lpc_chipset_info[id->driver_data];
@@ -702,7 +702,7 @@ static void __devinit lpc_ich_finalize_cell(struct mfd_cell *cell,
  * GPIO groups and it's enough to have access to one of these to instantiate
  * the device.
  */
-static int __devinit lpc_ich_check_conflict_gpio(struct resource *res)
+static int lpc_ich_check_conflict_gpio(struct resource *res)
 {
 	int ret;
 	u8 use_gpio = 0;
@@ -721,7 +721,7 @@ static int __devinit lpc_ich_check_conflict_gpio(struct resource *res)
 	return use_gpio ? use_gpio : ret;
 }
 
-static int __devinit lpc_ich_init_gpio(struct pci_dev *dev,
+static int lpc_ich_init_gpio(struct pci_dev *dev,
 				const struct pci_device_id *id)
 {
 	u32 base_addr_cfg;
@@ -798,7 +798,7 @@ gpio_done:
 	return ret;
 }
 
-static int __devinit lpc_ich_init_wdt(struct pci_dev *dev,
+static int lpc_ich_init_wdt(struct pci_dev *dev,
 				const struct pci_device_id *id)
 {
 	u32 base_addr_cfg;
@@ -852,7 +852,7 @@ wdt_done:
 	return ret;
 }
 
-static int __devinit lpc_ich_probe(struct pci_dev *dev,
+static int lpc_ich_probe(struct pci_dev *dev,
 				const struct pci_device_id *id)
 {
 	int ret;
diff --git a/drivers/mfd/lpc_sch.c b/drivers/mfd/lpc_sch.c
index 27477f4..5756a6a 100644
--- a/drivers/mfd/lpc_sch.c
+++ b/drivers/mfd/lpc_sch.c
@@ -83,7 +83,7 @@ static DEFINE_PCI_DEVICE_TABLE(lpc_sch_ids) = {
 };
 MODULE_DEVICE_TABLE(pci, lpc_sch_ids);
 
-static int __devinit lpc_sch_probe(struct pci_dev *dev,
+static int lpc_sch_probe(struct pci_dev *dev,
 				const struct pci_device_id *id)
 {
 	unsigned int base_addr_cfg;
diff --git a/drivers/mfd/max8907.c b/drivers/mfd/max8907.c
index 17f2593..81ded7a 100644
--- a/drivers/mfd/max8907.c
+++ b/drivers/mfd/max8907.c
@@ -183,7 +183,7 @@ static void max8907_power_off(void)
 			MAX8907_MASK_POWER_OFF, MAX8907_MASK_POWER_OFF);
 }
 
-static __devinit int max8907_i2c_probe(struct i2c_client *i2c,
+static int max8907_i2c_probe(struct i2c_client *i2c,
 				       const struct i2c_device_id *id)
 {
 	struct max8907 *max8907;
diff --git a/drivers/mfd/max8925-core.c b/drivers/mfd/max8925-core.c
index 9f54c04..20daa16 100644
--- a/drivers/mfd/max8925-core.c
+++ b/drivers/mfd/max8925-core.c
@@ -714,7 +714,7 @@ tsc_irq:
 	return 0;
 }
 
-static void __devinit init_regulator(struct max8925_chip *chip,
+static void init_regulator(struct max8925_chip *chip,
 				     struct max8925_platform_data *pdata)
 {
 	int ret;
@@ -821,7 +821,7 @@ static void __devinit init_regulator(struct max8925_chip *chip,
 	}
 }
 
-int __devinit max8925_device_init(struct max8925_chip *chip,
+int max8925_device_init(struct max8925_chip *chip,
 				  struct max8925_platform_data *pdata)
 {
 	int ret;
diff --git a/drivers/mfd/max8925-i2c.c b/drivers/mfd/max8925-i2c.c
index 375e047..6e3d30a 100644
--- a/drivers/mfd/max8925-i2c.c
+++ b/drivers/mfd/max8925-i2c.c
@@ -135,7 +135,7 @@ static const struct i2c_device_id max8925_id_table[] = {
 };
 MODULE_DEVICE_TABLE(i2c, max8925_id_table);
 
-static int __devinit max8925_probe(struct i2c_client *client,
+static int max8925_probe(struct i2c_client *client,
 				   const struct i2c_device_id *id)
 {
 	struct max8925_platform_data *pdata = client->dev.platform_data;
diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
index cebfe0a..46f7982 100644
--- a/drivers/mfd/omap-usb-host.c
+++ b/drivers/mfd/omap-usb-host.c
@@ -467,7 +467,7 @@ static void omap_usbhs_deinit(struct device *dev)
  *
  * Allocates basic resources for this USB host controller.
  */
-static int __devinit usbhs_omap_probe(struct platform_device *pdev)
+static int usbhs_omap_probe(struct platform_device *pdev)
 {
 	struct device			*dev =  &pdev->dev;
 	struct usbhs_omap_platform_data	*pdata = dev->platform_data;
diff --git a/drivers/mfd/omap-usb-tll.c b/drivers/mfd/omap-usb-tll.c
index d8f713b..d1332c7 100644
--- a/drivers/mfd/omap-usb-tll.c
+++ b/drivers/mfd/omap-usb-tll.c
@@ -200,7 +200,7 @@ static unsigned ohci_omap3_fslsmode(enum usbhs_omap_port_mode mode)
  *
  * Allocates basic resources for this USB host controller.
  */
-static int __devinit usbtll_omap_probe(struct platform_device *pdev)
+static int usbtll_omap_probe(struct platform_device *pdev)
 {
 	struct device				*dev =  &pdev->dev;
 	struct usbtll_omap_platform_data	*pdata = dev->platform_data;
diff --git a/drivers/mfd/palmas.c b/drivers/mfd/palmas.c
index 4f8d6e6..cb52783 100644
--- a/drivers/mfd/palmas.c
+++ b/drivers/mfd/palmas.c
@@ -247,7 +247,7 @@ static struct regmap_irq_chip palmas_irq_chip = {
 			PALMAS_INT1_MASK),
 };
 
-static void __devinit palmas_dt_to_pdata(struct device_node *node,
+static void palmas_dt_to_pdata(struct device_node *node,
 		struct palmas_platform_data *pdata)
 {
 	int ret;
@@ -275,7 +275,7 @@ static void __devinit palmas_dt_to_pdata(struct device_node *node,
 					PALMAS_POWER_CTRL_ENABLE2_MASK;
 }
 
-static int __devinit palmas_i2c_probe(struct i2c_client *i2c,
+static int palmas_i2c_probe(struct i2c_client *i2c,
 			    const struct i2c_device_id *id)
 {
 	struct palmas *palmas;
diff --git a/drivers/mfd/pcf50633-adc.c b/drivers/mfd/pcf50633-adc.c
index a285b51..dbd2f0d 100644
--- a/drivers/mfd/pcf50633-adc.c
+++ b/drivers/mfd/pcf50633-adc.c
@@ -199,7 +199,7 @@ static void pcf50633_adc_irq(int irq, void *data)
 	kfree(req);
 }
 
-static int __devinit pcf50633_adc_probe(struct platform_device *pdev)
+static int pcf50633_adc_probe(struct platform_device *pdev)
 {
 	struct pcf50633_adc *adc;
 
diff --git a/drivers/mfd/pcf50633-core.c b/drivers/mfd/pcf50633-core.c
index ad438e8..fc47735 100644
--- a/drivers/mfd/pcf50633-core.c
+++ b/drivers/mfd/pcf50633-core.c
@@ -191,7 +191,7 @@ static struct regmap_config pcf50633_regmap_config = {
 	.val_bits = 8,
 };
 
-static int __devinit pcf50633_probe(struct i2c_client *client,
+static int pcf50633_probe(struct i2c_client *client,
 				const struct i2c_device_id *ids)
 {
 	struct pcf50633 *pcf;
diff --git a/drivers/mfd/pm8921-core.c b/drivers/mfd/pm8921-core.c
index 24d57bc..4349134 100644
--- a/drivers/mfd/pm8921-core.c
+++ b/drivers/mfd/pm8921-core.c
@@ -80,7 +80,7 @@ static struct pm8xxx_drvdata pm8921_drvdata = {
 	.pmic_read_irq_stat	= pm8921_read_irq_stat,
 };
 
-static int __devinit pm8921_add_subdevices(const struct pm8921_platform_data
+static int pm8921_add_subdevices(const struct pm8921_platform_data
 					   *pdata,
 					   struct pm8921 *pmic,
 					   u32 rev)
@@ -104,7 +104,7 @@ static int __devinit pm8921_add_subdevices(const struct pm8921_platform_data
 	return ret;
 }
 
-static int __devinit pm8921_probe(struct platform_device *pdev)
+static int pm8921_probe(struct platform_device *pdev)
 {
 	const struct pm8921_platform_data *pdata = pdev->dev.platform_data;
 	struct pm8921 *pmic;
diff --git a/drivers/mfd/pm8xxx-irq.c b/drivers/mfd/pm8xxx-irq.c
index d452dd0..59c20ea 100644
--- a/drivers/mfd/pm8xxx-irq.c
+++ b/drivers/mfd/pm8xxx-irq.c
@@ -309,7 +309,7 @@ bail_out:
 }
 EXPORT_SYMBOL_GPL(pm8xxx_get_irq_stat);
 
-struct pm_irq_chip *  __devinit pm8xxx_irq_init(struct device *dev,
+struct pm_irq_chip *  pm8xxx_irq_init(struct device *dev,
 				const struct pm8xxx_irq_platform_data *pdata)
 {
 	struct pm_irq_chip  *chip;
diff --git a/drivers/mfd/rc5t583.c b/drivers/mfd/rc5t583.c
index d38ee24..f721b13 100644
--- a/drivers/mfd/rc5t583.c
+++ b/drivers/mfd/rc5t583.c
@@ -246,7 +246,7 @@ static const struct regmap_config rc5t583_regmap_config = {
 	.cache_type = REGCACHE_RBTREE,
 };
 
-static int __devinit rc5t583_i2c_probe(struct i2c_client *i2c,
+static int rc5t583_i2c_probe(struct i2c_client *i2c,
 			      const struct i2c_device_id *id)
 {
 	struct rc5t583 *rc5t583;
diff --git a/drivers/mfd/rdc321x-southbridge.c b/drivers/mfd/rdc321x-southbridge.c
index 3303963..be46539 100644
--- a/drivers/mfd/rdc321x-southbridge.c
+++ b/drivers/mfd/rdc321x-southbridge.c
@@ -72,7 +72,7 @@ static struct mfd_cell rdc321x_sb_cells[] = {
 	},
 };
 
-static int __devinit rdc321x_sb_probe(struct pci_dev *pdev,
+static int rdc321x_sb_probe(struct pci_dev *pdev,
 					const struct pci_device_id *ent)
 {
 	int err;
diff --git a/drivers/mfd/rtsx_pcr.c b/drivers/mfd/rtsx_pcr.c
index 11e671c..7c3b635 100644
--- a/drivers/mfd/rtsx_pcr.c
+++ b/drivers/mfd/rtsx_pcr.c
@@ -998,7 +998,7 @@ static int rtsx_pci_init_chip(struct rtsx_pcr *pcr)
 	return 0;
 }
 
-static int __devinit rtsx_pci_probe(struct pci_dev *pcidev,
+static int rtsx_pci_probe(struct pci_dev *pcidev,
 				    const struct pci_device_id *id)
 {
 	struct rtsx_pcr *pcr;
diff --git a/drivers/mfd/sm501.c b/drivers/mfd/sm501.c
index 777af5e..c9c102c 100644
--- a/drivers/mfd/sm501.c
+++ b/drivers/mfd/sm501.c
@@ -1014,7 +1014,7 @@ static struct gpio_chip gpio_chip_template = {
 	.get			= sm501_gpio_get,
 };
 
-static int __devinit sm501_gpio_register_chip(struct sm501_devdata *sm,
+static int sm501_gpio_register_chip(struct sm501_devdata *sm,
 					      struct sm501_gpio *gpio,
 					      struct sm501_gpio_chip *chip)
 {
@@ -1042,7 +1042,7 @@ static int __devinit sm501_gpio_register_chip(struct sm501_devdata *sm,
 	return gpiochip_add(gchip);
 }
 
-static int __devinit sm501_register_gpio(struct sm501_devdata *sm)
+static int sm501_register_gpio(struct sm501_devdata *sm)
 {
 	struct sm501_gpio *gpio = &sm->gpio;
 	resource_size_t iobase = sm->io_res->start + SM501_GPIO;
@@ -1313,7 +1313,7 @@ static unsigned int sm501_mem_local[] = {
  * Common init code for an SM501
 */
 
-static int __devinit sm501_init_dev(struct sm501_devdata *sm)
+static int sm501_init_dev(struct sm501_devdata *sm)
 {
 	struct sm501_initdata *idata;
 	struct sm501_platdata *pdata;
@@ -1389,7 +1389,7 @@ static int __devinit sm501_init_dev(struct sm501_devdata *sm)
 	return 0;
 }
 
-static int __devinit sm501_plat_probe(struct platform_device *dev)
+static int sm501_plat_probe(struct platform_device *dev)
 {
 	struct sm501_devdata *sm;
 	int ret;
@@ -1578,7 +1578,7 @@ static struct sm501_platdata sm501_pci_platdata = {
 	.gpio_base	= -1,
 };
 
-static int __devinit sm501_pci_probe(struct pci_dev *dev,
+static int sm501_pci_probe(struct pci_dev *dev,
 				     const struct pci_device_id *id)
 {
 	struct sm501_devdata *sm;
diff --git a/drivers/mfd/sta2x11-mfd.c b/drivers/mfd/sta2x11-mfd.c
index d35da68..2cfd55f 100644
--- a/drivers/mfd/sta2x11-mfd.c
+++ b/drivers/mfd/sta2x11-mfd.c
@@ -69,7 +69,7 @@ static struct sta2x11_mfd *sta2x11_mfd_find(struct pci_dev *pdev)
 	return NULL;
 }
 
-static int __devinit sta2x11_mfd_add(struct pci_dev *pdev, gfp_t flags)
+static int sta2x11_mfd_add(struct pci_dev *pdev, gfp_t flags)
 {
 	struct sta2x11_mfd *mfd = sta2x11_mfd_find(pdev);
 	struct sta2x11_instance *instance;
@@ -363,7 +363,7 @@ static int sta2x11_mfd_resume(struct pci_dev *pdev)
 	return 0;
 }
 
-static int __devinit sta2x11_mfd_probe(struct pci_dev *pdev,
+static int sta2x11_mfd_probe(struct pci_dev *pdev,
 				       const struct pci_device_id *pci_id)
 {
 	int err, i;
diff --git a/drivers/mfd/stmpe-i2c.c b/drivers/mfd/stmpe-i2c.c
index 6a6aed7..8195ca2 100644
--- a/drivers/mfd/stmpe-i2c.c
+++ b/drivers/mfd/stmpe-i2c.c
@@ -52,7 +52,7 @@ static struct stmpe_client_info i2c_ci = {
 	.write_block = i2c_block_write,
 };
 
-static int __devinit
+static int
 stmpe_i2c_probe(struct i2c_client *i2c, const struct i2c_device_id *id)
 {
 	i2c_ci.data = (void *)id;
diff --git a/drivers/mfd/stmpe-spi.c b/drivers/mfd/stmpe-spi.c
index 29590ad..5277433 100644
--- a/drivers/mfd/stmpe-spi.c
+++ b/drivers/mfd/stmpe-spi.c
@@ -82,7 +82,7 @@ static struct stmpe_client_info spi_ci = {
 	.init = spi_init,
 };
 
-static int __devinit
+static int
 stmpe_spi_probe(struct spi_device *spi)
 {
 	const struct spi_device_id *id = spi_get_device_id(spi);
diff --git a/drivers/mfd/stmpe.c b/drivers/mfd/stmpe.c
index ba157d4..c9f4129 100644
--- a/drivers/mfd/stmpe.c
+++ b/drivers/mfd/stmpe.c
@@ -885,7 +885,7 @@ static struct irq_domain_ops stmpe_irq_ops = {
         .xlate  = irq_domain_xlate_twocell,
 };
 
-static int __devinit stmpe_irq_init(struct stmpe *stmpe,
+static int stmpe_irq_init(struct stmpe *stmpe,
 				struct device_node *np)
 {
 	int base = stmpe->irq_base;
@@ -908,7 +908,7 @@ static int __devinit stmpe_irq_init(struct stmpe *stmpe,
 	return 0;
 }
 
-static int __devinit stmpe_chip_init(struct stmpe *stmpe)
+static int stmpe_chip_init(struct stmpe *stmpe)
 {
 	unsigned int irq_trigger = stmpe->pdata->irq_trigger;
 	int autosleep_timeout = stmpe->pdata->autosleep_timeout;
@@ -974,14 +974,14 @@ static int __devinit stmpe_chip_init(struct stmpe *stmpe)
 	return stmpe_reg_write(stmpe, stmpe->regs[STMPE_IDX_ICR_LSB], icr);
 }
 
-static int __devinit stmpe_add_device(struct stmpe *stmpe,
+static int stmpe_add_device(struct stmpe *stmpe,
 				      struct mfd_cell *cell)
 {
 	return mfd_add_devices(stmpe->dev, stmpe->pdata->id, cell, 1,
 			       NULL, stmpe->irq_base, stmpe->domain);
 }
 
-static int __devinit stmpe_devices_init(struct stmpe *stmpe)
+static int stmpe_devices_init(struct stmpe *stmpe)
 {
 	struct stmpe_variant_info *variant = stmpe->variant;
 	unsigned int platform_blocks = stmpe->pdata->blocks;
@@ -1017,7 +1017,7 @@ static int __devinit stmpe_devices_init(struct stmpe *stmpe)
 	return ret;
 }
 
-void __devinit stmpe_of_probe(struct stmpe_platform_data *pdata,
+void stmpe_of_probe(struct stmpe_platform_data *pdata,
 			struct device_node *np)
 {
 	struct device_node *child;
@@ -1044,7 +1044,7 @@ void __devinit stmpe_of_probe(struct stmpe_platform_data *pdata,
 }
 
 /* Called from client specific probe routines */
-int __devinit stmpe_probe(struct stmpe_client_info *ci, int partnum)
+int stmpe_probe(struct stmpe_client_info *ci, int partnum)
 {
 	struct stmpe_platform_data *pdata = dev_get_platdata(ci->dev);
 	struct device_node *np = ci->dev->of_node;
diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
index d258b59..3dbfe9a 100644
--- a/drivers/mfd/syscon.c
+++ b/drivers/mfd/syscon.c
@@ -97,7 +97,7 @@ static struct regmap_config syscon_regmap_config = {
 	.reg_stride = 4,
 };
 
-static int __devinit syscon_probe(struct platform_device *pdev)
+static int syscon_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
diff --git a/drivers/mfd/tc3589x.c b/drivers/mfd/tc3589x.c
index 553ce95..7e197f7 100644
--- a/drivers/mfd/tc3589x.c
+++ b/drivers/mfd/tc3589x.c
@@ -282,7 +282,7 @@ static int tc3589x_chip_init(struct tc3589x *tc3589x)
 	return tc3589x_reg_write(tc3589x, TC3589x_RSTINTCLR, 0x1);
 }
 
-static int __devinit tc3589x_device_init(struct tc3589x *tc3589x)
+static int tc3589x_device_init(struct tc3589x *tc3589x)
 {
 	int ret = 0;
 	unsigned int blocks = tc3589x->pdata->block;
@@ -329,7 +329,7 @@ static int tc3589x_of_probe(struct device_node *np,
 	return 0;
 }
 
-static int __devinit tc3589x_probe(struct i2c_client *i2c,
+static int tc3589x_probe(struct i2c_client *i2c,
 				   const struct i2c_device_id *id)
 {
 	struct tc3589x_platform_data *pdata = i2c->dev.platform_data;
diff --git a/drivers/mfd/tc6387xb.c b/drivers/mfd/tc6387xb.c
index 186f053..ca18f26 100644
--- a/drivers/mfd/tc6387xb.c
+++ b/drivers/mfd/tc6387xb.c
@@ -138,7 +138,7 @@ static struct mfd_cell tc6387xb_cells[] = {
 	},
 };
 
-static int __devinit tc6387xb_probe(struct platform_device *dev)
+static int tc6387xb_probe(struct platform_device *dev)
 {
 	struct tc6387xb_platform_data *pdata = dev->dev.platform_data;
 	struct resource *iomem, *rscr;
diff --git a/drivers/mfd/tc6393xb.c b/drivers/mfd/tc6393xb.c
index 9411a88..2567232 100644
--- a/drivers/mfd/tc6393xb.c
+++ b/drivers/mfd/tc6393xb.c
@@ -602,7 +602,7 @@ static void tc6393xb_detach_irq(struct platform_device *dev)
 
 /*--------------------------------------------------------------------------*/
 
-static int __devinit tc6393xb_probe(struct platform_device *dev)
+static int tc6393xb_probe(struct platform_device *dev)
 {
 	struct tc6393xb_platform_data *tcpd = dev->dev.platform_data;
 	struct tc6393xb *tc6393xb;
diff --git a/drivers/mfd/ti-ssp.c b/drivers/mfd/ti-ssp.c
index 1c31f87..b177f96 100644
--- a/drivers/mfd/ti-ssp.c
+++ b/drivers/mfd/ti-ssp.c
@@ -315,7 +315,7 @@ static irqreturn_t ti_ssp_interrupt(int irq, void *dev_data)
 	return IRQ_HANDLED;
 }
 
-static int __devinit ti_ssp_probe(struct platform_device *pdev)
+static int ti_ssp_probe(struct platform_device *pdev)
 {
 	static struct ti_ssp *ssp;
 	const struct ti_ssp_data *pdata = pdev->dev.platform_data;
diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
index 5b4c274..bc86fc9 100644
--- a/drivers/mfd/ti_am335x_tscadc.c
+++ b/drivers/mfd/ti_am335x_tscadc.c
@@ -58,7 +58,7 @@ static void tscadc_idle_config(struct ti_tscadc_dev *config)
 	tscadc_writel(config, REG_IDLECONFIG, idleconfig);
 }
 
-static	int __devinit ti_tscadc_probe(struct platform_device *pdev)
+static	int ti_tscadc_probe(struct platform_device *pdev)
 {
 	struct ti_tscadc_dev	*tscadc;
 	struct resource		*res;
diff --git a/drivers/mfd/timberdale.c b/drivers/mfd/timberdale.c
index 61badec..dddf1df 100644
--- a/drivers/mfd/timberdale.c
+++ b/drivers/mfd/timberdale.c
@@ -650,7 +650,7 @@ static DEVICE_ATTR(fw_ver, S_IRUGO, show_fw_ver, NULL);
 
 /*--------------------------------------------------------------------------*/
 
-static int __devinit timb_probe(struct pci_dev *dev,
+static int timb_probe(struct pci_dev *dev,
 	const struct pci_device_id *id)
 {
 	struct timberdale_device *priv;
diff --git a/drivers/mfd/tps6105x.c b/drivers/mfd/tps6105x.c
index 4538960..75a84ac 100644
--- a/drivers/mfd/tps6105x.c
+++ b/drivers/mfd/tps6105x.c
@@ -86,7 +86,7 @@ fail:
 }
 EXPORT_SYMBOL(tps6105x_mask_and_set);
 
-static int __devinit tps6105x_startup(struct tps6105x *tps6105x)
+static int tps6105x_startup(struct tps6105x *tps6105x)
 {
 	int ret;
 	u8 regval;
@@ -133,7 +133,7 @@ static struct mfd_cell tps6105x_cells[] = {
 	},
 };
 
-static int __devinit tps6105x_probe(struct i2c_client *client,
+static int tps6105x_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
 	struct tps6105x			*tps6105x;
diff --git a/drivers/mfd/tps65090.c b/drivers/mfd/tps65090.c
index d43ff16..0c446eb 100644
--- a/drivers/mfd/tps65090.c
+++ b/drivers/mfd/tps65090.c
@@ -188,7 +188,7 @@ static irqreturn_t tps65090_irq(int irq, void *data)
 	return acks ? IRQ_HANDLED : IRQ_NONE;
 }
 
-static int __devinit tps65090_irq_init(struct tps65090 *tps65090, int irq,
+static int tps65090_irq_init(struct tps65090 *tps65090, int irq,
 	int irq_base)
 {
 	int i, ret;
@@ -251,7 +251,7 @@ static const struct regmap_config tps65090_regmap_config = {
 	.volatile_reg = is_volatile_reg,
 };
 
-static int __devinit tps65090_i2c_probe(struct i2c_client *client,
+static int tps65090_i2c_probe(struct i2c_client *client,
 					const struct i2c_device_id *id)
 {
 	struct tps65090_platform_data *pdata = client->dev.platform_data;
diff --git a/drivers/mfd/tps65217.c b/drivers/mfd/tps65217.c
index 76360c10..8cba757 100644
--- a/drivers/mfd/tps65217.c
+++ b/drivers/mfd/tps65217.c
@@ -153,7 +153,7 @@ static const struct of_device_id tps65217_of_match[] = {
 	{ /* sentinel */ },
 };
 
-static int __devinit tps65217_probe(struct i2c_client *client,
+static int tps65217_probe(struct i2c_client *client,
 				const struct i2c_device_id *ids)
 {
 	struct tps65217 *tps;
diff --git a/drivers/mfd/tps6586x.c b/drivers/mfd/tps6586x.c
index 664e07c..0c5870b 100644
--- a/drivers/mfd/tps6586x.c
+++ b/drivers/mfd/tps6586x.c
@@ -322,7 +322,7 @@ static irqreturn_t tps6586x_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static int __devinit tps6586x_irq_init(struct tps6586x *tps6586x, int irq,
+static int tps6586x_irq_init(struct tps6586x *tps6586x, int irq,
 				       int irq_base)
 {
 	int i, ret;
@@ -367,7 +367,7 @@ static int __devinit tps6586x_irq_init(struct tps6586x *tps6586x, int irq,
 	return ret;
 }
 
-static int __devinit tps6586x_add_subdevs(struct tps6586x *tps6586x,
+static int tps6586x_add_subdevs(struct tps6586x *tps6586x,
 					  struct tps6586x_platform_data *pdata)
 {
 	struct tps6586x_subdev_info *subdev;
@@ -519,7 +519,7 @@ static void tps6586x_power_off(void)
 	tps6586x_set_bits(tps6586x_dev, TPS6586X_SUPPLYENE, SLEEP_MODE_BIT);
 }
 
-static int __devinit tps6586x_i2c_probe(struct i2c_client *client,
+static int tps6586x_i2c_probe(struct i2c_client *client,
 					const struct i2c_device_id *id)
 {
 	struct tps6586x_platform_data *pdata = client->dev.platform_data;
diff --git a/drivers/mfd/tps65910.c b/drivers/mfd/tps65910.c
index a3d732b..3a34022 100644
--- a/drivers/mfd/tps65910.c
+++ b/drivers/mfd/tps65910.c
@@ -78,7 +78,7 @@ static const struct regmap_config tps65910_regmap_config = {
 	.cache_type = REGCACHE_RBTREE,
 };
 
-static int __devinit tps65910_ck32k_init(struct tps65910 *tps65910,
+static int tps65910_ck32k_init(struct tps65910 *tps65910,
 					struct tps65910_board *pmic_pdata)
 {
 	int ret;
@@ -96,7 +96,7 @@ static int __devinit tps65910_ck32k_init(struct tps65910 *tps65910,
 	return 0;
 }
 
-static int __devinit tps65910_sleepinit(struct tps65910 *tps65910,
+static int tps65910_sleepinit(struct tps65910 *tps65910,
 		struct tps65910_board *pmic_pdata)
 {
 	struct device *dev = NULL;
@@ -237,7 +237,7 @@ static void tps65910_power_off(void)
 			DEVCTRL_DEV_ON_MASK);
 }
 
-static __devinit int tps65910_i2c_probe(struct i2c_client *i2c,
+static int tps65910_i2c_probe(struct i2c_client *i2c,
 					const struct i2c_device_id *id)
 {
 	struct tps65910 *tps65910;
diff --git a/drivers/mfd/tps65911-comparator.c b/drivers/mfd/tps65911-comparator.c
index a025587..b3d268f 100644
--- a/drivers/mfd/tps65911-comparator.c
+++ b/drivers/mfd/tps65911-comparator.c
@@ -122,7 +122,7 @@ static ssize_t comp_threshold_show(struct device *dev,
 static DEVICE_ATTR(comp1_threshold, S_IRUGO, comp_threshold_show, NULL);
 static DEVICE_ATTR(comp2_threshold, S_IRUGO, comp_threshold_show, NULL);
 
-static __devinit int tps65911_comparator_probe(struct platform_device *pdev)
+static int tps65911_comparator_probe(struct platform_device *pdev)
 {
 	struct tps65910 *tps65910 = dev_get_drvdata(pdev->dev.parent);
 	struct tps65910_board *pdata = dev_get_platdata(tps65910->dev);
diff --git a/drivers/mfd/tps65912-spi.c b/drivers/mfd/tps65912-spi.c
index 054315d..6366576 100644
--- a/drivers/mfd/tps65912-spi.c
+++ b/drivers/mfd/tps65912-spi.c
@@ -81,7 +81,7 @@ static int tps65912_spi_read(struct tps65912 *tps65912, u8 addr,
 	return ret;
 }
 
-static int __devinit tps65912_spi_probe(struct spi_device *spi)
+static int tps65912_spi_probe(struct spi_device *spi)
 {
 	struct tps65912 *tps65912;
 
diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index 4ae6423..271d98a 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -1170,7 +1170,7 @@ static int twl_remove(struct i2c_client *client)
 }
 
 /* NOTE: This driver only handles a single twl4030/tps659x0 chip */
-static int __devinit
+static int
 twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
 {
 	struct twl4030_platform_data	*pdata = client->dev.platform_data;
diff --git a/drivers/mfd/twl4030-audio.c b/drivers/mfd/twl4030-audio.c
index 08f9905..aacccdc 100644
--- a/drivers/mfd/twl4030-audio.c
+++ b/drivers/mfd/twl4030-audio.c
@@ -184,7 +184,7 @@ static bool twl4030_audio_has_vibra(struct twl4030_audio_data *pdata,
 	return false;
 }
 
-static int __devinit twl4030_audio_probe(struct platform_device *pdev)
+static int twl4030_audio_probe(struct platform_device *pdev)
 {
 	struct twl4030_audio *audio;
 	struct twl4030_audio_data *pdata = pdev->dev.platform_data;
diff --git a/drivers/mfd/twl4030-madc.c b/drivers/mfd/twl4030-madc.c
index 456ecb5..228d5aa 100644
--- a/drivers/mfd/twl4030-madc.c
+++ b/drivers/mfd/twl4030-madc.c
@@ -692,7 +692,7 @@ static int twl4030_madc_set_power(struct twl4030_madc_data *madc, int on)
 /*
  * Initialize MADC and request for threaded irq
  */
-static int __devinit twl4030_madc_probe(struct platform_device *pdev)
+static int twl4030_madc_probe(struct platform_device *pdev)
 {
 	struct twl4030_madc_data *madc;
 	struct twl4030_madc_platform_data *pdata = pdev->dev.platform_data;
diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power.c
index 79ca33d..a533206 100644
--- a/drivers/mfd/twl4030-power.c
+++ b/drivers/mfd/twl4030-power.c
@@ -124,7 +124,7 @@ static u8 res_config_addrs[] = {
 	[RES_MAIN_REF]	= 0x94,
 };
 
-static int __devinit twl4030_write_script_byte(u8 address, u8 byte)
+static int twl4030_write_script_byte(u8 address, u8 byte)
 {
 	int err;
 
@@ -138,7 +138,7 @@ out:
 	return err;
 }
 
-static int __devinit twl4030_write_script_ins(u8 address, u16 pmb_message,
+static int twl4030_write_script_ins(u8 address, u16 pmb_message,
 					   u8 delay, u8 next)
 {
 	int err;
@@ -158,7 +158,7 @@ out:
 	return err;
 }
 
-static int __devinit twl4030_write_script(u8 address, struct twl4030_ins *script,
+static int twl4030_write_script(u8 address, struct twl4030_ins *script,
 				       int len)
 {
 	int err;
@@ -183,7 +183,7 @@ static int __devinit twl4030_write_script(u8 address, struct twl4030_ins *script
 	return err;
 }
 
-static int __devinit twl4030_config_wakeup3_sequence(u8 address)
+static int twl4030_config_wakeup3_sequence(u8 address)
 {
 	int err;
 	u8 data;
@@ -208,7 +208,7 @@ out:
 	return err;
 }
 
-static int __devinit twl4030_config_wakeup12_sequence(u8 address)
+static int twl4030_config_wakeup12_sequence(u8 address)
 {
 	int err = 0;
 	u8 data;
@@ -262,7 +262,7 @@ out:
 	return err;
 }
 
-static int __devinit twl4030_config_sleep_sequence(u8 address)
+static int twl4030_config_sleep_sequence(u8 address)
 {
 	int err;
 
@@ -276,7 +276,7 @@ static int __devinit twl4030_config_sleep_sequence(u8 address)
 	return err;
 }
 
-static int __devinit twl4030_config_warmreset_sequence(u8 address)
+static int twl4030_config_warmreset_sequence(u8 address)
 {
 	int err;
 	u8 rd_data;
@@ -324,7 +324,7 @@ out:
 	return err;
 }
 
-static int __devinit twl4030_configure_resource(struct twl4030_resconfig *rconfig)
+static int twl4030_configure_resource(struct twl4030_resconfig *rconfig)
 {
 	int rconfig_addr;
 	int err;
@@ -416,7 +416,7 @@ static int __devinit twl4030_configure_resource(struct twl4030_resconfig *rconfi
 	return 0;
 }
 
-static int __devinit load_twl4030_script(struct twl4030_script *tscript,
+static int load_twl4030_script(struct twl4030_script *tscript,
 	       u8 address)
 {
 	int err;
@@ -527,7 +527,7 @@ void twl4030_power_off(void)
 		pr_err("TWL4030 Unable to power off\n");
 }
 
-void __devinit twl4030_power_init(struct twl4030_power_data *twl4030_scripts)
+void twl4030_power_init(struct twl4030_power_data *twl4030_scripts)
 {
 	int err = 0;
 	int i;
diff --git a/drivers/mfd/twl6040.c b/drivers/mfd/twl6040.c
index dde1754..c7a1b13 100644
--- a/drivers/mfd/twl6040.c
+++ b/drivers/mfd/twl6040.c
@@ -518,8 +518,8 @@ static struct regmap_irq_chip twl6040_irq_chip = {
 	.mask_base = TWL6040_REG_INTMR,
 };
 
-static int __devinit twl6040_probe(struct i2c_client *client,
-				     const struct i2c_device_id *id)
+static int twl6040_probe(struct i2c_client *client,
+			 const struct i2c_device_id *id)
 {
 	struct twl6040_platform_data *pdata = client->dev.platform_data;
 	struct device_node *node = client->dev.of_node;
diff --git a/drivers/mfd/vexpress-sysreg.c b/drivers/mfd/vexpress-sysreg.c
index 059d6b1..7d3754b 100644
--- a/drivers/mfd/vexpress-sysreg.c
+++ b/drivers/mfd/vexpress-sysreg.c
@@ -414,7 +414,7 @@ static ssize_t vexpress_sysreg_sys_id_show(struct device *dev,
 
 DEVICE_ATTR(sys_id, S_IRUGO, vexpress_sysreg_sys_id_show, NULL);
 
-static int __devinit vexpress_sysreg_probe(struct platform_device *pdev)
+static int vexpress_sysreg_probe(struct platform_device *pdev)
 {
 	int err;
 	struct resource *res = platform_get_resource(pdev,
diff --git a/drivers/mfd/vx855.c b/drivers/mfd/vx855.c
index c5a7df8..66ef03b 100644
--- a/drivers/mfd/vx855.c
+++ b/drivers/mfd/vx855.c
@@ -72,7 +72,7 @@ static struct mfd_cell vx855_cells[] = {
 	},
 };
 
-static __devinit int vx855_probe(struct pci_dev *pdev,
+static int vx855_probe(struct pci_dev *pdev,
 				 const struct pci_device_id *id)
 {
 	int ret;
diff --git a/drivers/mfd/wl1273-core.c b/drivers/mfd/wl1273-core.c
index 7f3f389..edbe6c1 100644
--- a/drivers/mfd/wl1273-core.c
+++ b/drivers/mfd/wl1273-core.c
@@ -182,7 +182,7 @@ static int wl1273_core_remove(struct i2c_client *client)
 	return 0;
 }
 
-static int __devinit wl1273_core_probe(struct i2c_client *client,
+static int wl1273_core_probe(struct i2c_client *client,
 				       const struct i2c_device_id *id)
 {
 	struct wl1273_fm_platform_data *pdata = client->dev.platform_data;
diff --git a/drivers/mfd/wm831x-spi.c b/drivers/mfd/wm831x-spi.c
index 4329a3a..4c7225a 100644
--- a/drivers/mfd/wm831x-spi.c
+++ b/drivers/mfd/wm831x-spi.c
@@ -21,7 +21,7 @@
 
 #include <linux/mfd/wm831x/core.h>
 
-static int __devinit wm831x_spi_probe(struct spi_device *spi)
+static int wm831x_spi_probe(struct spi_device *spi)
 {
 	const struct spi_device_id *id = spi_get_device_id(spi);
 	struct wm831x *wm831x;
diff --git a/drivers/mfd/wm8994-core.c b/drivers/mfd/wm8994-core.c
index bb9cf52..4642949 100644
--- a/drivers/mfd/wm8994-core.c
+++ b/drivers/mfd/wm8994-core.c
@@ -399,7 +399,7 @@ static const __devinitconst struct reg_default wm1811_reva_patch[] = {
 /*
  * Instantiate the generic non-control parts of the device.
  */
-static __devinit int wm8994_device_init(struct wm8994 *wm8994, int irq)
+static int wm8994_device_init(struct wm8994 *wm8994, int irq)
 {
 	struct wm8994_pdata *pdata = wm8994->dev->platform_data;
 	struct regmap_config *regmap_config;
@@ -689,7 +689,7 @@ static const struct of_device_id wm8994_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, wm8994_of_match);
 
-static __devinit int wm8994_i2c_probe(struct i2c_client *i2c,
+static int wm8994_i2c_probe(struct i2c_client *i2c,
 				      const struct i2c_device_id *id)
 {
 	struct wm8994 *wm8994;
diff --git a/include/linux/mfd/88pm80x.h b/include/linux/mfd/88pm80x.h
index a0ca0dc..478672e 100644
--- a/include/linux/mfd/88pm80x.h
+++ b/include/linux/mfd/88pm80x.h
@@ -364,6 +364,6 @@ static inline int pm80x_dev_resume(struct device *dev)
 #endif
 
 extern int pm80x_init(struct i2c_client *client,
-			     const struct i2c_device_id *id) __devinit;
+		      const struct i2c_device_id *id);
 extern int pm80x_deinit(struct i2c_client *client);
 #endif /* __LINUX_MFD_88PM80X_H */
diff --git a/include/linux/mfd/abx500/ab8500.h b/include/linux/mfd/abx500/ab8500.h
index 1491044..83f0bdc 100644
--- a/include/linux/mfd/abx500/ab8500.h
+++ b/include/linux/mfd/abx500/ab8500.h
@@ -291,7 +291,7 @@ struct ab8500_platform_data {
 	struct ab8500_codec_platform_data *codec;
 };
 
-extern int __devinit ab8500_init(struct ab8500 *ab8500,
+extern int ab8500_init(struct ab8500 *ab8500,
 				 enum ab8500_version version);
 extern int __devexit ab8500_exit(struct ab8500 *ab8500);
 
diff --git a/include/linux/mfd/pm8xxx/irq.h b/include/linux/mfd/pm8xxx/irq.h
index 4b21769..ddaa7f5 100644
--- a/include/linux/mfd/pm8xxx/irq.h
+++ b/include/linux/mfd/pm8xxx/irq.h
@@ -37,7 +37,7 @@ struct pm_irq_chip;
 
 #ifdef CONFIG_MFD_PM8XXX_IRQ
 int pm8xxx_get_irq_stat(struct pm_irq_chip *chip, int irq);
-struct pm_irq_chip * __devinit pm8xxx_irq_init(struct device *dev,
+struct pm_irq_chip *pm8xxx_irq_init(struct device *dev,
 				const struct pm8xxx_irq_platform_data *pdata);
 int __devexit pm8xxx_irq_exit(struct pm_irq_chip *chip);
 #else
@@ -45,7 +45,7 @@ static inline int pm8xxx_get_irq_stat(struct pm_irq_chip *chip, int irq)
 {
 	return -ENXIO;
 }
-static inline struct pm_irq_chip * __devinit pm8xxx_irq_init(
+static inline struct pm_irq_chip *pm8xxx_irq_init(
 				const struct device *dev,
 				const struct pm8xxx_irq_platform_data *pdata)
 {
-- 
1.8.0
