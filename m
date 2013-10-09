From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  9 Oct 2013 15:50:43 +0900
Subject: [GIT PULL] Second Round of Renesas ARM based SoC board updates for
 v3.13
Message-ID: <cover.1381299817.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin, Olof and Arnd,

please consider this second round of Renesas ARM based SoC board updates
for v3.13.

This pull request is based on a merge of renesas-soc2-for-v3.13 into
renesas-boards-for-v3.13. You have already pulled renesas-boards-for-v3.13
and I am sending a pull request for renesas-soc2-for-v3.13 today. The
reason for this merge is to supply SoC code that is needed by board code in
this series. In particular the r7s72100 SoC code for the Genmai board.


The following changes since commit 661a7335c4e47726df1e7264580209847509569a:

  Merge branch 'heads/soc2' into boards2-base (2013-10-08 10:01:47 +0900)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-boards2-for-v3.13

for you to fetch changes up to 7d4bde88e1135c4a3106b79650d3b85335f35717:

  ARM: shmobile: marzen: enable INTC IRQ (2013-10-08 10:02:22 +0900)

----------------------------------------------------------------
Second Round of Renesas ARM based SoC board updates for v3.13

* Enable INTC IRQ on marzen board
* Enable SMSC ethernet on reference board code for bockw
* Enable DMA for SDHI0 on marzen and bockw boards
* Enable DMA for MMCIF on ape6evm board
* Enable SMP and arch timers on Koelsh board
* Rework kzm9d make reference board code multiplatform
* Use a common DTB for kzm9d reference and non-reference
* Add Genmai board

----------------------------------------------------------------
Guennadi Liakhovetski (1):
      ARM: shmobile: ape6evm: add DMA support to MMCIF

Kuninori Morimoto (2):
      ARM: shmobile: bockw: add SMSC support on reference
      ARM: shmobile: marzen: enable INTC IRQ

Magnus Damm (9):
      ARM: shmobile: Genmai support
      ARM: shmobile: Use r8a7791_add_standard_devices() on Koelsch
      ARM: shmobile: Use arch timer on Koelsch
      ARM: shmobile: Sync KZM9D DTS with KZM9D reference DTS
      ARM: shmobile: Use KZM9D without reference for multiplatform
      ARM: shmobile: Remove non-multiplatform KZM9D reference support
      ARM: shmobile: Let KZM9D multiplatform boot with KZM9D DTB
      ARM: shmobile: Remove KZM9D reference DTS
      ARM: shmobile: Use SMP on Koelsch

Max Filippov (2):
      ARM: shmobile: bockw: enable DMA for SDHI0
      ARM: shmobile: marzen: enable DMA for SDHI0

 arch/arm/boot/dts/Makefile                      |  4 +-
 arch/arm/boot/dts/emev2-kzm9d-reference.dts     | 57 -------------------------
 arch/arm/boot/dts/emev2-kzm9d.dts               | 33 +++++++++++++-
 arch/arm/boot/dts/r7s72100-genmai.dts           | 31 ++++++++++++++
 arch/arm/mach-shmobile/Kconfig                  | 27 +++---------
 arch/arm/mach-shmobile/Makefile                 |  6 ++-
 arch/arm/mach-shmobile/Makefile.boot            |  2 +-
 arch/arm/mach-shmobile/board-ape6evm.c          |  2 +
 arch/arm/mach-shmobile/board-bockw-reference.c  | 20 +++++++++
 arch/arm/mach-shmobile/board-bockw.c            |  2 +
 arch/arm/mach-shmobile/board-genmai.c           | 43 +++++++++++++++++++
 arch/arm/mach-shmobile/board-koelsch.c          |  5 ++-
 arch/arm/mach-shmobile/board-kzm9d-reference.c  |  1 +
 arch/arm/mach-shmobile/board-marzen-reference.c |  1 +
 arch/arm/mach-shmobile/board-marzen.c           |  2 +
 15 files changed, 153 insertions(+), 83 deletions(-)
 delete mode 100644 arch/arm/boot/dts/emev2-kzm9d-reference.dts
 create mode 100644 arch/arm/boot/dts/r7s72100-genmai.dts
 create mode 100644 arch/arm/mach-shmobile/board-genmai.c
