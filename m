From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 24 Nov 2015 18:39:18 +0900
Subject: [PATCH 0/4] arm, arm64: uniphier: add a new driver,
 device tree updates
Message-ID: <1448357962-12259-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Here is another series for UniPhier SoC family:

 - 1/4: add a new driver.  The UniPhier System Bus is an external bus
        where on-board devices are connected to the SoC.
        (please check if the binding specification is OK.)

 - 2/4: device tree updates to use the driver added by 1/4

 - 3/4: trivial rename of device node names

 - 4/4: initial commit for ARMv8 SoC/Board device trees

Please apply 2/4, 3/4/, 4/4 into the same branch because 4/4 depends on 2/4 and 3/4.
(4/4 creates symbolic links to ARM device trees.)



Masahiro Yamada (4):
  bus: uniphier-system-bus: add UniPhier System Bus Controller driver
  ARM: dts: uniphier: add better-matching compatible string to extbus
    nodes
  ARM: dts: uniphier: rename nodes from extbus to system-bus
  arm64: dts: uniphier: add PH1-LD10 SoC/board support

 .../bindings/arm/uniphier/uniphier-system-bus.txt  |  70 +++++
 MAINTAINERS                                        |   2 +
 arch/arm/boot/dts/uniphier-ph1-ld4-ref.dts         |   2 +-
 arch/arm/boot/dts/uniphier-ph1-ld4.dtsi            |   5 +-
 arch/arm/boot/dts/uniphier-ph1-ld6b-ref.dts        |   2 +-
 arch/arm/boot/dts/uniphier-ph1-pro4-ref.dts        |   2 +-
 arch/arm/boot/dts/uniphier-ph1-pro4.dtsi           |   5 +-
 arch/arm/boot/dts/uniphier-ph1-pro5.dtsi           |   5 +-
 arch/arm/boot/dts/uniphier-ph1-sld3-ref.dts        |   2 +-
 arch/arm/boot/dts/uniphier-ph1-sld3.dtsi           |   5 +-
 arch/arm/boot/dts/uniphier-ph1-sld8-ref.dts        |   2 +-
 arch/arm/boot/dts/uniphier-ph1-sld8.dtsi           |   5 +-
 arch/arm/boot/dts/uniphier-proxstream2.dtsi        |   5 +-
 arch/arm/boot/dts/uniphier-support-card.dtsi       |   2 +-
 arch/arm64/boot/dts/Makefile                       |   1 +
 arch/arm64/boot/dts/socionext/Makefile             |   4 +
 .../boot/dts/socionext/uniphier-ph1-ld10-ref.dts   |  95 +++++++
 .../boot/dts/socionext/uniphier-ph1-ld10.dtsi      | 286 +++++++++++++++++++++
 .../arm64/boot/dts/socionext/uniphier-pinctrl.dtsi |   1 +
 .../boot/dts/socionext/uniphier-support-card.dtsi  |   1 +
 drivers/bus/Kconfig                                |   9 +
 drivers/bus/Makefile                               |   1 +
 drivers/bus/uniphier-system-bus.c                  | 284 ++++++++++++++++++++
 23 files changed, 778 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/uniphier/uniphier-system-bus.txt
 create mode 100644 arch/arm64/boot/dts/socionext/Makefile
 create mode 100644 arch/arm64/boot/dts/socionext/uniphier-ph1-ld10-ref.dts
 create mode 100644 arch/arm64/boot/dts/socionext/uniphier-ph1-ld10.dtsi
 create mode 120000 arch/arm64/boot/dts/socionext/uniphier-pinctrl.dtsi
 create mode 120000 arch/arm64/boot/dts/socionext/uniphier-support-card.dtsi
 create mode 100644 drivers/bus/uniphier-system-bus.c

-- 
1.9.1
