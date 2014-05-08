From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 8 May 2014 11:16:19 -0400
Subject: [GIT PULL] ARM: mvebu: driver changes for v3.16
Message-ID: <20140508151619.GD12708@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

guys,

Here a round of mvebu-devbus changes for v3.16 that add support for
orion5x.  This is part of the series Thomas did converting orion5x to
devicetree. sweet!

These changes have been in -next for over a week.  They are based on
v3.15-rc1 with mvebu/fixes merged in.  This branch does have a
dependency on mvebu/fixes as outlined in the tag message.

Please pull.

thx,

Jason.


The following changes since commit 1cc9d48145b81e307fab94a5cf6ee66ec2f0de60:

  ARM: orion5x: fix target ID for crypto SRAM window (2014-04-17 04:52:26 +0000)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-drivers-3.16

for you to fetch changes up to 0456d3300edba52e47c6b5582cfe9d87756f5590:

  memory: mvebu-devbus: add a devbus, keep-config property (2014-04-29 13:17:10 +0000)

----------------------------------------------------------------
mvebu driver changes for v3.16

 - mvebu-devbus
    - changes need to add support for the orion5x platform

Depends:

  - tags/mvebu-fixes-3.15 in the mvebu/fixes branch for:

     ce965c3d2e68 memory: mvebu-devbus: fix the conversion of the bus width

----------------------------------------------------------------
Thomas Petazzoni (5):
      memory: mvebu-devbus: use ARMADA_ prefix in defines
      memory: mvebu-devbus: use _SHIFT suffixes instead of _BIT
      memory: mvebu-devbus: split functions
      memory: mvebu-devbus: add Orion5x support
      memory: mvebu-devbus: add a devbus, keep-config property

 .../bindings/memory-controllers/mvebu-devbus.txt   |  32 ++-
 drivers/memory/mvebu-devbus.c                      | 229 ++++++++++++++-------
 2 files changed, 181 insertions(+), 80 deletions(-)
