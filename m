From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 24 Dec 2013 23:28:56 +0900
Subject: [GIT PULL 0/3] Renesas SH based SoC Updates for v3.14
Message-ID: <cover.1387889858.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin, Hi Olof, Hi Arnd,

Please consider these Renesas SH based SoC Updates for v3.14.

I am routing these changes through my tree as they are
dependencies for updates to the SH SCI driver.

This pull-request is based on the second round of Renesas SH SCI updates
for v3.14, tagged as renesas-sh-sci2-for-v3.14, which I will
also send a pull-request for today.


The following changes since commit ec09c5eb491834d4011c72538e58d8b7096076bd:

  serial: sh-sci: Rework baud rate calculation (2013-12-24 11:17:53 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-sh-soc-for-v3.14

for you to fetch changes up to d5917ef318b850fc72bd10db438580f7d1c406d9:

  sh: Don't set plat_sci_port scbrr_algo_id field (2013-12-24 21:49:43 +0900)

----------------------------------------------------------------
Renesas SH based SoC Updates for v3.14

* Global
  - Don't set plat_sci_port scbrr_algo_id field
  - Declare SCIF register base and IRQ as resources

* sh772[34] SoCs
  - Set serial port sampling rate to 8 for SCIFA ports

----------------------------------------------------------------
Laurent Pinchart (3):
      sh: Declare SCIF register base and IRQ as resources
      sh: sh772[34]: Set serial port sampling rate to 8 for SCIFA ports
      sh: Don't set plat_sci_port scbrr_algo_id field

 arch/sh/kernel/cpu/sh2/setup-sh7619.c  |  30 +++++++---
 arch/sh/kernel/cpu/sh2a/setup-mxg.c    |  10 +++-
 arch/sh/kernel/cpu/sh2a/setup-sh7201.c |  80 +++++++++++++++++--------
 arch/sh/kernel/cpu/sh2a/setup-sh7203.c |  40 +++++++++----
 arch/sh/kernel/cpu/sh2a/setup-sh7206.c |  40 +++++++++----
 arch/sh/kernel/cpu/sh2a/setup-sh7264.c | 104 +++++++++++++++++++++++++--------
 arch/sh/kernel/cpu/sh2a/setup-sh7269.c | 104 +++++++++++++++++++++++++--------
 arch/sh/kernel/cpu/sh3/setup-sh7705.c  |  20 +++++--
 arch/sh/kernel/cpu/sh3/setup-sh770x.c  |  30 +++++++---
 arch/sh/kernel/cpu/sh3/setup-sh7710.c  |  20 +++++--
 arch/sh/kernel/cpu/sh3/setup-sh7720.c  |  20 +++++--
 arch/sh/kernel/cpu/sh4/setup-sh4-202.c |  16 +++--
 arch/sh/kernel/cpu/sh4/setup-sh7750.c  |  20 +++++--
 arch/sh/kernel/cpu/sh4/setup-sh7760.c  |  62 ++++++++++++--------
 arch/sh/kernel/cpu/sh4a/setup-sh7343.c |  40 +++++++++----
 arch/sh/kernel/cpu/sh4a/setup-sh7366.c |  10 +++-
 arch/sh/kernel/cpu/sh4a/setup-sh7722.c |  30 +++++++---
 arch/sh/kernel/cpu/sh4a/setup-sh7723.c |  63 ++++++++++++++------
 arch/sh/kernel/cpu/sh4a/setup-sh7724.c |  63 ++++++++++++++------
 arch/sh/kernel/cpu/sh4a/setup-sh7734.c |  72 +++++++++++++++--------
 arch/sh/kernel/cpu/sh4a/setup-sh7757.c |  30 +++++++---
 arch/sh/kernel/cpu/sh4a/setup-sh7763.c |  30 +++++++---
 arch/sh/kernel/cpu/sh4a/setup-sh7770.c | 100 +++++++++++++++++++++----------
 arch/sh/kernel/cpu/sh4a/setup-sh7780.c |  22 ++++---
 arch/sh/kernel/cpu/sh4a/setup-sh7785.c |  60 +++++++++++++------
 arch/sh/kernel/cpu/sh4a/setup-sh7786.c |  88 +++++++++++++++++++---------
 arch/sh/kernel/cpu/sh4a/setup-shx3.c   |  48 +++++++++------
 arch/sh/kernel/cpu/sh5/setup-sh5.c     |  12 +++-
 28 files changed, 889 insertions(+), 375 deletions(-)
