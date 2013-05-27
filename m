From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 27 May 2013 14:54:36 -0400
Subject: [GIT PULL] ARM: mvebu: fixes for v3.10 (round 3)
Message-ID: <20130527185436.GN31290@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The following changes since commit 489e138eec96f529c5e8d4cd3ea45882ecdbf5ca:

  ARM: dts: mvebu: Fix wrong the address reg value for the L2-cache node (2013-05-20 17:44:54 +0000)

are available in the git repository at:

  git://git.infradead.org/users/jcooper/linux.git tags/fixes-3.10-3

for you to fetch changes up to 6484ae0dcd6d45c3a3ab0442cb44fc1dddc53aec:

  ARM: mvebu: Fix bug in coherency fabric low level init function (2013-05-23 17:35:51 +0000)

----------------------------------------------------------------
mvebu fixes for v3.10 round 3

 - mvebu
    - fix register area length for sata and ethernet
    - fix bug in coherency fabric low level init

 - kirkwood
    - fix crash from pcie double init

----------------------------------------------------------------
Andrew Lunn (1):
      ARM: Kirkwood: TS219: Fix crash by double PCIe instantiation

Nadav Haklai (1):
      ARM: mvebu: Fix bug in coherency fabric low level init function

Thomas Petazzoni (2):
      arm: mvebu: fix length of SATA registers area in .dtsi
      arm: mvebu: fix length of Ethernet registers area in .dtsi

 arch/arm/boot/dts/armada-370-xp.dtsi     |  6 +++---
 arch/arm/boot/dts/armada-xp-mv78460.dtsi |  2 +-
 arch/arm/boot/dts/armada-xp.dtsi         |  2 +-
 arch/arm/mach-kirkwood/board-ts219.c     | 10 ----------
 arch/arm/mach-mvebu/coherency_ll.S       | 16 +++++++++++-----
 5 files changed, 16 insertions(+), 20 deletions(-)
