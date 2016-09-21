From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 21 Sep 2016 12:19:51 +0200
Subject: [GIT PULL] ARM: mvebu: soc for v4.9 (#1)
Message-ID: <8737kt5zco.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the second tentative of first pull request for soc for mvebu
for v4.9.

The PCI related patch have been discarded.

Gregory

The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:

  Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-soc-4.9-1

for you to fetch changes up to 77a1c68a96f4e018860033f3827602014a4f1663:

  ARM: orion5x: remove extraneous NO_IRQ (2016-09-14 16:36:20 +0200)

----------------------------------------------------------------
mvebu soc for 4.9 (part 1)

- irq cleanup for old mvebu SoC

----------------------------------------------------------------
Arnd Bergmann (4):
      ARM: mv78xx0: simplify ethernet device creation
      ARM: mvebu/orion: remove NO_IRQ check from device init
      ARM: orion: simplify orion_ge00_switch_init
      ARM: orion5x: remove extraneous NO_IRQ

 arch/arm/mach-mv78xx0/common.c               |  9 +--
 arch/arm/mach-orion5x/common.c               |  4 +-
 arch/arm/mach-orion5x/common.h               |  2 +-
 arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c |  4 +-
 arch/arm/mach-orion5x/rd88f5181l-ge-setup.c  |  5 +-
 arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c |  6 +-
 arch/arm/mach-orion5x/wnr854t-setup.c        |  4 +-
 arch/arm/mach-orion5x/wrt350n-v2-setup.c     |  4 +-
 arch/arm/plat-orion/common.c                 | 85 +++++++++++-----------------
 arch/arm/plat-orion/include/plat/common.h    | 10 +---
 10 files changed, 51 insertions(+), 82 deletions(-)
