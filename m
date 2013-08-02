From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 2 Aug 2013 15:42:16 -0400
Subject: [GIT PULL] ARM: mvebu: boards for v3.12
Message-ID: <20130802194216.GE5882@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

These have been in -next for a week or so.

thx,

Jason.


The following changes since commit 3b2f64d00c46e1e4e9bd0bb9bb12619adac27a4b:

  Linux 3.11-rc2 (2013-07-21 12:05:29 -0700)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/boards-3.12

for you to fetch changes up to fa8c5a811e0e7c3e1c49b2e58fcb4db549b5719a:

  ARM: plat-orion: add reg offset to DT irq driver stub (2013-07-25 21:07:33 +0000)

----------------------------------------------------------------
mvebu boards changes for v3.12

 - convert kirkwood, dove, orion5x to DT init of mv643xx_eth
    - _lots_ of board code removal :)
 - convert kirkwood, dove and orion5x to DT init of clocksource and irqchip

----------------------------------------------------------------
Sebastian Hesselbarth (14):
      ARM: dove: add gigabit ethernet and mvmdio device tree nodes
      ARM: kirkwood: add gigabit ethernet and mvmdio device tree nodes
      ARM: orion5x: add gigabit ethernet and mvmdio device tree nodes
      ARM: dove: remove legacy mv643xx_eth setup
      ARM: kirkwood: remove redundant DT board files
      ARM: kirkwood: remove legacy clk alias for mv643xx_eth
      ARM: orion5x: remove legacy mv643xx_eth board setup
      ARM: dove: move device tree nodes to DT irqchip and clocksource
      ARM: kirkwood: move device tree nodes to DT irqchip and clocksource
      ARM: orion5x: update intc device tree node to new reg layout
      ARM: dove: convert to DT irqchip and clocksource
      ARM: kirkwood: convert to DT irqchip and clocksource
      ARM: kirkwood: remove obsolete SDIO clock gate workaround
      ARM: plat-orion: add reg offset to DT irq driver stub

 arch/arm/boot/dts/dove-cubox.dts                   |   7 +
 arch/arm/boot/dts/dove.dtsi                        |  56 +++++-
 arch/arm/boot/dts/kirkwood-cloudbox.dts            |  16 ++
 arch/arm/boot/dts/kirkwood-db.dtsi                 |  16 ++
 arch/arm/boot/dts/kirkwood-dnskw.dtsi              |  16 ++
 arch/arm/boot/dts/kirkwood-dockstar.dts            |  17 ++
 arch/arm/boot/dts/kirkwood-dreamplug.dts           |  28 +++
 arch/arm/boot/dts/kirkwood-goflexnet.dts           |  16 ++
 .../arm/boot/dts/kirkwood-guruplug-server-plus.dts |  30 ++++
 arch/arm/boot/dts/kirkwood-ib62x0.dts              |  16 ++
 arch/arm/boot/dts/kirkwood-iconnect.dts            |  16 ++
 arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts      |  24 +++
 arch/arm/boot/dts/kirkwood-is2.dts                 |   2 +
 arch/arm/boot/dts/kirkwood-km_kirkwood.dts         |  16 ++
 arch/arm/boot/dts/kirkwood-lsxl.dtsi               |  28 +++
 arch/arm/boot/dts/kirkwood-mplcec4.dts             |  27 +++
 .../boot/dts/kirkwood-netgear_readynas_duo_v2.dts  |  16 ++
 arch/arm/boot/dts/kirkwood-ns2-common.dtsi         |  16 ++
 arch/arm/boot/dts/kirkwood-ns2.dts                 |   2 +
 arch/arm/boot/dts/kirkwood-ns2lite.dts             |   2 +
 arch/arm/boot/dts/kirkwood-ns2max.dts              |   2 +
 arch/arm/boot/dts/kirkwood-ns2mini.dts             |   2 +
 arch/arm/boot/dts/kirkwood-openblocks_a6.dts       |  16 ++
 arch/arm/boot/dts/kirkwood-sheevaplug-common.dtsi  |  16 ++
 arch/arm/boot/dts/kirkwood-topkick.dts             |  16 ++
 arch/arm/boot/dts/kirkwood-ts219-6281.dts          |   4 +-
 arch/arm/boot/dts/kirkwood-ts219-6282.dts          |   4 +-
 arch/arm/boot/dts/kirkwood-ts219.dtsi              |  16 ++
 arch/arm/boot/dts/kirkwood.dtsi                    |  87 +++++++++-
 .../dts/orion5x-lacie-ethernet-disk-mini-v2.dts    |  17 ++
 arch/arm/boot/dts/orion5x.dtsi                     |  34 +++-
 arch/arm/configs/kirkwood_defconfig                |  23 ---
 arch/arm/mach-dove/Kconfig                         |   2 +
 arch/arm/mach-dove/Makefile                        |   4 +-
 arch/arm/mach-dove/board-dt.c                      |  30 ++--
 arch/arm/mach-kirkwood/Kconfig                     | 193 +++------------------
 arch/arm/mach-kirkwood/Makefile                    |  26 +--
 arch/arm/mach-kirkwood/board-db88f628x-bp.c        |  24 ---
 arch/arm/mach-kirkwood/board-dnskw.c               |   7 -
 arch/arm/mach-kirkwood/board-dockstar.c            |  32 ----
 arch/arm/mach-kirkwood/board-dreamplug.c           |  35 ----
 arch/arm/mach-kirkwood/board-dt.c                  | 113 ++----------
 arch/arm/mach-kirkwood/board-goflexnet.c           |  34 ----
 arch/arm/mach-kirkwood/board-guruplug.c            |  33 ----
 arch/arm/mach-kirkwood/board-ib62x0.c              |  29 ----
 arch/arm/mach-kirkwood/board-iconnect.c            |  24 ---
 arch/arm/mach-kirkwood/board-iomega_ix2_200.c      |  34 ----
 arch/arm/mach-kirkwood/board-km_kirkwood.c         |  44 -----
 arch/arm/mach-kirkwood/board-lsxl.c                |  36 ----
 arch/arm/mach-kirkwood/board-mplcec4.c             |  35 ----
 arch/arm/mach-kirkwood/board-ns2.c                 |  35 ----
 arch/arm/mach-kirkwood/board-openblocks_a6.c       |  26 ---
 arch/arm/mach-kirkwood/board-readynas.c            |  27 ---
 arch/arm/mach-kirkwood/board-sheevaplug.c          |  27 ---
 arch/arm/mach-kirkwood/board-ts219.c               |  40 -----
 arch/arm/mach-kirkwood/board-usi_topkick.c         |  29 ----
 arch/arm/mach-kirkwood/common.h                    | 109 ------------
 arch/arm/mach-orion5x/edmini_v2-setup.c            |  11 +-
 arch/arm/plat-orion/irq.c                          |   2 +-
 59 files changed, 629 insertions(+), 1016 deletions(-)
 delete mode 100644 arch/arm/mach-kirkwood/board-db88f628x-bp.c
 delete mode 100644 arch/arm/mach-kirkwood/board-dockstar.c
 delete mode 100644 arch/arm/mach-kirkwood/board-dreamplug.c
 delete mode 100644 arch/arm/mach-kirkwood/board-goflexnet.c
 delete mode 100644 arch/arm/mach-kirkwood/board-guruplug.c
 delete mode 100644 arch/arm/mach-kirkwood/board-ib62x0.c
 delete mode 100644 arch/arm/mach-kirkwood/board-iconnect.c
 delete mode 100644 arch/arm/mach-kirkwood/board-iomega_ix2_200.c
 delete mode 100644 arch/arm/mach-kirkwood/board-km_kirkwood.c
 delete mode 100644 arch/arm/mach-kirkwood/board-lsxl.c
 delete mode 100644 arch/arm/mach-kirkwood/board-mplcec4.c
 delete mode 100644 arch/arm/mach-kirkwood/board-ns2.c
 delete mode 100644 arch/arm/mach-kirkwood/board-openblocks_a6.c
 delete mode 100644 arch/arm/mach-kirkwood/board-readynas.c
 delete mode 100644 arch/arm/mach-kirkwood/board-sheevaplug.c
 delete mode 100644 arch/arm/mach-kirkwood/board-ts219.c
 delete mode 100644 arch/arm/mach-kirkwood/board-usi_topkick.c
