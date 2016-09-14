From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 14 Sep 2016 17:34:37 +0200
Subject: [GIT PULL] ARM: mvebu: soc for v4.9 (#1)
Message-ID: <87bmzqbilu.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the first pull request for soc for mvebu for v4.9.

Gregory

The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:

  Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-soc-4.9-1

for you to fetch changes up to a7f9f5baf306ff5422e6ab143c0af5dd6b5ed1a9:

  ARM: orion5x: Remove old non-DT-based WNR854T support (2016-09-14 16:57:26 +0200)

----------------------------------------------------------------
mvebu soc for 4.9 (part 1)

- irq cleanup for old mvebu SoC
- Convert orion5x based SoC Netgear WNR854T to devicetree

----------------------------------------------------------------
Arnd Bergmann (4):
      ARM: mv78xx0: simplify ethernet device creation
      ARM: mvebu/orion: remove NO_IRQ check from device init
      ARM: orion: simplify orion_ge00_switch_init
      ARM: orion5x: remove extraneous NO_IRQ

Jamie Lentin (2):
      ARM: orion5x: Add DT-based support for Netgear WNR854T
      ARM: orion5x: Remove old non-DT-based WNR854T support

 arch/arm/configs/multi_v5_defconfig          |   2 +-
 arch/arm/configs/mvebu_v5_defconfig          |   2 +-
 arch/arm/configs/orion5x_defconfig           |   2 +-
 arch/arm/mach-mv78xx0/common.c               |   9 +-
 arch/arm/mach-orion5x/Kconfig                |   4 +-
 arch/arm/mach-orion5x/Makefile               |   2 +-
 arch/arm/mach-orion5x/board-wnr854t.c        |  78 +++++++++++
 arch/arm/mach-orion5x/common.c               |   4 +-
 arch/arm/mach-orion5x/common.h               |   2 +-
 arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c |   4 +-
 arch/arm/mach-orion5x/rd88f5181l-ge-setup.c  |   5 +-
 arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c |   6 +-
 arch/arm/mach-orion5x/wnr854t-setup.c        | 185 ---------------------------
 arch/arm/mach-orion5x/wrt350n-v2-setup.c     |   4 +-
 arch/arm/plat-orion/common.c                 |  85 +++++-------
 arch/arm/plat-orion/include/plat/common.h    |  10 +-
 16 files changed, 133 insertions(+), 271 deletions(-)
 create mode 100644 arch/arm/mach-orion5x/board-wnr854t.c
 delete mode 100644 arch/arm/mach-orion5x/wnr854t-setup.c
