From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 22 Mar 2013 10:23:46 +0900
Subject: [GIT PULL] Renesas ARM-based SoC board updates for v3.10 #2
Message-ID: <1363915432-21720-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Hi Olof,

The following changes since commit 48296a13e7f411402f080d0603724623fa3eee14:

  ARM: shmobile: kzm9g: correct smsc regulator registration (2013-03-18 21:27:03 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-boards2-for-v3.10

for you to fetch changes up to ac22dde76c80a3ffa3c3c24cf16bb8076b20b767:

  Revert "ARM: shmobile: streamline mackerel SD and MMC devices" (2013-03-21 22:03:58 +0900)

----------------------------------------------------------------
Second round of Renesas ARM-based SoC board updates for v3.10

* Resolve a build regression on Mackerel by reverting
  "ARM: shmobile: streamline mackerel SD and MMC devices"
* DTS cleanup and corrections for kzm9g/sh73a0 from Guennadi
* SDHI voltage regulator enhancements for kzm9g and armadillo800eva
  from Guennadi

----------------------------------------------------------------
Guennadi Liakhovetski (5):
      ARM: shmobile: kzm9g: SDHI0 and SDHI1 use a 3.3V power supply
      ARM: shmobile: sh73a0: move SDHI and MMCIF DT nodes to sh73a0.dtsi
      ARM: shmobile: armadillo800eva: add a fixed voltage regulator for SDHI1
      ARM: shmobile: kzm9g: add fixed voltage regulators for SDHI0 and SDHI2
      ARM: shmobile: kzm9g-reference: fix device-tree bindings and device names

Simon Horman (1):
      Revert "ARM: shmobile: streamline mackerel SD and MMC devices"

 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts   |   49 ++++------
 arch/arm/boot/dts/sh73a0-reference.dtsi        |   24 -----
 arch/arm/boot/dts/sh73a0.dtsi                  |   44 +++++++++
 arch/arm/mach-shmobile/board-armadillo800eva.c |   45 ++++++++--
 arch/arm/mach-shmobile/board-kzm9g-reference.c |   27 +++---
 arch/arm/mach-shmobile/board-kzm9g.c           |   78 ++++++++++++----
 arch/arm/mach-shmobile/board-mackerel.c        |  113 ++++++++++++------------
 7 files changed, 230 insertions(+), 150 deletions(-)
 delete mode 100644 arch/arm/boot/dts/sh73a0-reference.dtsi
