From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 Apr 2014 07:44:53 +0900
Subject: [GIT PULL] Renesas ARM Based SoC Boards Updates for v3.16
Message-ID: <cover.1397774190.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM Based SoC Boards Updates for v3.16.


This pull request is based on
3984ba10dddc5a10 ("ARM: shmobile: r8a7791: Rename VSP1_SY clocks to VSP1_S").

That commit is part of the pull request
"Renesas ARM Based SoC Clock Updates for v3.16",
tagged as renesas-clock-for-v3.16, which I have previously sent.

I have not rebased this pull-request on top of renesas-clock-for-v3.16
in order to avoid churn in linux-next.

The reason for basing this pull-request on clock updates is
that many of its patches depend on shmobile_clk_workaround() which
is added as part of the clock updates.


The following changes since commit 58ea1d53ba93620ac50fef9d9720b2323971f243:

  ARM: shmobile: r8a7791: Rename VSP1_SY clocks to VSP1_S (2014-04-14 11:30:11 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-boards-for-v3.16

for you to fetch changes up to a09b2f0ba170dc89a67d6c4c4f027b37a085dad9:

  ARM: shmobile: lager legacy: Enable Quad SPI transfers for the SPI FLASH (2014-04-15 08:13:22 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC Boards Updates for v3.16

r8a7791 (R-Car M2) based Koelsch board
* Enable Quad SPI transfers for the SPI FLASH
* Clock workarounds for Ether, I2C, MSIOF, Quad SPI and SDHI
* Use shmobile_clk_workaround()

r8a7790 (R-Car H2) based Lager board
* Enable Quad SPI transfers for the SPI FLASH
* Switch to use dai info for R-Car sound
* Clock workarounds for Ether, MSIOF, MMCIF, Quad SPI and SDHI
* Use shmobile_clk_workaround()

r8a7778 (R-Car M1) based Bock-W board
* Switch to use dai info for R-Car sound

----------------------------------------------------------------
Geert Uytterhoeven (3):
      ARM: shmobile: koelsch-reference: Work around core clock issues
      ARM: shmobile: koelsch legacy: Enable Quad SPI transfers for the SPI FLASH
      ARM: shmobile: lager legacy: Enable Quad SPI transfers for the SPI FLASH

Kuninori Morimoto (3):
      ARM: shmobile: bockw: remove old style audio clock
      ARM: shmobile: bockw: switch to use dai info for R-Car sound
      ARM: shmobile: lager: switch to use dai info for R-Car sound

Magnus Damm (4):
      ARM: shmobile: Use shmobile_clk_workaround() on Lager
      ARM: shmobile: Use shmobile_clk_workaround() on Koelsch
      ARM: shmobile: Add Lager clock workarounds for SDHI and MMCIF
      ARM: shmobile: Add Koelsch clock workarounds for SDHI

Simon Horman (4):
      ARM: shmobile: koelsch: Annotate clk_names with __initconst
      ARM: shmobile: lager: Annotate clk_names with __initconst
      ARM: shmobile: koelsch-reference: Annotate clk_enables as __initconst
      ARM: shmobile: lager-reference: Work around core clock issues

 arch/arm/mach-shmobile/board-bockw.c             | 63 +++++++++++------
 arch/arm/mach-shmobile/board-koelsch-reference.c | 86 ++++++++++++------------
 arch/arm/mach-shmobile/board-koelsch.c           |  2 +-
 arch/arm/mach-shmobile/board-lager-reference.c   | 79 +++++++++++-----------
 arch/arm/mach-shmobile/board-lager.c             | 29 +++++---
 5 files changed, 142 insertions(+), 117 deletions(-)
