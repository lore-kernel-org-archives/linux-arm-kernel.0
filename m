From: rnayak@ti.com (Rajendra Nayak)
Date: Thu, 13 Jun 2013 19:47:08 +0530
Subject: [PATCH v2 0/3] minor omap dma fixes
Message-ID: <1371133031-29229-1-git-send-email-rnayak@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here are some minor omap dma fixes.

v2:
Patch 3/3 was wrongly fixed by just changing the
kfree() order. As Russell suggested the kfree()
was that for platform_data and wrong to begin with.
So Patch 3/3 now removes all instances of kfree() of
platform_data.

R Sricharan (2):
  ARM: OMAP: dma: Remove the wrong dev_id check
  ARM: OMAP: dma: Fix the dma_chan_link_map init order

Rajendra Nayak (1):
  ARM: OMAP: dma: Remove the erroneous freeing of platform data

 arch/arm/plat-omap/dma.c |   11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

-- 
1.7.9.5
