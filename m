From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 7 Mar 2012 17:10:12 -0500
Subject: [GIT PULL v4] ARM: kirkwood: fdt conversion progress
Message-ID: <20120307221012.GH5050@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit d65b4e98d7ea3038b767b70fe8be959b2913f16d:

  Linux 3.3-rc3 (2012-02-08 19:21:53 -0800)

are available in the git repository at:
  git://git.infradead.org/users/jcooper/linux-kirkwood.git kirkwood_dt

---
Arnd,

My first two should match up with what you have already, the only
outlier is that Jean-Christophe's patch is needed, but I don't think
everyone agrees on it yet.

thx,

Jason.

Andrew Lunn (2):
      ARM: orion: spi: remove enable_clock_fix which is not used
      ARM: Kirkwood: Remove tclk from kirkwood_asoc_platform_data.

Jason Cooper (10):
      ARM: kirkwood: add dreamplug (fdt) support.
      ARM: kirkwood: convert uart0 to devicetree.
      ARM: kirkwood: fdt: use mrvl ticker symbol
      ARM: kirkwood: fdt: absorb kirkwood_init()
      ARM: kirkwood: add interrupt controller to devicetree.
      ARM: kirkwood: rtc-mv devicetree bindings
      ARM: kirkwood: use devicetree for rtc-mv
      ARM: kirkwood: mv_cesa devicetree support.
      ARM: kirkwood: use devicetree for orion-ehci
      ARM: kirkwood: use devicetree to init sata_mv

Jean-Christophe PLAGNIOL-VILLARD (1):
      of: add dma-mask binding

Michael Walle (3):
      ARM: kirkwood: mv_cesa devicetree bindings
      ARM: kirkwood: ehci-orion: add device tree binding
      ARM: kirkwood: sata_mv: add device tree binding

 .../devicetree/bindings/crypto/mv_cesa.txt         |   18 ++
 .../devicetree/bindings/usb/ehci-orion.txt         |    5 +
 arch/arm/boot/dts/kirkwood-dreamplug.dts           |   41 ++++
 arch/arm/boot/dts/kirkwood.dtsi                    |   26 +++
 arch/arm/mach-kirkwood/Kconfig                     |   14 ++
 arch/arm/mach-kirkwood/Makefile                    |    1 +
 arch/arm/mach-kirkwood/Makefile.boot               |    2 +
 arch/arm/mach-kirkwood/board-dt.c                  |  206 ++++++++++++++++++++
 arch/arm/mach-kirkwood/common.c                    |   41 ++++-
 arch/arm/mach-kirkwood/common.h                    |    6 +
 arch/arm/plat-orion/include/plat/audio.h           |    1 -
 drivers/ata/sata_mv.c                              |   18 ++-
 drivers/crypto/mv_cesa.c                           |   13 ++
 drivers/of/platform.c                              |   26 +++-
 drivers/rtc/rtc-mv.c                               |    9 +
 drivers/spi/spi-orion.c                            |    5 -
 drivers/usb/host/ehci-orion.c                      |   50 +++++-
 include/linux/spi/orion_spi.h                      |    1 -
 18 files changed, 464 insertions(+), 19 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/crypto/mv_cesa.txt
 create mode 100644 Documentation/devicetree/bindings/usb/ehci-orion.txt
 create mode 100644 arch/arm/boot/dts/kirkwood-dreamplug.dts
 create mode 100644 arch/arm/boot/dts/kirkwood.dtsi
 create mode 100644 arch/arm/mach-kirkwood/board-dt.c
