From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 26 Nov 2014 00:02:23 -0500
Subject: [GIT PULL] ARM: mvebu: SoC changes for v3.19
Message-ID: <20141126050222.GN22670@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Folks,

Nice round of changes for mvebu.  The whole stack ahs been in -next for
several days.

This pull request has a dependency on mvebu/fixes for:

  2eb04ae010a8 ARM: mvebu: add missing of_node_put() call in coherency.c

Please pull.

thx,

Jason.


The following changes since commit 2eb04ae010a8fb165ba7aa56e9aa8e7980887dee:

  ARM: mvebu: add missing of_node_put() call in coherency.c (2014-11-07 02:56:36 +0000)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-soc-3.19

for you to fetch changes up to 626d686487bfd8136c4543bee7b6b2e52c33b3f8:

  ARM: mvebu: Implement the CPU hotplug support for the Armada 38x SoCs (2014-11-22 02:14:38 +0000)

----------------------------------------------------------------
mvebu SoC changes for v3.19

 - Armada 38x
    - Implement CPU hotplug support

 - Armada 375
    - Remove Z1 stepping support (limited dist. of SoC)

----------------------------------------------------------------
Ezequiel Garcia (1):
      ARM: mvebu: Remove thermal quirk for A375 Z1 revision

Gregory CLEMENT (4):
      ARM: mvebu: Clean-up the Armada XP support
      ARM: mvebu: Move SCU power up in a function
      ARM: mvebu: Fix the secondary startup for Cortex A9 SoC
      ARM: mvebu: Implement the CPU hotplug support for the Armada 38x SoCs

Jason Cooper (1):
      Merge branch 'mvebu/fixes' into mvebu/soc

Thomas Petazzoni (5):
      ARM: mvebu: make the coherency_ll.S functions work with no coherency fabric
      ARM: mvebu: disable I/O coherency on non-SMP situations on Armada 370/375/38x/XP
      ARM: mvebu: remove unused register offset definition
      ARM: mvebu: remove Armada 375 Z1 workaround for I/O coherency
      ARM: mvebu: update comments in coherency.c

 arch/arm/mach-mvebu/armada-370-xp.h |   6 -
 arch/arm/mach-mvebu/board-v7.c      |  71 +-----------
 arch/arm/mach-mvebu/coherency.c     | 221 ++++++------------------------------
 arch/arm/mach-mvebu/coherency_ll.S  |  21 +++-
 arch/arm/mach-mvebu/cpu-reset.c     |   1 -
 arch/arm/mach-mvebu/headsmp-a9.S    |   1 +
 arch/arm/mach-mvebu/platsmp-a9.c    |  53 ++++++++-
 arch/arm/mach-mvebu/platsmp.c       |   2 +
 arch/arm/mach-mvebu/pmsu.c          |   3 +-
 arch/arm/mach-mvebu/pmsu.h          |   2 +
 arch/arm/mach-mvebu/pmsu_ll.S       |  20 ++--
 11 files changed, 131 insertions(+), 270 deletions(-)
