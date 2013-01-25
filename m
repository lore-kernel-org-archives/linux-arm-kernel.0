From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 25 Jan 2013 11:13:18 +0900
Subject: [GIT PULL] Renesas ARM-based SoC for v3.9
Message-ID: <1359080013-29189-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Arnd,

please consider the following soc enhancements for 3.9.

This series is based on a merge of the irqchip/gic-vic-move and
timer/cleanup branches in the arm-soc tree. There were a number of
conflicts in this merge, as indicated by the merge commit
6265b0f325eed54558b35769aecb1d79423295c7. In each case I took care to
match the merge made in the arm-soc tree which is evident in the for-next
branch.

----------------------------------------------------------------
The following changes since commit 6265b0f325eed54558b35769aecb1d79423295c7:

  Merge remote-tracking branches 'arm-soc/irqchip/gic-vic-move' and 'arm-soc/timer/cleanup' into soc (2013-01-24 17:57:20 +0900)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git soc

for you to fetch changes up to 977b5564fc613d662a346abfce05104ea5080a46:

  ARM: shmobile: r8a7779: scif .irqs used SCIx_IRQ_MUXED() (2013-01-25 09:10:45 +0900)

----------------------------------------------------------------
Bastian Hecht (4):
      ARM: shmobile: sh73a0: Add CPU sleep suspend
      ARM: shmobile: r8a7740: Add CPU sleep suspend
      ARM: SH-Mobile: sh73a0: Secondary CPUs handle own SCU flags
      ARM: SH-Mobile: sh73a0: Add CPU Hotplug

Guennadi Liakhovetski (3):
      ARM: sh7372: add clock lookup entries for DT-based devices
      ARM: sh7372: fix cache clean / invalidate order
      ARM: shmobile: add function declarations for sh7372 DT helper functions

Kuninori Morimoto (3):
      ARM: shmobile: r8a7740: add TMU timer support
      ARM: shmobile: sh73a0: fixup div4_clks bitmap
      ARM: shmobile: r8a7779: scif .irqs used SCIx_IRQ_MUXED()

Magnus Damm (1):
      ARM: mach-shmobile: sh73a0 external IRQ wake update

Simon Horman (4):
      ARM: shmobile: Remove duplicate inclusion of dma-mapping.h in setup-r8a7740.c
      ARM: mach-shmobile: sh73a0: Allow initialisation of GIC by DT
      ARM: mach-shmobile: sh73a0: Minimal setup using DT
      ARM: mach-shmobile: sh73a0: Initialise MMCIF using DT

 arch/arm/boot/dts/sh73a0-reference.dtsi        |   24 ++++++
 arch/arm/boot/dts/sh73a0.dtsi                  |   93 +++++++++++++++++++++++
 arch/arm/mach-shmobile/Makefile                |    3 +-
 arch/arm/mach-shmobile/board-armadillo800eva.c |    2 +
 arch/arm/mach-shmobile/board-kzm9g.c           |    2 +
 arch/arm/mach-shmobile/clock-r8a7740.c         |    6 +-
 arch/arm/mach-shmobile/clock-sh7372.c          |    9 +++
 arch/arm/mach-shmobile/clock-sh73a0.c          |   35 ++++++---
 arch/arm/mach-shmobile/headsmp-sh73a0.S        |   50 +++++++++++++
 arch/arm/mach-shmobile/include/mach/common.h   |    8 ++
 arch/arm/mach-shmobile/intc-sh73a0.c           |   16 ++--
 arch/arm/mach-shmobile/pm-r8a7740.c            |   22 ++++++
 arch/arm/mach-shmobile/pm-sh73a0.c             |   32 ++++++++
 arch/arm/mach-shmobile/setup-r8a7740.c         |   95 +++++++++++++++++++++++-
 arch/arm/mach-shmobile/setup-r8a7779.c         |   18 ++---
 arch/arm/mach-shmobile/setup-sh73a0.c          |   62 +++++++++++++++-
 arch/arm/mach-shmobile/sleep-sh7372.S          |   12 +--
 arch/arm/mach-shmobile/smp-sh73a0.c            |   66 ++++++++--------
 18 files changed, 485 insertions(+), 70 deletions(-)
 create mode 100644 arch/arm/boot/dts/sh73a0-reference.dtsi
 create mode 100644 arch/arm/boot/dts/sh73a0.dtsi
 create mode 100644 arch/arm/mach-shmobile/headsmp-sh73a0.S
 create mode 100644 arch/arm/mach-shmobile/pm-sh73a0.c
