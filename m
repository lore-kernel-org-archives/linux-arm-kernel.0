From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 02 Jan 2012 09:45:59 +0900
Subject: [GIT PULL] Samsung devel-dma for v3.3
Message-ID: <037401ccc8e7$e5671380$b0353a80$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd and Olof,

Please pull Samsung devel-dma for v3.3 from following:
  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
next-samsung-devel-dma

Its major feature is including merge of pl330 driver into drivers/dma/ and
got the ack from Vinod Koul and Linus Walleij and some dma development for
Samsung stuff.

As a note, since having dependency with Vinod's slave-dma/next (dma tree)
and next-samsung-dt1 branch which has been sent to you for arm-soc/next/dt,
that has been provided based on slave-dma/next tree and next-samsung-dt1.

If any problems, please let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

The following changes since commit 6ff1a8bd0b37cf0f44a13d37b1f754abec84e61c:

  Merge branch 'next-samsung-devel-dt1' into for-vkoul-samsung-dma
(2011-12-26 18:49:31 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
next-samsung-devel-dma

Boojin Kim (5):
      DMA: PL330: Merge PL330 driver into drivers/dma/
      DMA: PL330: Removes useless function
      DMA: PL330: Support MEMTOMEM transmit w/o RMB, WMB
      ARM: EXYNOS: Enable MDMA driver
      ARM: EXYNOS: Support DMA for EXYNOS4X12 SoCs

Tushar Behera (1):
      ARM: EXYNOS: Add apb_pclk clkdev entry for mdma1

 arch/arm/common/Kconfig                        |    3 -
 arch/arm/common/Makefile                       |    1 -
 arch/arm/common/pl330.c                        | 1971
------------------------
 arch/arm/include/asm/hardware/pl330.h          |  338 +++--
 arch/arm/mach-exynos/clock.c                   |    9 +
 arch/arm/mach-exynos/dma.c                     |  130 ++-
 arch/arm/mach-exynos/include/mach/irqs.h       |    2 +
 arch/arm/mach-exynos/include/mach/map.h        |    3 +-
 arch/arm/plat-samsung/include/plat/dma-pl330.h |   16 +
 drivers/dma/Kconfig                            |    1 -
 drivers/dma/pl330.c                            | 1861
++++++++++++++++++++++
 11 files changed, 2199 insertions(+), 2136 deletions(-)
 delete mode 100644 arch/arm/common/pl330.c
