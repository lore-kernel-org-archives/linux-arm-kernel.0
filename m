From: joel@jms.id.au (Joel Stanley)
Date: Thu, 26 Jul 2018 14:00:49 +0930
Subject: [GIT PULL] ARM: aspeed: dts changes for 4.19
Message-ID: <CACPK8Xeu2JAVBTyiUtyso1egbe3X+r5a--Cx30YDJV-JmK==DQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello ARM Maintainers,

Here are the ASPEED device tree updates for 4.19. No new machines this time
around, but we now have some FSI (the bus between the BMC and the PowerPC host)
descriptions, and USB support.

The following changes since commit 7daf201d7fe8334e2d2364d4e8ed3394ec9af819:

  Linux 4.18-rc2 (2018-06-24 20:54:29 +0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joel/aspeed.git
tags/aspeed-4.19-devicetree

for you to fetch changes up to 19617a35b08379b3e6da0a4ee0d2d62645bf1b9e:

  ARM: dts: aspeed: Add Power9 CFAM description (2018-07-25 17:43:36 +0930)

----------------------------------------------------------------
ASPEED device tree updates for 4.19

 - New support for the ASPEED USB host controller and USB vhub (device)
 support

 - Descriptions for the FSI bus and hardware inside the Power8/Power9
 processors that are accessed over this bus. This includes the ColdFire
 processor that is part of the ASPEED SoC and is used to offload the FSI
 bit-banging

 - Small fixes:
  * pwm/tach clock
  * Romulus framebuffer location

----------------------------------------------------------------
Benjamin Herrenschmidt (11):
      ARM: dts: aspeed: Add G4 USB pinmux
      ARM: dts: aspeed: Add G5 USB host pinmux
      ARM: dts: aspeed: Add G4 USB Virtual Hub
      ARM: dts: aspeed: Add G5 USB Virtual Hub
      ARM: dts: aspeed: Enable vhub on port A of AST2500 EVB
      ARM: dts: aspeed: Fix Romulus VGA frame buffer
      ARM: dts: aspeed: Add coprocessor interrupt controller
      ARM: dts: aspeed: Romulus system can use coprocessor for FSI
      ARM: dts: aspeed: Palmetto system can use coprocessor for FSI
      ARM: dts: aspeed: Add Power8 CFAM description for use by Palmetto
      ARM: dts: aspeed: Add Power9 CFAM description

Lei YU (1):
      ARM: dts: aspeed: Use 24MHz fixed clock for pwm

 arch/arm/boot/dts/aspeed-ast2500-evb.dts         |  14 +--
 arch/arm/boot/dts/aspeed-bmc-opp-lanyang.dts     |   1 +
 arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts    |  38 +++++++--
 arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts     |  17 +++-
 arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts |   2 +
 arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts       |   2 +
 arch/arm/boot/dts/aspeed-g4.dtsi                 |  26 +++++-
 arch/arm/boot/dts/aspeed-g5.dtsi                 |  34 +++++++-
 arch/arm/boot/dts/ibm-power8-cfam.dtsi           |  31 +++++++
 arch/arm/boot/dts/ibm-power9-cfam.dtsi           | 104 +++++++++++++++++++++++
 arch/arm/boot/dts/ibm-power9-dual.dtsi           |  57 +++++++++++++
 11 files changed, 305 insertions(+), 21 deletions(-)
 create mode 100644 arch/arm/boot/dts/ibm-power8-cfam.dtsi
 create mode 100644 arch/arm/boot/dts/ibm-power9-cfam.dtsi
 create mode 100644 arch/arm/boot/dts/ibm-power9-dual.dtsi
