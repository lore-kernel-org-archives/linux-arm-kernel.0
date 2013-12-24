From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Tue, 24 Dec 2013 10:33:41 +0800
Subject: [PATCH v5 0/3] regulator: act8865: add PMIC driver
Message-ID: <1387852421-18033-1-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

Thanks a lot.

Since there is no seperate voltage registers for the suspend operations
in the act8865, so remove this operation. 

The patch set is to add act8865 PMIC driver.

The active-semi act8865 is designed as a PMIC for Atmel sama5d3x and at91sam9 series.
Its datasheet is available at: http://www.active-semi.com/sheets/ACT8865_Datasheet.pdf.

The patches is based on the branch: for-next of git respository, 
	git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git
and [PATCH] regulator: read low power states configuration from device tree from Vincent Palatin
	https://patchwork.kernel.org/patch/2833667/

Thanks.

Best Regards,
Wenyou Yang

v5 changelog:
 1./ Remove .set_suspend_voltage operation.

v4 changelog:
 1./ Using linear ranges with a plural, instead of table.

v3 changelog:
 1./ Add map_voltage() operation which missed.
 2./ Remove regulator_unregister statement which no need.
 3./ Remvoe memset statement.
 4./ Change the device tree regulator-name with the supply name in the schematic.
 5./ List all theregulator name in the binding doc.

v2 changelog:
 1./ Using regmap for register I/O instead of i2c function directly.
 2./ Using the helpers provided by the core.
 3./ Remove noisy logging.
 4./ Using the latest regulator register API.
 5./ Using module_i2c_driver helper macro replace module_init and module_exit.
 6./ Remove the vsel-state-low dt property which is not used now.


Wenyou Yang (3):
  regulator: act8865: add PMIC act8865 driver
  regulator: act8865: add device tree binding doc
  ARM: dts: sama5d3xcm: add the regulator device node

 .../bindings/regulator/act8865-regulator.txt       |   60 ++++
 .../devicetree/bindings/vendor-prefixes.txt        |    1 +
 arch/arm/boot/dts/sama5d3xcm.dtsi                  |   46 +++
 drivers/regulator/Kconfig                          |    8 +
 drivers/regulator/Makefile                         |    1 +
 drivers/regulator/act8865-regulator.c              |  368 ++++++++++++++++++++
 include/linux/regulator/act8865.h                  |   53 +++
 7 files changed, 537 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/act8865-regulator.txt
 create mode 100644 drivers/regulator/act8865-regulator.c
 create mode 100644 include/linux/regulator/act8865.h

-- 
1.7.9.5
