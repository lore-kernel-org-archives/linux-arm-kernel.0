From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 28 Feb 2014 23:19:47 -0500
Subject: [GIT PULL] ARM: mvebu: soc changes for v3.15 (incr. pull #2)
Message-ID: <20140301041947.GR1872@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All,

This is a big one for us :)  You've already pulled part of this as
mvebu/soc-3xx.  I merged that branch and mvebu/soc-kw back into
mvebu/soc.  This whole lot has been in -next all week.  Two minor issues
were discovered and patches added to correct them.

At this point I think the kirkwood and armada changes have been shaken
out enough that they no longer need their own branches.  If you don't
agree, just let me know and I'll send separate pull requests for the
per-SoC branches.

This is an incremental pull request from tags/mvebu-soc-3.15 in the
mvebu/soc branch up to tags/mvebu-soc-3.15-2.

There will be a small conflict between this branch and mvebu/dt.  This
is due to the kirkwood migration and maintaining bisectability.  I'll
detail the conflict in the mvebu/dt pull request.

Please pull.

thx,

Jason.


The following changes since commit 08bb3adfd3adeb4653095e7968b6a46cef940404:

  ARM: mvebu: remove unneeded ->map_io field for Armada 370/XP (2014-02-11 19:33:04 +0000)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-soc-3.15-2

for you to fetch changes up to 0d75ab68fd1a516f7a394fac6ba0f0ef34bbd18e:

  Merge branch 'mvebu/soc-kw' into mvebu/soc (2014-03-01 03:21:04 +0000)

----------------------------------------------------------------

mvebu soc changes for v3.15 (incremental pull #2)

 - mvebu
    - Add Armada 375, 380 and 385 SoCs

 - kirkwood
    - move kirkwood DT support to mach-mvebu
    - add mostly DT support for HP T5325 thin client

----------------------------------------------------------------
Andrew Lunn (17):
      ARM: kirkwood: Give pm.c its own header file.
      ARM: kirkwood: Convert mv88f6281gtw_ge switch setup to DT
      ARM: kirkwood: Drop printing the SoC type and revision
      ARM: kirkwood: Separate board-dt from common and pcie code.
      ARM: kirkwood: ioremap the cpu_config register before using it.
      ARM: kirkwood: ioremap memory control register
      ARM: mvebu: Add ARCH_MULTI_V7 to SoCs
      ARM: orion: Move cache-feroceon-l2.h out of plat-orion
      ARM: MM: Add DT binding for Feroceon L2 cache
      ARM: Fix default CPU selection for ARCH_MULTI_V5
      ARM: MM Enable building Feroceon L2 cache controller with ARCH_MVEBU
      ARM: mvebu: Move kirkwood DT boards into mach-mvebu
      ARM: mvebu: Let kirkwood use the system controller for restart
      ARM: mvebu: Enable mvebu-soc-id on Kirkwood
      ARM: mvebu: Simplify headers and make local
      ARM: kirkwood: Remove redundant kexec code
      ARM: kirkwood: Add HP T5325 thin client

Ezequiel Garcia (1):
      ARM: mvebu: Rename the ARCH_MVEBU menu option

Gregory CLEMENT (1):
      ARM: mvebu: add initial support for the Armada 375 SOCs

Jason Cooper (5):
      Merge tag 'tags/mvebu-soc-3.15' into mvebu/soc-3xx
      ARM: mvebu: Armada 375/38x depend on MULTI_V7
      ARM: kirkwood: select dtbs based on SoC
      Merge branch 'mvebu/soc-3xx' into mvebu/soc
      Merge branch 'mvebu/soc-kw' into mvebu/soc

Thomas Petazzoni (7):
      ARM: mvebu: rename armada-370-xp.c to board-v7.c
      ARM: mvebu: rename DT machine structure for Armada 370/XP
      ARM: mvebu: make CPU_PJ4B selection a per-SoC choice
      ARM: mvebu: add Armada 375 support to the system-controller driver
      ARM: mvebu: add workaround for data abort issue on Armada 375
      ARM: mvebu: add initial support for the Armada 380/385 SOCs
      Documentation: arm: update Marvell documentation about Armada 375/38x

 Documentation/arm/Marvell/README                   |  12 +-
 .../devicetree/bindings/arm/armada-375.txt         |   9 +
 .../devicetree/bindings/arm/armada-38x.txt         |  10 ++
 .../devicetree/bindings/arm/mrvl/feroceon.txt      |  16 ++
 .../bindings/arm/mvebu-system-controller.txt       |   3 +-
 arch/arm/Kconfig                                   |   2 +-
 arch/arm/boot/dts/Makefile                         |   7 +-
 arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts     |  62 +++++++
 .../asm/hardware}/cache-feroceon-l2.h              |   4 +-
 arch/arm/mach-kirkwood/Kconfig                     |   7 -
 arch/arm/mach-kirkwood/Makefile                    |   4 +-
 arch/arm/mach-kirkwood/board-dt.c                  | 113 +++++++++---
 arch/arm/mach-kirkwood/board-mv88f6281gtw_ge.c     |  50 ------
 arch/arm/mach-kirkwood/common.c                    |   3 +-
 arch/arm/mach-kirkwood/common.h                    |  13 --
 arch/arm/mach-kirkwood/include/mach/bridge-regs.h  |   2 +
 arch/arm/mach-kirkwood/pm.c                        |   9 +-
 arch/arm/mach-kirkwood/pm.h                        |  26 +++
 arch/arm/mach-mv78xx0/common.c                     |   2 +-
 arch/arm/mach-mvebu/Kconfig                        |  69 ++++++-
 arch/arm/mach-mvebu/Makefile                       |   7 +-
 arch/arm/mach-mvebu/board-t5325.c                  |  41 +++++
 .../arm/mach-mvebu/{armada-370-xp.c => board-v7.c} |  58 +++++-
 arch/arm/mach-mvebu/board.h                        |  22 +++
 arch/arm/mach-mvebu/kirkwood-pm.c                  |  76 ++++++++
 arch/arm/mach-mvebu/kirkwood-pm.h                  |  26 +++
 arch/arm/mach-mvebu/kirkwood.c                     | 199 +++++++++++++++++++++
 arch/arm/mach-mvebu/kirkwood.h                     |  22 +++
 arch/arm/mach-mvebu/mvebu-soc-id.c                 |   1 +
 arch/arm/mach-mvebu/system-controller.c            |  14 +-
 arch/arm/mm/Kconfig                                |   2 +-
 arch/arm/mm/cache-feroceon-l2.c                    |  45 ++++-
 32 files changed, 813 insertions(+), 123 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/armada-375.txt
 create mode 100644 Documentation/devicetree/bindings/arm/armada-38x.txt
 create mode 100644 Documentation/devicetree/bindings/arm/mrvl/feroceon.txt
 rename arch/arm/{plat-orion/include/plat => include/asm/hardware}/cache-feroceon-l2.h (75%)
 delete mode 100644 arch/arm/mach-kirkwood/board-mv88f6281gtw_ge.c
 create mode 100644 arch/arm/mach-kirkwood/pm.h
 create mode 100644 arch/arm/mach-mvebu/board-t5325.c
 rename arch/arm/mach-mvebu/{armada-370-xp.c => board-v7.c} (58%)
 create mode 100644 arch/arm/mach-mvebu/board.h
 create mode 100644 arch/arm/mach-mvebu/kirkwood-pm.c
 create mode 100644 arch/arm/mach-mvebu/kirkwood-pm.h
 create mode 100644 arch/arm/mach-mvebu/kirkwood.c
 create mode 100644 arch/arm/mach-mvebu/kirkwood.h
