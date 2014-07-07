From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon,  7 Jul 2014 16:16:49 +0200
Subject: [PATCH 1/2] power: Move power-supply drivers to subdirectory
In-Reply-To: <1404742610-4951-1-git-send-email-thierry.reding@gmail.com>
References: <1404742610-4951-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1404742610-4951-2-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

Currently the drivers/power directory almost exclusively contains
drivers implementing the power-supply class. However not all power-
related devices are supplies, so in order to give them an appropriate
home this commit moves supply drivers into a supply subdirectory. That
allows the base directory to be used for drivers that don't depend on
the POWER_SUPPLY symbol.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/Makefile                                  |   2 +-
 drivers/power/Kconfig                             | 395 +---------------------
 drivers/power/Makefile                            |  62 +---
 drivers/power/{ => supply}/88pm860x_battery.c     |   0
 drivers/power/{ => supply}/88pm860x_charger.c     |   0
 drivers/power/supply/Kconfig                      | 392 +++++++++++++++++++++
 drivers/power/supply/Makefile                     |  58 ++++
 drivers/power/{ => supply}/ab8500_bmdata.c        |   0
 drivers/power/{ => supply}/ab8500_btemp.c         |   0
 drivers/power/{ => supply}/ab8500_charger.c       |   0
 drivers/power/{ => supply}/ab8500_fg.c            |   0
 drivers/power/{ => supply}/abx500_chargalg.c      |   0
 drivers/power/{ => supply}/apm_power.c            |   0
 drivers/power/{ => supply}/bq2415x_charger.c      |   0
 drivers/power/{ => supply}/bq24190_charger.c      |   0
 drivers/power/{ => supply}/bq24735-charger.c      |   0
 drivers/power/{ => supply}/bq27x00_battery.c      |   0
 drivers/power/{ => supply}/collie_battery.c       |   0
 drivers/power/{ => supply}/da9030_battery.c       |   0
 drivers/power/{ => supply}/da9052-battery.c       |   0
 drivers/power/{ => supply}/ds2760_battery.c       |   0
 drivers/power/{ => supply}/ds2780_battery.c       |   0
 drivers/power/{ => supply}/ds2781_battery.c       |   0
 drivers/power/{ => supply}/ds2782_battery.c       |   0
 drivers/power/{ => supply}/generic-adc-battery.c  |   0
 drivers/power/{ => supply}/goldfish_battery.c     |   0
 drivers/power/{ => supply}/gpio-charger.c         |   0
 drivers/power/{ => supply}/intel_mid_battery.c    |   0
 drivers/power/{ => supply}/isp1704_charger.c      |   0
 drivers/power/{ => supply}/jz4740-battery.c       |   0
 drivers/power/{ => supply}/lp8727_charger.c       |   0
 drivers/power/{ => supply}/lp8788-charger.c       |   0
 drivers/power/{ => supply}/max14577_charger.c     |   0
 drivers/power/{ => supply}/max17040_battery.c     |   0
 drivers/power/{ => supply}/max17042_battery.c     |   0
 drivers/power/{ => supply}/max8903_charger.c      |   0
 drivers/power/{ => supply}/max8925_power.c        |   0
 drivers/power/{ => supply}/max8997_charger.c      |   0
 drivers/power/{ => supply}/max8998_charger.c      |   0
 drivers/power/{ => supply}/olpc_battery.c         |   0
 drivers/power/{ => supply}/pcf50633-charger.c     |   0
 drivers/power/{ => supply}/pda_power.c            |   0
 drivers/power/{ => supply}/pm2301_charger.c       |   0
 drivers/power/{ => supply}/pm2301_charger.h       |   0
 drivers/power/{ => supply}/pmu_battery.c          |   0
 drivers/power/{ => supply}/power_supply.h         |   0
 drivers/power/{ => supply}/power_supply_core.c    |   0
 drivers/power/{ => supply}/power_supply_leds.c    |   0
 drivers/power/{ => supply}/power_supply_sysfs.c   |   0
 drivers/power/{ => supply}/rx51_battery.c         |   0
 drivers/power/{ => supply}/s3c_adc_battery.c      |   0
 drivers/power/{ => supply}/sbs-battery.c          |   0
 drivers/power/{ => supply}/smb347-charger.c       |   0
 drivers/power/{ => supply}/test_power.c           |   0
 drivers/power/{ => supply}/tosa_battery.c         |   0
 drivers/power/{ => supply}/tps65090-charger.c     |   0
 drivers/power/{ => supply}/twl4030_charger.c      |   0
 drivers/power/{ => supply}/twl4030_madc_battery.c |   0
 drivers/power/{ => supply}/wm831x_backup.c        |   0
 drivers/power/{ => supply}/wm831x_power.c         |   0
 drivers/power/{ => supply}/wm8350_power.c         |   0
 drivers/power/{ => supply}/wm97xx_battery.c       |   0
 drivers/power/{ => supply}/z2_battery.c           |   0
 63 files changed, 455 insertions(+), 454 deletions(-)
 rename drivers/power/{ => supply}/88pm860x_battery.c (100%)
 rename drivers/power/{ => supply}/88pm860x_charger.c (100%)
 create mode 100644 drivers/power/supply/Kconfig
 create mode 100644 drivers/power/supply/Makefile
 rename drivers/power/{ => supply}/ab8500_bmdata.c (100%)
 rename drivers/power/{ => supply}/ab8500_btemp.c (100%)
 rename drivers/power/{ => supply}/ab8500_charger.c (100%)
 rename drivers/power/{ => supply}/ab8500_fg.c (100%)
 rename drivers/power/{ => supply}/abx500_chargalg.c (100%)
 rename drivers/power/{ => supply}/apm_power.c (100%)
 rename drivers/power/{ => supply}/bq2415x_charger.c (100%)
 rename drivers/power/{ => supply}/bq24190_charger.c (100%)
 rename drivers/power/{ => supply}/bq24735-charger.c (100%)
 rename drivers/power/{ => supply}/bq27x00_battery.c (100%)
 rename drivers/power/{ => supply}/collie_battery.c (100%)
 rename drivers/power/{ => supply}/da9030_battery.c (100%)
 rename drivers/power/{ => supply}/da9052-battery.c (100%)
 rename drivers/power/{ => supply}/ds2760_battery.c (100%)
 rename drivers/power/{ => supply}/ds2780_battery.c (100%)
 rename drivers/power/{ => supply}/ds2781_battery.c (100%)
 rename drivers/power/{ => supply}/ds2782_battery.c (100%)
 rename drivers/power/{ => supply}/generic-adc-battery.c (100%)
 rename drivers/power/{ => supply}/goldfish_battery.c (100%)
 rename drivers/power/{ => supply}/gpio-charger.c (100%)
 rename drivers/power/{ => supply}/intel_mid_battery.c (100%)
 rename drivers/power/{ => supply}/isp1704_charger.c (100%)
 rename drivers/power/{ => supply}/jz4740-battery.c (100%)
 rename drivers/power/{ => supply}/lp8727_charger.c (100%)
 rename drivers/power/{ => supply}/lp8788-charger.c (100%)
 rename drivers/power/{ => supply}/max14577_charger.c (100%)
 rename drivers/power/{ => supply}/max17040_battery.c (100%)
 rename drivers/power/{ => supply}/max17042_battery.c (100%)
 rename drivers/power/{ => supply}/max8903_charger.c (100%)
 rename drivers/power/{ => supply}/max8925_power.c (100%)
 rename drivers/power/{ => supply}/max8997_charger.c (100%)
 rename drivers/power/{ => supply}/max8998_charger.c (100%)
 rename drivers/power/{ => supply}/olpc_battery.c (100%)
 rename drivers/power/{ => supply}/pcf50633-charger.c (100%)
 rename drivers/power/{ => supply}/pda_power.c (100%)
 rename drivers/power/{ => supply}/pm2301_charger.c (100%)
 rename drivers/power/{ => supply}/pm2301_charger.h (100%)
 rename drivers/power/{ => supply}/pmu_battery.c (100%)
 rename drivers/power/{ => supply}/power_supply.h (100%)
 rename drivers/power/{ => supply}/power_supply_core.c (100%)
 rename drivers/power/{ => supply}/power_supply_leds.c (100%)
 rename drivers/power/{ => supply}/power_supply_sysfs.c (100%)
 rename drivers/power/{ => supply}/rx51_battery.c (100%)
 rename drivers/power/{ => supply}/s3c_adc_battery.c (100%)
 rename drivers/power/{ => supply}/sbs-battery.c (100%)
 rename drivers/power/{ => supply}/smb347-charger.c (100%)
 rename drivers/power/{ => supply}/test_power.c (100%)
 rename drivers/power/{ => supply}/tosa_battery.c (100%)
 rename drivers/power/{ => supply}/tps65090-charger.c (100%)
 rename drivers/power/{ => supply}/twl4030_charger.c (100%)
 rename drivers/power/{ => supply}/twl4030_madc_battery.c (100%)
 rename drivers/power/{ => supply}/wm831x_backup.c (100%)
 rename drivers/power/{ => supply}/wm831x_power.c (100%)
 rename drivers/power/{ => supply}/wm8350_power.c (100%)
 rename drivers/power/{ => supply}/wm97xx_battery.c (100%)
 rename drivers/power/{ => supply}/z2_battery.c (100%)

diff --git a/drivers/Makefile b/drivers/Makefile
index 37b9ed4cd2d6..47ae273b0917 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -100,7 +100,7 @@ obj-y				+= i2c/ media/
 obj-$(CONFIG_PPS)		+= pps/
 obj-$(CONFIG_PTP_1588_CLOCK)	+= ptp/
 obj-$(CONFIG_W1)		+= w1/
-obj-$(CONFIG_POWER_SUPPLY)	+= power/
+obj-y				+= power/
 obj-$(CONFIG_HWMON)		+= hwmon/
 obj-$(CONFIG_THERMAL)		+= thermal/
 obj-$(CONFIG_WATCHDOG)		+= watchdog/
diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
index ba6975123071..5d4833f779ae 100644
--- a/drivers/power/Kconfig
+++ b/drivers/power/Kconfig
@@ -1,396 +1,3 @@
-menuconfig POWER_SUPPLY
-	bool "Power supply class support"
-	help
-	  Say Y here to enable power supply class support. This allows
-	  power supply (batteries, AC, USB) monitoring by userspace
-	  via sysfs and uevent (if available) and/or APM kernel interface
-	  (if selected below).
-
-if POWER_SUPPLY
-
-config POWER_SUPPLY_DEBUG
-	bool "Power supply debug"
-	help
-	  Say Y here to enable debugging messages for power supply class
-	  and drivers.
-
-config PDA_POWER
-	tristate "Generic PDA/phone power driver"
-	depends on !S390
-	help
-	  Say Y here to enable generic power driver for PDAs and phones with
-	  one or two external power supplies (AC/USB) connected to main and
-	  backup batteries, and optional builtin charger.
-
-config APM_POWER
-	tristate "APM emulation for class batteries"
-	depends on APM_EMULATION
-	help
-	  Say Y here to enable support APM status emulation using
-	  battery class devices.
-
-config GENERIC_ADC_BATTERY
-	tristate "Generic battery support using IIO"
-	depends on IIO
-	help
-	  Say Y here to enable support for the generic battery driver
-	  which uses IIO framework to read adc.
-
-config MAX8925_POWER
-	tristate "MAX8925 battery charger support"
-	depends on MFD_MAX8925
-	help
-	  Say Y here to enable support for the battery charger in the Maxim
-	  MAX8925 PMIC.
-
-config WM831X_BACKUP
-	tristate "WM831X backup battery charger support"
-	depends on MFD_WM831X
-	help
-	  Say Y here to enable support for the backup battery charger
-	  in the Wolfson Microelectronics WM831x PMICs.
-
-config WM831X_POWER
-	tristate "WM831X PMU support"
-	depends on MFD_WM831X
-	help
-	  Say Y here to enable support for the power management unit
-	  provided by Wolfson Microelectronics WM831x PMICs.
-
-config WM8350_POWER
-        tristate "WM8350 PMU support"
-        depends on MFD_WM8350
-        help
-          Say Y here to enable support for the power management unit
-	  provided by the Wolfson Microelectronics WM8350 PMIC.
-
-config TEST_POWER
-	tristate "Test power driver"
-	help
-	  This driver is used for testing. It's safe to say M here.
-
-config BATTERY_88PM860X
-	tristate "Marvell 88PM860x battery driver"
-	depends on MFD_88PM860X
-	help
-	  Say Y here to enable battery monitor for Marvell 88PM860x chip.
-
-config BATTERY_DS2760
-	tristate "DS2760 battery driver (HP iPAQ & others)"
-	depends on W1 && W1_SLAVE_DS2760
-	help
-	  Say Y here to enable support for batteries with ds2760 chip.
-
-config BATTERY_DS2780
-	tristate "DS2780 battery driver"
-	depends on HAS_IOMEM
-	select W1
-	select W1_SLAVE_DS2780
-	help
-	  Say Y here to enable support for batteries with ds2780 chip.
-
-config BATTERY_DS2781
-	tristate "DS2781 battery driver"
-	depends on HAS_IOMEM
-	select W1
-	select W1_SLAVE_DS2781
-	help
-	  If you enable this you will have the DS2781 battery driver support.
-
-	  The battery monitor chip is used in many batteries/devices
-	  as the one who is responsible for charging/discharging/monitoring
-	  Li+ batteries.
-
-	  If you are unsure, say N.
-
-config BATTERY_DS2782
-	tristate "DS2782/DS2786 standalone gas-gauge"
-	depends on I2C
-	help
-	  Say Y here to enable support for the DS2782/DS2786 standalone battery
-	  gas-gauge.
-
-config BATTERY_PMU
-	tristate "Apple PMU battery"
-	depends on PPC32 && ADB_PMU
-	help
-	  Say Y here to expose battery information on Apple machines
-	  through the generic battery class.
-
-config BATTERY_OLPC
-	tristate "One Laptop Per Child battery"
-	depends on X86_32 && OLPC
-	help
-	  Say Y to enable support for the battery on the OLPC laptop.
-
-config BATTERY_TOSA
-	tristate "Sharp SL-6000 (tosa) battery"
-	depends on MACH_TOSA && MFD_TC6393XB && TOUCHSCREEN_WM97XX
-	help
-	  Say Y to enable support for the battery on the Sharp Zaurus
-	  SL-6000 (tosa) models.
-
-config BATTERY_COLLIE
-	tristate "Sharp SL-5500 (collie) battery"
-	depends on SA1100_COLLIE && MCP_UCB1200
-	help
-	  Say Y to enable support for the battery on the Sharp Zaurus
-	  SL-5500 (collie) models.
-
-config BATTERY_WM97XX
-	bool "WM97xx generic battery driver"
-	depends on TOUCHSCREEN_WM97XX=y
-	help
-	  Say Y to enable support for battery measured by WM97xx aux port.
-
-config BATTERY_SBS
-        tristate "SBS Compliant gas gauge"
-        depends on I2C
-        help
-	  Say Y to include support for SBS battery driver for SBS-compliant
-	  gas gauges.
-
-config BATTERY_BQ27x00
-	tristate "BQ27x00 battery driver"
-	depends on I2C || I2C=n
-	help
-	  Say Y here to enable support for batteries with BQ27x00 (I2C/HDQ) chips.
-
-config BATTERY_BQ27X00_I2C
-	bool "BQ27200/BQ27500 support"
-	depends on BATTERY_BQ27x00
-	depends on I2C
-	default y
-	help
-	  Say Y here to enable support for batteries with BQ27x00 (I2C) chips.
-
-config BATTERY_BQ27X00_PLATFORM
-	bool "BQ27000 support"
-	depends on BATTERY_BQ27x00
-	default y
-	help
-	  Say Y here to enable support for batteries with BQ27000 (HDQ) chips.
-
-config BATTERY_DA9030
-	tristate "DA9030 battery driver"
-	depends on PMIC_DA903X
-	help
-	  Say Y here to enable support for batteries charger integrated into
-	  DA9030 PMIC.
-
-config BATTERY_DA9052
-	tristate "Dialog DA9052 Battery"
-	depends on PMIC_DA9052
-	help
-	  Say Y here to enable support for batteries charger integrated into
-	  DA9052 PMIC.
-
-config BATTERY_MAX17040
-	tristate "Maxim MAX17040 Fuel Gauge"
-	depends on I2C
-	help
-	  MAX17040 is fuel-gauge systems for lithium-ion (Li+) batteries
-	  in handheld and portable equipment. The MAX17040 is configured
-	  to operate with a single lithium cell
-
-config BATTERY_MAX17042
-	tristate "Maxim MAX17042/17047/17050/8997/8966 Fuel Gauge"
-	depends on I2C
-	select REGMAP_I2C
-	help
-	  MAX17042 is fuel-gauge systems for lithium-ion (Li+) batteries
-	  in handheld and portable equipment. The MAX17042 is configured
-	  to operate with a single lithium cell. MAX8997 and MAX8966 are
-	  multi-function devices that include fuel gauages that are compatible
-	  with MAX17042. This driver also supports max17047/50 chips which are
-	  improved version of max17042.
-
-config BATTERY_Z2
-	tristate "Z2 battery driver"
-	depends on I2C && MACH_ZIPIT2
-	help
-	  Say Y to include support for the battery on the Zipit Z2.
-
-config BATTERY_S3C_ADC
-	tristate "Battery driver for Samsung ADC based monitoring"
-	depends on S3C_ADC
-	help
-	  Say Y here to enable support for iPAQ h1930/h1940/rx1950 battery
-
-config BATTERY_TWL4030_MADC
-	tristate "TWL4030 MADC battery driver"
-	depends on TWL4030_MADC
-	help
-	  Say Y here to enable this dumb driver for batteries managed
-	  through the TWL4030 MADC.
-
-config CHARGER_88PM860X
-	tristate "Marvell 88PM860x Charger driver"
-	depends on MFD_88PM860X && BATTERY_88PM860X
-	help
-	  Say Y here to enable charger for Marvell 88PM860x chip.
-
-config CHARGER_PCF50633
-	tristate "NXP PCF50633 MBC"
-	depends on MFD_PCF50633
-	help
-	 Say Y to include support for NXP PCF50633 Main Battery Charger.
-
-config BATTERY_JZ4740
-	tristate "Ingenic JZ4740 battery"
-	depends on MACH_JZ4740
-	depends on MFD_JZ4740_ADC
-	help
-	  Say Y to enable support for the battery on Ingenic JZ4740 based
-	  boards.
-
-	  This driver can be build as a module. If so, the module will be
-	  called jz4740-battery.
-
-config BATTERY_INTEL_MID
-	tristate "Battery driver for Intel MID platforms"
-	depends on INTEL_SCU_IPC && SPI
-	help
-	  Say Y here to enable the battery driver on Intel MID
-	  platforms.
-
-config BATTERY_RX51
-	tristate "Nokia RX-51 (N900) battery driver"
-	depends on TWL4030_MADC
-	help
-	  Say Y here to enable support for battery information on Nokia
-	  RX-51, also known as N900 tablet.
-
-config CHARGER_ISP1704
-	tristate "ISP1704 USB Charger Detection"
-	depends on USB_PHY
-	help
-	  Say Y to enable support for USB Charger Detection with
-	  ISP1707/ISP1704 USB transceivers.
-
-config CHARGER_MAX8903
-	tristate "MAX8903 Battery DC-DC Charger for USB and Adapter Power"
-	help
-	  Say Y to enable support for the MAX8903 DC-DC charger and sysfs.
-	  The driver supports controlling charger-enable and current-limit
-	  pins based on the status of charger connections with interrupt
-	  handlers.
-
-config CHARGER_TWL4030
-	tristate "OMAP TWL4030 BCI charger driver"
-	depends on TWL4030_CORE
-	help
-	  Say Y here to enable support for TWL4030 Battery Charge Interface.
-
-config CHARGER_LP8727
-	tristate "TI/National Semiconductor LP8727 charger driver"
-	depends on I2C
-	help
-	  Say Y here to enable support for LP8727 Charger Driver.
-
-config CHARGER_LP8788
-	tristate "TI LP8788 charger driver"
-	depends on MFD_LP8788
-	depends on LP8788_ADC
-	depends on IIO
-	help
-	  Say Y to enable support for the LP8788 linear charger.
-
-config CHARGER_GPIO
-	tristate "GPIO charger"
-	depends on GPIOLIB
-	help
-	  Say Y to include support for chargers which report their online status
-	  through a GPIO pin.
-
-	  This driver can be build as a module. If so, the module will be
-	  called gpio-charger.
-
-config CHARGER_MANAGER
-	bool "Battery charger manager for multiple chargers"
-	depends on REGULATOR && RTC_CLASS
-	select EXTCON
-	help
-          Say Y to enable charger-manager support, which allows multiple
-          chargers attached to a battery and multiple batteries attached to a
-          system. The charger-manager also can monitor charging status in
-          runtime and in suspend-to-RAM by waking up the system periodically
-          with help of suspend_again support.
-
-config CHARGER_MAX14577
-	tristate "Maxim MAX14577 MUIC battery charger driver"
-	depends on MFD_MAX14577
-	help
-	  Say Y to enable support for the battery charger control sysfs and
-	  platform data of MAX14577 MUICs.
-
-config CHARGER_MAX8997
-	tristate "Maxim MAX8997/MAX8966 PMIC battery charger driver"
-	depends on MFD_MAX8997 && REGULATOR_MAX8997
-	help
-	  Say Y to enable support for the battery charger control sysfs and
-	  platform data of MAX8997/LP3974 PMICs.
-
-config CHARGER_MAX8998
-	tristate "Maxim MAX8998/LP3974 PMIC battery charger driver"
-	depends on MFD_MAX8998 && REGULATOR_MAX8998
-	help
-	  Say Y to enable support for the battery charger control sysfs and
-	  platform data of MAX8998/LP3974 PMICs.
-
-config CHARGER_BQ2415X
-	tristate "TI BQ2415x battery charger driver"
-	depends on I2C
-	help
-	  Say Y to enable support for the TI BQ2415x battery charger
-	  PMICs.
-
-	  You'll need this driver to charge batteries on e.g. Nokia
-	  RX-51/N900.
-
-config CHARGER_BQ24190
-	tristate "TI BQ24190 battery charger driver"
-	depends on I2C && GPIOLIB
-	help
-	  Say Y to enable support for the TI BQ24190 battery charger.
-
-config CHARGER_BQ24735
-	tristate "TI BQ24735 battery charger support"
-	depends on I2C && GPIOLIB
-	help
-	  Say Y to enable support for the TI BQ24735 battery charger.
-
-config CHARGER_SMB347
-	tristate "Summit Microelectronics SMB347 Battery Charger"
-	depends on I2C
-	select REGMAP_I2C
-	help
-	  Say Y to include support for Summit Microelectronics SMB347
-	  Battery Charger.
-
-config CHARGER_TPS65090
-	tristate "TPS65090 battery charger driver"
-	depends on MFD_TPS65090
-	help
-	 Say Y here to enable support for battery charging with TPS65090
-	 PMIC chips.
-
-config AB8500_BM
-	bool "AB8500 Battery Management Driver"
-	depends on AB8500_CORE && AB8500_GPADC
-	help
-	  Say Y to include support for AB8500 battery management.
-
-config BATTERY_GOLDFISH
-	tristate "Goldfish battery driver"
-	depends on GOLDFISH || COMPILE_TEST
-	depends on HAS_IOMEM
-	help
-	  Say Y to enable support for the battery and AC power in the
-	  Goldfish emulator.
-
+source "drivers/power/supply/Kconfig"
 source "drivers/power/reset/Kconfig"
-
-endif # POWER_SUPPLY
-
 source "drivers/power/avs/Kconfig"
diff --git a/drivers/power/Makefile b/drivers/power/Makefile
index ee54a3e4c90a..d7a0b9dfd7ad 100644
--- a/drivers/power/Makefile
+++ b/drivers/power/Makefile
@@ -1,60 +1,4 @@
-ccflags-$(CONFIG_POWER_SUPPLY_DEBUG) := -DDEBUG
+obj-$(CONFIG_POWER_SUPPLY) += supply/
+obj-$(CONFIG_POWER_RESET) += reset/
+obj-$(CONFIG_POWER_AVS) += avs/
 
-power_supply-y				:= power_supply_core.o
-power_supply-$(CONFIG_SYSFS)		+= power_supply_sysfs.o
-power_supply-$(CONFIG_LEDS_TRIGGERS)	+= power_supply_leds.o
-
-obj-$(CONFIG_POWER_SUPPLY)	+= power_supply.o
-obj-$(CONFIG_GENERIC_ADC_BATTERY)	+= generic-adc-battery.o
-
-obj-$(CONFIG_PDA_POWER)		+= pda_power.o
-obj-$(CONFIG_APM_POWER)		+= apm_power.o
-obj-$(CONFIG_MAX8925_POWER)	+= max8925_power.o
-obj-$(CONFIG_WM831X_BACKUP)	+= wm831x_backup.o
-obj-$(CONFIG_WM831X_POWER)	+= wm831x_power.o
-obj-$(CONFIG_WM8350_POWER)	+= wm8350_power.o
-obj-$(CONFIG_TEST_POWER)	+= test_power.o
-
-obj-$(CONFIG_BATTERY_88PM860X)	+= 88pm860x_battery.o
-obj-$(CONFIG_BATTERY_DS2760)	+= ds2760_battery.o
-obj-$(CONFIG_BATTERY_DS2780)	+= ds2780_battery.o
-obj-$(CONFIG_BATTERY_DS2781)	+= ds2781_battery.o
-obj-$(CONFIG_BATTERY_DS2782)	+= ds2782_battery.o
-obj-$(CONFIG_BATTERY_GOLDFISH)	+= goldfish_battery.o
-obj-$(CONFIG_BATTERY_PMU)	+= pmu_battery.o
-obj-$(CONFIG_BATTERY_OLPC)	+= olpc_battery.o
-obj-$(CONFIG_BATTERY_TOSA)	+= tosa_battery.o
-obj-$(CONFIG_BATTERY_COLLIE)	+= collie_battery.o
-obj-$(CONFIG_BATTERY_WM97XX)	+= wm97xx_battery.o
-obj-$(CONFIG_BATTERY_SBS)	+= sbs-battery.o
-obj-$(CONFIG_BATTERY_BQ27x00)	+= bq27x00_battery.o
-obj-$(CONFIG_BATTERY_DA9030)	+= da9030_battery.o
-obj-$(CONFIG_BATTERY_DA9052)	+= da9052-battery.o
-obj-$(CONFIG_BATTERY_MAX17040)	+= max17040_battery.o
-obj-$(CONFIG_BATTERY_MAX17042)	+= max17042_battery.o
-obj-$(CONFIG_BATTERY_Z2)	+= z2_battery.o
-obj-$(CONFIG_BATTERY_S3C_ADC)	+= s3c_adc_battery.o
-obj-$(CONFIG_BATTERY_TWL4030_MADC)	+= twl4030_madc_battery.o
-obj-$(CONFIG_CHARGER_88PM860X)	+= 88pm860x_charger.o
-obj-$(CONFIG_CHARGER_PCF50633)	+= pcf50633-charger.o
-obj-$(CONFIG_BATTERY_JZ4740)	+= jz4740-battery.o
-obj-$(CONFIG_BATTERY_INTEL_MID)	+= intel_mid_battery.o
-obj-$(CONFIG_BATTERY_RX51)	+= rx51_battery.o
-obj-$(CONFIG_AB8500_BM)		+= ab8500_bmdata.o ab8500_charger.o ab8500_fg.o ab8500_btemp.o abx500_chargalg.o pm2301_charger.o
-obj-$(CONFIG_CHARGER_ISP1704)	+= isp1704_charger.o
-obj-$(CONFIG_CHARGER_MAX8903)	+= max8903_charger.o
-obj-$(CONFIG_CHARGER_TWL4030)	+= twl4030_charger.o
-obj-$(CONFIG_CHARGER_LP8727)	+= lp8727_charger.o
-obj-$(CONFIG_CHARGER_LP8788)	+= lp8788-charger.o
-obj-$(CONFIG_CHARGER_GPIO)	+= gpio-charger.o
-obj-$(CONFIG_CHARGER_MANAGER)	+= charger-manager.o
-obj-$(CONFIG_CHARGER_MAX14577)	+= max14577_charger.o
-obj-$(CONFIG_CHARGER_MAX8997)	+= max8997_charger.o
-obj-$(CONFIG_CHARGER_MAX8998)	+= max8998_charger.o
-obj-$(CONFIG_CHARGER_BQ2415X)	+= bq2415x_charger.o
-obj-$(CONFIG_CHARGER_BQ24190)	+= bq24190_charger.o
-obj-$(CONFIG_CHARGER_BQ24735)	+= bq24735-charger.o
-obj-$(CONFIG_POWER_AVS)		+= avs/
-obj-$(CONFIG_CHARGER_SMB347)	+= smb347-charger.o
-obj-$(CONFIG_CHARGER_TPS65090)	+= tps65090-charger.o
-obj-$(CONFIG_POWER_RESET)	+= reset/
diff --git a/drivers/power/88pm860x_battery.c b/drivers/power/supply/88pm860x_battery.c
similarity index 100%
rename from drivers/power/88pm860x_battery.c
rename to drivers/power/supply/88pm860x_battery.c
diff --git a/drivers/power/88pm860x_charger.c b/drivers/power/supply/88pm860x_charger.c
similarity index 100%
rename from drivers/power/88pm860x_charger.c
rename to drivers/power/supply/88pm860x_charger.c
diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
new file mode 100644
index 000000000000..a1dea66f024c
--- /dev/null
+++ b/drivers/power/supply/Kconfig
@@ -0,0 +1,392 @@
+menuconfig POWER_SUPPLY
+	bool "Power supply class support"
+	help
+	  Say Y here to enable power supply class support. This allows
+	  power supply (batteries, AC, USB) monitoring by userspace
+	  via sysfs and uevent (if available) and/or APM kernel interface
+	  (if selected below).
+
+if POWER_SUPPLY
+
+config POWER_SUPPLY_DEBUG
+	bool "Power supply debug"
+	help
+	  Say Y here to enable debugging messages for power supply class
+	  and drivers.
+
+config PDA_POWER
+	tristate "Generic PDA/phone power driver"
+	depends on !S390
+	help
+	  Say Y here to enable generic power driver for PDAs and phones with
+	  one or two external power supplies (AC/USB) connected to main and
+	  backup batteries, and optional builtin charger.
+
+config APM_POWER
+	tristate "APM emulation for class batteries"
+	depends on APM_EMULATION
+	help
+	  Say Y here to enable support APM status emulation using
+	  battery class devices.
+
+config GENERIC_ADC_BATTERY
+	tristate "Generic battery support using IIO"
+	depends on IIO
+	help
+	  Say Y here to enable support for the generic battery driver
+	  which uses IIO framework to read adc.
+
+config MAX8925_POWER
+	tristate "MAX8925 battery charger support"
+	depends on MFD_MAX8925
+	help
+	  Say Y here to enable support for the battery charger in the Maxim
+	  MAX8925 PMIC.
+
+config WM831X_BACKUP
+	tristate "WM831X backup battery charger support"
+	depends on MFD_WM831X
+	help
+	  Say Y here to enable support for the backup battery charger
+	  in the Wolfson Microelectronics WM831x PMICs.
+
+config WM831X_POWER
+	tristate "WM831X PMU support"
+	depends on MFD_WM831X
+	help
+	  Say Y here to enable support for the power management unit
+	  provided by Wolfson Microelectronics WM831x PMICs.
+
+config WM8350_POWER
+        tristate "WM8350 PMU support"
+        depends on MFD_WM8350
+        help
+          Say Y here to enable support for the power management unit
+	  provided by the Wolfson Microelectronics WM8350 PMIC.
+
+config TEST_POWER
+	tristate "Test power driver"
+	help
+	  This driver is used for testing. It's safe to say M here.
+
+config BATTERY_88PM860X
+	tristate "Marvell 88PM860x battery driver"
+	depends on MFD_88PM860X
+	help
+	  Say Y here to enable battery monitor for Marvell 88PM860x chip.
+
+config BATTERY_DS2760
+	tristate "DS2760 battery driver (HP iPAQ & others)"
+	depends on W1 && W1_SLAVE_DS2760
+	help
+	  Say Y here to enable support for batteries with ds2760 chip.
+
+config BATTERY_DS2780
+	tristate "DS2780 battery driver"
+	depends on HAS_IOMEM
+	select W1
+	select W1_SLAVE_DS2780
+	help
+	  Say Y here to enable support for batteries with ds2780 chip.
+
+config BATTERY_DS2781
+	tristate "DS2781 battery driver"
+	depends on HAS_IOMEM
+	select W1
+	select W1_SLAVE_DS2781
+	help
+	  If you enable this you will have the DS2781 battery driver support.
+
+	  The battery monitor chip is used in many batteries/devices
+	  as the one who is responsible for charging/discharging/monitoring
+	  Li+ batteries.
+
+	  If you are unsure, say N.
+
+config BATTERY_DS2782
+	tristate "DS2782/DS2786 standalone gas-gauge"
+	depends on I2C
+	help
+	  Say Y here to enable support for the DS2782/DS2786 standalone battery
+	  gas-gauge.
+
+config BATTERY_PMU
+	tristate "Apple PMU battery"
+	depends on PPC32 && ADB_PMU
+	help
+	  Say Y here to expose battery information on Apple machines
+	  through the generic battery class.
+
+config BATTERY_OLPC
+	tristate "One Laptop Per Child battery"
+	depends on X86_32 && OLPC
+	help
+	  Say Y to enable support for the battery on the OLPC laptop.
+
+config BATTERY_TOSA
+	tristate "Sharp SL-6000 (tosa) battery"
+	depends on MACH_TOSA && MFD_TC6393XB && TOUCHSCREEN_WM97XX
+	help
+	  Say Y to enable support for the battery on the Sharp Zaurus
+	  SL-6000 (tosa) models.
+
+config BATTERY_COLLIE
+	tristate "Sharp SL-5500 (collie) battery"
+	depends on SA1100_COLLIE && MCP_UCB1200
+	help
+	  Say Y to enable support for the battery on the Sharp Zaurus
+	  SL-5500 (collie) models.
+
+config BATTERY_WM97XX
+	bool "WM97xx generic battery driver"
+	depends on TOUCHSCREEN_WM97XX=y
+	help
+	  Say Y to enable support for battery measured by WM97xx aux port.
+
+config BATTERY_SBS
+        tristate "SBS Compliant gas gauge"
+        depends on I2C
+        help
+	  Say Y to include support for SBS battery driver for SBS-compliant
+	  gas gauges.
+
+config BATTERY_BQ27x00
+	tristate "BQ27x00 battery driver"
+	depends on I2C || I2C=n
+	help
+	  Say Y here to enable support for batteries with BQ27x00 (I2C/HDQ) chips.
+
+config BATTERY_BQ27X00_I2C
+	bool "BQ27200/BQ27500 support"
+	depends on BATTERY_BQ27x00
+	depends on I2C
+	default y
+	help
+	  Say Y here to enable support for batteries with BQ27x00 (I2C) chips.
+
+config BATTERY_BQ27X00_PLATFORM
+	bool "BQ27000 support"
+	depends on BATTERY_BQ27x00
+	default y
+	help
+	  Say Y here to enable support for batteries with BQ27000 (HDQ) chips.
+
+config BATTERY_DA9030
+	tristate "DA9030 battery driver"
+	depends on PMIC_DA903X
+	help
+	  Say Y here to enable support for batteries charger integrated into
+	  DA9030 PMIC.
+
+config BATTERY_DA9052
+	tristate "Dialog DA9052 Battery"
+	depends on PMIC_DA9052
+	help
+	  Say Y here to enable support for batteries charger integrated into
+	  DA9052 PMIC.
+
+config BATTERY_MAX17040
+	tristate "Maxim MAX17040 Fuel Gauge"
+	depends on I2C
+	help
+	  MAX17040 is fuel-gauge systems for lithium-ion (Li+) batteries
+	  in handheld and portable equipment. The MAX17040 is configured
+	  to operate with a single lithium cell
+
+config BATTERY_MAX17042
+	tristate "Maxim MAX17042/17047/17050/8997/8966 Fuel Gauge"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  MAX17042 is fuel-gauge systems for lithium-ion (Li+) batteries
+	  in handheld and portable equipment. The MAX17042 is configured
+	  to operate with a single lithium cell. MAX8997 and MAX8966 are
+	  multi-function devices that include fuel gauages that are compatible
+	  with MAX17042. This driver also supports max17047/50 chips which are
+	  improved version of max17042.
+
+config BATTERY_Z2
+	tristate "Z2 battery driver"
+	depends on I2C && MACH_ZIPIT2
+	help
+	  Say Y to include support for the battery on the Zipit Z2.
+
+config BATTERY_S3C_ADC
+	tristate "Battery driver for Samsung ADC based monitoring"
+	depends on S3C_ADC
+	help
+	  Say Y here to enable support for iPAQ h1930/h1940/rx1950 battery
+
+config BATTERY_TWL4030_MADC
+	tristate "TWL4030 MADC battery driver"
+	depends on TWL4030_MADC
+	help
+	  Say Y here to enable this dumb driver for batteries managed
+	  through the TWL4030 MADC.
+
+config CHARGER_88PM860X
+	tristate "Marvell 88PM860x Charger driver"
+	depends on MFD_88PM860X && BATTERY_88PM860X
+	help
+	  Say Y here to enable charger for Marvell 88PM860x chip.
+
+config CHARGER_PCF50633
+	tristate "NXP PCF50633 MBC"
+	depends on MFD_PCF50633
+	help
+	 Say Y to include support for NXP PCF50633 Main Battery Charger.
+
+config BATTERY_JZ4740
+	tristate "Ingenic JZ4740 battery"
+	depends on MACH_JZ4740
+	depends on MFD_JZ4740_ADC
+	help
+	  Say Y to enable support for the battery on Ingenic JZ4740 based
+	  boards.
+
+	  This driver can be build as a module. If so, the module will be
+	  called jz4740-battery.
+
+config BATTERY_INTEL_MID
+	tristate "Battery driver for Intel MID platforms"
+	depends on INTEL_SCU_IPC && SPI
+	help
+	  Say Y here to enable the battery driver on Intel MID
+	  platforms.
+
+config BATTERY_RX51
+	tristate "Nokia RX-51 (N900) battery driver"
+	depends on TWL4030_MADC
+	help
+	  Say Y here to enable support for battery information on Nokia
+	  RX-51, also known as N900 tablet.
+
+config CHARGER_ISP1704
+	tristate "ISP1704 USB Charger Detection"
+	depends on USB_PHY
+	help
+	  Say Y to enable support for USB Charger Detection with
+	  ISP1707/ISP1704 USB transceivers.
+
+config CHARGER_MAX8903
+	tristate "MAX8903 Battery DC-DC Charger for USB and Adapter Power"
+	help
+	  Say Y to enable support for the MAX8903 DC-DC charger and sysfs.
+	  The driver supports controlling charger-enable and current-limit
+	  pins based on the status of charger connections with interrupt
+	  handlers.
+
+config CHARGER_TWL4030
+	tristate "OMAP TWL4030 BCI charger driver"
+	depends on TWL4030_CORE
+	help
+	  Say Y here to enable support for TWL4030 Battery Charge Interface.
+
+config CHARGER_LP8727
+	tristate "TI/National Semiconductor LP8727 charger driver"
+	depends on I2C
+	help
+	  Say Y here to enable support for LP8727 Charger Driver.
+
+config CHARGER_LP8788
+	tristate "TI LP8788 charger driver"
+	depends on MFD_LP8788
+	depends on LP8788_ADC
+	depends on IIO
+	help
+	  Say Y to enable support for the LP8788 linear charger.
+
+config CHARGER_GPIO
+	tristate "GPIO charger"
+	depends on GPIOLIB
+	help
+	  Say Y to include support for chargers which report their online status
+	  through a GPIO pin.
+
+	  This driver can be build as a module. If so, the module will be
+	  called gpio-charger.
+
+config CHARGER_MANAGER
+	bool "Battery charger manager for multiple chargers"
+	depends on REGULATOR && RTC_CLASS
+	select EXTCON
+	help
+          Say Y to enable charger-manager support, which allows multiple
+          chargers attached to a battery and multiple batteries attached to a
+          system. The charger-manager also can monitor charging status in
+          runtime and in suspend-to-RAM by waking up the system periodically
+          with help of suspend_again support.
+
+config CHARGER_MAX14577
+	tristate "Maxim MAX14577 MUIC battery charger driver"
+	depends on MFD_MAX14577
+	help
+	  Say Y to enable support for the battery charger control sysfs and
+	  platform data of MAX14577 MUICs.
+
+config CHARGER_MAX8997
+	tristate "Maxim MAX8997/MAX8966 PMIC battery charger driver"
+	depends on MFD_MAX8997 && REGULATOR_MAX8997
+	help
+	  Say Y to enable support for the battery charger control sysfs and
+	  platform data of MAX8997/LP3974 PMICs.
+
+config CHARGER_MAX8998
+	tristate "Maxim MAX8998/LP3974 PMIC battery charger driver"
+	depends on MFD_MAX8998 && REGULATOR_MAX8998
+	help
+	  Say Y to enable support for the battery charger control sysfs and
+	  platform data of MAX8998/LP3974 PMICs.
+
+config CHARGER_BQ2415X
+	tristate "TI BQ2415x battery charger driver"
+	depends on I2C
+	help
+	  Say Y to enable support for the TI BQ2415x battery charger
+	  PMICs.
+
+	  You'll need this driver to charge batteries on e.g. Nokia
+	  RX-51/N900.
+
+config CHARGER_BQ24190
+	tristate "TI BQ24190 battery charger driver"
+	depends on I2C && GPIOLIB
+	help
+	  Say Y to enable support for the TI BQ24190 battery charger.
+
+config CHARGER_BQ24735
+	tristate "TI BQ24735 battery charger support"
+	depends on I2C && GPIOLIB
+	help
+	  Say Y to enable support for the TI BQ24735 battery charger.
+
+config CHARGER_SMB347
+	tristate "Summit Microelectronics SMB347 Battery Charger"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  Say Y to include support for Summit Microelectronics SMB347
+	  Battery Charger.
+
+config CHARGER_TPS65090
+	tristate "TPS65090 battery charger driver"
+	depends on MFD_TPS65090
+	help
+	 Say Y here to enable support for battery charging with TPS65090
+	 PMIC chips.
+
+config AB8500_BM
+	bool "AB8500 Battery Management Driver"
+	depends on AB8500_CORE && AB8500_GPADC
+	help
+	  Say Y to include support for AB8500 battery management.
+
+config BATTERY_GOLDFISH
+	tristate "Goldfish battery driver"
+	depends on GOLDFISH || COMPILE_TEST
+	depends on HAS_IOMEM
+	help
+	  Say Y to enable support for the battery and AC power in the
+	  Goldfish emulator.
+
+endif
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
new file mode 100644
index 000000000000..14597bba1852
--- /dev/null
+++ b/drivers/power/supply/Makefile
@@ -0,0 +1,58 @@
+ccflags-$(CONFIG_POWER_SUPPLY_DEBUG) := -DDEBUG
+
+power_supply-y				:= power_supply_core.o
+power_supply-$(CONFIG_SYSFS)		+= power_supply_sysfs.o
+power_supply-$(CONFIG_LEDS_TRIGGERS)	+= power_supply_leds.o
+
+obj-$(CONFIG_POWER_SUPPLY)	+= power_supply.o
+obj-$(CONFIG_GENERIC_ADC_BATTERY)	+= generic-adc-battery.o
+
+obj-$(CONFIG_PDA_POWER)		+= pda_power.o
+obj-$(CONFIG_APM_POWER)		+= apm_power.o
+obj-$(CONFIG_MAX8925_POWER)	+= max8925_power.o
+obj-$(CONFIG_WM831X_BACKUP)	+= wm831x_backup.o
+obj-$(CONFIG_WM831X_POWER)	+= wm831x_power.o
+obj-$(CONFIG_WM8350_POWER)	+= wm8350_power.o
+obj-$(CONFIG_TEST_POWER)	+= test_power.o
+
+obj-$(CONFIG_BATTERY_88PM860X)	+= 88pm860x_battery.o
+obj-$(CONFIG_BATTERY_DS2760)	+= ds2760_battery.o
+obj-$(CONFIG_BATTERY_DS2780)	+= ds2780_battery.o
+obj-$(CONFIG_BATTERY_DS2781)	+= ds2781_battery.o
+obj-$(CONFIG_BATTERY_DS2782)	+= ds2782_battery.o
+obj-$(CONFIG_BATTERY_GOLDFISH)	+= goldfish_battery.o
+obj-$(CONFIG_BATTERY_PMU)	+= pmu_battery.o
+obj-$(CONFIG_BATTERY_OLPC)	+= olpc_battery.o
+obj-$(CONFIG_BATTERY_TOSA)	+= tosa_battery.o
+obj-$(CONFIG_BATTERY_COLLIE)	+= collie_battery.o
+obj-$(CONFIG_BATTERY_WM97XX)	+= wm97xx_battery.o
+obj-$(CONFIG_BATTERY_SBS)	+= sbs-battery.o
+obj-$(CONFIG_BATTERY_BQ27x00)	+= bq27x00_battery.o
+obj-$(CONFIG_BATTERY_DA9030)	+= da9030_battery.o
+obj-$(CONFIG_BATTERY_DA9052)	+= da9052-battery.o
+obj-$(CONFIG_BATTERY_MAX17040)	+= max17040_battery.o
+obj-$(CONFIG_BATTERY_MAX17042)	+= max17042_battery.o
+obj-$(CONFIG_BATTERY_Z2)	+= z2_battery.o
+obj-$(CONFIG_BATTERY_S3C_ADC)	+= s3c_adc_battery.o
+obj-$(CONFIG_BATTERY_TWL4030_MADC)	+= twl4030_madc_battery.o
+obj-$(CONFIG_CHARGER_88PM860X)	+= 88pm860x_charger.o
+obj-$(CONFIG_CHARGER_PCF50633)	+= pcf50633-charger.o
+obj-$(CONFIG_BATTERY_JZ4740)	+= jz4740-battery.o
+obj-$(CONFIG_BATTERY_INTEL_MID)	+= intel_mid_battery.o
+obj-$(CONFIG_BATTERY_RX51)	+= rx51_battery.o
+obj-$(CONFIG_AB8500_BM)		+= ab8500_bmdata.o ab8500_charger.o ab8500_fg.o ab8500_btemp.o abx500_chargalg.o pm2301_charger.o
+obj-$(CONFIG_CHARGER_ISP1704)	+= isp1704_charger.o
+obj-$(CONFIG_CHARGER_MAX8903)	+= max8903_charger.o
+obj-$(CONFIG_CHARGER_TWL4030)	+= twl4030_charger.o
+obj-$(CONFIG_CHARGER_LP8727)	+= lp8727_charger.o
+obj-$(CONFIG_CHARGER_LP8788)	+= lp8788-charger.o
+obj-$(CONFIG_CHARGER_GPIO)	+= gpio-charger.o
+obj-$(CONFIG_CHARGER_MANAGER)	+= charger-manager.o
+obj-$(CONFIG_CHARGER_MAX14577)	+= max14577_charger.o
+obj-$(CONFIG_CHARGER_MAX8997)	+= max8997_charger.o
+obj-$(CONFIG_CHARGER_MAX8998)	+= max8998_charger.o
+obj-$(CONFIG_CHARGER_BQ2415X)	+= bq2415x_charger.o
+obj-$(CONFIG_CHARGER_BQ24190)	+= bq24190_charger.o
+obj-$(CONFIG_CHARGER_BQ24735)	+= bq24735-charger.o
+obj-$(CONFIG_CHARGER_SMB347)	+= smb347-charger.o
+obj-$(CONFIG_CHARGER_TPS65090)	+= tps65090-charger.o
diff --git a/drivers/power/ab8500_bmdata.c b/drivers/power/supply/ab8500_bmdata.c
similarity index 100%
rename from drivers/power/ab8500_bmdata.c
rename to drivers/power/supply/ab8500_bmdata.c
diff --git a/drivers/power/ab8500_btemp.c b/drivers/power/supply/ab8500_btemp.c
similarity index 100%
rename from drivers/power/ab8500_btemp.c
rename to drivers/power/supply/ab8500_btemp.c
diff --git a/drivers/power/ab8500_charger.c b/drivers/power/supply/ab8500_charger.c
similarity index 100%
rename from drivers/power/ab8500_charger.c
rename to drivers/power/supply/ab8500_charger.c
diff --git a/drivers/power/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
similarity index 100%
rename from drivers/power/ab8500_fg.c
rename to drivers/power/supply/ab8500_fg.c
diff --git a/drivers/power/abx500_chargalg.c b/drivers/power/supply/abx500_chargalg.c
similarity index 100%
rename from drivers/power/abx500_chargalg.c
rename to drivers/power/supply/abx500_chargalg.c
diff --git a/drivers/power/apm_power.c b/drivers/power/supply/apm_power.c
similarity index 100%
rename from drivers/power/apm_power.c
rename to drivers/power/supply/apm_power.c
diff --git a/drivers/power/bq2415x_charger.c b/drivers/power/supply/bq2415x_charger.c
similarity index 100%
rename from drivers/power/bq2415x_charger.c
rename to drivers/power/supply/bq2415x_charger.c
diff --git a/drivers/power/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
similarity index 100%
rename from drivers/power/bq24190_charger.c
rename to drivers/power/supply/bq24190_charger.c
diff --git a/drivers/power/bq24735-charger.c b/drivers/power/supply/bq24735-charger.c
similarity index 100%
rename from drivers/power/bq24735-charger.c
rename to drivers/power/supply/bq24735-charger.c
diff --git a/drivers/power/bq27x00_battery.c b/drivers/power/supply/bq27x00_battery.c
similarity index 100%
rename from drivers/power/bq27x00_battery.c
rename to drivers/power/supply/bq27x00_battery.c
diff --git a/drivers/power/collie_battery.c b/drivers/power/supply/collie_battery.c
similarity index 100%
rename from drivers/power/collie_battery.c
rename to drivers/power/supply/collie_battery.c
diff --git a/drivers/power/da9030_battery.c b/drivers/power/supply/da9030_battery.c
similarity index 100%
rename from drivers/power/da9030_battery.c
rename to drivers/power/supply/da9030_battery.c
diff --git a/drivers/power/da9052-battery.c b/drivers/power/supply/da9052-battery.c
similarity index 100%
rename from drivers/power/da9052-battery.c
rename to drivers/power/supply/da9052-battery.c
diff --git a/drivers/power/ds2760_battery.c b/drivers/power/supply/ds2760_battery.c
similarity index 100%
rename from drivers/power/ds2760_battery.c
rename to drivers/power/supply/ds2760_battery.c
diff --git a/drivers/power/ds2780_battery.c b/drivers/power/supply/ds2780_battery.c
similarity index 100%
rename from drivers/power/ds2780_battery.c
rename to drivers/power/supply/ds2780_battery.c
diff --git a/drivers/power/ds2781_battery.c b/drivers/power/supply/ds2781_battery.c
similarity index 100%
rename from drivers/power/ds2781_battery.c
rename to drivers/power/supply/ds2781_battery.c
diff --git a/drivers/power/ds2782_battery.c b/drivers/power/supply/ds2782_battery.c
similarity index 100%
rename from drivers/power/ds2782_battery.c
rename to drivers/power/supply/ds2782_battery.c
diff --git a/drivers/power/generic-adc-battery.c b/drivers/power/supply/generic-adc-battery.c
similarity index 100%
rename from drivers/power/generic-adc-battery.c
rename to drivers/power/supply/generic-adc-battery.c
diff --git a/drivers/power/goldfish_battery.c b/drivers/power/supply/goldfish_battery.c
similarity index 100%
rename from drivers/power/goldfish_battery.c
rename to drivers/power/supply/goldfish_battery.c
diff --git a/drivers/power/gpio-charger.c b/drivers/power/supply/gpio-charger.c
similarity index 100%
rename from drivers/power/gpio-charger.c
rename to drivers/power/supply/gpio-charger.c
diff --git a/drivers/power/intel_mid_battery.c b/drivers/power/supply/intel_mid_battery.c
similarity index 100%
rename from drivers/power/intel_mid_battery.c
rename to drivers/power/supply/intel_mid_battery.c
diff --git a/drivers/power/isp1704_charger.c b/drivers/power/supply/isp1704_charger.c
similarity index 100%
rename from drivers/power/isp1704_charger.c
rename to drivers/power/supply/isp1704_charger.c
diff --git a/drivers/power/jz4740-battery.c b/drivers/power/supply/jz4740-battery.c
similarity index 100%
rename from drivers/power/jz4740-battery.c
rename to drivers/power/supply/jz4740-battery.c
diff --git a/drivers/power/lp8727_charger.c b/drivers/power/supply/lp8727_charger.c
similarity index 100%
rename from drivers/power/lp8727_charger.c
rename to drivers/power/supply/lp8727_charger.c
diff --git a/drivers/power/lp8788-charger.c b/drivers/power/supply/lp8788-charger.c
similarity index 100%
rename from drivers/power/lp8788-charger.c
rename to drivers/power/supply/lp8788-charger.c
diff --git a/drivers/power/max14577_charger.c b/drivers/power/supply/max14577_charger.c
similarity index 100%
rename from drivers/power/max14577_charger.c
rename to drivers/power/supply/max14577_charger.c
diff --git a/drivers/power/max17040_battery.c b/drivers/power/supply/max17040_battery.c
similarity index 100%
rename from drivers/power/max17040_battery.c
rename to drivers/power/supply/max17040_battery.c
diff --git a/drivers/power/max17042_battery.c b/drivers/power/supply/max17042_battery.c
similarity index 100%
rename from drivers/power/max17042_battery.c
rename to drivers/power/supply/max17042_battery.c
diff --git a/drivers/power/max8903_charger.c b/drivers/power/supply/max8903_charger.c
similarity index 100%
rename from drivers/power/max8903_charger.c
rename to drivers/power/supply/max8903_charger.c
diff --git a/drivers/power/max8925_power.c b/drivers/power/supply/max8925_power.c
similarity index 100%
rename from drivers/power/max8925_power.c
rename to drivers/power/supply/max8925_power.c
diff --git a/drivers/power/max8997_charger.c b/drivers/power/supply/max8997_charger.c
similarity index 100%
rename from drivers/power/max8997_charger.c
rename to drivers/power/supply/max8997_charger.c
diff --git a/drivers/power/max8998_charger.c b/drivers/power/supply/max8998_charger.c
similarity index 100%
rename from drivers/power/max8998_charger.c
rename to drivers/power/supply/max8998_charger.c
diff --git a/drivers/power/olpc_battery.c b/drivers/power/supply/olpc_battery.c
similarity index 100%
rename from drivers/power/olpc_battery.c
rename to drivers/power/supply/olpc_battery.c
diff --git a/drivers/power/pcf50633-charger.c b/drivers/power/supply/pcf50633-charger.c
similarity index 100%
rename from drivers/power/pcf50633-charger.c
rename to drivers/power/supply/pcf50633-charger.c
diff --git a/drivers/power/pda_power.c b/drivers/power/supply/pda_power.c
similarity index 100%
rename from drivers/power/pda_power.c
rename to drivers/power/supply/pda_power.c
diff --git a/drivers/power/pm2301_charger.c b/drivers/power/supply/pm2301_charger.c
similarity index 100%
rename from drivers/power/pm2301_charger.c
rename to drivers/power/supply/pm2301_charger.c
diff --git a/drivers/power/pm2301_charger.h b/drivers/power/supply/pm2301_charger.h
similarity index 100%
rename from drivers/power/pm2301_charger.h
rename to drivers/power/supply/pm2301_charger.h
diff --git a/drivers/power/pmu_battery.c b/drivers/power/supply/pmu_battery.c
similarity index 100%
rename from drivers/power/pmu_battery.c
rename to drivers/power/supply/pmu_battery.c
diff --git a/drivers/power/power_supply.h b/drivers/power/supply/power_supply.h
similarity index 100%
rename from drivers/power/power_supply.h
rename to drivers/power/supply/power_supply.h
diff --git a/drivers/power/power_supply_core.c b/drivers/power/supply/power_supply_core.c
similarity index 100%
rename from drivers/power/power_supply_core.c
rename to drivers/power/supply/power_supply_core.c
diff --git a/drivers/power/power_supply_leds.c b/drivers/power/supply/power_supply_leds.c
similarity index 100%
rename from drivers/power/power_supply_leds.c
rename to drivers/power/supply/power_supply_leds.c
diff --git a/drivers/power/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
similarity index 100%
rename from drivers/power/power_supply_sysfs.c
rename to drivers/power/supply/power_supply_sysfs.c
diff --git a/drivers/power/rx51_battery.c b/drivers/power/supply/rx51_battery.c
similarity index 100%
rename from drivers/power/rx51_battery.c
rename to drivers/power/supply/rx51_battery.c
diff --git a/drivers/power/s3c_adc_battery.c b/drivers/power/supply/s3c_adc_battery.c
similarity index 100%
rename from drivers/power/s3c_adc_battery.c
rename to drivers/power/supply/s3c_adc_battery.c
diff --git a/drivers/power/sbs-battery.c b/drivers/power/supply/sbs-battery.c
similarity index 100%
rename from drivers/power/sbs-battery.c
rename to drivers/power/supply/sbs-battery.c
diff --git a/drivers/power/smb347-charger.c b/drivers/power/supply/smb347-charger.c
similarity index 100%
rename from drivers/power/smb347-charger.c
rename to drivers/power/supply/smb347-charger.c
diff --git a/drivers/power/test_power.c b/drivers/power/supply/test_power.c
similarity index 100%
rename from drivers/power/test_power.c
rename to drivers/power/supply/test_power.c
diff --git a/drivers/power/tosa_battery.c b/drivers/power/supply/tosa_battery.c
similarity index 100%
rename from drivers/power/tosa_battery.c
rename to drivers/power/supply/tosa_battery.c
diff --git a/drivers/power/tps65090-charger.c b/drivers/power/supply/tps65090-charger.c
similarity index 100%
rename from drivers/power/tps65090-charger.c
rename to drivers/power/supply/tps65090-charger.c
diff --git a/drivers/power/twl4030_charger.c b/drivers/power/supply/twl4030_charger.c
similarity index 100%
rename from drivers/power/twl4030_charger.c
rename to drivers/power/supply/twl4030_charger.c
diff --git a/drivers/power/twl4030_madc_battery.c b/drivers/power/supply/twl4030_madc_battery.c
similarity index 100%
rename from drivers/power/twl4030_madc_battery.c
rename to drivers/power/supply/twl4030_madc_battery.c
diff --git a/drivers/power/wm831x_backup.c b/drivers/power/supply/wm831x_backup.c
similarity index 100%
rename from drivers/power/wm831x_backup.c
rename to drivers/power/supply/wm831x_backup.c
diff --git a/drivers/power/wm831x_power.c b/drivers/power/supply/wm831x_power.c
similarity index 100%
rename from drivers/power/wm831x_power.c
rename to drivers/power/supply/wm831x_power.c
diff --git a/drivers/power/wm8350_power.c b/drivers/power/supply/wm8350_power.c
similarity index 100%
rename from drivers/power/wm8350_power.c
rename to drivers/power/supply/wm8350_power.c
diff --git a/drivers/power/wm97xx_battery.c b/drivers/power/supply/wm97xx_battery.c
similarity index 100%
rename from drivers/power/wm97xx_battery.c
rename to drivers/power/supply/wm97xx_battery.c
diff --git a/drivers/power/z2_battery.c b/drivers/power/supply/z2_battery.c
similarity index 100%
rename from drivers/power/z2_battery.c
rename to drivers/power/supply/z2_battery.c
-- 
2.0.1
