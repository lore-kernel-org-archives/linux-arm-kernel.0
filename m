From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 17 Nov 2012 14:02:39 +0100
Subject: [PULL REQUEST] GPIO driver to turn power off
Message-ID: <20121117130239.GD11717@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jason

Here is a pull request for the GPIO power off driver.

Thanks
     Andrew

The following changes since commit 77b67063bb6bce6d475e910d3b886a606d0d91f7:

  Linux 3.7-rc5 (2012-11-11 13:44:33 +0100)

are available in the git repository at:

  git://github.com/lunn/linux.git tags/for-next-gpio-poweroff-v4

for you to fetch changes up to 7125ab6492a33c2a669892cae6f6d5b9643d9672:

  ARM: Kirkwood: Convert IB62x0 to use gpio-poweroff. (2012-11-17 13:37:51 +0100)

----------------------------------------------------------------
GPIO driver for turning board power off.

----------------------------------------------------------------
Andrew Lunn (2):
      ARM: Kirkwood: Convert DNSKW to use gpio-poweroff.
      ARM: Kirkwood: Convert IB62x0 to use gpio-poweroff.

Jamie Lentin (1):
      power: Add simple poweroff-gpio driver

 .../devicetree/bindings/gpio/gpio-poweroff.txt     |   22 ++++
 arch/arm/boot/dts/kirkwood-dnskw.dtsi              |    5 +
 arch/arm/boot/dts/kirkwood-ib62x0.dts              |    6 +
 arch/arm/mach-kirkwood/Kconfig                     |    4 +
 arch/arm/mach-kirkwood/board-dnskw.c               |   12 --
 arch/arm/mach-kirkwood/board-ib62x0.c              |   13 --
 drivers/power/Kconfig                              |    3 +
 drivers/power/Makefile                             |    1 +
 drivers/power/reset/Kconfig                        |   15 +++
 drivers/power/reset/Makefile                       |    1 +
 drivers/power/reset/gpio-poweroff.c                |  129 ++++++++++++++++++++
 11 files changed, 186 insertions(+), 25 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-poweroff.txt
 create mode 100644 drivers/power/reset/Kconfig
 create mode 100644 drivers/power/reset/Makefile
 create mode 100644 drivers/power/reset/gpio-poweroff.c
