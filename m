From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 29 Apr 2014 08:37:41 -0400
Subject: [GIT PULL] ARM: mvebu: DT fixes for v3.15
Message-ID: <20140429123741.GG28159@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Guys,

Here's the DT fixes I've collected so far.  They've all been in next for
at least four days.

The only questionable one is

  d685058f5b87 ARM: mvebu: enable the SATA interface on Armada 375 DB

I decided to include it as a fix for v3.15 because with it you can boot
the new Armada 375 SoC from disk with v3.15.  Which means we went from
zero to booting a new SoC in one merge window :-)

Please pull.

thx,

Jason.


The following changes since commit c9eaa447e77efe77b7fa4c953bd62de8297fd6c5:

  Linux 3.15-rc1 (2014-04-13 14:18:35 -0700)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt-fixes-3.15

for you to fetch changes up to e247686085f71e9c25e3488ce83d5d0f77023438:

  ARM: Kirkwood: T5325: Fix double probe of Codec (2014-04-25 21:23:42 +0000)

----------------------------------------------------------------
mvebu DT fixes for v3.15

 - mvebu

    - fix NOR bus width on Armada XP boards
    - use qsgmii on Armada XP GP board
    - add i2c bus freq for Armada 370 DB board
    - add SATA interface for Armada 375 DB

 - kirkwood

    - fix double probe of audio codec for T5325

----------------------------------------------------------------
Andrew Lunn (1):
      ARM: Kirkwood: T5325: Fix double probe of Codec

Thomas Petazzoni (6):
      ARM: mvebu: fix NOR bus-width in Armada XP GP Device Tree
      ARM: mvebu: fix NOR bus-width in Armada XP DB Device Tree
      ARM: mvebu: fix NOR bus-width in Armada XP OpenBlocks AX3 Device Tree
      ARM: mvebu: use qsgmii phy-mode for Armada XP GP interfaces
      ARM: mvebu: specify I2C bus frequency on Armada 370 DB
      ARM: mvebu: enable the SATA interface on Armada 375 DB

 arch/arm/boot/dts/armada-370-db.dts              |  1 +
 arch/arm/boot/dts/armada-375-db.dts              |  5 +++++
 arch/arm/boot/dts/armada-xp-db.dts               |  2 +-
 arch/arm/boot/dts/armada-xp-gp.dts               | 10 +++++-----
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts |  2 +-
 arch/arm/boot/dts/kirkwood-t5325.dts             |  5 -----
 6 files changed, 13 insertions(+), 12 deletions(-)
