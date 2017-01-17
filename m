From: joel@jms.id.au (Joel Stanley)
Date: Wed, 18 Jan 2017 09:50:02 +1100
Subject: [GIT PULL] ARM: aspeed: devicetree for 4.11
Message-ID: <CACPK8XffqYCRipx+KzxyH0z-5=t53ezPjRv+MxOj7-tj2kbG2A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Arnd and Olof,

Please pull the Aspeed devicetree ...tree for 4.11.

The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:

  Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joel/aspeed.git
tags/aspeed-4.11-devicetree

for you to fetch changes up to 8f9bafbb92c0308cf8d33536803c822e14bed4d7:

  ARM: dts: aspeed: Add Romulus BMC platform (2017-01-10 21:55:46 +1100)

----------------------------------------------------------------
Aspeed devicetree updates for 4.11

This introduces the first OpenPower Power9 BMC system, Romulus. Romulus is
based on the ast2500 SoC from Aspeed.

These commits also add newly upstreamed drivers to the Palmetto BMC and ast2500
eval board. We now have working network, ipmi bt, gpio and pinmux on
all platforms.

  ARM: dts: aspeed: Add Romulus BMC platform
  ARM: dts: aspeed: Add ftgmac100 to g4 and g5 platforms
  ARM: dts: aspeed: Correct palmetto device tree
  ARM: dts: aspeed: Reserve framebuffer memory
  ARM: dts: aspeed-g5: Add gpio controller to devicetree
  ARM: dts: aspeed-g5: Add syscon and pin controller nodes
  ARM: dts: aspeed-g5: Add LPC Controller node
  ARM: dts: aspeed-g5: Add SoC Display Controller node
  ARM: dts: aspeed-g4: Add gpio controller to devicetree
  ARM: dts: aspeed-g4: Add syscon and pin controller nodes

----------------------------------------------------------------
Andrew Jeffery (6):
      ARM: dts: aspeed-g4: Add syscon and pin controller nodes
      ARM: dts: aspeed-g4: Add gpio controller to devicetree
      ARM: dts: aspeed-g5: Add SoC Display Controller node
      ARM: dts: aspeed-g5: Add LPC Controller node
      ARM: dts: aspeed-g5: Add syscon and pin controller nodes
      ARM: dts: aspeed-g5: Add gpio controller to devicetree

Cyril Bur (2):
      ARM: dts: aspeed: Reserve framebuffer memory
      ARM: dts: aspeed: Correct palmetto device tree

Joel Stanley (2):
      ARM: dts: aspeed: Add ftgmac100 to g4 and g5 platforms
      ARM: dts: aspeed: Add Romulus BMC platform

 arch/arm/boot/dts/Makefile                    |   1 +
 arch/arm/boot/dts/aspeed-ast2500-evb.dts      |  14 +
 arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts |  24 +-
 arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts  |  45 ++
 arch/arm/boot/dts/aspeed-g4.dtsi              | 776 +++++++++++++++++++++++
 arch/arm/boot/dts/aspeed-g5.dtsi              | 879 ++++++++++++++++++++++++++
 6 files changed, 1737 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts
