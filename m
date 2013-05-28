From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 28 May 2013 16:30:21 -0400
Subject: [GIT PULL 5/5] ARM: mvebu: clock SoC reorg for v3.11
In-Reply-To: <20130528202433.GH31290@titan.lakedaemon.net>
References: <20130528202140.GG31290@titan.lakedaemon.net>
 <20130528202433.GH31290@titan.lakedaemon.net>
Message-ID: <20130528203021.GK31290@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The following changes since commit 3d9939c92efdd4ced672b94994959ca71b141cb8:

  pci: mvebu: fix return value check in mvebu_pcie_probe() (2013-05-27 15:51:56 +0000)

are available in the git repository at:

  git://git.infradead.org/users/jcooper/linux.git tags/seb_clk-3.11

for you to fetch changes up to 279f759aac0990402407d97b21475677f499f4ac:

  clk: mvebu: desintegrate obsolete file (2013-05-28 15:18:37 +0000)

----------------------------------------------------------------
mvebu clock restructuring for v3.11

 - clk: mvebu
    - reorganize by SoC to remove built up #ifdefs
    - add clk flags per clock gate

Note: this branch only depends on mvebu/pcie in order to prevent managing a
tricky modify/remove file merge conflict.  By rebasing on mvebu/pcie, we are
able to build the resolution into the patch series.  The change is small, and
has been tested by the respective authors.

depends:
 - mvebu/pcie
    - mvebu/of_pci

----------------------------------------------------------------
Sebastian Hesselbarth (10):
      clk: mvebu: introduce per-clock-gate flags
      clk: mvebu: add common clock functions for core clk and clk gating
      clk: mvebu: add Dove SoC-centric clock init
      clk: mvebu: add Kirkwood SoC-centric clock init
      clk: mvebu: add Armada 370 SoC-centric clock init
      clk: mvebu: add Armada XP SoC-centric clock init
      ARM: dove: move DT boards to SoC-centric clock init
      ARM: kirkwood: move DT boards to SoC-centric clock init
      ARM: mvebu: move DT boards to SoC-centric clock init
      clk: mvebu: desintegrate obsolete file

 arch/arm/mach-dove/Kconfig          |   3 +-
 arch/arm/mach-dove/board-dt.c       |   3 +-
 arch/arm/mach-dove/common.c         |   1 -
 arch/arm/mach-kirkwood/Kconfig      |   3 +-
 arch/arm/mach-kirkwood/board-dt.c   |   3 +-
 arch/arm/mach-mvebu/Kconfig         |   5 +-
 arch/arm/mach-mvebu/armada-370-xp.c |   4 +-
 drivers/clk/mvebu/Kconfig           |  25 +-
 drivers/clk/mvebu/Makefile          |   8 +-
 drivers/clk/mvebu/armada-370.c      | 176 ++++++++++
 drivers/clk/mvebu/armada-xp.c       | 210 +++++++++++
 drivers/clk/mvebu/clk-core.c        | 675 ------------------------------------
 drivers/clk/mvebu/clk-core.h        |  18 -
 drivers/clk/mvebu/clk-gating-ctrl.c | 256 --------------
 drivers/clk/mvebu/clk-gating-ctrl.h |  22 --
 drivers/clk/mvebu/clk.c             |  23 --
 drivers/clk/mvebu/common.c          | 163 +++++++++
 drivers/clk/mvebu/common.h          |  48 +++
 drivers/clk/mvebu/dove.c            | 194 +++++++++++
 drivers/clk/mvebu/kirkwood.c        | 247 +++++++++++++
 include/linux/clk/mvebu.h           |  22 --
 21 files changed, 1072 insertions(+), 1037 deletions(-)
 create mode 100644 drivers/clk/mvebu/armada-370.c
 create mode 100644 drivers/clk/mvebu/armada-xp.c
 delete mode 100644 drivers/clk/mvebu/clk-core.c
 delete mode 100644 drivers/clk/mvebu/clk-core.h
 delete mode 100644 drivers/clk/mvebu/clk-gating-ctrl.c
 delete mode 100644 drivers/clk/mvebu/clk-gating-ctrl.h
 delete mode 100644 drivers/clk/mvebu/clk.c
 create mode 100644 drivers/clk/mvebu/common.c
 create mode 100644 drivers/clk/mvebu/common.h
 create mode 100644 drivers/clk/mvebu/dove.c
 create mode 100644 drivers/clk/mvebu/kirkwood.c
 delete mode 100644 include/linux/clk/mvebu.h
