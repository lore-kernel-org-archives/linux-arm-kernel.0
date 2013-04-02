From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  2 Apr 2013 14:06:56 +0900
Subject: [GIT PULL] Renesas ARM SoC updates for v3.10 #2
Message-ID: <1364879246-9470-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Hi Olof,

The following changes since commit 4c82e452732784419fd616cf1acf2bc9b004aae1:

  Merge tag 'renesas-intc-external-irq2-for-v3.10' into soc-base (2013-04-02 10:55:57 +0900)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc2-for-v3.10

for you to fetch changes up to 8585deb18580d04209a2986430aa0959ef38fce2:

  ARM: shmobile: r8a7790 SoC 64-bit DT support (2013-04-02 11:02:21 +0900)

----------------------------------------------------------------
Second round of Renesas ARM SoC updates for v3.10

Some Highlights:

* Add r8a7790 SoC
* Add r8a73a4 SoC
* Migrate r8a7740 SoC from INTC to GIC
* Add thermal driver support to r8a73a4 SoC
* Add irqpin DT nodes to sh73a0 SoC
* Add SCIF support to r8a7778 SoC

This pull request is based on a merge of:
git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas renesas-soc-for-v3.10
git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas renesas-intc-external-irq2-for-v3.10

----------------------------------------------------------------
Bastian Hecht (1):
      ARM: shmobile: r8a7740: Migrate from INTC to GIC

Guennadi Liakhovetski (3):
      ARM: shmobile: sh73a0: wait for completion when kicking the clock
      ARM: shmobile: sh73a0: add irqpin DT nodes
      ARM: shmobile: sh73a0: add a TWD clock

Kuninori Morimoto (15):
      ARM: shmobile: add R8A7778 basis support
      ARM: shmobile: r8a7778 SCIF support
      ARM: shmobile: r8a73a4: add thermal driver support
      ARM: shmobile: sh73a0: remove DIV4_ZT* clocks
      ARM: shmobile: sh7372: remove DIV4_ZT* clocks
      ARM: shmobile: add struct clk_ratio and fixed ratio clock macro
      ARM: shmobile: sh7372: use fixed ratio clock
      ARM: shmobile: sh73a0: use fixed ratio clock
      ARM: shmobile: r8a7740: tidyup comment/implementation mismatch
      ARM: shmobile: r8a7740: use fixed ratio clock
      ARM: shmobile: r8a7779: remove DIV4 clocks and use fixed ratio clock
      ARM: shmobile: sh7372: move global functions to sh7372.h
      ARM: shmobile: sh73a0: move global functions to sh73a0.h
      ARM: shmobile: r8a7740: move global functions to r8a7740.h
      ARM: shmobile: r8a7779: move global functions to r8a7779.h

Magnus Damm (9):
      ARM: shmobile: Initial r8a73a4 SoC support V3
      ARM: shmobile: r8a73a4 SCIF support V3
      ARM: shmobile: r8a73a4 IRQC support V2
      ARM: shmobile: r8a73a4 PFC support
      ARM: shmobile: Disallow PINCTRL without GPIOLIB
      ARM: shmobile: Initial r8a7790 SoC support
      ARM: shmobile: r8a7790 SCIF support
      ARM: shmobile: r8a7790 IRQC support
      ARM: shmobile: r8a7790 PFC support

Takashi YOSHII (2):
      ARM: shmobile: r8a73a4 SoC 64-bit DT support
      ARM: shmobile: r8a7790 SoC 64-bit DT support

 arch/arm/Kconfig                               |    2 +-
 arch/arm/boot/dts/r8a73a4.dtsi                 |   94 ++++
 arch/arm/boot/dts/r8a7778.dtsi                 |   35 ++
 arch/arm/boot/dts/r8a7790.dtsi                 |   63 +++
 arch/arm/boot/dts/sh73a0.dtsi                  |   81 +++
 arch/arm/mach-shmobile/Kconfig                 |   26 +
 arch/arm/mach-shmobile/Makefile                |    3 +
 arch/arm/mach-shmobile/board-armadillo800eva.c |   35 +-
 arch/arm/mach-shmobile/clock-r8a73a4.c         |  115 +++++
 arch/arm/mach-shmobile/clock-r8a7740.c         |  114 ++---
 arch/arm/mach-shmobile/clock-r8a7778.c         |  104 ++++
 arch/arm/mach-shmobile/clock-r8a7779.c         |  196 ++++----
 arch/arm/mach-shmobile/clock-r8a7790.c         |   93 ++++
 arch/arm/mach-shmobile/clock-sh7372.c          |   50 +-
 arch/arm/mach-shmobile/clock-sh73a0.c          |  115 ++---
 arch/arm/mach-shmobile/clock.c                 |   13 +
 arch/arm/mach-shmobile/include/mach/clock.h    |   39 ++
 arch/arm/mach-shmobile/include/mach/common.h   |   54 --
 arch/arm/mach-shmobile/include/mach/r8a73a4.h  |    8 +
 arch/arm/mach-shmobile/include/mach/r8a7740.h  |    9 +
 arch/arm/mach-shmobile/include/mach/r8a7778.h  |   28 ++
 arch/arm/mach-shmobile/include/mach/r8a7779.h  |   13 +
 arch/arm/mach-shmobile/include/mach/r8a7790.h  |    8 +
 arch/arm/mach-shmobile/include/mach/sh7372.h   |   12 +
 arch/arm/mach-shmobile/include/mach/sh73a0.h   |   15 +
 arch/arm/mach-shmobile/intc-r8a7740.c          |  641 ++----------------------
 arch/arm/mach-shmobile/setup-r8a73a4.c         |  202 ++++++++
 arch/arm/mach-shmobile/setup-r8a7740.c         |  192 +++++--
 arch/arm/mach-shmobile/setup-r8a7778.c         |  193 +++++++
 arch/arm/mach-shmobile/setup-r8a7790.c         |  137 +++++
 drivers/pinctrl/sh-pfc/pfc-r8a7740.c           |   64 +--
 31 files changed, 1732 insertions(+), 1022 deletions(-)
 create mode 100644 arch/arm/boot/dts/r8a73a4.dtsi
 create mode 100644 arch/arm/boot/dts/r8a7778.dtsi
 create mode 100644 arch/arm/boot/dts/r8a7790.dtsi
 create mode 100644 arch/arm/mach-shmobile/clock-r8a73a4.c
 create mode 100644 arch/arm/mach-shmobile/clock-r8a7778.c
 create mode 100644 arch/arm/mach-shmobile/clock-r8a7790.c
 create mode 100644 arch/arm/mach-shmobile/include/mach/clock.h
 create mode 100644 arch/arm/mach-shmobile/include/mach/r8a73a4.h
 create mode 100644 arch/arm/mach-shmobile/include/mach/r8a7778.h
 create mode 100644 arch/arm/mach-shmobile/include/mach/r8a7790.h
 create mode 100644 arch/arm/mach-shmobile/setup-r8a73a4.c
 create mode 100644 arch/arm/mach-shmobile/setup-r8a7778.c
 create mode 100644 arch/arm/mach-shmobile/setup-r8a7790.c
