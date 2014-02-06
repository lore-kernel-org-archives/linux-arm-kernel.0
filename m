From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  6 Feb 2014 15:21:05 +0900
Subject: [GIT PULL 00/13] Renesas ARM Based SoC Updates for v3.15
Message-ID: <cover.1391666228.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

please consider these Renesas ARM based SoC updates for v3.15.

This pull request is based on "Renesas CPG update for v3.15",
tagged as renesas-cpg-for-v3.15, which I am also sending a pull request for
today. The reason for the dependency is to provide driver support for
the "Wait for status on selected MSTP clocks" patches in this pull-request.
These are correctness fixes.


The following changes since commit a028c6da34d434e35ba8322568c756ea97ff3c18:

  ARM: shmobile: wait for MSTP clock status to toggle, when enabling it (2014-02-04 10:22:39 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc-for-v3.15

for you to fetch changes up to 012a7069b5a10a0851584d71a1facdc40a972319:

  ARM: shmobile: r8a7790: Add PCI USB host clock support (2014-02-04 10:25:03 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC Updates for v3.15

* r7s72100 SoC (RZ/A1H)
  - Add i2c clocks (portion missing from previous patch due to miss-merge)

* r8a7791 (R-Car M2)
  - Add SATA clocks
  - Add ZS clock
  - Wait for status on all MSTP clocks
 -- Add I2C and VIN clocks

* r8a7790 (R-Car H2)
  - Add PCI USB host clock support
  - Add Audio DMAC, SATA and VIN clocks
  - Add Audio DMAC support

* r8a7779 (R-Car H1)
  - Wait for status on selected MSTP clocks

----------------------------------------------------------------
Kuninori Morimoto (2):
      ARM: shmobile: r8a7790: add Audio DMAC clock
      ARM: shmobile: r8a7790: add Audio DMAC support

Laurent Pinchart (1):
      ARM: shmobile: r8a7779: Wait for status on selected MSTP clocks

Shinya Kuribayashi (2):
      ARM: shmobile: r8a7790: Wait for status on all MSTP clocks
      ARM: shmobile: r8a7791: Wait for status on all MSTP clocks

Valentine Barshak (7):
      ARM: shmobile: r8a7791: Add I2C clocks
      ARM: shmobile: r8a7791: Add VIN clocks
      ARM: shmobile: r8a7790: Add VIN clock support
      ARM: shmobile: r8a7790: Add SATA clocks
      ARM: shmobile: r8a7791: Add ZS clock
      ARM: shmobile: r8a7791: Add SATA clocks
      ARM: shmobile: r8a7790: Add PCI USB host clock support

Wolfram Sang (1):
      ARM: shmobile: r7s72100: really add i2c clocks

 arch/arm/mach-shmobile/clock-r7s72100.c       |   4 +
 arch/arm/mach-shmobile/clock-r8a7779.c        |  20 ++--
 arch/arm/mach-shmobile/clock-r8a7790.c        | 140 ++++++++++++++++----------
 arch/arm/mach-shmobile/clock-r8a7791.c        |  81 +++++++++++----
 arch/arm/mach-shmobile/include/mach/r8a7790.h |  25 +++++
 arch/arm/mach-shmobile/setup-r8a7790.c        |  90 +++++++++++++++++
 6 files changed, 275 insertions(+), 85 deletions(-)
