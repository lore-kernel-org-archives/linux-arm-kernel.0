From: tony@atomide.com (Tony Lindgren)
Date: Tue, 24 Feb 2015 12:52:20 -0800
Subject: [GIT PULL] omap fixes against v4.0-rc1
Message-ID: <20150224205219.GM11056@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539:

  Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/fixes-v4.0-rc1

for you to fetch changes up to 67fd14b3eca63b14429350e9eadc5fab709a8821:

  ARM: dts: am335x-bone*: usb0 is hardwired for peripheral (2015-02-24 10:35:44 -0800)

----------------------------------------------------------------
Fixes for various omap devices. It's all dts and defconfig
changes for this set:

- Fix wrong DMA properties for dma to avoid them getting
  copied wrong again before we start actually using them

- USB fixes to revert the extcon changes as the driver did not
  get merged yet and cause issues

- Omap5 and dra7 fixes to boot from sata

- Fix few am437x issues for i2c and pinctrl

- Fix beaglebone for hardwared USB configuration

- Defconfig changes for NAND, SATA and TPS62362

- Fix n900 i2c numbering for legacy user space and smc91x
  register offset so it works also for qemu

- Fix incomplete USB configuration for dm816x

----------------------------------------------------------------
Felipe Balbi (3):
      ARM: dts: am437x-idk: fix TPS62362 i2c bus
      ARM: omap2plus_defconfig: enable TPS62362 regulator
      ARM: dts: am437x-idk: fix sleep pinctrl state

Ivaylo Dimitrov (1):
      ARM: dts: n900: fix i2c bus numbering

Pali Roh?r (1):
      ARM: dts: n900: Fix offset for smc91x ethernet

Peter Ujfalusi (5):
      ARM: dts: omap2: Correct the dma controller's property names
      ARM: dts: omap3: Correct the dma controller's property names
      ARM: dts: omap4: Correct the dma controller's property names
      ARM: dts: omap5: Correct the dma controller's property names
      ARM: dts: dra7: Correct the dma controller's property names

Robert Nelson (1):
      ARM: dts: am335x-bone*: usb0 is hardwired for peripheral

Roger Quadros (5):
      ARM: dts: DRA7: Fix SATA PHY node
      ARM: dts: OMAP5: Fix SATA PHY node
      ARM: omap2plus_defconfig: Enable OMAP NAND BCH driver
      ARM: omap2plus_defconfig: Fix SATA boot
      ARM: dts: dra7x-evm: beagle-x15: Fix USB Host

Tony Lindgren (1):
      ARM: dts: Fix USB dts configuration for dm816x

 arch/arm/boot/dts/am335x-bone-common.dtsi |  1 +
 arch/arm/boot/dts/am437x-idk-evm.dts      | 25 ++---------------------
 arch/arm/boot/dts/am57xx-beagle-x15.dts   |  8 --------
 arch/arm/boot/dts/dm8168-evm.dts          | 25 +++++++++++++++++++++++
 arch/arm/boot/dts/dm816x.dtsi             | 34 +++++++++++++++++++++++++++----
 arch/arm/boot/dts/dra7-evm.dts            |  8 --------
 arch/arm/boot/dts/dra7.dtsi               |  8 ++++----
 arch/arm/boot/dts/dra72-evm.dts           |  8 --------
 arch/arm/boot/dts/omap2.dtsi              |  4 ++--
 arch/arm/boot/dts/omap3-n900.dts          |  9 +++++++-
 arch/arm/boot/dts/omap3.dtsi              |  4 ++--
 arch/arm/boot/dts/omap4.dtsi              |  4 ++--
 arch/arm/boot/dts/omap5.dtsi              |  8 ++++----
 arch/arm/configs/omap2plus_defconfig      |  4 +++-
 14 files changed, 83 insertions(+), 67 deletions(-)
