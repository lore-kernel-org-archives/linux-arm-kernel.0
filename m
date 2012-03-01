From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 01 Mar 2012 14:12:56 +0900
Subject: [GIT PULL] merge PL330 DMAC driver
Message-ID: <077301ccf769$f6ac3750$e404a5f0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell and Vinod,

Please pull merging dma pl330 driver into drivers/dma/.
It's time to send this to you, and I think that should be sent to upstream
via rmk and dma tree together.

If any problems, please kindly let me know.

As a note, since there is no regarding samsung stuff here, I don't merge
this into samsung tree.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

The following changes since commit b01543dfe67bb1d191998e90d20534dc354de059:

  Linux 3.3-rc4 (2012-02-18 15:53:33 -0800)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
v3.4-for-vkoul-v3

Boojin Kim (3):
      DMA: PL330: Merge PL330 driver into drivers/dma/
      DMA: PL330: Removes useless function
      DMA: PL330: Support MEMTOMEM transmit w/o RMB, WMB

 arch/arm/common/Kconfig               |    3 -
 arch/arm/common/Makefile              |    1 -
 arch/arm/common/pl330.c               | 1959
-------------------------------
 arch/arm/include/asm/hardware/pl330.h |  217 ----
 drivers/dma/Kconfig                   |    1 -
 drivers/dma/pl330.c                   | 2089
++++++++++++++++++++++++++++++++-
 include/linux/amba/pl330.h            |    1 -
 7 files changed, 2088 insertions(+), 2183 deletions(-)
 delete mode 100644 arch/arm/common/pl330.c
 delete mode 100644 arch/arm/include/asm/hardware/pl330.h
