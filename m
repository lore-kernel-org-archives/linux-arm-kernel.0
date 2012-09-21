From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 21 Sep 2012 15:46:29 -0400
Subject: [GIT PULL V3 2/5] ARM: Kirkwood: DT changes for v3.7
In-Reply-To: <20120829001129.GO19437@titan.lakedaemon.net>
References: <20120829001129.GO19437@titan.lakedaemon.net>
Message-ID: <20120921194629.GW5469@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 5b40baee4a39d96d4d6a48a2b2383982912c429b:

  arm: mvebu: add address decoding controller to the DT (2012-09-21 18:05:29 +0000)

are available in the git repository at:
  git://git.infradead.org/users/jcooper/linux.git kirkwood/dt

Andrew Lunn (3): 
      ARM: Kirkwood: ehci-orion: Add device tree binding
      ARM: Kirkwood: Convert all DT boards to EHCI via DT.
      Crypto: CESA: Add support for DT based instantiation.

Arnaud Patard (2):
      ARM: Kirkwood: Describe iconnect keys in DT.
      ARM: Kirkwood: Describe iconnect nand in DT.

Jamie Lentin (2):
      hwmon: Add devicetree bindings to gpio-fan
      ARM: kirkwood: Use devicetree to define DNS-32[05] fan

Sebastian Hesselbarth (3):
      pinctrl: mvebu: pinctrl driver core
      pinctrl: mvebu: dove pinctrl driver
      pinctrl: mvebu: kirkwood pinctrl driver

Thomas Petazzoni (12):
      pinctrl: mvebu: add pinctrl driver for Armada 370
      pinctrl: mvebu: add pinctrl driver for Armada XP
      ARM: mvebu: Add pinctrl support to Armada XP SoCs
      ARM: mvebu: Add pinctrl support to Armada 370 SoC
      ARM: mvebu: adjust Armada XP evaluation board DTS
      arm: mvebu: split Kconfig options for Armada 370 and XP
      arm: mvebu: select the pinctrl drivers for Armada 370 and Armada XP platforms
      gpio: introduce gpio-mvebu driver for Marvell SoCs
      Documentation: add description of DT binding for the gpio-mvebu driver
      arm: mvebu: use GPIO support now that a driver is available
      arm: mvebu: add DT information for GPIO banks on Armada 370 and XP
      arm: mvebu: add gpio support in defconfig

 .../devicetree/bindings/crypto/mv_cesa.txt         |   20 +
 .../devicetree/bindings/gpio/gpio-fan.txt          |   25 +
 .../devicetree/bindings/gpio/gpio-mvebu.txt        |   53 ++
 .../pinctrl/marvell,armada-370-pinctrl.txt         |   95 +++
 .../bindings/pinctrl/marvell,armada-xp-pinctrl.txt |  100 +++
 .../bindings/pinctrl/marvell,dove-pinctrl.txt      |   72 ++
 .../bindings/pinctrl/marvell,kirkwood-pinctrl.txt  |  279 ++++++++
 .../bindings/pinctrl/marvell,mvebu-pinctrl.txt     |   46 ++
 .../devicetree/bindings/usb/ehci-orion.txt         |   19 +
 arch/arm/Kconfig                                   |    2 +
 arch/arm/boot/dts/armada-370.dtsi                  |   44 ++
 arch/arm/boot/dts/armada-xp-db.dts                 |    4 +-
 arch/arm/boot/dts/armada-xp-mv78230.dtsi           |   57 ++
 arch/arm/boot/dts/armada-xp-mv78260.dtsi           |   70 ++
 arch/arm/boot/dts/armada-xp-mv78460.dtsi           |   70 ++
 arch/arm/boot/dts/kirkwood-dnskw.dtsi              |   10 +
 arch/arm/boot/dts/kirkwood-iconnect.dts            |   50 ++-
 arch/arm/boot/dts/kirkwood.dtsi                    |   20 +-
 arch/arm/configs/mvebu_defconfig                   |    2 +
 arch/arm/mach-kirkwood/board-dnskw.c               |   27 -
 arch/arm/mach-kirkwood/board-dreamplug.c           |    1 -
 arch/arm/mach-kirkwood/board-dt.c                  |    3 +-
 arch/arm/mach-kirkwood/board-goflexnet.c           |    1 -
 arch/arm/mach-kirkwood/board-ib62x0.c              |    1 -
 arch/arm/mach-kirkwood/board-iconnect.c            |   49 --
 arch/arm/mach-kirkwood/board-lsxl.c                |    1 -
 arch/arm/mach-kirkwood/board-ts219.c               |    1 -
 arch/arm/mach-mvebu/Kconfig                        |   18 +-
 arch/arm/mach-mvebu/include/mach/gpio.h            |    1 +
 drivers/crypto/mv_cesa.c                           |   17 +-
 drivers/gpio/Kconfig                               |    6 +
 drivers/gpio/Makefile                              |    1 +
 drivers/gpio/gpio-mvebu.c                          |  679 ++++++++++++++++++
 drivers/hwmon/gpio-fan.c                           |  120 ++++
 drivers/pinctrl/Kconfig                            |   22 +
 drivers/pinctrl/Makefile                           |    5 +
 drivers/pinctrl/pinctrl-armada-370.c               |  421 +++++++++++
 drivers/pinctrl/pinctrl-armada-xp.c                |  468 ++++++++++++
 drivers/pinctrl/pinctrl-dove.c                     |  620 ++++++++++++++++
 drivers/pinctrl/pinctrl-kirkwood.c                 |  472 ++++++++++++
 drivers/pinctrl/pinctrl-mvebu.c                    |  754 ++++++++++++++++++++
 drivers/pinctrl/pinctrl-mvebu.h                    |  192 +++++
 drivers/usb/host/ehci-orion.c                      |   59 ++-
 43 files changed, 4883 insertions(+), 94 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/crypto/mv_cesa.txt
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-fan.txt
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-mvebu.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/marvell,armada-370-pinctrl.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/marvell,armada-xp-pinctrl.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/marvell,dove-pinctrl.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/marvell,kirkwood-pinctrl.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/marvell,mvebu-pinctrl.txt
 create mode 100644 Documentation/devicetree/bindings/usb/ehci-orion.txt
 create mode 100644 arch/arm/boot/dts/armada-xp-mv78230.dtsi
 create mode 100644 arch/arm/boot/dts/armada-xp-mv78260.dtsi
 create mode 100644 arch/arm/boot/dts/armada-xp-mv78460.dtsi
 create mode 100644 arch/arm/mach-mvebu/include/mach/gpio.h
 create mode 100644 drivers/gpio/gpio-mvebu.c
 create mode 100644 drivers/pinctrl/pinctrl-armada-370.c
 create mode 100644 drivers/pinctrl/pinctrl-armada-xp.c
 create mode 100644 drivers/pinctrl/pinctrl-dove.c
 create mode 100644 drivers/pinctrl/pinctrl-kirkwood.c
 create mode 100644 drivers/pinctrl/pinctrl-mvebu.c
 create mode 100644 drivers/pinctrl/pinctrl-mvebu.h
