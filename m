From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 13 May 2013 13:03:25 -0400
Subject: [GIT PULL] ARM: mvebu: fixes for v3.10 (round 1)
Message-ID: <20130513170325.GT31290@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The following changes since commit f722406faae2d073cc1d01063d1123c35425939e:

  Linux 3.10-rc1 (2013-05-11 17:14:08 -0700)

are available in the git repository at:

  git://git.infradead.org/users/jcooper/linux.git tags/fixes-3.10-1

for you to fetch changes up to 00ed4a0bd964555fe9276f2299564c384d50ae7d:

  ARM: mvebu: Add a ranges entry to translate devbus childs (2013-05-13 16:23:47 +0000)

----------------------------------------------------------------
mvebu fixes for v3.10 round 1

 - mvebu
    - duplicate alias removal
    - augment new internal-regs dt node with proper ranges node

 - kirkwood
    - stable fix for QNAP TS-11x/TS-21x enabling PCIe port 1

 - plat-orion
    - missing ehci include in common.h.  needed within common.h.

----------------------------------------------------------------
Ezequiel Garcia (1):
      ARM: mvebu: Add a ranges entry to translate devbus childs

Martin Michlmayr (1):
      Kirkwood: Enable PCIe port 1 on QNAP TS-11x/TS-21x

Sebastian Hesselbarth (1):
      ARM: plat-orion: add missing ehci include to common.h

Thomas Petazzoni (1):
      ARM: mvebu: do not duplicate the mpic alias

 arch/arm/boot/dts/armada-370.dtsi                | 2 +-
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts | 3 +++
 arch/arm/boot/dts/armada-xp.dtsi                 | 2 +-
 arch/arm/mach-kirkwood/ts219-setup.c             | 2 +-
 arch/arm/plat-orion/include/plat/common.h        | 1 +
 5 files changed, 7 insertions(+), 3 deletions(-)
