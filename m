From: tony@atomide.com (Tony Lindgren)
Date: Mon, 22 Feb 2016 13:56:12 -0800
Subject: [GIT PULL] omap device tree changes for v4.6 merge window, part 1
Message-ID: <20160222215612.GV13417@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:

  Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.6/dt-pt1

for you to fetch changes up to b9d3ec1d98c658226606e66e55c940491447e617:

  ARM: dts: am57xx-beagle-x15: Add eeprom information (2016-02-22 11:18:40 -0800)

----------------------------------------------------------------
Device tree changes for omaps for v4.6 merge window. Mostly just
adding board specific devices and few new boards:

- N900 improvments for adp1653 and gpio keys

- Add missing bandgap data for omap3

- Add more devices for compulab cm-t335

- Add n950 WLAN support, enable modem, add pinctrl for SSI

- Correct dm814x and dra62x auxclk rate, add support for GPMC and NAND

- Add syscon node for PHY's on dra7

- Add support more devices on logicpd torpedo

- Add USB host support for igep and specify boot console

- Fix audio clock for am335x-sl50 and specify boot console

- Remove deprecated tx-fifo-resize for dwc3 that was only used on
  omap5 es1.0

- Add dra7 thermal data

- Update am43x-epos-evm compatible string to am438

- Add support for logicpd dm3730 som-lv

----------------------------------------------------------------
Adam Ford (8):
      ARM: dts: LogicPD Torpedo: Add MT9P031 Support
      ARM: dts: LogicPD Torpedo: Add AT24 EEPROM Support
      ARM: dts: LogicPD Torpedo: Fix Panel Sleep
      ARM: dts: LogicPD Torpedo: Add SPI EEPROM
      ARM: dts: LogicPD Torpedo: Set HSUSB0 Pin Mux
      ARM: dts: omap3logic: Add PWM-Backlight
      ARM: DTS: Add minimal Support for Logic PD DM3730 SOM-LV
      ARM: dts: Add HSUSB2 EHCI Support to Logic PD DM37xx SOM-LV

Enric Balletbo i Serra (3):
      ARM: dts: igep00x0: Specify the device to be used for boot console output.
      ARM: dts: am335x-sl50: Specify the device to be used for boot console output.
      ARM: dts: am335x-sl50: Fix audio codec setup.

Felipe Balbi (1):
      ARM: dts: remove deprecated property dwc3

Ivaylo Dimitrov (1):
      ARM: dts: omap3-n900: Allow gpio keys to be disabled

Keerthy (4):
      ARM: dts: DRA7: Add DSPEVE thermal data
      ARM: dts: DRA7: Add IVA thermal data
      ARM: dts: DRA7: Add missing IVA and DSPEVE thermal domain data
      ARM: dts: am43x-epos-evm: Add the am438 compatible string

Kishon Vijay Abraham I (4):
      ARM: dts: dra7: Add dt node for the sycon pcie
      ARM: dts: dra7: Use "syscon-phy-power" and "syscon-pcs" in PCIe PHY node
      ARM: dts: dra7: Use "ti,dra7x-usb2-phy2" compatible string for USB2 PHY2
      ARM: dts: am4372/dra7/omap5: Use "syscon-phy-power" instead of "ctrl-module"

Nishanth Menon (1):
      ARM: dts: am57xx-beagle-x15: Add eeprom information

Pali Roh?r (3):
      ARM: dts: n900: Include adp1653 device
      ARM: dts: omap3: Include missing bandgap data for ti-soc-thermal driver
      ARM: dts: n900: Use linux input defines instead hardcoded constants

Pau Pajuel (1):
      ARM: dts: omap3-igep0030-common: Add USB Host support

Sebastian Reichel (4):
      ARM: dts: N950: Add wlan support
      ARM: dts: OMAP3-N950-N9: Enable SSI module
      ARM: dts: OMAP3-N950-N9: Enable modem
      ARM: dts: OMAP3-N950-N9: Add ssi idle pinctrl state

Tony Lindgren (5):
      ARM: dts: The rate for auxclk is 22.59792 by default
      ARM: dts: Add support for GPMC for dm814x and dra62x
      ARM: dts: Add NAND support for j5-eco evm
      ARM: dts: Add NAND support for dm8148-evm
      Merge branch 'n900-keys' into omap-for-v4.6/dt

Uri Mashiach (4):
      ARM: dts: cm-t335: Add support for CAN bus
      ARM: dts: cm-t335: add touchscreen support
      ARM: dts: cm-t335: add audio support
      ARM: dts: add spi wifi support to cm-t335

 .../devicetree/bindings/arm/omap/omap.txt          |   2 +-
 arch/arm/boot/dts/am335x-cm-t335.dts               | 171 +++++++++++++
 arch/arm/boot/dts/am335x-sl50.dts                  |  24 +-
 arch/arm/boot/dts/am4372.dtsi                      |  16 +-
 arch/arm/boot/dts/am43x-epos-evm.dts               |   2 +-
 arch/arm/boot/dts/am57xx-beagle-x15.dts            |   5 +
 arch/arm/boot/dts/dm8148-evm.dts                   |  56 +++++
 arch/arm/boot/dts/dm814x-clocks.dtsi               |   4 +-
 arch/arm/boot/dts/dm814x.dtsi                      |  12 +
 arch/arm/boot/dts/dra62x-j5eco-evm.dts             |  56 +++++
 arch/arm/boot/dts/dra7-dspeve-thermal.dtsi         |  27 +++
 arch/arm/boot/dts/dra7-iva-thermal.dtsi            |  27 +++
 arch/arm/boot/dts/dra7.dtsi                        |  80 ++----
 arch/arm/boot/dts/dra74x.dtsi                      |   1 -
 arch/arm/boot/dts/logicpd-som-lv-37xx-devkit.dts   | 268 +++++++++++++++++++++
 arch/arm/boot/dts/logicpd-som-lv.dtsi              | 265 ++++++++++++++++++++
 arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts  | 163 ++++++++++---
 arch/arm/boot/dts/logicpd-torpedo-som.dtsi         |  35 +++
 arch/arm/boot/dts/omap3-igep.dtsi                  |   4 +
 arch/arm/boot/dts/omap3-igep0030-common.dtsi       |  41 ++++
 arch/arm/boot/dts/omap3-n9.dts                     |   4 +
 arch/arm/boot/dts/omap3-n900.dts                   |  44 ++--
 arch/arm/boot/dts/omap3-n950-n9.dtsi               |  93 +++++++
 arch/arm/boot/dts/omap3-n950.dts                   |  33 +++
 arch/arm/boot/dts/omap34xx.dtsi                    |   6 +
 arch/arm/boot/dts/omap36xx.dtsi                    |   6 +
 arch/arm/boot/dts/omap5.dtsi                       |  27 +--
 27 files changed, 1324 insertions(+), 148 deletions(-)
 create mode 100644 arch/arm/boot/dts/dra7-dspeve-thermal.dtsi
 create mode 100644 arch/arm/boot/dts/dra7-iva-thermal.dtsi
 create mode 100644 arch/arm/boot/dts/logicpd-som-lv-37xx-devkit.dts
 create mode 100644 arch/arm/boot/dts/logicpd-som-lv.dtsi
