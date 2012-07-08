From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 8 Jul 2012 16:56:15 +0200
Subject: Orion DT Pull request for 3.6
Message-ID: <20120708145615.GA10201@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jason

Here is a pull request for the DT work i've been doing for Orion. I've
tested on Kirkwood, but the generic patches have also been tested on
Dove. Compared to the last post of the patches, i've dropped the
crypto patch, since it was not ready. I also extended the binding
documentation for IRQ handlers at the request of Arnd.

It would be good to pull these into a for-next tree and publish it so
others can build upon them.

Thanks
	Andrew

The following changes since commit 6887a4131da3adaab011613776d865f4bcfb5678:

  Linux 3.5-rc5 (2012-06-30 16:08:57 -0700)

are available in the git repository at:

  https://github.com/lunn/linux.git v3.5-rc5-qnap-dt

for you to fetch changes up to 76a6f95e022f975d3e62b7ecdcba8814712e60c0:

  ARM: Kirkwood: Use DT to configure SATA device. (2012-07-05 18:24:40 +0200)

----------------------------------------------------------------
Andrew Lunn (7):
      ARM: Orion: DT support for IRQ and GPIO Controllers
      SPI: Refactor spi-orion to use SPI framework queue.
      I2C: MV64XXX: Add Device Tree support
      Kirkwood: Add basic device tree support for QNAP TS219.
      ARM: Orion: DTify the watchdog timer.
      ATA: sata_mv: Add device tree support
      ARM: Kirkwood: Use DT to configure SATA device.

Michael Walle (4):
      spi-orion: remove uneeded spi_info
      spi-orion: add device tree binding
      ARM: kirkwood: use devicetree for orion-spi
      ARM: kirkwood: use devicetree for SPI on dreamplug

 .../devicetree/bindings/arm/mrvl/intc.txt          |   20 ++
 Documentation/devicetree/bindings/ata/marvell.txt  |   16 ++
 .../devicetree/bindings/gpio/mrvl-gpio.txt         |   23 ++
 Documentation/devicetree/bindings/i2c/mrvl-i2c.txt |   32 ++-
 .../devicetree/bindings/spi/spi-orion.txt          |   19 ++
 .../devicetree/bindings/watchdog/marvel.txt        |   14 ++
 arch/arm/Kconfig                                   |    1 +
 arch/arm/boot/dts/kirkwood-dns320.dts              |    5 +
 arch/arm/boot/dts/kirkwood-dns325.dts              |    5 +
 arch/arm/boot/dts/kirkwood-dreamplug.dts           |   34 +++
 arch/arm/boot/dts/kirkwood-ib62x0.dts              |    5 +
 arch/arm/boot/dts/kirkwood-ts219-6281.dts          |   21 ++
 arch/arm/boot/dts/kirkwood-ts219-6282.dts          |   21 ++
 arch/arm/boot/dts/kirkwood-ts219.dtsi              |   77 +++++++
 arch/arm/boot/dts/kirkwood.dtsi                    |   62 ++++++
 arch/arm/mach-dove/irq.c                           |   58 ++---
 arch/arm/mach-kirkwood/Kconfig                     |   14 ++
 arch/arm/mach-kirkwood/Makefile                    |    1 +
 arch/arm/mach-kirkwood/Makefile.boot               |    1 +
 arch/arm/mach-kirkwood/board-dnskw.c               |    5 -
 arch/arm/mach-kirkwood/board-dreamplug.c           |   46 ----
 arch/arm/mach-kirkwood/board-dt.c                  |   20 +-
 arch/arm/mach-kirkwood/board-ib62x0.c              |    5 -
 arch/arm/mach-kirkwood/board-ts219.c               |   82 +++++++
 arch/arm/mach-kirkwood/common.h                    |    5 +
 arch/arm/mach-kirkwood/irq.c                       |   38 ++--
 arch/arm/mach-mv78xx0/irq.c                        |   22 +-
 arch/arm/mach-orion5x/irq.c                        |   22 +-
 arch/arm/plat-orion/gpio.c                         |  166 ++++++++++----
 arch/arm/plat-orion/include/plat/gpio.h            |   16 +-
 arch/arm/plat-orion/include/plat/irq.h             |    3 +-
 arch/arm/plat-orion/irq.c                          |   40 ++++
 drivers/ata/sata_mv.c                              |   42 ++--
 drivers/i2c/busses/i2c-mv64xxx.c                   |   38 +++-
 drivers/spi/spi-orion.c                            |  231 +++++++-------------
 drivers/watchdog/orion_wdt.c                       |    8 +
 36 files changed, 856 insertions(+), 362 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ata/marvell.txt
 create mode 100644 Documentation/devicetree/bindings/spi/spi-orion.txt
 create mode 100644 Documentation/devicetree/bindings/watchdog/marvel.txt
 create mode 100644 arch/arm/boot/dts/kirkwood-ts219-6281.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-ts219-6282.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-ts219.dtsi
 create mode 100644 arch/arm/mach-kirkwood/board-ts219.c
