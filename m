From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 23 Jun 2014 11:26:36 +0900
Subject: [GIT PULL] Renesas ARM Based SoC r8a7779-multiplatform Updates for
 v3.17
Message-ID: <cover.1403487423.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC r8a7779-multiplatform updates
for v3.17.

This pull request is based on 'Renesas ARM Based SoC Header Cleanup for v3.17',
tagged as header-cleanup-for-v3.17, which I have already sent a
pull-request for.


The following changes since commit 62872989bdbf1245d7239b9f4c05a8ee7c775ed5:

  ARM: shmobile: Move rcar-gen2.h, cleanup r8a7790 case (2014-06-17 17:09:40 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git renesas-r8a7779-multiplatform-for-v3.17

for you to fetch changes up to c1a0f9932b66b2298163c31f8ac3f2844476e1c2:

  ARM: shmobile: marzen: Do not use workaround for scif devices (2014-06-17 19:56:37 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC r8a7779-multiplatform Updates for v3.17

Move r8a7779 SoC and its Marzen board to use common clocks,
multiplatform and initialise SCIF (serial) devices using DT.

----------------------------------------------------------------
Geert Uytterhoeven (2):
      ARM: shmobile: r8a7779 dtsi: Update unit-addresses for clocks
      ARM: shmobile: r8a7779 dtsi: Correct #address-cells/#size-cells for clocks

Simon Horman (22):
      ARM: shmobile: r8a7779: Add clocks
      ARM: shmobile: Sync Marzen DTS with Marzen reference DTS
      ARM: shmobile: marzen: Specify external clock frequency in DT
      ARM: shmobile: r8a7779: Reference clocks
      ARM: shmobile: r8a7779: Add helper to read mode pins
      ARM: shmobile: r8a7779: Move r8a7779_earlytimer_init to clock-r8a7779.c
      ARM: shmobile: marzen-reference: Move clock and OF device initialisation into board code
      ARM: shmobile: r8a7779: Initial multiplatform support
      ARM: shmobile: marzen-reference: Initialize CPG device
      ARM: shmobile: marzen-reference: Instantiate clkdevs for SCIF and TMU
      ARM: shmobile: Remove non-multiplatform Marzen reference support
      ARM: shmobile: Let Marzen multiplatform boot with Marzen DTB
      ARM: shmobile: Remove Marzen reference DTS
      ARM: shmobile: marzen-reference: Remove legacy clock support
      ARM: shmobile: r8a7779: Add Maximum CPU Frequency to DTS
      ARM: shmobile: r8a7779: Use DT CPU Frequency in common case
      ARM: shmobile: marzen-reference: Use DT CPU Frequency
      ARM: shmobile: r8a7779: Remove unused r8a7779_init_delay()
      ARM: shmobile: r8a7779: Add scif nodes to dtsi
      ARM: shmobile: marzen: Remove early_printk from command line
      ARM: shmobile: marzen: Initialise SCIF devices using DT
      ARM: shmobile: marzen: Do not use workaround for scif devices

 arch/arm/boot/dts/Makefile                      |   4 +-
 arch/arm/boot/dts/r8a7779-marzen-reference.dts  | 121 -------------
 arch/arm/boot/dts/r8a7779-marzen.dts            | 116 ++++++++++++-
 arch/arm/boot/dts/r8a7779.dtsi                  | 220 ++++++++++++++++++++++++
 arch/arm/mach-shmobile/Kconfig                  |  23 ++-
 arch/arm/mach-shmobile/Makefile                 |   2 +-
 arch/arm/mach-shmobile/Makefile.boot            |   1 -
 arch/arm/mach-shmobile/board-marzen-reference.c |  24 ++-
 arch/arm/mach-shmobile/clock-r8a7779.c          |  22 ++-
 arch/arm/mach-shmobile/include/mach/r8a7779.h   |   2 +-
 arch/arm/mach-shmobile/setup-r8a7779.c          |  45 +++--
 11 files changed, 407 insertions(+), 173 deletions(-)
 delete mode 100644 arch/arm/boot/dts/r8a7779-marzen-reference.dts
