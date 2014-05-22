From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 22 May 2014 11:31:16 -0400
Subject: [GIT PULL] ARM: mvebu: fixes for v3.15 (incr. #2)
Message-ID: <20140522153116.GR8664@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Guys,

In the interest of reducing the number of pull requests, I've merged
mvebu/dt-fixes into mvebu/fixes.  The amount of fixes added since the
last pull request for each was minimal and is reflected below.

The mvebu-soc-id changes have been in -next for a while, and as usual,
this is an incremental pull request from tags/mvebu-fixes-3.15 to
tags/mvebu-fixes-3.15-2 in the mvebu/fixes branch.

Please pull.

thx,

Jason.


The following changes since commit 1cc9d48145b81e307fab94a5cf6ee66ec2f0de60:

  ARM: orion5x: fix target ID for crypto SRAM window (2014-04-17 04:52:26 +0000)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-fixes-3.15-2

for you to fetch changes up to d903bc9ee9b67410d02923d98a8dd4ecf5a1bc69:

  Merge branch 'mvebu/dt-fixes' into mvebu/fixes (2014-05-22 15:16:37 +0000)

----------------------------------------------------------------

mvebu fixes for v3.15 (incremental #2)

 - Armada 38x
    - fix PCIe dt nodes for handling more interfaces

 - mvebu
    - mvebu-soc-id: fix clock handling and PCIe interface disabling.

----------------------------------------------------------------
Jason Cooper (1):
      Merge branch 'mvebu/dt-fixes' into mvebu/fixes

Thomas Petazzoni (3):
      ARM: mvebu: mvebu-soc-id: add missing clk_put() call
      ARM: mvebu: mvebu-soc-id: keep clock enabled if PCIe unit is enabled
      ARM: mvebu: fix definitions of PCIe interfaces on Armada 38x

 arch/arm/boot/dts/armada-380.dtsi                |  2 +-
 arch/arm/boot/dts/armada-385.dtsi                |  4 ++--
 arch/arm/mach-mvebu/mvebu-soc-id.c               | 13 ++++++++++++-
 11 files changed, 48 insertions(+), 32 deletions(-)
