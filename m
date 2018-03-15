From: joel@jms.id.au (Joel Stanley)
Date: Thu, 15 Mar 2018 17:12:09 +1030
Subject: [GIT PULL] ARM: aspeed: dts changes for 4.17
Message-ID: <CACPK8Xfv2XnhGo9cmJC69suOu9+caOp5QoXuD5Xw-gznGP61Og@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello ARM maintainers,

Here are the ASPEED device tree updates for 4.17.

Thanks!

The following changes since commit 91ab883eb21325ad80f3473633f794c78ac87f51:

  Linux 4.16-rc2 (2018-02-18 17:29:42 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joel/aspeed.git
tags/aspeed-4.17-devicetree

for you to fetch changes up to 3719a1b130566cf91c3b3ec4707e1ed61bff6d54:

  ARM: dts: aspeed: Add Qualcomm Centriq 2400 REP BMC (2018-03-14
16:30:43 +1030)

----------------------------------------------------------------
ASPEED device tree updates for 4.17

Updates to OpenPower BMC systems:

 A number of updates to use recently merged drivers, including moving to
 upstreamed IPMI BT nodes, a temp sensor for Romulus, and adding
 simple-reset for UARTs.

 This includes more of Palmetto's device tree, so that it's ever so
 close to booting the host with an upstream kernel.

New machines:

 Add Qualcomm Centriq ARM64 server reference platform, which will run
 OpenBMC on an AST2500.

----------------------------------------------------------------
Andrew Jeffery (1):
      ARM: dts: palmetto: Request mux as per strapping configuration

Joel Stanley (9):
      ARM: dts: aspeed: Add IPMI BT node
      ARM: dts: aspeed: Enable IPMI BT node on OpenPower machines
      ARM: dts: aspeed-g5: Update LPC node
      ARM: dts: aspeed: Add LPC clock phandles
      ARM: dts: palmetto: Add LEDs and GPIO keys
      ARM: dts: aspeed: Add Palmetto GPIO hogs
      ARM: dts: aspeed: Add LPC reset controller node
      ARM: dts: palmetto: Enable rear UART
      ARM: dts: romulus: Remove MAX31785 device

Ken Chen (1):
      ARM: dts: aspeed: Add Qualcomm Centriq 2400 REP BMC

Lei YU (2):
      ARM: dts: aspeed: romulus: hog GPIOS7
      ARM: dts: aspeed: romulus: Add w83773g temp sensor

 arch/arm/boot/dts/Makefile                         |   1 +
 .../boot/dts/aspeed-bmc-arm-centriq2400-rep.dts    | 225 +++++++++++++++++++++
 arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts      | 206 +++++++++++++++++++
 arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts       |  16 +-
 arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts   |   4 +
 arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts         |   4 +
 arch/arm/boot/dts/aspeed-g4.dtsi                   |  18 ++
 arch/arm/boot/dts/aspeed-g5.dtsi                   |  25 ++-
 8 files changed, 492 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-arm-centriq2400-rep.dts
