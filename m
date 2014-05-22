From: ivan.khoronzhuk@ti.com (Ivan Khoronzhuk)
Date: Thu, 22 May 2014 16:48:29 +0300
Subject: [Patch v5 0/7] Introduce keystone reset driver
Message-ID: <1400766516-14537-1-git-send-email-ivan.khoronzhuk@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches introduce keystone reset driver.

The keystone SoC can be rebooted in several ways. By external reset
pin, by soft and by watchdogs. This driver allows software reset and reset
by one of the watchdogs. Also added opportunity to set soft/hard reset type.

Based on linux-next/master

v5..v4
  power: reset: keystone-reset: introduce keystone reset driver
  	- changed to get rsmux and rspll offsets from DT
  clock: keystone-pllctrl: add bindings for keystone pll controller
  	- new patch
  mfd: ti-keystone-devctrl: add bindings for device state control
  	- new patch
  power: reset: add bindings for keystone reset driver
  	- corrected description of "ti,syscon-pll", "ti,syscon-dev" properties
	- corrected examples
  ARM: dts: keystone: update reset node to work with reset driver
  	- added nodes for pll-controller and device-state-controll
	- added offsets to "ti,syscon-pll", "ti,syscon-dev" properties

v4..v3
  Power: reset: keystone-reset: introduce keystone reset driver
  	- changed to use syscon framework
  	- changed to use regmap to access registers
  Power: reset: add bindings for keystone reset driver
  	- deleted properties "reg", "reg-names"
	- added properties "ti,syscon-pll", "ti,syscon-dev"
  ARM: dts: keystone: update reset node to work with reset driver
  	- deleted properties "reg", "reg-names"
	- added properties "ti,syscon-pll", "ti,syscon-dev"

v2..v3
  Power: reset: keystone-reset: introduce keystone reset driver
	- no functional changes, only sanity
  Power: reset: add bindings for keystone reset driver
  	- corrected WDT numeration in examples
	- extended description of wdt_list property

v1..v2
	- re based on v3.15-rc1 without changes

Ivan Khoronzhuk (7):
  power: reset: keystone-reset: introduce keystone reset driver
  clock: keystone-pllctrl: add bindings for keystone pll controller
  mfd: ti-keystone-devctrl: add bindings for device state control
  power: reset: add bindings for keystone reset driver
  ARM: keystone: remove redundant reset stuff
  ARM: dts: keystone: update reset node to work with reset driver
  ARM: keystone: enable reset driver support

 .../bindings/clock/ti-keystone-pllctrl.txt         |  20 +++
 .../bindings/mfd/ti-keystone-devctrl.txt           |  19 +++
 .../bindings/power/reset/keystone-reset.txt        |  67 +++++++++
 arch/arm/boot/dts/keystone.dtsi                    |  14 +-
 arch/arm/configs/keystone_defconfig                |   3 +
 arch/arm/mach-keystone/keystone.c                  |  34 -----
 drivers/power/reset/Kconfig                        |   8 +
 drivers/power/reset/Makefile                       |   1 +
 drivers/power/reset/keystone-reset.c               | 166 +++++++++++++++++++++
 9 files changed, 297 insertions(+), 35 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/ti-keystone-pllctrl.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/ti-keystone-devctrl.txt
 create mode 100644 Documentation/devicetree/bindings/power/reset/keystone-reset.txt
 create mode 100644 drivers/power/reset/keystone-reset.c

-- 
1.8.3.2
