From: manishv.b@ti.com (Vishwanathrao Badarkhe, Manish)
Date: Thu, 7 Mar 2013 11:56:19 +0530
Subject: [RESEND 0/2] davinci: Add device tree data for tps6507x.
Message-ID: <1362637581-12673-1-git-send-email-manishv.b@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device tree data for regulator via tps6507x mfd device 
in da850-evm.
Applies on top of v3.9-rc1 of linus tree.

Tested on da850-evm device.

Test procedure followed as below:
Once device boots up, issue command as:

$for reg in /sys/class/regulator/*; do echo $reg `cat $reg/name`
 `cat $reg/state` `cat $reg/microvolts`; done

This command will print all available regulators with its name,
status (enabled/disabled) and voltages(in microvolts) like as below:
/sys/class/regulator/regulator.1 VDCDC1_3.3V enabled 3300000
/sys/class/regulator/regulator.2 VDCDC2_3.3V enabled 3300000
/sys/class/regulator/regulator.3 VDCDC3_1.2V enabled 1200000
/sys/class/regulator/regulator.4 LDO1_1.8V enabled 1800000
/sys/class/regulator/regulator.5 LDO2_1.2V enabled 1200000

Note: Some of patches in this series are already accepted and 
residing in v3.9-rc1 kernel. These patches are as follows:

1. mfd: tps6507x: add device-tree support.
2. regulator: tps6507x: add device tree support. 
3. ARM: davinci: da850: add DT node for I2C0. 

Vishwanathrao Badarkhe, Manish (2):
  ARM: regulator: add tps6507x device tree data
  ARM: davinci: da850: add tps6507x regulator DT data

 arch/arm/boot/dts/da850-evm.dts |   63 +++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/tps6507x.dtsi |   47 +++++++++++++++++++++++++++++
 2 files changed, 110 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/tps6507x.dtsi

-- 
1.7.4.1
