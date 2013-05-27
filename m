From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 27 May 2013 18:59:24 +0900
Subject: [GIT PULL] Renesas ARM based r8a7778 SoC updates for v3.11
Message-ID: <1369648773-7941-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Hi Olof,

The following changes since commit c7788792a5e7b0d5d7f96d0766b4cb6112d47d75:

  Linux 3.10-rc2 (2013-05-20 14:37:38 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc-r8a7778-for-v3.11

for you to fetch changes up to 35019d7f4aba4c4ccece584b872a8ebcdd62e6fa:

  ARM: shmobile: r8a7778: correct model name in Kconfig (2013-05-27 18:22:42 +0900)

----------------------------------------------------------------
Renesas ARM based sh7778 SoC updates for v3.11

* Correction of model name in Kconfig by Sergei Shtylyov
* Registration of SDHI and PFC devices by Kuninori Morimoto
* Extended clock coverage by Kuninori Morimoto
* Correction of ethernet device's platform driver name by Sergei Shtylyov

----------------------------------------------------------------
Kuninori Morimoto (7):
      ARM: shmobile: use do{ }while() on SH_CLK_SET_RATIO()
      ARM: shmobile: add GPIO IRQ macro
      ARM: shmobile: r8a7778: fixup Ether setup code position
      ARM: shmobile: r8a7778: use fixed ratio clock
      ARM: shmobile: r8a7778: Register PFC device
      ARM: shmobile: r8a7778: add SDHI clock support
      ARM: shmobile: r8a7778: Register SDHI device

Sergei Shtylyov (2):
      ARM: shmobile: r8a7778: fix Ether device name
      ARM: shmobile: r8a7778: correct model name in Kconfig

 arch/arm/mach-shmobile/Kconfig                |    3 +-
 arch/arm/mach-shmobile/clock-r8a7778.c        |  156 ++++++++++++++++++++++---
 arch/arm/mach-shmobile/include/mach/clock.h   |    4 +-
 arch/arm/mach-shmobile/include/mach/irqs.h    |    5 +
 arch/arm/mach-shmobile/include/mach/r8a7778.h |    3 +
 arch/arm/mach-shmobile/setup-r8a7778.c        |   65 ++++++++---
 6 files changed, 206 insertions(+), 30 deletions(-)
