From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 13 Jun 2013 16:00:50 +0900
Subject: [PATCH 00/11] Renesas ARM-based SoC updates for v3.11 #2
Message-ID: <1371106861-25626-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Arnd,

this pull-request is based on renesas-soc-for-v3.11 which you have
previously pulled.

This pull may cause various conflicts though I believe all of them are not
difficult to resolve. The renesas-next-20130613 tag in my tree illustrates
how I have handled the conflicts with both changes already in arm-soc and
changes I intend to send pull requests for in the near future.

The following changes since commit 413bfd0e67894c930242482cd15ac09a800e2ab8:

  ARM: shmobile: sh73a0: div4 clocks must check the kick bit before changing rate (2013-06-07 14:24:52 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc2-for-v3.11

for you to fetch changes up to 018222f5d32bc5ca9fd830aebfeed10f1be96c93:

  ARM: shmobile: r8a7790: add clock definitions and aliases for MMCIF and SDHI (2013-06-12 21:07:38 +0900)

----------------------------------------------------------------
Second Round of Renesas ARM-based SoC updates for v3.11

* Ether device name updates for r8a7778 and r8a7779 Sergei Shtylyov
* Extended clock and driver coverage for r8a7778 by Goda-san and Morimoto-san
* Extended clock and coverage for r8a73a4 and r8a7790 by  Guennadi Liakhovetski
* HSCIF support for r8a7790 by Ulrich Hecht

----------------------------------------------------------------
Guennadi Liakhovetski (2):
      ARM: shmobile: r8a73a4: add clock definitions and aliases for MMCIF and SDHI
      ARM: shmobile: r8a7790: add clock definitions and aliases for MMCIF and SDHI

Kuninori Morimoto (6):
      ARM: shmobile: r8a7778: add support I2C clock
      ARM: shmobile: r8a7778: add support HSPI clock
      ARM: shmobile: r8a7778: add support MMC clock
      ARM: shmobile: r8a7778: add support I2C driver
      ARM: shmobile: r8a7778: add support HSPI driver
      ARM: shmobile: r8a7778: add support MMC driver

Sergei Shtylyov (2):
      ARM: shmobile: r8a7779: fix Ether device name
      ARM: shmobile: r8a7778: fix Ether device name

Ulrich Hecht (1):
      ARM: shmobile: r8a7790: HSCIF support

 arch/arm/mach-shmobile/clock-r8a73a4.c        | 22 +++++++---
 arch/arm/mach-shmobile/clock-r8a7778.c        | 23 +++++++++-
 arch/arm/mach-shmobile/clock-r8a7790.c        | 31 ++++++++++---
 arch/arm/mach-shmobile/include/mach/r8a7778.h |  5 +++
 arch/arm/mach-shmobile/setup-r8a7778.c        | 63 ++++++++++++++++++++++++++-
 arch/arm/mach-shmobile/setup-r8a7779.c        |  2 +-
 6 files changed, 131 insertions(+), 15 deletions(-)
