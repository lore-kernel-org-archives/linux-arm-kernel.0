From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri,  7 Aug 2015 11:12:03 +0900
Subject: [GIT PULL] Renesas ARM Based SoC CPG MSTP Clock Domain Updates for
 v4.3
Message-ID: <cover.1438911559.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC CPG MSTP clock domain updates
for v4.3.

This pull request is based on "Third Round of Renesas ARM Based SoC DT
Updates for v4.3", tagged as renesas-dt3-for-v4.3, which I have also sent a
pull-request for.

The reason for that base is that the DT changes in this series update nodes
added in that tag.

This series begins with driver changes and follows up with DT changes.
The latter depend on the former.


The following changes since commit 94bdc48d55ca10f90b4a625f0e443197e0013557:

  ARM: shmobile: sh73a0 dtsi: Add missing "gpio-ranges" to gpio node (2015-08-05 06:39:28 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-cpg-mstp-clock-domain-for-v4.3

for you to fetch changes up to 2daa8a5a8c0994893c2ca456303f0bf53e881cb9:

  ARM: shmobile: r8a7794 dtsi: Add CPG/MSTP Clock Domain (2015-08-05 06:42:51 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC CPG MSTP Clock Domain Updates for v4.3

* Add Clock Domain support to the Clock Pulse Generator
  (CPG) Module Stop (MSTP) Clocks driver using the generic PM Domain.

----------------------------------------------------------------
Geert Uytterhoeven (12):
      clk: shmobile: Add CPG/MSTP Clock Domain support
      clk: shmobile: r8a7778: Add CPG/MSTP Clock Domain support
      clk: shmobile: r8a7779: Add CPG/MSTP Clock Domain support
      clk: shmobile: rcar-gen2: Add CPG/MSTP Clock Domain support
      clk: shmobile: rz: Add CPG/MSTP Clock Domain support
      ARM: shmobile: r7s72100 dtsi: Add CPG/MSTP Clock Domain
      ARM: shmobile: r8a7778 dtsi: Add CPG/MSTP Clock Domain
      ARM: shmobile: r8a7779 dtsi: Add CPG/MSTP Clock Domain
      ARM: shmobile: r8a7790 dtsi: Add CPG/MSTP Clock Domain
      ARM: shmobile: r8a7791 dtsi: Add CPG/MSTP Clock Domain
      ARM: shmobile: r8a7793 dtsi: Add CPG/MSTP Clock Domain
      ARM: shmobile: r8a7794 dtsi: Add CPG/MSTP Clock Domain

 .../bindings/clock/renesas,r8a7778-cpg-clocks.txt  | 29 ++++++-
 .../bindings/clock/renesas,r8a7779-cpg-clocks.txt  | 30 +++++++-
 .../clock/renesas,rcar-gen2-cpg-clocks.txt         | 26 ++++++-
 .../bindings/clock/renesas,rz-cpg-clocks.txt       | 29 ++++++-
 arch/arm/boot/dts/r7s72100.dtsi                    | 19 +++++
 arch/arm/boot/dts/r8a7778.dtsi                     | 22 ++++++
 arch/arm/boot/dts/r8a7779.dtsi                     | 23 ++++++
 arch/arm/boot/dts/r8a7790.dtsi                     | 86 ++++++++++++++++++---
 arch/arm/boot/dts/r8a7791.dtsi                     | 88 ++++++++++++++++++++--
 arch/arm/boot/dts/r8a7793.dtsi                     |  7 ++
 arch/arm/boot/dts/r8a7794.dtsi                     | 29 +++++++
 arch/arm/mach-shmobile/Kconfig                     |  2 +
 drivers/clk/shmobile/clk-mstp.c                    | 87 +++++++++++++++++++++
 drivers/clk/shmobile/clk-r8a7778.c                 |  2 +
 drivers/clk/shmobile/clk-r8a7779.c                 |  2 +
 drivers/clk/shmobile/clk-rcar-gen2.c               |  2 +
 drivers/clk/shmobile/clk-rz.c                      |  3 +
 include/linux/clk/shmobile.h                       | 12 +++
 18 files changed, 470 insertions(+), 28 deletions(-)
