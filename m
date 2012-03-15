From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 15 Mar 2012 17:34:11 +0100
Subject: [PULL 01/02 v2] AT91 DT2 pull request
Message-ID: <20120315163411.GC7757@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

	please find a pull with DT update for AT91
	based on cleanup2 + DT previously pull

	with :

	 - OF: boolean
	 - NAND (with generic bining and at91 fixed)
	 - RAAM Controller
	 - i2c/gpio (binding + soc)
	 - PMC
	 - Reset Controller
	 - Shutdown Controller
	 - USB ECHI & OHCI

	v2 add missing USB host (Acked)

The following changes since commit f75622f4679479d352d2fa83e0d84c6c13cfcb5f:

  ARM: at91: at91sam9x5cm/dt: add leds support (2012-03-01 22:34:22 +0800)

are available in the git repository at:
  git://github.com/at91linux/linux-at91.git at91-3.4-cleanup2-DT2

Jean-Christophe PLAGNIOL-VILLARD (23):
      ATMEL: fix nand ecc support
      mtd/atmel_nand: add on_flash_bbt to enable the use of On Flash BBT
      ARM: at91: enable on flash bbt for Atmel Reference and DT boards
      of: introduce helper to manage boolean
      of/mtd/nand: add generic bindings and helpers
      atmel/nand: add DT support
      ARM: at91: sam9x5 add nand support
      i2c/gpio: add DT support
      ARM: at91: sam9g20 add i2c DT support
      ARM: at91: usb_a9g20 add DT i2c support
      ARM: at91: sam9g45 add i2c DT support
      ARM: at91: sam9x5 add i2c DT support
      ARM: at91/dt: add Calao DAB-MMX daugther board support for USB-A9G20
      ARM: at91/dt: add specific DT soc init
      ARM: at91: add pmc DT support
      ARM: at91: always enable sam9 restart
      ARM: at91: add RSTC (Reset Controller) dt support
      ARM: at91: add ram controller DT support
      ARM: at91: add Shutdown Controller (SHDWC) DT support
      ARM: at91: usb ohci add dt support
      ARM: at91: dt: enable usb ohci for sam9g20, sam9g45 amd sam9x5
      ARM: at91: usb ehci add dt support
      ARM: at91: dt: enable usb ehci for sam9g45 and sam9x5

 .../devicetree/bindings/arm/atmel-at91.txt         |   60 ++++++++
 .../devicetree/bindings/arm/atmel-pmc.txt          |   11 ++
 .../devicetree/bindings/gpio/gpio_i2c.txt          |   32 ++++
 .../devicetree/bindings/mtd/atmel-nand.txt         |   41 +++++
 Documentation/devicetree/bindings/mtd/nand.txt     |    7 +
 .../devicetree/bindings/usb/atmel-usb.txt          |   31 ++++
 arch/arm/boot/dts/at91sam9g20.dtsi                 |   56 +++++++
 arch/arm/boot/dts/at91sam9g25ek.dts                |   14 ++-
 arch/arm/boot/dts/at91sam9g45.dtsi                 |   64 ++++++++
 arch/arm/boot/dts/at91sam9m10g45ek.dts             |   46 ++++++-
 arch/arm/boot/dts/at91sam9x5.dtsi                  |   88 +++++++++++
 arch/arm/boot/dts/at91sam9x5cm.dtsi                |   45 ++++++
 arch/arm/boot/dts/usb_a9g20-dab-mmx.dtsi           |   96 ++++++++++++
 arch/arm/boot/dts/usb_a9g20.dts                    |   69 +++++++++-
 arch/arm/configs/at91sam9g20_defconfig             |    3 +
 arch/arm/mach-at91/Kconfig                         |   10 +-
 arch/arm/mach-at91/at91sam9260.c                   |    1 +
 arch/arm/mach-at91/at91sam9g45.c                   |    2 +
 arch/arm/mach-at91/at91sam9x5.c                    |   17 +--
 arch/arm/mach-at91/board-afeb-9260v1.c             |    1 +
 arch/arm/mach-at91/board-cam60.c                   |    1 +
 arch/arm/mach-at91/board-cpu9krea.c                |    1 +
 arch/arm/mach-at91/board-dt.c                      |   57 +-------
 arch/arm/mach-at91/board-kb9202.c                  |    1 +
 arch/arm/mach-at91/board-neocore926.c              |    1 +
 arch/arm/mach-at91/board-qil-a9260.c               |    2 +
 arch/arm/mach-at91/board-rm9200dk.c                |    2 +
 arch/arm/mach-at91/board-sam9-l9260.c              |    1 +
 arch/arm/mach-at91/board-sam9260ek.c               |    2 +
 arch/arm/mach-at91/board-sam9261ek.c               |    2 +
 arch/arm/mach-at91/board-sam9263ek.c               |    2 +
 arch/arm/mach-at91/board-sam9g20ek.c               |    2 +
 arch/arm/mach-at91/board-sam9m10g45ek.c            |    2 +
 arch/arm/mach-at91/board-sam9rlek.c                |    2 +
 arch/arm/mach-at91/board-snapper9260.c             |    1 +
 arch/arm/mach-at91/board-stamp9g20.c               |    1 +
 arch/arm/mach-at91/board-usb-a926x.c               |    2 +
 arch/arm/mach-at91/board-yl-9200.c                 |    1 +
 arch/arm/mach-at91/clock.c                         |   56 +++++++-
 arch/arm/mach-at91/generic.h                       |    2 +
 arch/arm/mach-at91/include/mach/at91_shdwc.h       |    4 +-
 arch/arm/mach-at91/include/mach/at91sam9x5.h       |    5 -
 arch/arm/mach-at91/include/mach/board.h            |   15 +--
 arch/arm/mach-at91/pm.c                            |   13 --
 arch/arm/mach-at91/setup.c                         |  158 ++++++++++++++++++++
 arch/avr32/boards/atngw100/setup.c                 |    1 +
 arch/avr32/boards/atstk1000/atstk1002.c            |    1 +
 arch/avr32/mach-at32ap/include/mach/board.h        |   13 +--
 drivers/i2c/busses/i2c-gpio.c                      |   94 +++++++++---
 drivers/mtd/nand/atmel_nand.c                      |  136 ++++++++++++-----
 drivers/of/Kconfig                                 |    4 +
 drivers/of/Makefile                                |    1 +
 drivers/of/of_mtd.c                                |   85 +++++++++++
 drivers/usb/Kconfig                                |    2 +-
 drivers/usb/host/ehci-atmel.c                      |   24 +++-
 drivers/usb/host/ohci-at91.c                       |  101 ++++++++++++-
 include/linux/of.h                                 |   16 ++
 include/linux/of_mtd.h                             |   19 +++
 include/linux/platform_data/atmel.h                |   27 ++++
 59 files changed, 1363 insertions(+), 191 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/atmel-pmc.txt
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio_i2c.txt
 create mode 100644 Documentation/devicetree/bindings/mtd/atmel-nand.txt
 create mode 100644 Documentation/devicetree/bindings/mtd/nand.txt
 create mode 100644 Documentation/devicetree/bindings/usb/atmel-usb.txt
 create mode 100644 arch/arm/boot/dts/usb_a9g20-dab-mmx.dtsi
 create mode 100644 drivers/of/of_mtd.c
 create mode 100644 include/linux/of_mtd.h
 create mode 100644 include/linux/platform_data/atmel.h

Best Regards,
J.
