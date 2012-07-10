From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 10 Jul 2012 11:13:00 +0900
Subject: [GIT PULL] Samsung devel-dma ops for v3.6
Message-ID: <0c5001cd5e41$87daa1b0$978fe510$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Here is updating DMA common operation for Samsung SoCs.

Since some DMA client driver such as spi needs to change the configuration
after dma_request() so this branch adds dma_config() can configure DMA
transmit option which is included in dma_request() after that.

Note, according to the changes, needs to update spi and ASoC drivers for
Samsung SoCs and only got the ack from Mark Brown not Grant Likely and as I
know, he is busy for moving. But I think, the spi change has no problem and
it is simple.

If any problems, please kindly let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

The following changes since commit 485802a6c524e62b5924849dd727ddbb1497cc71:

  Linux 3.5-rc3 (2012-06-16 17:25:17 -0700)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
next/devel-dma-ops

Boojin Kim (3):
      ARM: SAMSUNG: Add config() function in DMA common operations
      spi/s3c64xx: Add the use of DMA config operation
      ASoC: follow the updated samsung DMA common operations

Sachin Kamat (1):
      ARM: SAMSUNG: Fix compiler warning in dma-ops.c file

 arch/arm/plat-samsung/dma-ops.c              |   76
++++++++++++++------------
 arch/arm/plat-samsung/include/plat/dma-ops.h |   20 ++++---
 arch/arm/plat-samsung/s3c-dma-ops.c          |   39 ++++++++------
 drivers/spi/spi-s3c64xx.c                    |   33 +++++++-----
 sound/soc/samsung/dma.c                      |   18 ++++---
 5 files changed, 105 insertions(+), 81 deletions(-)
