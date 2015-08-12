From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 12 Aug 2015 17:15:13 +0900
Subject: [GIT PULL] Renesas ARM Based SoC CPG/MSTP Clock Driver Updates for
 v4.3
Message-ID: <cover.1439365731.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC CPG/MSTP clock driver updates
for v4.3.

As requested by Olof, this is a repost of patches broken out of a now
defunct pull-request, "Renesas ARM Based SoC CPG MSTP Clock Domain Updates
for v4.3".  The motivation being to have driver changes in a separate
branch to DT changes.

* These patches were Acked by Stephen Boyd in a reply to:
  [PATCH v2 00/14] ARM: shmobile: Add CPG Clock Domains
  https://lkml.org/lkml/2015/6/8/622
* The patch subjects were subsequently updated with other changes in:
  [PATCH v3 00/16] ARM: shmobile: Add CPG/MSTP Clock Domain
  https://lkml.org/lkml/2015/7/1/408
* And further updates were made in the patchset I queued up:
  [PATCH v4 00/16] ARM: shmobile: Add CPG/MSTP Clock Domain
  https://lkml.org/lkml/2015/8/4/389


The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:

  Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-clk-for-v4.3

for you to fetch changes up to f04b486d34ac6bab2aaa3988ee098b2bad3950de:

  clk: shmobile: rz: Add CPG/MSTP Clock Domain support (2015-08-12 10:31:28 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC CPG/MSTP Clock Driver Updates for v4.3

* Add Clock Domain support to the Clock Pulse Generator
  (CPG) Module Stop (MSTP) Clocks driver using the generic PM Domain.

----------------------------------------------------------------
Geert Uytterhoeven (5):
      clk: shmobile: Add CPG/MSTP Clock Domain support
      clk: shmobile: r8a7778: Add CPG/MSTP Clock Domain support
      clk: shmobile: r8a7779: Add CPG/MSTP Clock Domain support
      clk: shmobile: rcar-gen2: Add CPG/MSTP Clock Domain support
      clk: shmobile: rz: Add CPG/MSTP Clock Domain support

 .../bindings/clock/renesas,r8a7778-cpg-clocks.txt  | 29 +++++++-
 .../bindings/clock/renesas,r8a7779-cpg-clocks.txt  | 30 +++++++-
 .../clock/renesas,rcar-gen2-cpg-clocks.txt         | 26 ++++++-
 .../bindings/clock/renesas,rz-cpg-clocks.txt       | 29 +++++++-
 arch/arm/mach-shmobile/Kconfig                     |  2 +
 drivers/clk/shmobile/clk-mstp.c                    | 87 ++++++++++++++++++++++
 drivers/clk/shmobile/clk-r8a7778.c                 |  2 +
 drivers/clk/shmobile/clk-r8a7779.c                 |  2 +
 drivers/clk/shmobile/clk-rcar-gen2.c               |  2 +
 drivers/clk/shmobile/clk-rz.c                      |  3 +
 include/linux/clk/shmobile.h                       | 12 +++
 11 files changed, 213 insertions(+), 11 deletions(-)
