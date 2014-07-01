From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 1 Jul 2014 08:05:48 -0400
Subject: [GIT PULL] ARM: mvebu: Fixes for v3.16 (incremental #2)
Message-ID: <20140701120548.GC23978@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Guys,

Here's a small set of fixes to take care PCIe deadlocks with SMP, and
cpuidle on big-endian systems.

This is an incremental pull request from tags/mvebu-fixes-3.16 up to
tags/mvebu-fixes-3.16-2 on the mvebu/fixes branch.

Please pull.

thx,

Jason.

The following changes since commit 8dbdb8e704db34085f5978c335c10256b0fb9629:

  ARM: mvebu: Fix the improper use of the compatible string armada38x using a wildcard (2014-06-24 11:33:24 +0000)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-fixes-3.16-2

for you to fetch changes up to 6509dc74c9f55ffaa558738b96c4da8b98d39571:

  ARM: mvebu: fix cpuidle implementation to work on big-endian systems (2014-06-30 18:15:11 +0000)

----------------------------------------------------------------
mvebu fixes for v3.16 (round #2)

 - mvebu
    - Fix PCIe deadlock now that SMP is enabled
    - Fix cpuidle for big-endian systems

----------------------------------------------------------------
Thomas Petazzoni (3):
      ARM: mvebu: move Armada 375 external abort logic as a quirk
      ARM: mvebu: update L2/PCIe deadlock workaround after L2CC cleanup
      ARM: mvebu: fix cpuidle implementation to work on big-endian systems

 arch/arm/mach-mvebu/Makefile   |  2 +-
 arch/arm/mach-mvebu/board-v7.c | 29 +++++++++++++++++++----------
 arch/arm/mach-mvebu/pmsu.c     |  9 ++-------
 arch/arm/mach-mvebu/pmsu_ll.S  | 25 +++++++++++++++++++++++++
 4 files changed, 47 insertions(+), 18 deletions(-)
 create mode 100644 arch/arm/mach-mvebu/pmsu_ll.S
