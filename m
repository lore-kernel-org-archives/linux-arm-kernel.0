From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 16 Apr 2014 15:03:25 +0900
Subject: [GIT PULL] Renesas ARM Based SoC Updates for v3.16
Message-ID: <cover.1397627619.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC updates for v3.16.


The following changes since commit c9eaa447e77efe77b7fa4c953bd62de8297fd6c5:

  Linux 3.15-rc1 (2014-04-13 14:18:35 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc-for-v3.16

for you to fetch changes up to e35db38d66d1e4007cfc1bb90a05e11b4aaee2a8:

  ARM: shmobile: r8a7778/bockw: Move "select RENESAS_INTC_IRQPIN" under SoC (2014-04-14 11:28:43 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC Updates for v3.16

SH Mobile shared SoC code
* Add shared shmobile_init_delay()

r8a7791 (R-Car M2) and r8a7790 (R-Car H2) SoCs (R-Car Gen2 shared code)
* Cache Mode Monitor Register Value

r8a7791 (R-Car M2) SoC
Check r8a7791 MD21 at SMP boot

r8a7790 (R-Car H2) SoC
* Make use of r8a7790_add_standard_devices()
* Update r8a7791 CPU freq to 1500MHz

r8a7778 (R-Car M1) SoC
* Move "select RENESAS_INTC_IRQPIN" under SoC

emev2 (Emma Mobale EV2) SoC
*  Remove legacy EMEV2 SoC support

----------------------------------------------------------------
Geert Uytterhoeven (2):
      ARM: shmobile: rcar-gen2: Cache Mode Monitor Register Value
      ARM: shmobile: r8a7778/bockw: Move "select RENESAS_INTC_IRQPIN" under SoC

Magnus Damm (6):
      ARM: shmobile: Update r8a7791 CPU freq to 1500MHz in C
      ARM: shmobile: Add shared shmobile_init_delay()
      ARM: shmobile: Remove legacy EMEV2 SoC support
      ARM: shmobile: Remove EMEV2 header file
      ARM: shmobile: Make use of r8a7790_add_standard_devices()
      ARM: shmobile: Check r8a7791 MD21 at SMP boot

 arch/arm/boot/dts/Makefile                   |   3 +-
 arch/arm/mach-shmobile/Kconfig               |  13 +-
 arch/arm/mach-shmobile/Makefile              |   1 -
 arch/arm/mach-shmobile/clock-emev2.c         | 231 ---------------------------
 arch/arm/mach-shmobile/include/mach/common.h |   1 +
 arch/arm/mach-shmobile/include/mach/emev2.h  |   9 --
 arch/arm/mach-shmobile/setup-emev2.c         |  11 +-
 arch/arm/mach-shmobile/setup-r8a7790.c       |  12 +-
 arch/arm/mach-shmobile/setup-r8a7791.c       |   2 +-
 arch/arm/mach-shmobile/setup-rcar-gen2.c     |  16 +-
 arch/arm/mach-shmobile/smp-emev2.c           |   1 -
 arch/arm/mach-shmobile/smp-r8a7791.c         |  15 +-
 arch/arm/mach-shmobile/timer.c               |  28 ++++
 13 files changed, 66 insertions(+), 277 deletions(-)
 delete mode 100644 arch/arm/mach-shmobile/clock-emev2.c
 delete mode 100644 arch/arm/mach-shmobile/include/mach/emev2.h
