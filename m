From: joel@jms.id.au (Joel Stanley)
Date: Wed, 3 Jan 2018 14:47:27 +1030
Subject: [GIT PULL] ARM: aspeed: dts changes for 4.16
Message-ID: <CACPK8XdOywvpyWqgOG6TVj4EwBqWA7yCmzaNqGQyvQJzPuseSg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello ARM maintainers,

Here are the ASPEED devicetree updates for 4.16.

They've had a run through a few next trees where Stephen noticed two minor
merge conflicts[1] that should be obvious to resolve, but please let me know if
you have concerns.

[1] https://lkml.org/lkml/2017/12/21/750

As discussed with Arnd, there is a commit for a clock header in
include/dt-bindings
that is also being merged through the clk tree. This should require no special
attention.

Thanks!

The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:

  Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joel/aspeed.git
tags/aspeed-4.16-devicetree

for you to fetch changes up to e40ed274489a5f516da120186578eb379b452ac6:

  ARM: dts: aspeed-evb: Add unit name to memory node (2017-12-21 14:03:22 +1030)

----------------------------------------------------------------
ASPEED device tree updates for 4.16

Clock driver support:

 Rework all platforms to use proper clock bindings. Linux should now boot
 upstream kernels on ast2400 and ast2500 platforms without out of tree
 patches.

New systems:

 Witherspoon: OpenPower Power9 server manufactured by IBM that uses
the ASPEED ast2500
 Zaius: OpenPower Power9 server manufactured by Invatech that uses the
ASPEED ast2500
 Q71L: Intel Xeon server manufactured by Qanta that uses the ASPEED ast2400

 We also see updates to the Palmetto and Romulus systems to bring them in
 line with the functionality of those above.

 The systems take advantage of recently added drivers for LPC Snoop
 device and the PWM/Tachometer fan controller.

OpenBMC flash layout:

 The flash layout used OpenBMC systems is added and the device trees now
 use it.

----------------------------------------------------------------
Andrew Jeffery (1):
      ARM: dts: aspeed: Add LPC and child devices

Joel Stanley (17):
      dt-bindings: clock: Add ASPEED constants
      dt-bindings: gpio: Add ASPEED constants
      ARM: dts: aspeed: Add proper clock references
      ARM: dts: aspeed: Add MAC clocks
      ARM: dts: aspeed: Add watchdog clocks
      ARM: dts: aspeed: Add flash controller clocks
      ARM: dts: aspeed: Add clock phandle to GPIO
      ARM: dts: aspeed: Add PWM and tachometer node
      ARM: dts: aspeed: Add LPC Snoop device
      ARM: dts: aspeed: Remove skeleton.dtsi
      ARM: dts: aspeed: Update license headers
      ARM: dts: Add OpenBMC flash layout
      ARM: dts: aspeed: Sort ASPEED entries in makefile
      ARM: dts: aspeed: Add Witherspoon BMC machine
      ARM: dts: aspeed-romulus: Update Romulus system
      ARM: dts: aspeed-plametto: Add flash layout and fix memory node
      ARM: dts: aspeed-evb: Add unit name to memory node

Rick Altherr (1):
      ARM: dts: aspeed: Add Qanta Q71L BMC machine

Xo Wang (1):
      ARM: dts: aspeed: Add Ingrasys Zaius BMC machine

 arch/arm/boot/dts/Makefile                       |   8 +-
 arch/arm/boot/dts/aspeed-ast2500-evb.dts         |   4 +-
 arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts    |   5 +-
 arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts     | 135 +++++-
 arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts | 548 +++++++++++++++++++++++
 arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts       | 426 ++++++++++++++++++
 arch/arm/boot/dts/aspeed-bmc-quanta-q71l.dts     | 458 +++++++++++++++++++
 arch/arm/boot/dts/aspeed-g4.dtsi                 | 165 ++++---
 arch/arm/boot/dts/aspeed-g5.dtsi                 | 156 ++++---
 arch/arm/boot/dts/openbmc-flash-layout.dtsi      |  32 ++
 include/dt-bindings/clock/aspeed-clock.h         |  52 +++
 include/dt-bindings/gpio/aspeed-gpio.h           |  49 ++
 12 files changed, 1888 insertions(+), 150 deletions(-)
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-quanta-q71l.dts
 create mode 100644 arch/arm/boot/dts/openbmc-flash-layout.dtsi
 create mode 100644 include/dt-bindings/clock/aspeed-clock.h
 create mode 100644 include/dt-bindings/gpio/aspeed-gpio.h
