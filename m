From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 13 Feb 2014 17:04:56 +0900
Subject: [GIT PULL 00/12] Second Round of Renesas ARM Based SoC Updates for
 v3.15
Message-ID: <cover.1392277789.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

please consider this second round of Renesas ARM Based SoC updates for v3.15.

This pull-request is based on the first round of such changes,
tagged as renesas-soc-for-v3.15, which I have previously sent a
pull-request for.


The following changes since commit 012a7069b5a10a0851584d71a1facdc40a972319:

  ARM: shmobile: r8a7790: Add PCI USB host clock support (2014-02-04 10:25:03 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc2-for-v3.15

for you to fetch changes up to 74b9ba5f35fbd071f313781498a9e244bcc6f03e:

  ARM: shmobile: r8a7790: Correct SYS DMAC clock defines (2014-02-07 09:24:07 +0900)

----------------------------------------------------------------
Second Round of Renesas ARM Based SoC Updates for v3.15

* r7s72100 SoC (RZ/A1H)
  - Add clock for SH Ethernet
  - Add RSPI clocks

* r8a7791 (R-Car M2)
  - Add QSPI clocks
  - Use 64-bit dma_addr_t

* r8a7790 (R-Car H2)
  - Correct SYS DMAC clock defines
  - Add audio clock
  - Add CA15-SCU, CA7-SCU
  - Add SYSC setup code
  - Use 64-bit dma_addr_t

----------------------------------------------------------------
Gaku Inami (1):
      ARM: shmobile: r8a7790 CA7-SCU enablement

Geert Uytterhoeven (3):
      ARM: shmobile: r7s72100 clock: Add RSPI clocks
      ARM: shmobile: r7s72100 clock: Add RSPI clocks for DT
      ARM: shmobile: r8a7791 clock: add QSPI clocks

Hisashi Nakamura (1):
      ARM: shmobile: r8a7790 SYSC setup code

Keita Kobayashi (1):
      ARM: shmobile: r8a7790 CA15-SCU enablement

Kuninori Morimoto (2):
      ARM: shmobile: r8a7778: add audio clock in new style
      ARM: shmobile: r8a7790: add audio clock

Magnus Damm (2):
      ARM: shmobile: Use 64-bit dma_addr_t on r8a7790/r8a7791
      ARM: shmobile: Break out R-Car SYSC PM code

Simon Horman (2):
      ARM: shmobile: r7s72100: Add clock for r7s72100-ether
      ARM: shmobile: r8a7790: Correct SYS DMAC clock defines

 arch/arm/boot/dts/r8a7790.dtsi                |  23 +++++
 arch/arm/mach-shmobile/Kconfig                |   3 +
 arch/arm/mach-shmobile/Makefile               |   3 +-
 arch/arm/mach-shmobile/clock-r7s72100.c       |  30 +++++-
 arch/arm/mach-shmobile/clock-r8a7778.c        |   4 +
 arch/arm/mach-shmobile/clock-r8a7790.c        |  20 ++++
 arch/arm/mach-shmobile/clock-r8a7791.c        |  11 ++
 arch/arm/mach-shmobile/include/mach/pm-rcar.h |  15 +++
 arch/arm/mach-shmobile/include/mach/r8a7779.h |  13 +--
 arch/arm/mach-shmobile/include/mach/r8a7790.h |   1 +
 arch/arm/mach-shmobile/pm-r8a7779.c           | 131 ++----------------------
 arch/arm/mach-shmobile/pm-r8a7790.c           |  45 ++++++++
 arch/arm/mach-shmobile/pm-rcar.c              | 142 ++++++++++++++++++++++++++
 arch/arm/mach-shmobile/smp-r8a7779.c          |  17 +--
 arch/arm/mach-shmobile/smp-r8a7790.c          |  17 +++
 include/dt-bindings/clock/r8a7790-clock.h     |   4 +-
 16 files changed, 331 insertions(+), 148 deletions(-)
 create mode 100644 arch/arm/mach-shmobile/include/mach/pm-rcar.h
 create mode 100644 arch/arm/mach-shmobile/pm-r8a7790.c
 create mode 100644 arch/arm/mach-shmobile/pm-rcar.c
