From: joel@jms.id.au (Joel Stanley)
Date: Fri, 6 Oct 2017 16:35:19 +0930
Subject: [GIT PULL] ARM: dts: aspeed: Changes for v4.15
Message-ID: <CACPK8XdG=wjKuAJJ7yzu320UPxKAGA-A2DYtrL5=CwCN2DNpBg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello ARM SoC maintainers!

Here are some ASPEED device tree updates for v4.15.

Sadly our clk driver is still under review, so I have not been able to
include all of the patches I intended to. Alas, these improvements are
still useful.

Cheers,

Joel

The following changes since commit e19b205be43d11bff638cad4487008c48d21c103:

  Linux 4.14-rc2 (2017-09-24 16:38:56 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joel/aspeed.git
tags/aspeed-4.15-devicetree

for you to fetch changes up to 27b5e338d2153978aa1d4a01189bbd4713dab406:

  ARM: dts: aspeed-romulus: Enable VUART (2017-10-05 16:30:13 +1030)

----------------------------------------------------------------
ASPEED devicetree updates for 4.15

 - Cleanups of the ASPEED device trees
 - Enable the i2c bus on all platforms
 - Turn VUART on for BMC platforms
 - Bind watchdog two for compatilbiy with shipping u-boot

----------------------------------------------------------------
Andrew Jeffery (1):
      ARM: dts: aspeed: Move pinctrl subnodes to improve readability

Joel Stanley (12):
      ARM: dts: aspeed: Reorder ADC node
      ARM: dts: aspeed: Add I2C buses
      ARM: dts: aspeed-romulus: Add I2C devices
      ARM: dts: aspeed-palmetto: Add I2C devices
      ARM: dts: aspeed-ast2500: Add I2C devices
      ARM: dts: aspeed: Add aliases for UARTs
      ARM: dts: aspeed: Correctly order UART nodes
      ARM: dts: aspeed: Clean up UART nodes
      ARM: dts: aspeed: Remove undocumented wdt properties
      ARM: dts: aspeed: Enable watchdog two
      ARM: dts: aspeed-palmetto: Enable VUART
      ARM: dts: aspeed-romulus: Enable VUART

 arch/arm/boot/dts/aspeed-ast2500-evb.dts      |   19 +
 arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts |   56 +-
 arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts  |   58 +
 arch/arm/boot/dts/aspeed-g4.dtsi              | 1816 ++++++++++++++-----------
 arch/arm/boot/dts/aspeed-g5.dtsi              | 1806 +++++++++++++-----------
 5 files changed, 2199 insertions(+), 1556 deletions(-)
