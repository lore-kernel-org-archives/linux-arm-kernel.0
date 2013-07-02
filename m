From: dsd@laptop.org (Daniel Drake)
Date: Mon,  1 Jul 2013 23:12:44 -0400 (EDT)
Subject: [GIT PULL] Initial OLPC XO-1.75/XO-4 support
Message-ID: <20130702031244.B2D74FAAD2@dev.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

These patches add support for booting OLPC XO-1.75 (Marvell MMP2) and OLPC
XO-4 (Marvell MMP3) which present device trees from OpenFirmware.

With the exception of the most recent patch, which has been acked (I think),
the other patches were posted about 2 weeks ago and haven't received
any comments from the MMP arch maintainers.

Please consider for the next available merge window (not sure if we're
now too late for 3.11, no big deal if so).

The following changes since commit 8bb495e3f02401ee6f76d1b1d77f3ac9f079e376:

  Linux 3.10 (2013-06-30 15:13:29 -0700)

are available in the git repository at:

  git://dev.laptop.org/users/dsd/linux-olpc arm-xo-boot

for you to fetch changes up to 99ba42c6d18a81935fcc40b604bbcccc1a04d0c5:

  mmp: irq: Don't clear unused interrupt enable bits (2013-07-01 20:54:12 -0600)

----------------------------------------------------------------
Chris Ball (1):
      ARM: mmp: Add compatible entries for OLPC XO laptops

Daniel Drake (4):
      clk: mmp: use global clock lock
      clk: mmp: add support for DT-defined clocks
      ARM: mmp: initialize l2x0 cache on MMP3
      mmp: irq: Don't clear unused interrupt enable bits

Mitch Bradley (1):
      ARM: mmp: irq: Improve DT layout

 .../devicetree/bindings/arm/mrvl/intc.txt          |  43 ++++---
 .../devicetree/bindings/arm/mrvl/mrvl.txt          |   8 ++
 .../devicetree/bindings/clock/mmp-apbc.txt         |  30 +++++
 .../devicetree/bindings/clock/mmp-apmu.txt         |  30 +++++
 arch/arm/Kconfig                                   |   5 +-
 arch/arm/boot/dts/mmp2.dtsi                        | 128 +++++++++----------
 arch/arm/mach-mmp/Kconfig                          |   5 +-
 arch/arm/mach-mmp/irq.c                            |  19 +--
 arch/arm/mach-mmp/mmp2-dt.c                        |   2 +
 arch/arm/mach-mmp/mmp2.c                           |   6 +
 drivers/clk/mmp/Makefile                           |   2 +-
 drivers/clk/mmp/clk-apbc.c                         | 104 +++++++++++-----
 drivers/clk/mmp/clk-apmu.c                         |  57 ++++++---
 drivers/clk/mmp/clk-mmp2.c                         | 135 ++++++++++++---------
 drivers/clk/mmp/clk.h                              |   8 +-
 drivers/clk/mmp/common.c                           |  13 ++
 16 files changed, 391 insertions(+), 204 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/mmp-apbc.txt
 create mode 100644 Documentation/devicetree/bindings/clock/mmp-apmu.txt
 create mode 100644 drivers/clk/mmp/common.c
