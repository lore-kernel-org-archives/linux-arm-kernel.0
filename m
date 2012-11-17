From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 17 Nov 2012 17:00:42 +0100
Subject: [PATCH v2 00/14] Convert Kirkwood DT boards to pinctrl
Message-ID: <1353168058-14043-1-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset converts all Kirkwood DT boards to pinctrl. The
configuration of pins is moved into the board DT files. Since none of
the kirkwood boards need to dynamically change pin configurations, pin
hogs are specified.

In order to support the 98DX412x family of network switches with
embedded kirkwood CPUs, a new CPU variant is added to the kirkwood
pinctrl driver.

These patches apply on top of the conversion to using regulators.
These patches also rely on three patches already accepted by Linus
Walleij to the mvebu pinctrl driver.

Andrew Lunn (12):
  GPIO: mvebu: Allow all plat-orion platforms.
  ARM: Kirkwood: Make use of mvebu pincltl and gpio drivers
  ARM: Kirkwood: Add DTSI files for pinctrl
  ARM: Kirkwood: Convert TS219 to pinctrl.
  ARM: Kirkwood: Convert iConnect to pinctrl.
  ARM: Kirkwood: Convert dnskw to pinctrl
  ARM: Kirkwood: Convert dockstar to pinctrl.
  ARM: Kirkwood: Convert dreamplug to pinctrl.
  ARM: Kirkwood: Convert GoFlex Net to pinctrl.
  ARM: Kirkwood: Convert ib62x0 to pinctrl.
  ARM: Kirkwood: Convert lsxl boards to pinctrl.
  ARM: Kirkwood: Convert IX2-200 to pinctrl.

Valentin Longchamp (2):
  ARM: Kirkwood: support 98DX412x kirkwoods with pinctrl
  ARM: Kirkwood: Convert km_kirkwood to pinctrl

 .../bindings/pinctrl/marvell,kirkwood-pinctrl.txt  |   39 ++
 arch/arm/Kconfig                                   |    2 +
 arch/arm/boot/dts/kirkwood-6281.dtsi               |   39 ++
 arch/arm/boot/dts/kirkwood-6282.dtsi               |   35 ++
 arch/arm/boot/dts/kirkwood-98dx4122.dtsi           |   31 ++
 arch/arm/boot/dts/kirkwood-dnskw.dtsi              |  105 ++++
 arch/arm/boot/dts/kirkwood-dockstar.dts            |   20 +
 arch/arm/boot/dts/kirkwood-dreamplug.dts           |   21 +
 arch/arm/boot/dts/kirkwood-goflexnet.dts           |   56 ++
 arch/arm/boot/dts/kirkwood-ib62x0.dts              |   34 ++
 arch/arm/boot/dts/kirkwood-iconnect.dts            |   51 ++
 arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts      |   89 +++
 arch/arm/boot/dts/kirkwood-km_kirkwood.dts         |   17 +
 arch/arm/boot/dts/kirkwood-lsxl.dtsi               |   66 +++
 arch/arm/boot/dts/kirkwood-ts219-6281.dts          |   31 ++
 arch/arm/boot/dts/kirkwood-ts219-6282.dts          |   31 ++
 arch/arm/boot/dts/kirkwood.dtsi                    |   10 +-
 arch/arm/mach-kirkwood/board-dnskw.c               |   37 --
 arch/arm/mach-kirkwood/board-dockstar.c            |   10 -
 arch/arm/mach-kirkwood/board-dreamplug.c           |   14 -
 arch/arm/mach-kirkwood/board-goflexnet.c           |   18 -
 arch/arm/mach-kirkwood/board-ib62x0.c              |   21 -
 arch/arm/mach-kirkwood/board-iconnect.c            |   17 -
 arch/arm/mach-kirkwood/board-iomega_ix2_200.c      |   24 -
 arch/arm/mach-kirkwood/board-km_kirkwood.c         |   12 -
 arch/arm/mach-kirkwood/board-lsxl.c                |   19 -
 arch/arm/mach-kirkwood/board-ts219.c               |   25 -
 arch/arm/plat-orion/irq.c                          |    6 +-
 drivers/gpio/Kconfig                               |    2 +-
 drivers/pinctrl/mvebu/pinctrl-kirkwood.c           |  568 ++++++++++----------
 30 files changed, 967 insertions(+), 483 deletions(-)
 create mode 100644 arch/arm/boot/dts/kirkwood-6281.dtsi
 create mode 100644 arch/arm/boot/dts/kirkwood-6282.dtsi
 create mode 100644 arch/arm/boot/dts/kirkwood-98dx4122.dtsi

-- 
1.7.10.4
