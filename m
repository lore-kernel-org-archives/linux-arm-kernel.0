From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 24 Dec 2013 23:15:38 +0900
Subject: [GIT PULL 00/29] Third Round of Renesas ARM Based SoC Updates for
 v3.14
Message-ID: <cover.1387888861.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin, Hi Olof, Hi Arnd,

please consider this third round of Renesas ARM based SoC updates for v3.14.

It is based on a merge of:

* The second round of Renesas ARM based SoC updates for v3.14, tagged as
  renesas-soc2-for-v3.14, which I have sent a pull-request for.

* The second round of Renesas SH SCI updates for v3.14, tagged as
  renesas-sh-sci2-for-v3.14, which I have sent a pull-request for.

The reason for the merge is to provide SH SCI driver dependencies
for the SH SCI SoC changes in this series. That is, all
the changes by Laurent Pinchart in this series.


The following changes since commit e62db3848cd61e85a2b0b7828eb47de3ccda83e2:

  Merge branch 'sh-sci' into soc3-base (2013-12-24 21:08:27 +0900)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc3-for-v3.14

for you to fetch changes up to d85bcfa916ffdf078f188aeab60f738b290f4309:

  arm: shmobile: r7s72100: add i2c clocks (2013-12-24 21:09:19 +0900)

----------------------------------------------------------------
Third Round of Renesas ARM Based SoC Updates for v3.14

* Global
  - Don't set plat_sci_port scbrr_algo_id field
  - Declare SCIF register base and IRQ as resources
  - Don't define SCIF platform data in an array
  - Use macros to declare SCIF devices

* r7s72100 SoC (RZ/A1H)
  - Add i2c clocks

* r8a7778 (R-Car M1)
  - Add sound SCU clock support

----------------------------------------------------------------
Kuninori Morimoto (1):
      ARM: shmobile: r8a7778: add sound SCU clock support

Laurent Pinchart (27):
      ARM: shmobile: sh7372: Use macros to declare SCIF devices
      ARM: shmobile: sh73a0: Use macros to declare SCIF devices
      ARM: shmobile: r8a7740: Use macros to declare SCIF devices
      ARM: shmobile: r8a7779: Use macros to declare SCIF devices
      ARM: shmobile: r8a73a4: Don't define SCIF platform data in an array
      ARM: shmobile: r7s72100: Don't define SCIF platform data in an array
      ARM: shmobile: r8a7778: Don't define SCIF platform data in an array
      ARM: shmobile: r8a7791: Don't define SCIF platform data in an array
      ARM: shmobile: r8a7790: Don't define SCIF platform data in an array
      ARM: shmobile: sh7372: Declare SCIF register base and IRQ as resources
      ARM: shmobile: sh73a0: Declare SCIF register base and IRQ as resources
      ARM: shmobile: r7s72100: Declare SCIF register base and IRQ as resources
      ARM: shmobile: r8a73a4: Declare SCIF register base and IRQ as resources
      ARM: shmobile: r8a7740: Declare SCIF register base and IRQ as resources
      ARM: shmobile: r8a7779: Declare SCIF register base and IRQ as resources
      ARM: shmobile: sh7372: Don't set plat_sci_port scbrr_algo_id field
      ARM: shmobile: r8a7778: Declare SCIF register base and IRQ as resources
      ARM: shmobile: r8a7791: Declare SCIF register base and IRQ as resources
      ARM: shmobile: r8a7790: Declare SCIF register base and IRQ as resources
      ARM: shmobile: sh73a0: Don't set plat_sci_port scbrr_algo_id field
      ARM: shmobile: r7s72100: Don't set plat_sci_port scbrr_algo_id field
      ARM: shmobile: r8a7778: Don't set plat_sci_port scbrr_algo_id field
      ARM: shmobile: r8a73a4: Don't set plat_sci_port scbrr_algo_id field
      ARM: shmobile: r8a7740: Don't set plat_sci_port scbrr_algo_id field
      ARM: shmobile: r8a7790: Don't set plat_sci_port scbrr_algo_id field
      ARM: shmobile: r8a7779: Don't set plat_sci_port scbrr_algo_id field
      ARM: shmobile: r8a7791: Don't set plat_sci_port scbrr_algo_id field

Wolfram Sang (1):
      arm: shmobile: r7s72100: add i2c clocks

 arch/arm/mach-shmobile/clock-r7s72100.c |   8 +-
 arch/arm/mach-shmobile/clock-r8a7778.c  |  20 ++++
 arch/arm/mach-shmobile/setup-r7s72100.c |  64 ++++++-----
 arch/arm/mach-shmobile/setup-r8a73a4.c  |  66 ++++++-----
 arch/arm/mach-shmobile/setup-r8a7740.c  | 195 ++++++--------------------------
 arch/arm/mach-shmobile/setup-r8a7778.c  |  46 ++++----
 arch/arm/mach-shmobile/setup-r8a7779.c  | 128 +++++----------------
 arch/arm/mach-shmobile/setup-r8a7790.c  | 116 +++++++++----------
 arch/arm/mach-shmobile/setup-r8a7791.c  | 129 +++++++++------------
 arch/arm/mach-shmobile/setup-sh7372.c   | 160 +++++---------------------
 arch/arm/mach-shmobile/setup-sh73a0.c   | 191 +++++--------------------------
 11 files changed, 348 insertions(+), 775 deletions(-)
