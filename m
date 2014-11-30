From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 30 Nov 2014 11:56:09 -0500
Subject: [GIT PULL] mvebu: SoC suspend/resume for v3.19
Message-ID: <20141130165608.GT22670@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All,

This is a late pull request because we were finalizing a few last minute
patch routing issues.  This entire series has been in -next since the
22nd of November.  The commit IDs changed just today because I dropped
the gpio driver changes (LinusW had already applied them to his tree and
Acked the changes).

I kept this in a branch by itself in case it caused any trouble with
merging or build failures.  I'm reasonably confident those are all
identified and mitigated now.

Please pull.

thx,

Jason.


The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:

  Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-soc-suspend-3.19

for you to fetch changes up to 6e6db2bea3ea9424a0cb19d89d47664bc13e31bc:

  ARM: mvebu: add SDRAM controller description for Armada XP (2014-11-30 16:40:19 +0000)

----------------------------------------------------------------
mvebu SoC suspend changes for v3.19

 - Armada 370/XP suspend/resume support

 - mvebu SoC driver suspend/resume support
    - irqchip
    - clocksource
    - mbus
    - clk

----------------------------------------------------------------
Thomas Petazzoni (14):
      Documentation: dt-bindings: minimal documentation for MVEBU SDRAM controller
      irqchip: armada-370-xp: Add suspend/resume support
      clocksource: time-armada-370-xp: add suspend/resume support
      bus: mvebu-mbus: suspend/resume support
      bus: mvebu-mbus: provide a mechanism to save SDRAM window configuration
      clk: mvebu: add suspend/resume for gatable clocks
      ARM: mvebu: implement suspend/resume support for Armada XP
      ARM: mvebu: reserve the first 10 KB of each memory bank for suspend/resume
      ARM: mvebu: Armada XP GP specific suspend/resume code
      ARM: mvebu: make sure MMU is disabled in armada_370_xp_cpu_resume
      ARM: mvebu: synchronize secondary CPU clocks on resume
      ARM: mvebu: add suspend/resume DT information for Armada XP GP
      ARM: mvebu: adjust mbus controller description on Armada 370/XP
      ARM: mvebu: add SDRAM controller description for Armada XP

 .../devicetree/bindings/bus/mvebu-mbus.txt         |  17 +-
 .../memory-controllers/mvebu-sdram-controller.txt  |  21 ++
 arch/arm/boot/dts/armada-370-xp.dtsi               |   3 +-
 arch/arm/boot/dts/armada-xp-gp.dts                 |  19 +-
 arch/arm/boot/dts/armada-xp.dtsi                   |   5 +
 arch/arm/mach-mvebu/Makefile                       |   2 +-
 arch/arm/mach-mvebu/board-v7.c                     |  51 +++++
 arch/arm/mach-mvebu/common.h                       |   2 +
 arch/arm/mach-mvebu/platsmp.c                      |  31 ++-
 arch/arm/mach-mvebu/pm-board.c                     | 141 +++++++++++++
 arch/arm/mach-mvebu/pm.c                           | 218 +++++++++++++++++++++
 arch/arm/mach-mvebu/pmsu.h                         |   1 +
 arch/arm/mach-mvebu/pmsu_ll.S                      |   8 +
 drivers/bus/mvebu-mbus.c                           | 180 ++++++++++++++++-
 drivers/clk/mvebu/common.c                         |  32 ++-
 drivers/clocksource/time-armada-370-xp.c           |  25 +++
 drivers/irqchip/irq-armada-370-xp.c                |  52 +++++
 include/linux/mbus.h                               |   1 +
 18 files changed, 777 insertions(+), 32 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/mvebu-sdram-controller.txt
 create mode 100644 arch/arm/mach-mvebu/pm-board.c
 create mode 100644 arch/arm/mach-mvebu/pm.c
