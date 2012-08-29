From: tushar.behera@linaro.org (Tushar Behera)
Date: Wed, 29 Aug 2012 10:16:23 +0530
Subject: [PATCH 0/2] ARM: EXYNOS: Set the capability of pdm0 and pdm1 as
 DMA_PRIVATE
Message-ID: <1346215585-31023-1-git-send-email-tushar.behera@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DMA clients pdma0 and pdma1 are internal to the SoC and are used only
by dedicated peripherals. Since they cannot be used for generic
purpose, their capability should be set as DMA_PRIVATE.

The patches are rebased on top of v3.6-rc3.

Tushar Behera (2):
  ARM: EXYNOS: Set the capability of pdm0 and pdm1 as DMA_PRIVATE
  DMA: PL330: Set the capability of pdm0 and pdm1 as DMA_PRIVATE

 arch/arm/mach-exynos/dma.c |    2 ++
 drivers/dma/pl330.c        |    1 +
 2 files changed, 3 insertions(+), 0 deletions(-)

-- 
1.7.4.1
