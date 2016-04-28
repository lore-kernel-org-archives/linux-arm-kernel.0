From: vz@mleia.com (Vladimir Zapolskiy)
Date: Thu, 28 Apr 2016 03:11:44 +0300
Subject: NXP LPC32xx DT Updates for v4.7
Message-ID: <57215540.7060706@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof, Kevin,

please consider to include NXP LPC32xx device tree updates for v4.7.

I'm adding an official LPC32xx maintainer Roland to Cc, however
he seems to be unresponsive for a quite long time.

Thank you in advance.


The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  git://github.com/vzapolskiy/linux-lpc32xx.git tags/lpc32xx-dt-4.7

for you to fetch changes up to 3ff11fe8e8195d87090df9ffabfc85b4d35054c2:

  ARM: dts: lpc32xx: phy3250: add SoC name prefix to board dts file (2016-04-28 00:40:48 +0300)

----------------------------------------------------------------
NXP LPC32xx device tree updates for v4.7

This includes a few functional changes:
* new representation of MIC, SIC1 and SIC2 interrupt controllers,
* disabled by default SPI1, SPI2, SSP0 and SSP1 SPI controllers in
  shared lpc32xx.dtsi file,
* added clock sources for SPI1 and SPI2,
* set default clock rate of HCLK PLL to main osc rate multiplied by 16.

Also there are some non-functional changes:
* flatten board DTS files by exploiting device node labels,
* add 'partitions' device node for NAND SLC / MTD OF,
* correct Atmel vendor prefix to describe on board AT24 EEPROMs,
* rename board DTS files by adding SoC name prefix.

Since now DTS files of LPC32xx boards match "^lpc32[2345]0-" pattern.

----------------------------------------------------------------
Sylvain Lemieux (3):
      ARM: dts: lpc32xx: add clock properties to spi nodes
      ARM: dts: phy3250: enable ssp0
      ARM: dts: lpc32xx: disabled ssp0/spi1 & ssp1/spi2 by default

Vladimir Zapolskiy (10):
      ARM: dts: lpc32xx: set default clock rate of HCLK PLL
      dt-bindings: interrupt-controllers: add description of SIC1 and SIC2
      ARM: dts: lpc32xx: reparent SIC1 and SIC2 interrupts from MIC
      ARM: dts: lpc32xx: ea3250: avoid extension of device nodes by absolute path
      ARM: dts: lpc32xx: ea3250: add NAND partitions device node
      ARM: dts: lpc32xx: ea3250: fix Atmel at24 eeprom vendor
      ARM: dts: lpc32xx: ea3250: add SoC name prefix to board dts file
      ARM: dts: lpc32xx: phy3250: avoid extension of device nodes by absolute path
      ARM: dts: lpc32xx: phy3250: add NAND partitions device node
      ARM: dts: lpc32xx: phy3250: add SoC name prefix to board dts file

 .../interrupt-controller/nxp,lpc3220-mic.txt       |  70 ++++---
 arch/arm/boot/dts/Makefile                         |   3 +-
 .../boot/dts/{ea3250.dts => lpc3250-ea3250.dts}    | 230 ++++++++++-----------
 arch/arm/boot/dts/lpc3250-phy3250.dts              | 226 ++++++++++++++++++++
 arch/arm/boot/dts/lpc32xx.dtsi                     |  77 +++++--
 arch/arm/boot/dts/phy3250.dts                      | 227 --------------------
 6 files changed, 447 insertions(+), 386 deletions(-)
 rename arch/arm/boot/dts/{ea3250.dts => lpc3250-ea3250.dts} (61%)
 create mode 100644 arch/arm/boot/dts/lpc3250-phy3250.dts
 delete mode 100644 arch/arm/boot/dts/phy3250.dts
