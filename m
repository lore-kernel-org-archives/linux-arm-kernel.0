From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 20 Jul 2018 14:05:30 +0200
Subject: [GIT PULL] Second Round of Renesas ARM Based SoC Updates for v4.19
Message-ID: <cover.1532087129.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these second round of Renesas ARM based SoC updates for v4.19.

This pull request is based on the previous round of
such requests, tagged as renesas-arm-soc-for-v4.19,
which I have already sent a pull-request for.


The following changes since commit c44e182e537492baaa37303fc0ee299222fce921:

  ARM: shmobile: convert to SPDX identifier (2018-06-18 12:00:29 +0200)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-arm-soc2-for-v4.19

for you to fetch changes up to 54f464e0c91f10212fa5699bfef1f104ee7d2213:

  ARM: shmobile: Always enable ARCH_TIMER on SoCs with A7 and/or A15 (2018-07-20 13:44:10 +0200)

----------------------------------------------------------------
Second Round of Renesas ARM Based SoC Updates for v4.19

* Always enable ARCH_TIMER on SoCs with A7 or A15

  All such SoCs have ARCH_TIMER so there is no need for it to be optional.
  This allows clean-up which is included in this change.

* Do not compile r8a7779_platform_cpu_kill when it is unused

  This avoids a warning by shuffling code into an existing #ifdef
  r8a7779 is the R-Car H1 SoC

* Add SMP enabler driver for the RZ/N1D (r9a06g032) SoC

  This is to allow SMP to be enabled via DT on the r9a06g032

* Stop compiling headsmp-apmu for non-SMP configs

  This is a minor clean-up allowing removal of an #ifdef

----------------------------------------------------------------
Arnd Bergmann (2):
      soc: r9a06g032: don't build SMP files for non-SMP config
      ARM: shmobile: r8a7779: hide unused r8a7779_platform_cpu_kill

Geert Uytterhoeven (2):
      ARM: shmobile: rcar-gen2: Stop compiling headsmp-apmu on !SMP
      ARM: shmobile: Always enable ARCH_TIMER on SoCs with A7 and/or A15

Michel Pollet (1):
      ARM: shmobile: Add the R9A06G032 SMP enabler driver

 arch/arm/mach-shmobile/Kconfig           |  2 +
 arch/arm/mach-shmobile/Makefile          |  2 +-
 arch/arm/mach-shmobile/headsmp-apmu.S    |  2 -
 arch/arm/mach-shmobile/setup-r8a73a4.c   |  1 -
 arch/arm/mach-shmobile/setup-rcar-gen2.c |  4 --
 arch/arm/mach-shmobile/smp-r8a7779.c     | 22 ++++----
 arch/arm/mach-shmobile/timer.c           |  8 ---
 drivers/soc/renesas/Makefile             |  3 +
 drivers/soc/renesas/r9a06g032-smp.c      | 96 ++++++++++++++++++++++++++++++++
 9 files changed, 113 insertions(+), 27 deletions(-)
 create mode 100644 drivers/soc/renesas/r9a06g032-smp.c
