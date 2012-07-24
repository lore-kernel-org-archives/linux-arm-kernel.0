From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 24 Jul 2012 10:17:32 +0200
Subject: Orion Pull request
Message-ID: <20120724081732.GR18778@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof

I know this is very late, the main pull request direction Linus has
been made, etc. Its been an interesting learning experience for me,
jumping in to take over from Jason.

Please note, there are a few patches between the v3.5-rc7 and the
first patch to be pulled. These patches have been accepted by the I2C
maintainer & SPI maintainer, so should not be pulled.

I also have no pgp keys in place, so there is no signed tag. I will
remedy this for next time.

If you can pull this great. Otherwise, it can wait for 3.7.

Thanks
	Andrew

The following changes since commit bcf32faebf69bfa95f72db4b818fb1358d91d38e:

  SPI: Refactor spi-orion to use SPI framework queue. (2012-07-23 13:04:11 +0200)

are available in the git repository at:

  git://github.com/lunn/linux.git v3.5-rc7-for-next-v6

for you to fetch changes up to e8891dde45f63fd8654a8ba06d95fc0eba51d697:

  ARM: Orion: fix driver probe error handling with respect to clk (2012-07-23 13:04:48 +0200)

----------------------------------------------------------------
Andrew Lunn (15):
      ARM: Orion: DT support for IRQ and GPIO Controllers
      ARM: Kirkwood: Ensure runit clock always ticks.
      ARM: Orion: Add arch support needed for I2C via DT.
      Kirkwood: Add basic device tree support for QNAP TS219.
      ARM: Orion: DTify the watchdog timer.
      ATA: sata_mv: Add device tree support
      ARM: Kirkwood: Use DT to configure SATA device.
      ARM: Kirkwood: Describe DNS325 temperature sensor in DT.
      ARM: Kirkwood: Describe IB62x0 gpio-keys in DT.
      ARM: Kirkwood: Describe iConnects temperature sensor in DT.
      ARM: Kirkwood: Describe Dreamplug LEDs in DT.
      ARM: Kirkwood: Describe GoFlex Net LEDs and SATA in DT.
      ARM: Kirkwood: Describe ib62x0 LEDs in DT.
      ARM: Kirkwood: Describe iConnect LEDs in DT.
      ARM: Kirkwood: Replace mrvl with marvell

Hannes Reinecke (1):
      mach-dove: Fixup ge00 initialisation

Jamie Lentin (3):
      kirkwood: Replace DNS-320/DNS-325 leds with dt bindings
      ARM: Kirkwood: Move common portions into a kirkwood-dnskw.dtsi
      ARM: Kirkwood: Describe DNS32? gpio-keys in DT.

Josh Coombs (1):
      ARM: Kirkwood: Initial DTS support for Kirkwood GoFlex Net

Michael Walle (3):
      ARM: kirkwood: use devicetree for orion-spi
      ARM: kirkwood: use devicetree for SPI on dreamplug
      ARM: kirkwood: Add LS-XHL and LS-CHLv2 support

Simon Baatz (2):
      ARM: Kirkwood: Fix PHY disable clk problems
      ARM: Orion: fix driver probe error handling with respect to clk

 .../devicetree/bindings/arm/mrvl/intc.txt          |   20 +++
 Documentation/devicetree/bindings/ata/marvell.txt  |   16 ++
 .../devicetree/bindings/gpio/mrvl-gpio.txt         |   23 +++
 .../devicetree/bindings/mtd/orion-nand.txt         |    4 +-
 .../devicetree/bindings/watchdog/marvel.txt        |   14 ++
 arch/arm/Kconfig                                   |    1 +
 arch/arm/boot/dts/kirkwood-dns320.dts              |   64 ++++----
 arch/arm/boot/dts/kirkwood-dns325.dts              |   70 ++++-----
 arch/arm/boot/dts/kirkwood-dnskw.dtsi              |   69 ++++++++
 arch/arm/boot/dts/kirkwood-dreamplug.dts           |   52 +++++-
 arch/arm/boot/dts/kirkwood-goflexnet.dts           |   99 ++++++++++++
 arch/arm/boot/dts/kirkwood-ib62x0.dts              |   40 ++++-
 arch/arm/boot/dts/kirkwood-iconnect.dts            |   44 +++++-
 arch/arm/boot/dts/kirkwood-lschlv2.dts             |   20 +++
 arch/arm/boot/dts/kirkwood-lsxhl.dts               |   20 +++
 arch/arm/boot/dts/kirkwood-lsxl.dtsi               |   95 +++++++++++
 arch/arm/boot/dts/kirkwood-ts219-6281.dts          |   21 +++
 arch/arm/boot/dts/kirkwood-ts219-6282.dts          |   21 +++
 arch/arm/boot/dts/kirkwood-ts219.dtsi              |   78 +++++++++
 arch/arm/boot/dts/kirkwood.dtsi                    |   66 +++++++-
 arch/arm/mach-dove/common.c                        |    4 +-
 arch/arm/mach-dove/irq.c                           |   58 +++----
 arch/arm/mach-kirkwood/Kconfig                     |   29 ++++
 arch/arm/mach-kirkwood/Makefile                    |    3 +
 arch/arm/mach-kirkwood/Makefile.boot               |    4 +
 arch/arm/mach-kirkwood/board-dnskw.c               |  143 -----------------
 arch/arm/mach-kirkwood/board-dreamplug.c           |   80 ----------
 arch/arm/mach-kirkwood/board-dt.c                  |   29 +++-
 arch/arm/mach-kirkwood/board-goflexnet.c           |   71 +++++++++
 arch/arm/mach-kirkwood/board-ib62x0.c              |   72 ---------
 arch/arm/mach-kirkwood/board-iconnect.c            |   56 -------
 arch/arm/mach-kirkwood/board-lsxl.c                |  135 ++++++++++++++++
 arch/arm/mach-kirkwood/board-ts219.c               |   82 ++++++++++
 arch/arm/mach-kirkwood/common.c                    |   72 +++++++--
 arch/arm/mach-kirkwood/common.h                    |   17 ++
 arch/arm/mach-kirkwood/irq.c                       |   38 ++---
 arch/arm/mach-mv78xx0/irq.c                        |   22 +--
 arch/arm/mach-orion5x/irq.c                        |   22 +--
 arch/arm/plat-orion/common.c                       |    1 +
 arch/arm/plat-orion/gpio.c                         |  166 +++++++++++++++-----
 arch/arm/plat-orion/include/plat/gpio.h            |   16 +-
 arch/arm/plat-orion/include/plat/irq.h             |    3 +-
 arch/arm/plat-orion/irq.c                          |   40 +++++
 drivers/ata/sata_mv.c                              |   42 +++--
 drivers/crypto/mv_cesa.c                           |    4 +
 drivers/mmc/host/mvsdio.c                          |    4 +
 drivers/mtd/nand/orion_nand.c                      |    6 +-
 drivers/net/ethernet/marvell/mv643xx_eth.c         |    6 +
 drivers/rtc/rtc-mv.c                               |    2 +-
 drivers/usb/host/ehci-orion.c                      |    4 +
 drivers/watchdog/orion_wdt.c                       |    8 +
 sound/soc/kirkwood/kirkwood-i2s.c                  |    8 +-
 52 files changed, 1485 insertions(+), 599 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ata/marvell.txt
 create mode 100644 Documentation/devicetree/bindings/watchdog/marvel.txt
 create mode 100644 arch/arm/boot/dts/kirkwood-dnskw.dtsi
 create mode 100644 arch/arm/boot/dts/kirkwood-goflexnet.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-lschlv2.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-lsxhl.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-lsxl.dtsi
 create mode 100644 arch/arm/boot/dts/kirkwood-ts219-6281.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-ts219-6282.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-ts219.dtsi
 create mode 100644 arch/arm/mach-kirkwood/board-goflexnet.c
 create mode 100644 arch/arm/mach-kirkwood/board-lsxl.c
 create mode 100644 arch/arm/mach-kirkwood/board-ts219.c
