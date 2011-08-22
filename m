From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Tue, 23 Aug 2011 03:29:42 +0530
Subject: [RESEND][PATCH 0/3] dma: pl330: Simplify platform data for pl330
	driver
Message-ID: <1314050385-9617-1-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The rqtype parameter specified in platform data as part of the
'struct dma_pl330_peri' can be infered from the direction of the transfer
specified with transfer requests. So the rqtype parameter can be removed
and 'struct dma_pl330_peri' is then left with only one field 'peri_id'
which itself can be moved into 'struct dma_pl330_platdata' and the
entire 'struct dma_pl330_peri' can be eliminated.

This is first step towards adding device tree support for pl330 dma driver.
With rqtype information inferred from transfer requests, it need not be
included in device tree to describe each hardware dma request.

This patchset is based on following tree.
http://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
and branch 'kgene/next/topic-dma-pl330'.

This patchset has been implemented and tested only for Exynos4. If this
patchset is acceptable, then pl330 driver platform data for other samsung
platforms will also be modfied.

Thomas Abraham (3):
  DMA: PL330: Infer transfer direction from transfer request instead of platform data
  ARM: SAMSUNG: Modify pl330 channel filter function
  ARM: EXYNOS4: Modify platform data for pl330 driver

 arch/arm/mach-exynos4/dma.c     |  220 +++++++++++----------------------------
 arch/arm/plat-samsung/dma-ops.c |    4 +-
 drivers/dma/pl330.c             |   56 ++--------
 include/linux/amba/pl330.h      |   14 +--
 4 files changed, 75 insertions(+), 219 deletions(-)
