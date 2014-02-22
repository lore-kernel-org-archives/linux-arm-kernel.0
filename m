From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 22 Feb 2014 01:32:28 -0500
Subject: [GIT PULL] irqchip: armada-370-xp changes for v3.15
Message-ID: <20140222063228.GY7862@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas,

This is a small round of changes intended for v3.15.  Despite the commit
date these have been in -next for almost a week.  I needed to rebase the
branch on v3.14-rc1 instead of merging it.  When I originally added
these patches, the dove PMU hadn't been pulled from this branch yet.

At any rate, these patches depend on the tag mvebu-irqchip-fixes-3.13
which you've already pulled in.  They need the MSI fix from that series.

Please pull.

thx,

Jason.


The following changes since commit 3efca1d15656fe7e3f57c1f5f21e596967355200:

  Merge tag 'tags/mvebu-irqchip-fixes-3.13' into mvebu/irqchip (2014-02-22 06:11:45 +0000)

are available in the git repository at:


  git://git.infradead.org/linux-mvebu.git tags/irqchip-mvebu-3.15

for you to fetch changes up to bc69b8adfe221def02ea10f7b9ab32e80195334c:

  irqchip: armada-370-xp: Setup a chained handler for the MPIC (2014-02-22 06:12:29 +0000)

----------------------------------------------------------------
irqchip mvebu changes for v3.15

 - armada-370-xp
    - add MSI helper
    - MPIC chained handler

----------------------------------------------------------------
Ezequiel Garcia (2):
      irqchip: armada-370-xp: Add helper for the MSI IRQ handling
      irqchip: armada-370-xp: Setup a chained handler for the MPIC

 .../devicetree/bindings/arm/armada-370-xp-mpic.txt |  8 +-
 drivers/irqchip/irq-armada-370-xp.c                | 96 ++++++++++++++++------
 2 files changed, 76 insertions(+), 28 deletions(-)
