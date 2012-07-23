From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 23 Jul 2012 20:33:20 -0000
Subject: [GIT PULL 04/15] arm-soc: samsung dma changes
In-Reply-To: <1343075561-17446-1-git-send-email-arnd@arndb.de>
References: <1343075561-17446-1-git-send-email-arnd@arndb.de>
Message-ID: <1343075561-17446-5-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit bd0a521e88aa7a06ae7aabaed7ae196ed4ad867a:

  Linux 3.5-rc6 (2012-07-07 17:23:56 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git next/dma

for you to fetch changes up to 31dfec74c0dc49521b2e17543ff9dd9dd0221702:

  Merge branch 'next/devel-dma-ops' of git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung into next/dma (2012-07-10 14:12:05 +0200)

----------------------------------------------------------------

arm-soc: samsung dma changes

Some platforms are not yet converted to use the dmaengine framework,
including some of the samsung SoCs. In the meantime, we treat this
as platform code and merge the patches through the arm-soc tree.

----------------------------------------------------------------

Arnd Bergmann (2):
      Merge branch 'next/devel-dma-ops' of git://git.kernel.org/.../kgene/linux-samsung into next/dma
      Merge branch 'next/dma' into for-next

Boojin Kim (3):
      ARM: SAMSUNG: Add config() function in DMA common operations
      spi/s3c64xx: Add the use of DMA config operation
      ASoC: follow the updated samsung DMA common operations

Sachin Kamat (1):
      ARM: SAMSUNG: Fix compiler warning in dma-ops.c file

 arch/arm/plat-samsung/dma-ops.c              |   76 ++++++++++++++------------
 arch/arm/plat-samsung/include/plat/dma-ops.h |   20 ++++---
 arch/arm/plat-samsung/s3c-dma-ops.c          |   39 +++++++------
 drivers/spi/spi-s3c64xx.c                    |   33 ++++++-----
 sound/soc/samsung/dma.c                      |   18 +++---
 5 files changed, 105 insertions(+), 81 deletions(-)
