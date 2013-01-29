From: manishv.b@ti.com (Vishwanathrao Badarkhe, Manish)
Date: Tue, 29 Jan 2013 13:08:48 +0530
Subject: [PATCH V2 0/6] davinci: DT support for i2c0 and tps6507x
Message-ID: <1359445134-13323-1-git-send-email-manishv.b@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series enables device tree support for I2C0
and for regulator via tps6507x mfd device on da850-evm.

Applies on top of v3.8-rc5 of linus tree.

Tested on da850-evm device.

Test procedure followed as below:
Once device boots up, issue command as:

$for reg in /sys/class/regulator/*; do echo $reg `cat $reg/name`
 `cat $reg/state` `cat $reg/microvolts`; done

Depends on:
 - ARM: davinci: da850: add interrupt-parent property in soc node
   https://patchwork.kernel.org/patch/2044101/
 - ARM: davinci: da850: add pinctrl support
   http://comments.gmane.org/gmane.linux.davinci/25993

Changes since V1:
 - Updated i2c0 node name in da850 dts and dtsi file.
 - Removed interrupt parent from i2c0 node.
 - Updated name for da850 auxdata lookup.
 - Added a patch in series to update pin control driver
   registration.

Vishwanathrao Badarkhe, Manish (6):
  pinctrl: pinctrl-single: use arch_initcall and module_exit
  ARM: davinci: da850: add OF_DEV_AUXDATA entry for I2C0
  ARM: davinci: da850: add DT node for I2C0
  mfd: tps6507x: add device-tree support.
  ARM: regulator: add tps6507x device tree data
  ARM: davinci: da850: add tps6507x regulator DT data

 arch/arm/boot/dts/da850-evm.dts  |   68 ++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/da850.dtsi     |   15 ++++++++
 arch/arm/boot/dts/tps6507x.dtsi  |   47 ++++++++++++++++++++++++++
 arch/arm/mach-davinci/da8xx-dt.c |    8 ++++-
 drivers/mfd/tps6507x.c           |    9 +++++
 drivers/pinctrl/pinctrl-single.c |   12 ++++++-
 6 files changed, 157 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/boot/dts/tps6507x.dtsi

-- 
1.7.4.1
