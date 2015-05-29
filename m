From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 29 May 2015 23:51:54 +0200
Subject: [GIT PULL] ARM: mvebu: fixes for v4.1 #3
Message-ID: <5568DF7A.9090600@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the third pull request for fixes for mvebu for v4.1.

Gregory

The following changes since commit 31c17ac98fc005c0998f890094eb8fe17061e667:

  MAINTAINERS: Add dts entries for some of the Marvell SoCs (2015-05-15 14:25:43 +0200)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-fixes-4.1-3

for you to fetch changes up to 885dbd154b2f2ee305cec6fd0a162e1a77ae2b06:

  Revert "bus: mvebu-mbus: make sure SDRAM CS for DMA don't overlap the MBus bridge window" (2015-05-28 11:14:31 +0200)

----------------------------------------------------------------
mvebu fixes for 4.1 (part 3)

Disable unused internal RTC for Mamba from linksys (Armada XP)
And 2 commits fixing regressions on mvebu-mbus:
- the first one for Kirkwood or Orion SoC
- the second one for DMA when the platform have more than 4GB (only
  possible on Armada XP as far as I know)

----------------------------------------------------------------
Imre Kaloz (1):
      ARM: mvebu: armada-xp-linksys-mamba: Disable internal RTC

Nicolas Schichan (1):
      bus: mvebu-mbus: do not set WIN_CTRL_SYNCBARRIER on non io-coherent platforms.

Thomas Petazzoni (1):
      Revert "bus: mvebu-mbus: make sure SDRAM CS for DMA don't overlap the MBus bridge window"

 arch/arm/boot/dts/armada-xp-linksys-mamba.dts |   5 +++++
 drivers/bus/mvebu-mbus.c                      | 109 +++++++++++++++++++------------------------------------------------------------------------------------------
 2 files changed, 24 insertions(+), 90 deletions(-)

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
