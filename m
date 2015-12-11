From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 11 Dec 2015 15:20:11 +0100
Subject: [GIT PULL] ARM: mvebu: soc for v4.5 (#1)
Message-ID: <87r3it6p9g.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the first pull request for soc for mvebu for v4.5.

The annoying part is that with this pull request then the kernel built
for Orion5x will be bigger as noticed by Detlef.

Gregory

The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:

  Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-soc-4.5-1

for you to fetch changes up to c5d431e8c511788556651b91debd7d77d4508f4b:

  ARM: dove: convert legacy dove to PMU support (2015-12-08 13:23:14 +0100)

----------------------------------------------------------------
mvebu soc for 4.5 (part 1)

- orion5x/mv78xx0 multiplatform conversion
- legacy dove PMU support conversion

----------------------------------------------------------------
Arnd Bergmann (7):
      ARM: orion: move watchdog setup to mach-orion5x
      ARM: orion: always use MULTI_IRQ_HANDLER
      ARM: orion: use SPARSE_IRQ everywhere
      ARM: mv78xx0: clean up mach/*.h headers
      ARM: mv78xx0: multiplatform support
      ARM: orion5x: clean up mach/*.h headers
      ARM: orion5x: multiplatform support

Russell King (2):
      soc: dove: add legacy support to PMU driver
      ARM: dove: convert legacy dove to PMU support

 arch/arm/Kconfig                                   |  30 +------
 arch/arm/configs/mv78xx0_defconfig                 |   3 +
 arch/arm/configs/orion5x_defconfig                 |   3 +
 arch/arm/mach-dove/cm-a510.c                       |   1 +
 arch/arm/mach-dove/common.c                        |  43 +++++++++
 arch/arm/mach-dove/dove-db-setup.c                 |   1 +
 arch/arm/mach-dove/include/mach/dove.h             |   2 +
 arch/arm/mach-dove/include/mach/entry-macro.S      |  33 -------
 arch/arm/mach-dove/include/mach/irqs.h             |   2 +-
 arch/arm/mach-dove/include/mach/pm.h               |  20 ++---
 arch/arm/mach-dove/irq.c                           | 100 +--------------------
 arch/arm/mach-mv78xx0/Kconfig                      |  15 +++-
 arch/arm/mach-mv78xx0/Makefile                     |   2 +
 .../mach-mv78xx0/{include/mach => }/bridge-regs.h  |   4 +-
 arch/arm/mach-mv78xx0/buffalo-wxl-setup.c          |   3 +-
 arch/arm/mach-mv78xx0/common.c                     |   4 +-
 arch/arm/mach-mv78xx0/db78x00-bp-setup.c           |   3 +-
 arch/arm/mach-mv78xx0/include/mach/entry-macro.S   |  41 ---------
 arch/arm/mach-mv78xx0/include/mach/hardware.h      |  14 ---
 arch/arm/mach-mv78xx0/include/mach/uncompress.h    |  46 ----------
 arch/arm/mach-mv78xx0/irq.c                        |  35 +++++++-
 arch/arm/mach-mv78xx0/{include/mach => }/irqs.h    |   4 +-
 arch/arm/mach-mv78xx0/mpp.c                        |   2 +-
 arch/arm/mach-mv78xx0/{include/mach => }/mv78xx0.h |   4 +-
 arch/arm/mach-mv78xx0/pcie.c                       |   2 +-
 arch/arm/mach-mv78xx0/rd78x00-masa-setup.c         |   3 +-
 arch/arm/mach-orion5x/Kconfig                      |  18 +++-
 arch/arm/mach-orion5x/Makefile                     |   2 +
 arch/arm/mach-orion5x/board-d2net.c                |   2 +-
 arch/arm/mach-orion5x/board-dt.c                   |   4 +-
 arch/arm/mach-orion5x/board-mss2.c                 |   4 +-
 arch/arm/mach-orion5x/board-rd88f5182.c            |   2 +-
 .../mach-orion5x/{include/mach => }/bridge-regs.h  |   4 +-
 arch/arm/mach-orion5x/common.c                     |  20 ++++-
 arch/arm/mach-orion5x/db88f5281-setup.c            |   3 +-
 arch/arm/mach-orion5x/dns323-setup.c               |   3 +-
 arch/arm/mach-orion5x/include/mach/entry-macro.S   |  25 ------
 arch/arm/mach-orion5x/include/mach/hardware.h      |  14 ---
 arch/arm/mach-orion5x/include/mach/uncompress.h    |  48 ----------
 arch/arm/mach-orion5x/irq.c                        |  13 +--
 arch/arm/mach-orion5x/{include/mach => }/irqs.h    |   4 +-
 arch/arm/mach-orion5x/kurobox_pro-setup.c          |   4 +-
 arch/arm/mach-orion5x/ls-chl-setup.c               |   3 +-
 arch/arm/mach-orion5x/ls_hgl-setup.c               |   3 +-
 arch/arm/mach-orion5x/mpp.c                        |   2 +-
 arch/arm/mach-orion5x/mv2120-setup.c               |   3 +-
 arch/arm/mach-orion5x/net2big-setup.c              |   3 +-
 arch/arm/mach-orion5x/{include/mach => }/orion5x.h |   4 +-
 arch/arm/mach-orion5x/pci.c                        |   2 +-
 arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c       |   3 +-
 arch/arm/mach-orion5x/rd88f5181l-ge-setup.c        |   3 +-
 arch/arm/mach-orion5x/rd88f5182-setup.c            |   3 +-
 arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c       |   3 +-
 arch/arm/mach-orion5x/terastation_pro2-setup.c     |   3 +-
 arch/arm/mach-orion5x/ts209-setup.c                |   3 +-
 arch/arm/mach-orion5x/ts409-setup.c                |   3 +-
 arch/arm/mach-orion5x/ts78xx-setup.c               |   3 +-
 arch/arm/mach-orion5x/tsx09-common.c               |   2 +-
 arch/arm/mach-orion5x/wnr854t-setup.c              |   3 +-
 arch/arm/mach-orion5x/wrt350n-v2-setup.c           |   3 +-
 arch/arm/plat-orion/common.c                       |  21 -----
 arch/arm/plat-orion/include/plat/common.h          |   2 -
 arch/arm/plat-orion/irq.c                          |   1 -
 arch/arm/plat-orion/mpp.c                          |   1 -
 drivers/soc/Makefile                               |   1 +
 drivers/soc/dove/pmu.c                             |  43 +++++++++
 include/linux/soc/dove/pmu.h                       |  19 ++++
 67 files changed, 269 insertions(+), 461 deletions(-)
 delete mode 100644 arch/arm/mach-dove/include/mach/entry-macro.S
 rename arch/arm/mach-mv78xx0/{include/mach => }/bridge-regs.h (92%)
 delete mode 100644 arch/arm/mach-mv78xx0/include/mach/entry-macro.S
 delete mode 100644 arch/arm/mach-mv78xx0/include/mach/hardware.h
 delete mode 100644 arch/arm/mach-mv78xx0/include/mach/uncompress.h
 rename arch/arm/mach-mv78xx0/{include/mach => }/irqs.h (95%)
 rename arch/arm/mach-mv78xx0/{include/mach => }/mv78xx0.h (98%)
 rename arch/arm/mach-orion5x/{include/mach => }/bridge-regs.h (92%)
 delete mode 100644 arch/arm/mach-orion5x/include/mach/entry-macro.S
 delete mode 100644 arch/arm/mach-orion5x/include/mach/hardware.h
 delete mode 100644 arch/arm/mach-orion5x/include/mach/uncompress.h
 rename arch/arm/mach-orion5x/{include/mach => }/irqs.h (94%)
 rename arch/arm/mach-orion5x/{include/mach => }/orion5x.h (99%)

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
