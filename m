From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 22 Sep 2012 13:36:46 -0400
Subject: [GIT PULL V5 7/7] ARM: kirkwood drivers changes for v3.7
In-Reply-To: <20120922171554.GE5469@titan.lakedaemon.net>
References: <20120922171554.GE5469@titan.lakedaemon.net>
Message-ID: <20120922173646.GL5469@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Depends:
 - Based on v3.6-rc5
 - kirkwood/addr_decode

New drivers:
 - pinctrl (dove, kirkwood, mvebu)
 - gpio (mvebu)

Conflicts:
 - kirkwood/boards (arch/arm/Kconfig)
    - keep MIGHT_HAVE_PCI
    - keep PLAT_ORION_LEGACY over PLAT_ORION
    - allow add USB_ARCH_HAS_EHCI

Resolution should look like this:

config ARCH_DOVE
        bool "Marvell Dove"
        select CPU_V7
        select ARCH_REQUIRE_GPIOLIB
        select GENERIC_CLOCKEVENTS
        select MIGHT_HAVE_PCI
        select NEED_MACH_IO_H
        select PLAT_ORION_LEGACY
        select USB_ARCH_HAS_EHCI
        help
          Support for the Marvell Dove SoC 88AP510


The following changes since commit 5b40baee4a39d96d4d6a48a2b2383982912c429b:

  arm: mvebu: add address decoding controller to the DT (2012-09-21 18:05:29 +0000)

are available in the git repository at:
  git://git.infradead.org/users/jcooper/linux.git kirkwood/drivers

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

 .../devicetree/bindings/gpio/gpio-mvebu.txt        |   53 ++
 .../pinctrl/marvell,armada-370-pinctrl.txt         |   95 +++
 .../bindings/pinctrl/marvell,armada-xp-pinctrl.txt |  100 +++
 .../bindings/pinctrl/marvell,dove-pinctrl.txt      |   72 ++
 .../bindings/pinctrl/marvell,kirkwood-pinctrl.txt  |  279 ++++++++
 .../bindings/pinctrl/marvell,mvebu-pinctrl.txt     |   46 ++
 arch/arm/Kconfig                                   |    2 +
 arch/arm/boot/dts/armada-370.dtsi                  |   44 ++
 arch/arm/boot/dts/armada-xp-db.dts                 |    4 +-
 arch/arm/boot/dts/armada-xp-mv78230.dtsi           |   57 ++
 arch/arm/boot/dts/armada-xp-mv78260.dtsi           |   70 ++
 arch/arm/boot/dts/armada-xp-mv78460.dtsi           |   70 ++
 arch/arm/configs/mvebu_defconfig                   |    2 +
 arch/arm/mach-mvebu/Kconfig                        |   18 +-
 arch/arm/mach-mvebu/include/mach/gpio.h            |    1 +
 drivers/gpio/Kconfig                               |    6 +
 drivers/gpio/Makefile                              |    1 +
 drivers/gpio/gpio-mvebu.c                          |  679 ++++++++++++++++++
 drivers/pinctrl/Kconfig                            |   22 +
 drivers/pinctrl/Makefile                           |    5 +
 drivers/pinctrl/pinctrl-armada-370.c               |  421 +++++++++++
 drivers/pinctrl/pinctrl-armada-xp.c                |  468 ++++++++++++
 drivers/pinctrl/pinctrl-dove.c                     |  620 ++++++++++++++++
 drivers/pinctrl/pinctrl-kirkwood.c                 |  472 ++++++++++++
 drivers/pinctrl/pinctrl-mvebu.c                    |  754 ++++++++++++++++++++
 drivers/pinctrl/pinctrl-mvebu.h                    |  192 +++++
 26 files changed, 4548 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-mvebu.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/marvell,armada-370-pinctrl.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/marvell,armada-xp-pinctrl.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/marvell,dove-pinctrl.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/marvell,kirkwood-pinctrl.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/marvell,mvebu-pinctrl.txt
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
