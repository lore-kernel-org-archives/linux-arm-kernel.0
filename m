From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  9 Oct 2013 15:49:27 +0900
Subject: [GIT PULL] Second round of Renesas ARM based SoC updates for v3.13
Message-ID: <cover.1381293239.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Kevin and Arnd,

please consider this second round of Renesas ARM based SoC updates for v3.13.

This pull-request is based on a merge of the following, each of which
you have already pulled. The reason for the merge is to eliminate conflicts.
* renesas-soc-for-v3.13
* renesas-smp-for-v3.13
* renesas-fixes4-for-v3.13

The following changes since commit 243b6db0588b1425cb020e764475e8e1c4eb40d9:

  Merge tag 'renesas-fixes4-for-v3.12' into soc2-base (2013-10-08 09:44:08 +0900)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc2-for-v3.13

for you to fetch changes up to 687c27b07050c21a62c4c975777c89e698649a6b:

  ARM: shmobile: r8a7791 SMP support (2013-10-08 09:53:02 +0900)

----------------------------------------------------------------
Second Round of Renesas ARM based SoC updates for v3.13

* SMP support for r8a7791 SoC
* r8a7779_init_irq_extpin() for DT for r8a7779 and r8a7778 SoCs
* Add HPB-DMAC to r8a7779 and r8a7778 SoCs
* Add r7s72100 SoC
* Make use of ARCH timer workaround on r8a7791 SoC
* Add IRQC platform device support to r8a7791 SoC
* Add I2C clocks and aliases for the DT mode for r8a7790 SoC
* Add MAC platform device to r8a73a4 SoC

----------------------------------------------------------------
Guennadi Liakhovetski (3):
      ARM: shmobile: r8a73a4: add a DMAC platform device and clock for it
      ARM: shmobile: r8a7790: add I2C clocks and aliases for the DT mode
      ARM: shmobile: r8a73a4: add a clock alias for the DMAC in DT mode

Kuninori Morimoto (2):
      ARM: shmobile: r8a7778: split r8a7778_init_irq_extpin() for DT
      ARM: shmobile: r8a7779: split r8a7779_init_irq_extpin() for DT

Magnus Damm (7):
      ARM: shmobile: Break out R-Car Gen2 setup code
      ARM: shmobile: Introduce r8a7791_add_standard_devices()
      ARM: shmobile: r8a7791 IRQC platform device support
      ARM: shmobile: r8a7791 Arch timer workaround
      ARM: shmobile: Initial r7s72100 SoC support
      ARM: shmobile: r7s72100 SCIF support
      ARM: shmobile: r8a7791 SMP support

Max Filippov (2):
      ARM: shmobile: r8a7778: add HPB-DMAC support
      ARM: shmobile: r8a7779: add HPB-DMAC support

 arch/arm/boot/dts/r7s72100.dtsi                 |  36 +++++
 arch/arm/mach-shmobile/Kconfig                  |   6 +
 arch/arm/mach-shmobile/Makefile                 |   6 +-
 arch/arm/mach-shmobile/board-lager-reference.c  |   2 +-
 arch/arm/mach-shmobile/board-lager.c            |   2 +-
 arch/arm/mach-shmobile/clock-r7s72100.c         | 202 ++++++++++++++++++++++++
 arch/arm/mach-shmobile/clock-r8a73a4.c          |   5 +-
 arch/arm/mach-shmobile/clock-r8a7790.c          |  12 +-
 arch/arm/mach-shmobile/include/mach/r7s72100.h  |   8 +
 arch/arm/mach-shmobile/include/mach/r8a73a4.h   |   9 ++
 arch/arm/mach-shmobile/include/mach/r8a7778.h   |   9 ++
 arch/arm/mach-shmobile/include/mach/r8a7779.h   |   8 +
 arch/arm/mach-shmobile/include/mach/r8a7790.h   |   6 +-
 arch/arm/mach-shmobile/include/mach/r8a7791.h   |   2 +
 arch/arm/mach-shmobile/include/mach/rcar-gen2.h |   8 +
 arch/arm/mach-shmobile/setup-r7s72100.c         |  88 +++++++++++
 arch/arm/mach-shmobile/setup-r8a73a4.c          |  91 +++++++++++
 arch/arm/mach-shmobile/setup-r8a7778.c          |  91 ++++++++++-
 arch/arm/mach-shmobile/setup-r8a7779.c          | 160 ++++++++++++++++++-
 arch/arm/mach-shmobile/setup-r8a7790.c          |  68 +-------
 arch/arm/mach-shmobile/setup-r8a7791.c          |  35 ++++
 arch/arm/mach-shmobile/setup-rcar-gen2.c        |  91 +++++++++++
 arch/arm/mach-shmobile/smp-r8a7791.c            |  62 ++++++++
 23 files changed, 929 insertions(+), 78 deletions(-)
 create mode 100644 arch/arm/boot/dts/r7s72100.dtsi
 create mode 100644 arch/arm/mach-shmobile/clock-r7s72100.c
 create mode 100644 arch/arm/mach-shmobile/include/mach/r7s72100.h
 create mode 100644 arch/arm/mach-shmobile/include/mach/rcar-gen2.h
 create mode 100644 arch/arm/mach-shmobile/setup-r7s72100.c
 create mode 100644 arch/arm/mach-shmobile/setup-rcar-gen2.c
 create mode 100644 arch/arm/mach-shmobile/smp-r8a7791.c
