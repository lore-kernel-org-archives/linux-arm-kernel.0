From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 8 Feb 2014 12:22:17 -0500
Subject: [GIT PULL] mvebu: phy and ata fixes for v3.14
Message-ID: <20140208172217.GK8533@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All,

Here is a small set of fixes for fix a boot hang we are currently
experiencing in the boot farm.  Now that we are probing for the phy, we
didn't take into account optional phys, which causes the hang.  These
patches fix this and restore booting on the affected platforms.

thx,

Jason.


The following changes since commit 38dbfb59d1175ef458d006556061adeaa8751b72:

  Linus 3.14-rc1 (2014-02-02 16:42:13 -0800)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-phy_ata-fixes-3.14

for you to fetch changes up to 90aa2997029fa623fe9e3ec3a469a00a34130237:

  ata: sata_mv: Fix probe failures with optional phys (2014-02-05 05:48:58 +0000)

----------------------------------------------------------------
mvebu phy and ata fixes for v3.14

 - phy
    - add support for optional phys via NULL

 - ata
    - fix boot hang due to probe failure of optional phys

NOTE:  Series has been Ack'd by both the phy maintainer and the ata maintainer
for going through arm-soc

----------------------------------------------------------------
Andrew Lunn (3):
      drivers: phy: Make NULL a valid phy reference
      drivers: phy: Add support for optional phys
      ata: sata_mv: Fix probe failures with optional phys

 Documentation/phy.txt   | 26 +++++++++++++++------
 drivers/ata/sata_mv.c   |  8 ++++---
 drivers/phy/phy-core.c  | 62 ++++++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/phy/phy.h | 14 +++++++++++
 4 files changed, 99 insertions(+), 11 deletions(-)
