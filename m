From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 27 May 2013 17:59:41 +0900
Subject: [GIT PULL] Renesas ARM based r8a7740 SoC updates for v3.11
Message-ID: <1369645193-3595-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Hi Olof,

The following changes since commit c7788792a5e7b0d5d7f96d0766b4cb6112d47d75:

  Linux 3.10-rc2 (2013-05-20 14:37:38 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc-r8a7740-for-v3.11

for you to fetch changes up to 0a9e1c1eef2b050a16685952ce20575348b94d5c:

  ARM: shmobile: clock-r8a7740: add TPU PWM support (2013-05-27 17:45:27 +0900)

----------------------------------------------------------------
Renesas ARM based r8a7740 SoC updates for v3.11

* Clean-ups from Kuninori Morimoto, Magnus Damm and Laurent Pinchart.
* Extended clock coverage by Bastian Hecht.
* Support for initialising GIC from OF by Bastian Hecht.
* Support for reference DT initialisation by Bastian Hecht.
  This is used in conjunction with other changes initialise
  the Armadillo 800 eva board in DT as much as possible.
* Suspend to RAM and CPUIdle support by Bastian Hecht
* Build fix for fallout by Arnd Bergmann from suspend to RAM change.

----------------------------------------------------------------
Arnd Bergmann (1):
      ARM: shmobile: fix sleep-r8a7740.S miscompiles

Bastian Hecht (7):
      ARM: shmobile: r8a7740: Add interim sh-eth device name to clocks list
      ARM: shmobile: r8a7740: Add DT name to clock list for CMT10
      ARM: shmobile: r8a7740: Add I2C DT clock names
      ARM: shmobile: r8a7740: Add OF support to initialze the GIC
      ARM: shmobile: r8a7740: Prepare for reference DT setup
      ARM: shmobile: r8a7740: Add Suspend-To-RAM A3SM
      ARM: shmobile: r8a7740: Add CPUIdle

Kuninori Morimoto (1):
      ARM: shmobile: remove ";" from SH_FIXED_RATIO_CLK*() macro

Laurent Pinchart (2):
      ARM: shmobile: r8a7740: Make private clock arrays static
      ARM: shmobile: clock-r8a7740: add TPU PWM support

Magnus Damm (1):
      ARM: shmobile: r8a7740 pinmux platform device cleanup

 arch/arm/boot/dts/r8a7740.dtsi                |  117 ++++++++++++++++++
 arch/arm/mach-shmobile/Makefile               |    2 +-
 arch/arm/mach-shmobile/clock-r8a7740.c        |   12 +-
 arch/arm/mach-shmobile/cpuidle-r8a7740.c      |   62 ++++++++++
 arch/arm/mach-shmobile/include/mach/clock.h   |    4 +-
 arch/arm/mach-shmobile/include/mach/r8a7740.h |    7 ++
 arch/arm/mach-shmobile/intc-r8a7740.c         |   24 +++-
 arch/arm/mach-shmobile/pm-r8a7740.c           |  165 ++++++++++++++++++++++++-
 arch/arm/mach-shmobile/setup-r8a7740.c        |   78 +++++-------
 arch/arm/mach-shmobile/sleep-r8a7740.S        |   57 +++++++++
 10 files changed, 469 insertions(+), 59 deletions(-)
 create mode 100644 arch/arm/mach-shmobile/cpuidle-r8a7740.c
 create mode 100644 arch/arm/mach-shmobile/sleep-r8a7740.S
