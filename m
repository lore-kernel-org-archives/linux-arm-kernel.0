From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 11 Mar 2013 20:43:53 +0000
Subject: Regulator API ignored return values
Message-ID: <201303112043.53334.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Mark Brown has added a patch to Linux-next that warns about certain regulator
API functions being called without checking the results, which seems to have
uncovered a number of bugs.

I've added a few people to Cc that might be interested in the reports and
in fixing these bugs. Below you can find a list of all instances I found
building the ARM defconfigs.

	Arnd

==> build/dove_defconfig/faillog <==
/git/arm-soc/drivers/mmc/host/sdhci.c: In function 'sdhci_add_host':
/git/arm-soc/drivers/mmc/host/sdhci.c:2910:19: warning: ignoring return value of 'regulator_enable', declared with attribute warn_unused_result [-Wunused-result]

==> build/imx_v4_v5_defconfig/faillog <==
/git/arm-soc/drivers/input/touchscreen/ads7846.c: In function '__ads7846_enable':
/git/arm-soc/drivers/input/touchscreen/ads7846.c:239:18: warning: ignoring return value of 'regulator_enable', declared with attribute warn_unused_result [-Wunused-result]
/git/arm-soc/drivers/mmc/host/sdhci.c: In function 'sdhci_add_host':
/git/arm-soc/drivers/mmc/host/sdhci.c:2910:19: warning: ignoring return value of 'regulator_enable', declared with attribute warn_unused_result [-Wunused-result]
/git/arm-soc/drivers/video/backlight/l4f00242t03.c: In function 'l4f00242t03_lcd_init':
/git/arm-soc/drivers/video/backlight/l4f00242t03.c:58:18: warning: ignoring return value of 'regulator_enable', declared with attribute warn_unused_result [-Wunused-result]
/git/arm-soc/drivers/video/backlight/l4f00242t03.c:61:18: warning: ignoring return value of 'regulator_enable', declared with attribute warn_unused_result [-Wunused-result]

==> build/imx_v6_v7_defconfig/faillog <==
/git/arm-soc/drivers/mmc/host/sdhci.c: In function 'sdhci_add_host':
/git/arm-soc/drivers/mmc/host/sdhci.c:2910:19: warning: ignoring return value of 'regulator_enable', declared with attribute warn_unused_result [-Wunused-result]
/git/arm-soc/drivers/video/backlight/l4f00242t03.c: In function 'l4f00242t03_lcd_init':
/git/arm-soc/drivers/video/backlight/l4f00242t03.c:58:18: warning: ignoring return value of 'regulator_enable', declared with attribute warn_unused_result [-Wunused-result]
/git/arm-soc/drivers/video/backlight/l4f00242t03.c:61:18: warning: ignoring return value of 'regulator_enable', declared with attribute warn_unused_result [-Wunused-result]

==> build/magician_defconfig/faillog <==
/git/arm-soc/drivers/usb/otg/gpio_vbus.c: In function 'set_vbus_draw':
/git/arm-soc/drivers/usb/otg/gpio_vbus.c:72:20: warning: ignoring return value of 'regulator_enable', declared with attribute warn_unused_result [-Wunused-result]

==> build/mmp2_defconfig/faillog <==
/git/arm-soc/drivers/mmc/host/sdhci.c: In function 'sdhci_add_host':
/git/arm-soc/drivers/mmc/host/sdhci.c:2910:19: warning: ignoring return value of 'regulator_enable', declared with attribute warn_unused_result [-Wunused-result]

==> build/omap2plus_defconfig/faillog <==
/git/arm-soc/drivers/input/touchscreen/ads7846.c: In function '__ads7846_enable':
/git/arm-soc/drivers/input/touchscreen/ads7846.c:239:18: warning: ignoring return value of 'regulator_enable', declared with attribute warn_unused_result [-Wunused-result]

==> build/tegra_defconfig/faillog <==
/git/arm-soc/arch/arm/mach-tegra/board-harmony-pcie.c: In function 'harmony_pcie_init':
/git/arm-soc/arch/arm/mach-tegra/board-harmony-pcie.c:65:18: warning: ignoring return value of 'regulator_enable', declared with attribute warn_unused_result [-Wunused-result]
/git/arm-soc/drivers/mmc/host/sdhci.c: In function 'sdhci_add_host':
/git/arm-soc/drivers/mmc/host/sdhci.c:2910:19: warning: ignoring return value of 'regulator_enable', declared with attribute warn_unused_result [-Wunused-result]

==> build/u8500_defconfig/faillog <==
/git/arm-soc/arch/arm/mach-ux500/board-mop500.c: In function 'mop500_prox_activate':
/git/arm-soc/arch/arm/mach-ux500/board-mop500.c:432:18: warning: ignoring return value of 'regulator_enable', declared with attribute warn_unused_result [-Wunused-result]
/git/arm-soc/drivers/mfd/ab8500-gpadc.c: In function 'ab8500_gpadc_runtime_resume':
/git/arm-soc/drivers/mfd/ab8500-gpadc.c:598:18: warning: ignoring return value of 'regulator_enable', declared with attribute warn_unused_result [-Wunused-result]
/git/arm-soc/drivers/mfd/ab8500-gpadc.c: In function 'ab8500_gpadc_probe':
/git/arm-soc/drivers/mfd/ab8500-gpadc.c:655:18: warning: ignoring return value of 'regulator_enable', declared with attribute warn_unused_result [-Wunused-result]
/git/arm-soc/drivers/staging/ste_rmi4/synaptics_i2c_rmi4.c: In function 'synaptics_rmi4_resume':
/git/arm-soc/drivers/staging/ste_rmi4/synaptics_i2c_rmi4.c:1085:18: warning: ignoring return value of 'regulator_enable', declared with attribute warn_unused_result [-Wunused-result]
