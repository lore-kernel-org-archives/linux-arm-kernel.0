From: nico@fluxnic.net (Nicolas Pitre)
Date: Sat, 05 Mar 2011 23:30:35 -0500 (EST)
Subject: Git pull request: Orion/Kirkwood updates for next merge window
Message-ID: <alpine.LFD.2.00.1103052320520.27995@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell, please pull:

	git://git.kernel.org/pub/scm/linux/kernel/git/nico/orion.git

This contains the following:

Alexander Clouter (4):
      [ARM] orion5x: accelerate NAND on the TS-78xx
      [ARM] update FPGA revisions for TS-7800
      ARM: orion5x: use safer FPGA ID 'default' for TS-78xx
      ARM: orion5x: fix compiler cast warnings in ts78xx-setup.c

Arnaud Patard (1):
      [ARM] Kirkwood: t5325: add audio support

Eric Cooper (3):
      [ARM] add machine-specific hook to machine_kexec
      [ARM] Kirkwood: enable PCIe before reading device ID register
      [ARM] Kirkwood: enable PCIe for kexec

Lennert Buytenhek (3):
      ARM: Remove dependency of plat-orion time code on mach directory includes.
      ARM: Remove dependency of plat-orion GPIO code on mach directory includes.
      ARM: Dove: Remove PXA compatibility IRQ defines.

Michael Spang (1):
      ARM: Enable TS-78XX features in unknown revisions

Nicolas Pitre (2):
      [ARM] Kirkwood: make kirkwood_find_tclk() static
      [ARM] Kirkwood: add LaCie d2 Network v2 to defconfig

Zintis P?tersons (1):
      [ARM] Kirkwood: initialize PCIE1 for QNAP TS-419P+

 arch/arm/configs/kirkwood_defconfig               |    1 +
 arch/arm/include/asm/kexec.h                      |    3 +
 arch/arm/kernel/machine_kexec.c                   |    7 +
 arch/arm/mach-dove/cm-a510.c                      |    1 +
 arch/arm/mach-dove/common.c                       |    8 +-
 arch/arm/mach-dove/common.h                       |    1 +
 arch/arm/mach-dove/dove-db-setup.c                |    1 +
 arch/arm/mach-dove/include/mach/bridge-regs.h     |    4 -
 arch/arm/mach-dove/include/mach/dove.h            |    3 +-
 arch/arm/mach-dove/include/mach/gpio.h            |   42 --
 arch/arm/mach-dove/include/mach/irqs.h            |    7 +-
 arch/arm/mach-dove/irq.c                          |   30 +-
 arch/arm/mach-kirkwood/common.c                   |   16 +-
 arch/arm/mach-kirkwood/common.h                   |    2 +
 arch/arm/mach-kirkwood/d2net_v2-setup.c           |    1 +
 arch/arm/mach-kirkwood/db88f6281-bp-setup.c       |    1 +
 arch/arm/mach-kirkwood/dockstar-setup.c           |    1 +
 arch/arm/mach-kirkwood/guruplug-setup.c           |    1 +
 arch/arm/mach-kirkwood/include/mach/bridge-regs.h |    3 -
 arch/arm/mach-kirkwood/include/mach/gpio.h        |   29 -
 arch/arm/mach-kirkwood/include/mach/kirkwood.h    |    2 +
 arch/arm/mach-kirkwood/irq.c                      |   22 +-
 arch/arm/mach-kirkwood/mpp.c                      |    3 -
 arch/arm/mach-kirkwood/mv88f6281gtw_ge-setup.c    |    1 +
 arch/arm/mach-kirkwood/netspace_v2-setup.c        |    3 +
 arch/arm/mach-kirkwood/netxbig_v2-setup.c         |    2 +
 arch/arm/mach-kirkwood/openrd-setup.c             |    3 +
 arch/arm/mach-kirkwood/pcie.c                     |    8 +
 arch/arm/mach-kirkwood/rd88f6192-nas-setup.c      |    1 +
 arch/arm/mach-kirkwood/rd88f6281-setup.c          |    1 +
 arch/arm/mach-kirkwood/sheevaplug-setup.c         |    2 +
 arch/arm/mach-kirkwood/t5325-setup.c              |   18 +
 arch/arm/mach-kirkwood/ts219-setup.c              |    1 +
 arch/arm/mach-kirkwood/ts41x-setup.c              |    9 +-
 arch/arm/mach-loki/common.c                       |    9 +-
 arch/arm/mach-loki/common.h                       |    1 +
 arch/arm/mach-loki/include/mach/bridge-regs.h     |    5 -
 arch/arm/mach-loki/lb88rc8480-setup.c             |    1 +
 arch/arm/mach-mv78xx0/buffalo-wxl-setup.c         |    1 +
 arch/arm/mach-mv78xx0/common.c                    |    8 +-
 arch/arm/mach-mv78xx0/common.h                    |    1 +
 arch/arm/mach-mv78xx0/db78x00-bp-setup.c          |    1 +
 arch/arm/mach-mv78xx0/include/mach/bridge-regs.h  |    4 -
 arch/arm/mach-mv78xx0/include/mach/gpio.h         |   31 -
 arch/arm/mach-mv78xx0/include/mach/mv78xx0.h      |    1 +
 arch/arm/mach-mv78xx0/irq.c                       |   22 +-
 arch/arm/mach-mv78xx0/mpp.c                       |    3 -
 arch/arm/mach-mv78xx0/rd78x00-masa-setup.c        |    1 +
 arch/arm/mach-orion5x/common.c                    |   10 +-
 arch/arm/mach-orion5x/common.h                    |    1 +
 arch/arm/mach-orion5x/d2net-setup.c               |    2 +
 arch/arm/mach-orion5x/db88f5281-setup.c           |    1 +
 arch/arm/mach-orion5x/dns323-setup.c              |    1 +
 arch/arm/mach-orion5x/edmini_v2-setup.c           |    1 +
 arch/arm/mach-orion5x/include/mach/bridge-regs.h  |    6 +-
 arch/arm/mach-orion5x/include/mach/gpio.h         |   28 -
 arch/arm/mach-orion5x/include/mach/orion5x.h      |    1 +
 arch/arm/mach-orion5x/irq.c                       |   19 +-
 arch/arm/mach-orion5x/kurobox_pro-setup.c         |    2 +
 arch/arm/mach-orion5x/ls-chl-setup.c              |    1 +
 arch/arm/mach-orion5x/ls_hgl-setup.c              |    1 +
 arch/arm/mach-orion5x/lsmini-setup.c              |    1 +
 arch/arm/mach-orion5x/mpp.c                       |    3 -
 arch/arm/mach-orion5x/mss2-setup.c                |    1 +
 arch/arm/mach-orion5x/mv2120-setup.c              |    1 +
 arch/arm/mach-orion5x/net2big-setup.c             |    1 +
 arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c      |    1 +
 arch/arm/mach-orion5x/rd88f5181l-ge-setup.c       |    1 +
 arch/arm/mach-orion5x/rd88f5182-setup.c           |    1 +
 arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c      |    1 +
 arch/arm/mach-orion5x/terastation_pro2-setup.c    |    1 +
 arch/arm/mach-orion5x/ts209-setup.c               |    1 +
 arch/arm/mach-orion5x/ts409-setup.c               |    1 +
 arch/arm/mach-orion5x/ts78xx-fpga.h               |   15 +-
 arch/arm/mach-orion5x/ts78xx-setup.c              |   78 +++-
 arch/arm/mach-orion5x/wnr854t-setup.c             |    1 +
 arch/arm/mach-orion5x/wrt350n-v2-setup.c          |    1 +
 arch/arm/plat-orion/gpio.c                        |  456 ++++++++++-----
 arch/arm/plat-orion/include/plat/gpio.h           |    5 +-
 arch/arm/plat-orion/include/plat/time.h           |    5 +-
 arch/arm/plat-orion/time.c                        |  119 +++--
 81 files changed, 656 insertions(+), 439 deletions(-)
