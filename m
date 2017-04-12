From: joel@jms.id.au (Joel Stanley)
Date: Wed, 12 Apr 2017 12:29:12 +0930
Subject: [GIT PULL] ARM: aspeed: devicetree for 4.12
Message-ID: <CACPK8Xfp+x=MGtj-eOjdU+jSgkriJ1uG8LnP4=OB97pLdbO4Vw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Arnd, Olof,

These are the Aspeed devicetree changes for 4.12.

The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joel/aspeed.git
tags/aspeed-4.12-devicetree

for you to fetch changes up to 78a2569fa60497347babeddb24a367946e258283:

  arm: dts: aspeed: Describe ADCs for AST2400/AST2500 (2017-04-07
13:09:47 +0930)

----------------------------------------------------------------
Aspeed devicetree updates for 4.12

Updates to the device tree to include upstreamed drivers:

 - SPI flash controller
 - Watchdog
 - ADC

In addition we describe some of the clocks so that upstream kernels can
boot on hardware.

----------------------------------------------------------------
C?dric Le Goater (3):
      ARM: dts: aspeed: add SPI controller bindings
      ARM: dts: aspeed: Add SPI controller bindings to Romulus
      ARM: dts: aspeed: Add a fastread property

Joel Stanley (3):
      ARM: dts: aspeed: Make G5 clocks fixed
      ARM: dts: aspeed: Make G4 clocks fixed
      ARM: dts: aspeed: Update watchdog compatible strings

Lei YU (1):
      ARM: dts: aspeed: romulus: Add UART1

Rick Altherr (1):
      arm: dts: aspeed: Describe ADCs for AST2400/AST2500

 arch/arm/boot/dts/aspeed-ast2500-evb.dts      |  22 ++++
 arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts |  18 +++
 arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts  |  36 ++++++
 arch/arm/boot/dts/aspeed-g4.dtsi              | 109 +++++++++++++-----
 arch/arm/boot/dts/aspeed-g5.dtsi              | 156 +++++++++++++++++++-------
 5 files changed, 271 insertions(+), 70 deletions(-)
