From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  4 Sep 2014 10:12:38 +0900
Subject: [GIT PULL] Renesas ARM Based SoC Kconfig Cleanups for v3.18
Message-ID: <cover.1409792454.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC kconfig cleanups for v3.18.

This pull request is based on v3.17-rc2.
This is to avoid a conflict between v3.17-rc2 and this series.


The following changes since commit 52addcf9d6669fa439387610bc65c92fa0980cef:

  Linux 3.17-rc2 (2014-08-25 15:36:20 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-kconfig-cleanups-for-v3.18

for you to fetch changes up to 13298fbbdb3f6a0ef55419dc048e064c7a7b0ef8:

  ARM: shmobile: r8a7791 is now called "R-Car M2-W" (2014-09-02 09:32:08 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC Kconfig Cleanups for v3.18

* Update name of "R-Car M2-W" SoC (previously there was no "-W")
* Consolidate Legacy SH_CLK_CPG and CPU_V7 Kconfig
* Only select PM_RMOBILE for legacy case
* Cleanup pm-rcar.o and pm-rmobile.o build using Kconfig

----------------------------------------------------------------
Geert Uytterhoeven (1):
      ARM: shmobile: r8a7791 is now called "R-Car M2-W"

Magnus Damm (8):
      ARM: shmobile: Introduce a Kconfig entry for R-Mobile
      ARM: shmobile: Introduce a Kconfig entry for R-Car Gen1
      ARM: shmobile: Introduce a Kconfig entry for R-Car Gen2
      ARM: shmobile: Cleanup pm-rcar.o build using Kconfig
      ARM: shmobile: Cleanup pm-rmobile.o build using Kconfig
      ARM: shmobile: Only select PM_RMOBILE for legacy case
      ARM: shmobile: Consolidate Legacy CPU_V7 Kconfig
      ARM: shmobile: Consolidate Legacy SH_CLK_CPG Kconfig

 arch/arm/Kconfig                    |  2 +
 arch/arm/mach-shmobile/Kconfig      | 77 ++++++++++++++++++-------------------
 arch/arm/mach-shmobile/Makefile     | 30 +++++++--------
 arch/arm/mach-shmobile/pm-rcar.c    |  4 --
 arch/arm/mach-shmobile/pm-rmobile.c |  2 -
 arch/arm/mach-shmobile/pm-rmobile.h |  4 +-
 6 files changed, 54 insertions(+), 65 deletions(-)
