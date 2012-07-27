From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 27 Jul 2012 17:22:36 +0200
Subject: [PULL REQUEST] ARM: Orion DT converstions
Message-ID: <20120727152236.GB31179@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof

Here is the pull request for Orion DT changes.

I've not yet received an answer as to if the i2c-embedded branch is
stable. So i rebuilt the branch without it. The patches themselves are
identical, with our without.

The spi-3.6 branch is also merged as a runtime dependency. I also
merged my own v3.5-rc7-fixes, which you have already pulled. These are
needed for the mrvl->marvell rename.

Thanks
	Andrew

The following changes since commit 89fb2d77d5daa821e3868ea59963f28249974840:

  Merge branch 'v3.5-rc7-fixes' into v3.5-rc7-dt-v3 (2012-07-27 16:45:25 +0200)

are available in the git repository at:


  git at github.com:lunn/linux.git v3.5-rc7-dt-v3

for you to fetch changes up to f39c1101dd4489bca966974624fe19af1c8ebe23:

  ARM: Kirkwood: Replace mrvl with marvell (2012-07-27 16:50:57 +0200)

----------------------------------------------------------------
Andrew Lunn (14):
      ARM: Orion: DT support for IRQ and GPIO Controllers
      ARM: Orion: Add arch support needed for I2C via DT.
      ARM: Orion: DTify the watchdog timer.
      ATA: sata_mv: Add device tree support
      ARM: Kirkwood: Add basic device tree support for QNAP TS219.
      ARM: Kirkwood: Use DT to configure SATA device.
      ARM: Kirkwood: Describe DNS325 temperature sensor in DT.
      ARM: Kirkwood: Describe IB62x0 gpio-keys in DT.
      ARM: Kirkwood: Describe IB62x0 LEDs in DT.
      ARM: Kirkwood: Describe iConnects temperature sensor in DT.
      ARM: Kirkwood: Describe iConnects LEDs in DT.
      ARM: Kirkwood: Describe Dreamplug LEDs in DT.
      ARM: Kirkwood: Describe GoFlex Net LEDs and SATA in DT.
      ARM: Kirkwood: Replace mrvl with marvell

Jamie Lentin (3):
      ARM: Kirkwood: Replace DNS-320/DNS-325 leds with dt bindings
      ARM: Kirkwood: Move common portions into a kirkwood-dnskw.dtsi
      ARM: Kirkwood: Describe DNS32? gpio-keys in DT.

Josh Coombs (1):
      ARM: Kirkwood: Initial DTS support for Kirkwood GoFlex Net

Michael Walle (3):
      ARM: kirkwood: use devicetree for orion-spi
      ARM: kirkwood: Add LS-XHL and LS-CHLv2 support
      ARM: kirkwood: use devicetree for SPI on dreamplug

 .../devicetree/bindings/arm/mrvl/intc.txt          |   20 +++
 Documentation/devicetree/bindings/ata/marvell.txt  |   16 ++
 .../devicetree/bindings/gpio/mrvl-gpio.txt         |   23 +++
 .../devicetree/bindings/watchdog/marvel.txt        |   14 ++
 arch/arm/Kconfig                                   |    1 +
 arch/arm/boot/dts/kirkwood-dns320.dts              |   62 +++-----
 arch/arm/boot/dts/kirkwood-dns325.dts              |   68 ++++----
 arch/arm/boot/dts/kirkwood-dnskw.dtsi              |   69 ++++++++
 arch/arm/boot/dts/kirkwood-dreamplug.dts           |   50 ++++++
 arch/arm/boot/dts/kirkwood-goflexnet.dts           |   99 ++++++++++++
 arch/arm/boot/dts/kirkwood-ib62x0.dts              |   38 +++++
 arch/arm/boot/dts/kirkwood-iconnect.dts            |   42 +++++
 arch/arm/boot/dts/kirkwood-lschlv2.dts             |   20 +++
 arch/arm/boot/dts/kirkwood-lsxhl.dts               |   20 +++
 arch/arm/boot/dts/kirkwood-lsxl.dtsi               |   95 +++++++++++
 arch/arm/boot/dts/kirkwood-ts219-6281.dts          |   21 +++
 arch/arm/boot/dts/kirkwood-ts219-6282.dts          |   21 +++
 arch/arm/boot/dts/kirkwood-ts219.dtsi              |   78 +++++++++
 arch/arm/boot/dts/kirkwood.dtsi                    |   60 +++++++
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
 arch/arm/mach-kirkwood/common.c                    |    2 +
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
 drivers/watchdog/orion_wdt.c                       |    8 +
 43 files changed, 1387 insertions(+), 569 deletions(-)
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
