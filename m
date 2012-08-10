From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 10 Aug 2012 14:48:20 +0200
Subject: [PATCH 00/14] ARM: at91: add pinctrl support
Message-ID: <20120810124820.GA20557@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

	This patch series introduce the pinctrl on AT91 on all the DT Soc.

	THe pinctrl is limited to only the DT. Old code still use the custom
	at91 pin mux api.

The following changes since commit 0d7614f09c1ebdbaa1599a5aba7593f147bf96ee:

  Linux 3.6-rc1 (2012-08-02 16:38:10 -0700)

are available in the git repository at:

  git://github.com/at91linux/linux-at91.git j/pinctrl

for you to fetch changes up to 7ff6e8b37d1f334ef24b87661c40aaa548dd93f6:

  MTD: atmel_nand: add pinctrl consumer support (2012-08-10 20:46:24 +0800)

----------------------------------------------------------------
Jean-Christophe PLAGNIOL-VILLARD (14):
      ARM: at91: gpio: implement request and free
      at91: regroup gpio and pinctrl under a simple-bus
      arm: at91: at91sam9x5: fix gpio number per bank
      ARM: at91: add dummies pinctrl for non dt platform
      ARM: at91: add pinctrl support
      arm: at91: dt: at91sam9 add pinctrl support
      arm: at91: dt: at91sam9 add serial pinctrl support
      tty: atmel_serial: add pinctrl support
      arm: at91: dt: sam9m10g45ek: use rts/cts pinctrl group for uart1
      arm: at91: dt: sam9263ek: use rts/cts pinctrl group for uart0
      arm: at91: dt: sam9g20ek: use rts/cts/dtr/dsr/dcd/ri pinctrl group for uart0
      MTD: atmel nand: fix gpio missing request
      arm: at91: dt: at91sam9 add nand pinctrl support
      MTD: atmel_nand: add pinctrl consumer support

 Documentation/devicetree/bindings/gpio/gpio_atmel.txt            |    5 +
 Documentation/devicetree/bindings/pinctrl/atmel,at91-pinctrl.txt |   84 ++++++++
 arch/arm/Kconfig                                                 |    1 +
 arch/arm/boot/dts/at91sam9260.dtsi                               |  182 +++++++++++++---
 arch/arm/boot/dts/at91sam9263.dtsi                               |  164 +++++++++++----
 arch/arm/boot/dts/at91sam9263ek.dts                              |    1 +
 arch/arm/boot/dts/at91sam9g15.dtsi                               |   28 +++
 arch/arm/boot/dts/at91sam9g15ek.dts                              |   16 ++
 arch/arm/boot/dts/at91sam9g20ek_common.dtsi                      |    6 +
 arch/arm/boot/dts/at91sam9g25.dtsi                               |   28 +++
 arch/arm/boot/dts/at91sam9g25ek.dts                              |   37 +---
 arch/arm/boot/dts/at91sam9g35.dtsi                               |   28 +++
 arch/arm/boot/dts/at91sam9g35ek.dts                              |   16 ++
 arch/arm/boot/dts/at91sam9g45.dtsi                               |  181 ++++++++++++----
 arch/arm/boot/dts/at91sam9m10g45ek.dts                           |    1 +
 arch/arm/boot/dts/at91sam9n12.dtsi                               |  173 +++++++++++++---
 arch/arm/boot/dts/at91sam9x25.dtsi                               |   28 +++
 arch/arm/boot/dts/at91sam9x25ek.dts                              |   16 ++
 arch/arm/boot/dts/at91sam9x35.dtsi                               |   28 +++
 arch/arm/boot/dts/at91sam9x35ek.dts                              |   16 ++
 arch/arm/boot/dts/at91sam9x5.dtsi                                |  179 +++++++++++++---
 arch/arm/boot/dts/at91sam9x5ek.dtsi                              |   47 +++++
 arch/arm/configs/at91_dt_defconfig                               |    1 +
 arch/arm/mach-at91/Makefile.boot                                 |    4 +
 arch/arm/mach-at91/at91sam9263.c                                 |    5 +
 arch/arm/mach-at91/at91sam9g45.c                                 |    6 +
 arch/arm/mach-at91/at91sam9n12.c                                 |    3 -
 arch/arm/mach-at91/at91sam9x5.c                                  |    7 -
 arch/arm/mach-at91/board-dt.c                                    |    2 -
 arch/arm/mach-at91/gpio.c                                        |  197 ++++--------------
 arch/arm/mach-at91/setup.c                                       |    6 +-
 drivers/mtd/nand/atmel_nand.c                                    |   65 +++++-
 drivers/pinctrl/Kconfig                                          |    9 +
 drivers/pinctrl/Makefile                                         |    1 +
 drivers/pinctrl/pinctrl-at91.c                                   | 1448 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/tty/serial/atmel_serial.c                                |    8 +
 36 files changed, 2654 insertions(+), 373 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/atmel,at91-pinctrl.txt
 create mode 100644 arch/arm/boot/dts/at91sam9g15.dtsi
 create mode 100644 arch/arm/boot/dts/at91sam9g15ek.dts
 create mode 100644 arch/arm/boot/dts/at91sam9g25.dtsi
 create mode 100644 arch/arm/boot/dts/at91sam9g35.dtsi
 create mode 100644 arch/arm/boot/dts/at91sam9g35ek.dts
 create mode 100644 arch/arm/boot/dts/at91sam9x25.dtsi
 create mode 100644 arch/arm/boot/dts/at91sam9x25ek.dts
 create mode 100644 arch/arm/boot/dts/at91sam9x35.dtsi
 create mode 100644 arch/arm/boot/dts/at91sam9x35ek.dts
 create mode 100644 arch/arm/boot/dts/at91sam9x5ek.dtsi
 create mode 100644 drivers/pinctrl/pinctrl-at91.c

Best Regards,
J.
